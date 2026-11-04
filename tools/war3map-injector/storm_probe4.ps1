# Brute-force the Storm.dll ordinals that do name -> (bool) lookups on an opened
# archive. Prints with explicit flush so a crash still leaves the log behind.
param(
  [Parameter(Mandatory=$true)][string]$Map,
  [int]$Lo = 250,
  [int]$Hi = 330
)

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class K32c {
  [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Ansi)]
  public static extern IntPtr LoadLibraryA(string name);
  [DllImport("kernel32.dll", SetLastError=true)]
  public static extern IntPtr GetProcAddress(IntPtr h, IntPtr ordinal);
}
public static class SFc {
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool OpenArchive(string name, uint priority, uint flags, out IntPtr h);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool F2(IntPtr h, string name);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool F3(IntPtr h, string name, uint flags, out IntPtr fh);
}
"@

function Say([string]$s) { [Console]::Out.WriteLine($s); [Console]::Out.Flush() }

$storm = [K32c]::LoadLibraryA("H:\Games\War3\Storm.dll")
if ($storm -eq [IntPtr]::Zero) { Say "storm load fail"; exit 2 }
function Ptr([int]$n) { [K32c]::GetProcAddress($storm, [IntPtr]$n) }

$oaP = Ptr 266
$OA = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($oaP, [SFc+OpenArchive])
$h = [IntPtr]::Zero
Say ("open {0} -> {1}" -f $Map, $OA.Invoke($Map, 0, 0x100, [ref]$h))
if ($h -eq [IntPtr]::Zero) { exit 1 }

Say "--- 2-arg bool(h,name): exists / not-exists / listfile"
for ($n = $Lo; $n -le $Hi; $n++) {
  $p = Ptr $n
  if ($p -eq [IntPtr]::Zero) { continue }
  try {
    $f = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($p, [SFc+F2])
    $a = $f.Invoke($h, "war3map.w3i")
    $b = $f.Invoke($h, "__nope__.zzz")
    if ($a -or $b) { Say ("  ord {0}: w3i={1} nope={2}" -f $n, $a, $b) }
  } catch { Say ("  ord {0}: threw {1}" -f $n, $_.Exception.Message) }
}

Say "--- 3-arg bool(h,name,flags,&fh)"
for ($n = $Lo; $n -le $Hi; $n++) {
  $p = Ptr $n
  if ($p -eq [IntPtr]::Zero) { continue }
  try {
    $f = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($p, [SFc+F3])
    $fh = [IntPtr]::Zero
    $a = $f.Invoke($h, "war3map.w3i", 0, [ref]$fh)
    if ($a) { Say ("  ord {0}: open ok fh={1}" -f $n, $fh) }
  } catch { Say ("  ord {0}: threw {1}" -f $n, $_.Exception.Message) }
}
Say "done"
