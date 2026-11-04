# Open a file *inside* an archive as an archive (the path Warcraft III uses to
# load a campaign chapter), through SFmpq.dll -> the game's Storm.dll.
# Stored (uncompressed) sub-files can be opened this way; compressed ones cannot.
param(
  [Parameter(Mandatory=$true)][string]$Map,
  [string]$Names = "chapter1.w3x,chapter2.w3x,prologue.w3x,end.w3x"
)

$tmp = Join-Path $env:TEMP "sfmpq_sub_$PID"
New-Item -ItemType Directory -Force -Path $tmp | Out-Null
Copy-Item -LiteralPath "H:\Games\War3\Storm.dll" -Destination $tmp -Force
Copy-Item -LiteralPath (Join-Path $PSScriptRoot "_sfmpq\SFmpq.dll") -Destination $tmp -Force

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class SAK {
  [DllImport("kernel32.dll", SetLastError=true, CharSet=CharSet.Ansi)]
  public static extern IntPtr LoadLibraryExA(string name, IntPtr file, uint flags);
  [DllImport("kernel32.dll", SetLastError=true)]
  public static extern IntPtr GetProcAddress(IntPtr h, string name);
}
public static class SAAPI {
  [UnmanagedFunctionPointer(CallingConvention.StdCall, CharSet=CharSet.Ansi)]
  public delegate bool OpenArchive(string name, uint priority, uint flags, out IntPtr h);
  [UnmanagedFunctionPointer(CallingConvention.StdCall, CharSet=CharSet.Ansi)]
  public delegate bool OpenFileAsArchive(IntPtr h, string name, uint priority, uint flags, out IntPtr sub);
  [UnmanagedFunctionPointer(CallingConvention.StdCall, CharSet=CharSet.Ansi)]
  public delegate bool OpenFileEx(IntPtr h, string name, uint scope, out IntPtr fh);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate uint GetFileSize(IntPtr fh, IntPtr hi);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool CloseArchive(IntPtr h);
  [UnmanagedFunctionPointer(CallingConvention.StdCall)]
  public delegate bool CloseFile(IntPtr fh);
}
"@

function Say([string]$s) { [Console]::Out.WriteLine($s); [Console]::Out.Flush() }

$sf = [SAK]::LoadLibraryExA((Join-Path $tmp "SFmpq.dll"), [IntPtr]::Zero, 0x8)
if ($sf -eq [IntPtr]::Zero) { Say "SFmpq load failed"; exit 2 }
function Bind([string]$n, [type]$t) {
  $p = [SAK]::GetProcAddress($sf, $n)
  if ($p -eq [IntPtr]::Zero) { return $null }
  return [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($p, $t)
}
$OA = Bind "SFileOpenArchive" ([SAAPI+OpenArchive])
$OFA = Bind "SFileOpenFileAsArchive" ([SAAPI+OpenFileAsArchive])
$OFX = Bind "SFileOpenFileEx" ([SAAPI+OpenFileEx])
$GFS = Bind "SFileGetFileSize" ([SAAPI+GetFileSize])
$CA = Bind "SFileCloseArchive" ([SAAPI+CloseArchive])
$CF = Bind "SFileCloseFile" ([SAAPI+CloseFile])
Say ("bound: OA={0} OFA={1} OFX={2}" -f [bool]$OA, [bool]$OFA, [bool]$OFX)
if (-not ($OA -and $OFA)) { exit 3 }

Say "===== $Map"
$h = [IntPtr]::Zero
Say ("  SFileOpenArchive -> " + $OA.Invoke($Map, 0, 0x100, [ref]$h))
foreach ($n in $Names.Split(",")) {
  $n = $n.Trim()
  if (-not $n) { continue }
  $sub = [IntPtr]::Zero
  $ok = $OFA.Invoke($h, $n, 0, 0, [ref]$sub)
  if (-not $ok) { Say ("  {0,-16} open-as-archive: FAIL" -f $n); continue }
  # opened: read an inner file to prove it is really usable
  $fh = [IntPtr]::Zero
  $inner = $OFX.Invoke($sub, "war3map.w3i", 0, [ref]$fh)
  $sz = 0
  if ($inner) { $sz = [int]$GFS.Invoke($fh, [IntPtr]::Zero); $null = $CF.Invoke($fh) }
  $null = $CA.Invoke($sub)
  Say ("  {0,-16} open-as-archive: OK   (inner war3map.w3i = {1} bytes)" -f $n, $sz)
}
$null = $CA.Invoke($h)
