# Call Storm's SFileVerifyFile on files inside an archive (the check the engine
# does before loading a campaign chapter). Returns 0 when the file verifies.
param(
  [Parameter(Mandatory=$true)][string]$Map,
  [Parameter(Mandatory=$true)][string]$Names,
  [uint32]$Flags = 0
)
$tmp = Join-Path $env:TEMP "sfmpq_ver_$PID"
New-Item -ItemType Directory -Force -Path $tmp | Out-Null
Copy-Item -LiteralPath "H:\Games\War3\Storm.dll" -Destination $tmp -Force
Copy-Item -LiteralPath (Join-Path $PSScriptRoot "_sfmpq\SFmpq.dll") -Destination $tmp -Force
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class VK {
  [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Ansi)]
  public static extern IntPtr LoadLibraryExA(string name, IntPtr file, uint flags);
  [DllImport("kernel32.dll", SetLastError=true)]
  public static extern IntPtr GetProcAddress(IntPtr h, string name);
}
public static class VAPI {
  [UnmanagedFunctionPointer(CallingConvention.StdCall, CharSet=CharSet.Ansi)]
  public delegate bool OpenArchive(string name, uint priority, uint flags, out IntPtr h);
  [UnmanagedFunctionPointer(CallingConvention.StdCall, CharSet=CharSet.Ansi)]
  public delegate uint VerifyFile(IntPtr h, string name, uint flags);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool CloseArchive(IntPtr h);
}
"@
function Say([string]$s) { [Console]::Out.WriteLine($s); [Console]::Out.Flush() }
$sf = [VK]::LoadLibraryExA((Join-Path $tmp "SFmpq.dll"), [IntPtr]::Zero, 0x8)
function Bind([string]$n, [type]$t) {
  $p = [VK]::GetProcAddress($sf, $n)
  if ($p -eq [IntPtr]::Zero) { return $null }
  return [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($p, $t)
}
$OA = Bind "SFileOpenArchive" ([VAPI+OpenArchive])
$VF = Bind "SFileVerifyFile" ([VAPI+VerifyFile])
$CA = Bind "SFileCloseArchive" ([VAPI+CloseArchive])
Say ("bound: OA={0} VerifyFile={1} CA={2}" -f [bool]$OA, [bool]$VF, [bool]$CA)
if (-not $VF) { Say "Storm 没有导出 SFileVerifyFile"; exit 2 }
$h = [IntPtr]::Zero
if (-not $OA.Invoke($Map, 0, 0x100, [ref]$h)) { Say "open archive FAIL"; exit 1 }
foreach ($n in $Names.Split(",")) {
  $n = $n.Trim(); if (-not $n) { continue }
  $r = $VF.Invoke($h, $n, $Flags)
  Say ("  {0,-24} verify=0x{1:X8} {2}" -f $n, $r, $(if ($r -eq 0) { "OK" } else { "**FAIL**" }))
}
$null = $CA.Invoke($h)
Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue
