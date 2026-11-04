# A/B the container with the game's own Storm.dll named exports:
#   SFileOpenArchive(266) -> SFile::FileExists -> SFile::LoadFile
# LoadFile performs the real decrypt+decompress path, so a byte count + content
# check here is equivalent to what Warcraft III does when opening a map.
param([Parameter(Mandatory=$true)][string[]]$Map)

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class K32d {
  [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Ansi)]
  public static extern IntPtr LoadLibraryA(string name);
  [DllImport("kernel32.dll", SetLastError=true)]
  public static extern IntPtr GetProcAddress(IntPtr h, IntPtr ordinal);
  [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Ansi)]
  public static extern IntPtr GetProcAddress(IntPtr h, string name);
}
public static class SFd {
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool OpenArchive(string name, uint priority, uint flags, out IntPtr h);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool CloseArchive(IntPtr h);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate int FileExists(string name);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate uint LoadFile(string name, out IntPtr buf, out uint size, uint flags, IntPtr ovl);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate uint Open(string name, out IntPtr f);
}
"@

function Say([string]$s) { [Console]::Out.WriteLine($s); [Console]::Out.Flush() }

$storm = [K32d]::LoadLibraryA("H:\Games\War3\Storm.dll")
if ($storm -eq [IntPtr]::Zero) { Say "storm load fail"; exit 2 }
function Named([string]$n, [type]$t) {
  $p = [K32d]::GetProcAddress($storm, $n)
  if ($p -eq [IntPtr]::Zero) { Say "  (missing export $n)"; return $null }
  return [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($p, $t)
}
$oaP = [K32d]::GetProcAddress($storm, [IntPtr]266)
$OA = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($oaP, [SFd+OpenArchive])
$CA = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer(
      [K32d]::GetProcAddress($storm, [IntPtr]253), [SFd+CloseArchive])
$FE = Named "?FileExists@SFile@@SGHPBD@Z" ([SFd+FileExists])
$LF = Named "?LoadFile@SFile@@SGKPBDPAPAXPAKKPAUSOVERLAPPED@@@Z" ([SFd+LoadFile])
$OP = Named "?Open@SFile@@SGKPBDPAPAV1@@Z" ([SFd+Open])

$names = @("war3map.w3i","war3map.j","war3map.w3h","war3map.w3a","war3map.w3t","war3map.w3u","war3map.w3e","war3map.wts","war3map.doo","war3map.wpm","__nope__.zzz")
foreach ($m in $Map) {
  Say "===== $m"
  $h = [IntPtr]::Zero
  $ok = $OA.Invoke($m, 0, 0x100, [ref]$h)
  Say ("  SFileOpenArchive -> {0}" -f $ok)
  if (-not $ok) { continue }
  foreach ($f in $names) {
    $ex = -1
    if ($FE) { $ex = $FE.Invoke($f) }
    $sz = 0
    if ($LF) {
      $buf = [IntPtr]::Zero
      $n = $LF.Invoke($f, [ref]$buf, [ref]$sz, 0, [IntPtr]::Zero)
      if ($n -eq 0) { $sz = -1 }
    }
    Say ("  {0,-16} FileExists={1} LoadFileSize={2}" -f $f, $ex, $sz)
  }
  $null = $CA.Invoke($h)
}
