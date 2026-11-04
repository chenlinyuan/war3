param(
  [Parameter(Mandatory=$true)][string]$Map,
  [Parameter(Mandatory=$true)][string]$Source,
  [Parameter(Mandatory=$true)][string]$Internal,
  [uint32]$MaxFiles = 4096,
  [switch]$Compress,
  [switch]$Replace
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$tmp = Join-Path $env:TEMP "sfmpq_add_$PID"
New-Item -ItemType Directory -Force -Path $tmp | Out-Null
try {
  $storm = "H:\Games\War3\Storm.dll"
  if (-not (Test-Path -LiteralPath $storm)) {
    throw "Storm.dll not found: $storm"
  }
  Copy-Item -LiteralPath (Join-Path $root "_sfmpq\SFmpq.dll") -Destination $tmp -Force
  Copy-Item -LiteralPath $storm -Destination $tmp -Force
  $env:PATH = "$tmp;$env:PATH"

  Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class SFNative {
  [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Ansi)]
  public static extern IntPtr LoadLibraryExA(string name, IntPtr file, uint flags);
  [DllImport("kernel32.dll", SetLastError=true)]
  public static extern IntPtr GetProcAddress(IntPtr module, string name);
}
public static class SFDelegates {
  [UnmanagedFunctionPointer(CallingConvention.StdCall, CharSet=CharSet.Ansi)]
  public delegate IntPtr OpenArchiveForUpdate(string file, uint flags, uint maxFiles);
  [UnmanagedFunctionPointer(CallingConvention.StdCall, CharSet=CharSet.Ansi)]
  public delegate bool AddFileToArchiveEx(
    IntPtr archive, string source, string internalName, uint flags,
    uint compression, uint compressionLevel);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate uint CloseUpdatedArchive(IntPtr archive, uint flags);
}
"@

  $module = [SFNative]::LoadLibraryExA((Join-Path $tmp "SFmpq.dll"), [IntPtr]::Zero, 0x8)
  if ($module -eq [IntPtr]::Zero) {
    throw "SFmpq.dll load failed: $([Runtime.InteropServices.Marshal]::GetLastWin32Error())"
  }
  function Bind([string]$name, [type]$type) {
    $address = [SFNative]::GetProcAddress($module, $name)
    if ($address -eq [IntPtr]::Zero) {
      throw "SFmpq export missing: $name"
    }
    return [Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($address, $type)
  }
  $open = Bind "MpqOpenArchiveForUpdate" ([SFDelegates+OpenArchiveForUpdate])
  $add = Bind "MpqAddFileToArchiveEx" ([SFDelegates+AddFileToArchiveEx])
  $close = Bind "MpqCloseUpdatedArchive" ([SFDelegates+CloseUpdatedArchive])
  # MOAU_OPEN_EXISTING (0x04) | MOAU_MAINTAIN_LISTFILE (0x01)
  $handle = $open.Invoke((Resolve-Path -LiteralPath $Map).Path, 5, $MaxFiles)
  if ($handle -eq [IntPtr]::Zero) {
    throw "MpqOpenArchiveForUpdate failed"
  }
  $flags = if ($Compress) { [uint32]0x00000200 } else { [uint32]0 }
  if ($Replace) { $flags = $flags -bor [uint32]0x00000001 }
  $compression = if ($Compress) { [uint32]0x02 } else { [uint32]0 }
  $ok = $add.Invoke(
    $handle,
    (Resolve-Path -LiteralPath $Source).Path,
    $Internal,
    $flags,
    $compression,
    $(if ($Compress) { 9 } else { 0 })
  )
  $closed = $close.Invoke($handle, 0)
  if (-not $ok) {
    throw "MpqAddFileToArchiveEx failed for $Internal"
  }
  if (-not $closed) {
    throw "MpqCloseUpdatedArchive failed"
  }
  Write-Output "added: $Internal"
}
finally {
  Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue
}
