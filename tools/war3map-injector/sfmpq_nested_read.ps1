# Read files *inside* a chapter that is itself stored inside a .w3n,
# through SFmpq.dll -> the game's own Storm.dll (the path the engine uses).
param(
  [Parameter(Mandatory=$true)][string]$Map,
  [Parameter(Mandatory=$true)][string]$Chapter,
  [string]$Names = "war3map.j,war3map.w3e,war3map.doo,war3map.shd,war3map.wpm,war3map.w3i,war3map.w3u,war3map.w3a",
  [switch]$All,
  [uint32]$Flags = 0x100
)

$tmp = Join-Path $env:TEMP "sfmpq_nested_$PID"
New-Item -ItemType Directory -Force -Path $tmp | Out-Null
Copy-Item -LiteralPath "H:\Games\War3\Storm.dll" -Destination $tmp -Force
Copy-Item -LiteralPath (Join-Path $PSScriptRoot "_sfmpq\SFmpq.dll") -Destination $tmp -Force

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class NK {
  [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Ansi)]
  public static extern IntPtr LoadLibraryExA(string name, IntPtr file, uint flags);
  [DllImport("kernel32.dll", SetLastError=true)]
  public static extern IntPtr GetProcAddress(IntPtr h, string name);
}
public static class NAPI {
  [UnmanagedFunctionPointer(CallingConvention.StdCall, CharSet=CharSet.Ansi)]
  public delegate bool OpenArchive(string name, uint priority, uint flags, out IntPtr h);
  [UnmanagedFunctionPointer(CallingConvention.StdCall, CharSet=CharSet.Ansi)]
  public delegate bool OpenFileAsArchive(IntPtr h, string name, uint priority, uint flags, out IntPtr sub);
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

$sf = [NK]::LoadLibraryExA((Join-Path $tmp "SFmpq.dll"), [IntPtr]::Zero, 0x8)
if ($sf -eq [IntPtr]::Zero) { Say "SFmpq.dll load failed"; exit 2 }
function Bind([string]$n, [type]$t) {
  $p = [NK]::GetProcAddress($sf, $n)
  if ($p -eq [IntPtr]::Zero) { return $null }
  return [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($p, $t)
}
$OA  = Bind "SFileOpenArchive"     ([NAPI+OpenArchive])
$OFA = Bind "SFileOpenFileAsArchive" ([NAPI+OpenFileAsArchive])
$OFX = Bind "SFileOpenFileEx"      ([NAPI+OpenFileEx])
$GFS = Bind "SFileGetFileSize"     ([NAPI+GetFileSize])
$RF  = Bind "SFileReadFile"        ([NAPI+ReadFile])
$CF  = Bind "SFileCloseFile"       ([NAPI+CloseFile])
$CA  = Bind "SFileCloseArchive"    ([NAPI+CloseArchive])

Say "===== $Map  /  $Chapter"
$h = [IntPtr]::Zero
if (-not $OA.Invoke($Map, 0, 0x100, [ref]$h)) { Say "open archive FAIL"; exit 1 }
$sub = [IntPtr]::Zero
if (-not $OFA.Invoke($h, $Chapter, 0, $Flags, [ref]$sub)) { Say ("open-as-archive FAIL (flags=0x{0:X})" -f $Flags); exit 1 }
Say ("  open-as-archive: OK (flags=0x{0:X})" -f $Flags)
if ($All) {
  # first read (listfile) to get every inner file name
  $lh = [IntPtr]::Zero
  if ($OFX.Invoke($sub, "(listfile)", 0, [ref]$lh)) {
    $lsz = [int64]$GFS.Invoke($lh, [IntPtr]::Zero)
    $lbuf = New-Object byte[] ([Math]::Max($lsz,1))
    $lgot = 0
    $null = $RF.Invoke($lh, $lbuf, [uint32]$lsz, [ref]$lgot, [IntPtr]::Zero)
    $null = $CF.Invoke($lh)
    $txt = [Text.Encoding]::UTF8.GetString($lbuf, 0, [int]$lgot)
    $Names = ($txt -split "[`r`n]+" | Where-Object { $_.Trim() }) -join ","
    Say ("  (listfile) lists {0} files" -f ($Names.Split(",").Count))
  } else { Say "  (listfile) FAIL" }
}
foreach ($n in $Names.Split(",")) {
  $n = $n.Trim(); if (-not $n) { continue }
  $fh = [IntPtr]::Zero
  if (-not $OFX.Invoke($sub, $n, 0, [ref]$fh)) { Say ("  {0,-20} OPEN FAIL" -f $n); continue }
  $sz = [int64]$GFS.Invoke($fh, [IntPtr]::Zero)
  $buf = New-Object byte[] ([Math]::Max($sz,1))
  $got = 0
  $sw = [Diagnostics.Stopwatch]::StartNew()
  $rok = $RF.Invoke($fh, $buf, [uint32]$sz, [ref]$got, [IntPtr]::Zero)
  $sw.Stop()
  $null = $CF.Invoke($fh)
  $md5 = ""
  if ($rok -and $got -gt 0) {
    $m = [System.Security.Cryptography.MD5]::Create()
    $md5 = [BitConverter]::ToString($m.ComputeHash($buf,0,[int]$got)).Substring(0,8)
  }
  Say ("  {0,-20} size={1,-9} read={2,-9} ok={3,-5} md5={4} {5}ms" -f $n, $sz, $got, $rok, $md5, $sw.ElapsedMilliseconds)
}
$null = $CA.Invoke($sub)
$null = $CA.Invoke($h)
Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue
