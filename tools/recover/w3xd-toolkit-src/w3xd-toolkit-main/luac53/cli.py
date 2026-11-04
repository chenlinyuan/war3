"""Command line interface: ``python -m luac53`` or the ``luac53`` console script."""

import argparse
import os
import subprocess
import sys
import tempfile

from . import __version__, chunk, disasm


def _java_args():
    """Locate unluac.

    Search order: ``$UNLUAC_JAR``, ``./unluac.jar``, ``./tools/unluac.jar``,
    then a source checkout built by ``scripts/get-unluac.*``.
    """
    jar = os.environ.get("UNLUAC_JAR")
    if jar and os.path.isfile(jar):
        return ["java", "-jar", jar]
    here = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    for cand in (os.path.join(here, "unluac.jar"),
                 os.path.join(here, "tools", "unluac.jar")):
        if os.path.isfile(cand):
            return ["java", "-jar", cand]
    for cand in (os.path.join(here, "tools", "unluac", "src", "build"),
                 os.path.join(here, "unluac-src", "src", "build")):
        if os.path.isdir(cand):
            return ["java", "-cp", cand, "unluac.Main"]
    return None


def cmd_info(args):
    data = open(args.file, "rb").read()
    hdr = chunk.read_header(data)
    print("file                : %s" % args.file)
    print("size                : %s bytes" % format(len(data), ","))
    print("version             : Lua %d.%d" % (hdr["version"] >> 4, hdr["version"] & 0xF))
    print("sizeof(int)         : %d" % hdr["sizeof_int"])
    print("sizeof(size_t)      : %d" % hdr["sizeof_size_t"])
    print("sizeof(Instruction) : %d" % hdr["sizeof_instruction"])
    print("sizeof(lua_Integer) : %d%s" % (hdr["sizeof_lua_integer"],
                                          "  (Blizzard build)" if hdr["sizeof_lua_integer"] == 4 else ""))
    print("sizeof(lua_Number)  : %d%s" % (hdr["sizeof_lua_number"],
                                          "  (Blizzard build)" if hdr["sizeof_lua_number"] == 4 else ""))
    try:
        _h, nup, main, stats = chunk.parse(data)
    except chunk.LuaChunkError as e:
        print("parse               : FAILED (%s)" % e)
        return 1
    print("main source         : %r" % (main["source"],))
    print("functions           : %d" % (stats["protos"] + 1))
    print("instructions        : %s" % format(stats["code"], ","))
    print("constants           : %s" % format(stats["consts"], ","))
    print("string constants    : %s" % format(stats["strings"], ","))
    print("debug info          : %s lines, %s locals, %s upvalue names"
          % (format(stats["lineinfo"], ","), format(stats["locvars"], ","),
             format(stats["upnames"], ",")))
    return 0


def cmd_convert(args):
    data = open(args.file, "rb").read()
    if chunk.looks_like_stock(data):
        print("already a stock Lua 5.3 chunk; copying")
        out = data
        stats = None
    else:
        out, stats = chunk.convert(data)
    dest = args.out or os.path.splitext(args.file)[0] + ".stock.luac"
    with open(dest, "wb") as fh:
        fh.write(out)
    if stats:
        print("functions=%d code=%s consts=%s strings=%s"
              % (stats["protos"] + 1, format(stats["code"], ","),
                 format(stats["consts"], ","), format(stats["strings"], ",")))
    print("%s -> %s (%s bytes)" % (args.file, dest, format(len(out), ",")))
    return 0


def cmd_disasm(args):
    data = open(args.file, "rb").read()
    if args.find:
        hits = disasm.find_protos(data, *args.find)
        if not hits:
            print("no prototype mentioning %s" % (args.find,))
            return 1
        for path, f in hits:
            print(disasm.format_proto(path, f, with_constants=not args.no_constants))
        return 0
    for path, f in disasm.protos_of(data):
        lines = f["lineinfo"]
        if args.lines and lines:
            lo, hi = args.lines
            if not any(lo <= l <= hi for l in lines):
                continue
        print(disasm.format_proto(path, f, with_constants=not args.no_constants))
    return 0


def cmd_decompile(args):
    """convert -> stock chunk -> unluac -> .lua"""
    java = _java_args()
    if java is None:
        print("unluac not found.  Run scripts/get-unluac.sh (or .ps1), or set\n"
              "UNLUAC_JAR to an unluac jar path.", file=sys.stderr)
        return 2
    data = open(args.file, "rb").read()
    stock, stats = chunk.convert(data) if not chunk.looks_like_stock(data) else (data, None)
    tmp = args.keep or os.path.join(tempfile.gettempdir(), "_luac53_stock.luac")
    with open(tmp, "wb") as fh:
        fh.write(stock)
    dest = args.out or os.path.splitext(args.file)[0] + ".lua"
    with open(dest, "wb") as fh:
        rc = subprocess.call(java + [tmp], stdout=fh)
    if rc != 0:
        print("unluac failed (exit %d)" % rc, file=sys.stderr)
        return rc
    print("%s -> %s (%s bytes)" % (args.file, dest, format(os.path.getsize(dest), ",")))
    return 0


def build_parser():
    p = argparse.ArgumentParser(
        prog="luac53",
        description="Blizzard Lua 5.3 bytecode: inspect, convert, disassemble, decompile")
    p.add_argument("--version", action="version", version="luac53 " + __version__)
    sub = p.add_subparsers(dest="cmd", required=True)

    s = sub.add_parser("info", help="header and structure of a .luac")
    s.add_argument("file")
    s.set_defaults(func=cmd_info)

    s = sub.add_parser("convert", help="rewrite as a stock Lua 5.3 chunk")
    s.add_argument("file")
    s.add_argument("-o", "--out")
    s.set_defaults(func=cmd_convert)

    s = sub.add_parser("disasm", help="disassemble")
    s.add_argument("file")
    s.add_argument("--find", nargs="+", metavar="TEXT",
                   help="only prototypes whose constants contain these strings")
    s.add_argument("--lines", nargs=2, type=int, metavar=("LO", "HI"),
                   help="only prototypes covering this source line range")
    s.add_argument("--no-constants", action="store_true")
    s.set_defaults(func=cmd_disasm)

    s = sub.add_parser("decompile", help="convert and run unluac in one step")
    s.add_argument("file")
    s.add_argument("-o", "--out")
    s.add_argument("--keep", help="where to keep the intermediate stock chunk")
    s.set_defaults(func=cmd_decompile)
    return p


def main(argv=None):
    args = build_parser().parse_args(argv)
    try:
        return args.func(args)
    except chunk.LuaChunkError as e:
        print("error: %s" % e, file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
