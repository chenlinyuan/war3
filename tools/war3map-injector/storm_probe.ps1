# Probe a map with the game's own Storm.dll (same MPQ reader Warcraft III uses).
param(
  [Parameter(Mandatory=$true)][string[]]$Map,
  [string[]]$Files = @("war3map.j","war3map.w3i","war3map.w3h","war3map.w3a","war3map.w3t","war3map.w3u","war3map.wts","war3map.imp","(listfile)")
)

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class K32 {
  [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Ansi)]
  public static extern IntPtr LoadLibraryA(string name);
  [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Ansi)]
  public static extern IntPtr GetProcAddress(IntPtr h, string name);
}
public static class SF {
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool OpenArchive(string name, uint priority, uint flags, out IntPtr h);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool CloseArchive(IntPtr h);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool HasFile(IntPtr h, string name);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool OpenFileEx(IntPtr h, string name, uint flags, out IntPtr fh);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate uint GetFileSize(IntPtr fh, IntPtr hi);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool ReadFile(IntPtr fh, byte[] buf, uint toRead, out uint read, uint ovl, IntPtr pfn);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool CloseFile(IntPtr fh);
}
"@

$storm = [K32]::LoadLibraryA("H:\Games\War3\Storm.dll")
if ($storm -eq [IntPtr]::Zero) { Write-Host "Storm.dll load failed"; exit 2 }

function Fn([string]$n, [type]$t) {
  $p = [K32]::GetProcAddress($storm, $n)
  if ($p -eq [IntPtr]::Zero) { return $null }
  return [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($p, $t)
}
$OA  = Fn "SFileOpenArchive" ([SF+OpenArchive])
$CA  = Fn "SFileCloseArchive" ([SF+CloseArchive])
$HF  = Fn "SFileHasFile" ([SF+HasFile])
$OFX = Fn "SFileOpenFileEx" ([SF+OpenFileEx])
$GFS = Fn "SFileGetFileSize" ([SF+GetFileSize])
$RF  = Fn "SFileReadFile" ([SF+ReadFile])
$CF  = Fn "SFileCloseFile" ([SF+CloseFile])
if (-not ($OA -and $CA -and $HF -and $OFX -and $GFS -and $RF -and $CF)) {
  Write-Host "Storm exports missing: OA=$([bool]$OA) CA=$([bool]$CA) HF=$([bool]$HF) OFX=$([bool]$OFX) GFS=$([bool]$GFS) RF=$([bool]$RF) CF=$([bool]$CF)"
  exit 3
}

foreach ($m in $Map) {
  Write-Host "===== $m"
  if (-not (Test-Path -LiteralPath $m)) { Write-Host "  missing"; continue }
  $h = [IntPtr]::Zero
  $ok = $OA.Invoke($m, 0, 0x100, [ref]$h)
  Write-Host ("  OpenArchive: {0}  handle={1}" -f $ok, $h)
  if (-not $ok) { continue }
  foreach ($f in $Files) {
    $has = $HF.Invoke($h, $f)
    $fh = [IntPtr]::Zero
    $oof = $OFX.Invoke($h, $f, 0, [ref]$fh)
    $sz = -1
    $rd = -1
    if ($oof) {
      $sz = [int]$GFS.Invoke($fh, [IntPtr]::Zero)
      $buf = New-Object byte[] ([Math]::Max($sz,1))
      $got = 0
      $rok = $RF.Invoke($fh, $buf, [uint32]$sz, [ref]$got, 0, [IntPtr]::Zero)
      $rd = if ($rok) { [int]$got } else { -2 }
      $null = $CF.Invoke($fh)
    }
    Write-Host ("  {0,-16} HasFile={1,-5} Open={2,-5} Size={3,-8} Read={4}" -f $f, $has, $oof, $sz, $rd)
  }
  $null = $CA.Invoke($h)
}
