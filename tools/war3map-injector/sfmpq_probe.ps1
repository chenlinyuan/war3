# Read a map through SFmpq.dll -> the game's own Storm.dll (32-bit host needed).
# This is the same MPQ code path Warcraft III uses when it opens a map.
param(
  [Parameter(Mandatory=$true)][string]$Map,
  [string]$Names = "war3map.w3i,war3map.j,war3map.w3a,war3map.w3t,war3map.w3u,war3map.w3h,war3map.w3e,war3map.doo,war3map.shd,war3map.wpm,war3map.mmp,war3map.wtg,war3map.wct,war3map.wts,(listfile),__nope__.zzz",
  [string]$OutDir = ""
)

$tmp = Join-Path $env:TEMP "sfmpq_probe_$PID"
New-Item -ItemType Directory -Force -Path $tmp | Out-Null
Copy-Item -LiteralPath "H:\Games\War3\Storm.dll" -Destination $tmp -Force
$sfSrc = Join-Path $PSScriptRoot "_sfmpq\SFmpq.dll"
Copy-Item -LiteralPath $sfSrc -Destination $tmp -Force

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class SFK {
  [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Ansi)]
  public static extern IntPtr LoadLibraryExA(string name, IntPtr file, uint flags);
  [DllImport("kernel32.dll", SetLastError=true)]
  public static extern IntPtr GetProcAddress(IntPtr h, string name);
}
public static class SFAPI {
  [UnmanagedFunctionPointer(CallingConvention.StdCall, CharSet=CharSet.Ansi)]
  public delegate bool OpenArchive(string name, uint priority, uint flags, out IntPtr h);
  [UnmanagedFunctionPointer(CallingConvention.StdCall, CharSet=CharSet.Ansi)]
  public delegate bool OpenFileEx(IntPtr h, string name, uint scope, out IntPtr fh);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate uint GetFileSize(IntPtr fh, IntPtr hi);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool ReadFile(IntPtr fh, byte[] buf, uint toRead, out uint read, IntPtr ovl);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool CloseFile(IntPtr fh);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool CloseArchive(IntPtr h);
}
"@

function Say([string]$s) { [Console]::Out.WriteLine($s); [Console]::Out.Flush() }

$sf = [SFK]::LoadLibraryExA((Join-Path $tmp "SFmpq.dll"), [IntPtr]::Zero, 0x8)  # ALTERED_SEARCH_PATH
if ($sf -eq [IntPtr]::Zero) { Say "SFmpq.dll load failed (err $([Runtime.InteropServices.Marshal]::GetLastWin32Error()))"; exit 2 }
function Bind([string]$n, [type]$t) {
  $p = [SFK]::GetProcAddress($sf, $n)
  if ($p -eq [IntPtr]::Zero) { return $null }
  return [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($p, $t)
}
$OA = Bind "SFileOpenArchive" ([SFAPI+OpenArchive])
$OFX = Bind "SFileOpenFileEx" ([SFAPI+OpenFileEx])
$GFS = Bind "SFileGetFileSize" ([SFAPI+GetFileSize])
$RF = Bind "SFileReadFile" ([SFAPI+ReadFile])
$CF = Bind "SFileCloseFile" ([SFAPI+CloseFile])
$CA = Bind "SFileCloseArchive" ([SFAPI+CloseArchive])
Say ("SFmpq bound: OA={0} OFX={1} GFS={2} RF={3} CF={4} CA={5}" -f [bool]$OA,[bool]$OFX,[bool]$GFS,[bool]$RF,[bool]$CF,[bool]$CA)

Say "===== $Map"
$h = [IntPtr]::Zero
$ok = $OA.Invoke($Map, 0, 0x100, [ref]$h)
Say ("  SFileOpenArchive -> {0}" -f $ok)
if (-not $ok) { exit 1 }
foreach ($n in $Names.Split(",")) {
  $n = $n.Trim()
  if (-not $n) { continue }
  $fh = [IntPtr]::Zero
  $oof = $OFX.Invoke($h, $n, 0, [ref]$fh)
  if (-not $oof) { Say ("  {0,-24} OPEN FAIL" -f $n); continue }
  $sz = [int64]$GFS.Invoke($fh, [IntPtr]::Zero)
  $buf = New-Object byte[] ([Math]::Max($sz,1))
  $got = 0
  $rok = $RF.Invoke($fh, $buf, [uint32]$sz, [ref]$got, [IntPtr]::Zero)
  $null = $CF.Invoke($fh)
  $crc = 0
  if ($rok -and $got -gt 0) {
    $md5 = [System.Security.Cryptography.MD5]::Create()
    $crc = [BitConverter]::ToString($md5.ComputeHash($buf, 0, [int]$got)).Substring(0,8)
  }
  if ($OutDir -and $rok -and $got -gt 0) {
    $safe = $n -replace '[\\/:*?"<>|]', '_'
    [System.IO.File]::WriteAllBytes((Join-Path $OutDir $safe), $buf[0..([int]$got - 1)])
  }
  Say ("  {0,-24} size={1,-8} read={2,-8} ok={3,-5} md5={4}" -f $n, $sz, $got, $rok, $crc)
}
$null = $CA.Invoke($h)
Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue
