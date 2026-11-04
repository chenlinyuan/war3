# Probe a map with the game's own Storm.dll, addressing exports by ordinal
# (the game itself imports Storm by ordinal, see _storm_ordinals.py).
param(
  [Parameter(Mandatory=$true)][string[]]$Map
)

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class K32 {
  [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Ansi)]
  public static extern IntPtr LoadLibraryA(string name);
  [DllImport("kernel32.dll", SetLastError=true)]
  public static extern IntPtr GetProcAddress(IntPtr h, IntPtr ordinal);
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
  public delegate bool ReadFile(IntPtr fh, byte[] buf, uint toRead, out uint read, IntPtr ovl, IntPtr pfn);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool CloseFile(IntPtr fh);
}
"@

$storm = [K32]::LoadLibraryA("H:\Games\War3\Storm.dll")
Write-Host "Storm.dll handle: $storm"
if ($storm -eq [IntPtr]::Zero) { exit 2 }

function Ord([int]$n, [type]$t) {
  $p = [K32]::GetProcAddress($storm, [IntPtr]$n)
  if ($p -eq [IntPtr]::Zero) { return $null }
  return [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($p, $t)
}

$OA  = Ord 266 ([SF+OpenArchive])    # SFileOpenArchive
$CA  = Ord 253 ([SF+CloseArchive])   # SFileCloseArchive
$HF  = Ord 288 ([SF+HasFile])        # SFileHasFile
$OFX = Ord 268 ([SF+OpenFileEx])     # SFileOpenFileEx
$GFS = Ord 265 ([SF+GetFileSize])    # SFileGetFileSize
$RF  = Ord 269 ([SF+ReadFile])       # SFileReadFile
$CF  = Ord 252 ([SF+CloseFile])      # SFileCloseFile
Write-Host ("resolved: OA={0} CA={1} HF={2} OFX={3} GFS={4} RF={5} CF={6}" -f `
  [bool]$OA, [bool]$CA, [bool]$HF, [bool]$OFX, [bool]$GFS, [bool]$RF, [bool]$CF)

$names = @("war3map.j","war3map.w3i","war3map.w3e","war3map.w3a","war3map.w3t","war3map.w3u","war3map.w3h","war3map.wts","war3map.doo","war3map.shd","war3map.wpm","war3map.mmp","war3map.wtg","war3map.wct","(listfile)")

foreach ($m in $Map) {
  Write-Host "===== $m"
  if (-not (Test-Path -LiteralPath $m)) { Write-Host "  missing"; continue }
  $h = [IntPtr]::Zero
  Write-Host "  calling OpenArchive..."
  $ok = $OA.Invoke($m, 0, 0x100, [ref]$h)
  Write-Host ("  OpenArchive -> {0} handle={1}" -f $ok, $h)
  if (-not $ok) { continue }
  foreach ($f in $names) {
    $has = $HF.Invoke($h, $f)
    $fh = [IntPtr]::Zero
    $oof = $OFX.Invoke($h, $f, 0, [ref]$fh)
    if ($oof) {
      $sz = [int]$GFS.Invoke($fh, [IntPtr]::Zero)
      $buf = New-Object byte[] ([Math]::Max($sz,1))
      $got = 0
      $rok = $RF.Invoke($fh, $buf, [uint32]$sz, [ref]$got, [IntPtr]::Zero, [IntPtr]::Zero)
      $null = $CF.Invoke($fh)
      Write-Host ("  {0,-16} HasFile={1,-5} Open=True  Size={2,-8} Read={3} (ok={4})" -f $f, $has, $sz, $got, $rok)
    } else {
      Write-Host ("  {0,-16} HasFile={1,-5} Open=False" -f $f, $has)
    }
  }
  $null = $CA.Invoke($h)
  Write-Host "  closed"
}
