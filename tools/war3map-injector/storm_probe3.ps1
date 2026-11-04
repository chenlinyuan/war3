# Identify the right Storm.dll ordinals for reading a map, using a map the game
# is known to load (origbak) as the control.
param([string]$Good, [string]$Bad)

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class K32b {
  [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Ansi)]
  public static extern IntPtr LoadLibraryA(string name);
  [DllImport("kernel32.dll", SetLastError=true)]
  public static extern IntPtr GetProcAddress(IntPtr h, IntPtr ordinal);
}
public static class SFb {
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool OpenArchive(string name, uint priority, uint flags, out IntPtr h);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool CloseArchive(IntPtr h);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool HasFile(IntPtr h, string name);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool OpenFileEx(IntPtr h, string name, uint flags, out IntPtr fh);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool OpenFile2(IntPtr h, string name, out IntPtr fh);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate uint GetFileSize(IntPtr fh, IntPtr hi);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool ReadFile(IntPtr fh, byte[] buf, uint toRead, out uint read, IntPtr ovl, IntPtr pfn);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool CloseFile(IntPtr fh);
}
"@

$storm = [K32b]::LoadLibraryA("H:\Games\War3\Storm.dll")
if ($storm -eq [IntPtr]::Zero) { Write-Host "storm load fail"; exit 2 }
function Ord([int]$n, [type]$t) {
  $p = [K32b]::GetProcAddress($storm, [IntPtr]$n)
  if ($p -eq [IntPtr]::Zero) { return $null }
  return [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($p, $t)
}
$OA = Ord 266 ([SFb+OpenArchive])

foreach ($case in @(@("GOOD",$Good), @("BOGUS","maps\__nope__.w3x"))) {
  $h = [IntPtr]::Zero
  Write-Host ("--- ordinal 266 on {0} ({1})" -f $case[0], $case[1])
  $r = $OA.Invoke($case[1], 0, 0x100, [ref]$h)
  Write-Host ("    flags=0x100 -> {0} handle={1}" -f $r, $h)
  if ($h -ne [IntPtr]::Zero) { $null = (Ord 253 ([SFb+CloseArchive])).Invoke($h) }
}

# Try candidate "has file" / "open file" ordinals on the good map
$h = [IntPtr]::Zero
$r = $OA.Invoke($Good, 0, 0x100, [ref]$h)
if (-not $r) { Write-Host "good map open failed"; exit 1 }
$name = "war3map.w3i"
foreach ($cand in @(288,267,268)) {
  try {
    $f3 = Ord $cand ([SFb+OpenFileEx])
    if ($f3) {
      $fh = [IntPtr]::Zero
      $o = $f3.Invoke($h, $name, 0, [ref]$fh)
      Write-Host ("   ord {0} as OpenFileEx(h,name,0,&fh) -> {1} fh={2}" -f $cand, $o, $fh)
      if ($o) { $null = (Ord 252 ([SFb+CloseFile])).Invoke($fh) }
    }
  } catch { Write-Host ("   ord {0} OpenFileEx threw: {1}" -f $cand, $_.Exception.Message) }
}
foreach ($cand in @(288,267)) {
  try {
    $f2 = Ord $cand ([SFb+HasFile])
    if ($f2) { Write-Host ("   ord {0} as HasFile(h,name) -> {1}" -f $cand, $f2.Invoke($h, $name)) }
  } catch { Write-Host ("   ord {0} HasFile threw: {1}" -f $cand, $_.Exception.Message) }
}
$null = (Ord 253 ([SFb+CloseArchive])).Invoke($h)
Write-Host "done"
