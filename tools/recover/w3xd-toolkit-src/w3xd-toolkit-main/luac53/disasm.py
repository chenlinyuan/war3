"""
A small Lua 5.3 disassembler.

Handy when a decompiler gets a control-flow construct wrong: dumping the
prototype shows the real jumps.  Use :func:`find_protos` to locate a function
by a constant it mentions, e.g. its own name.
"""

from .chunk import parse

OPNAMES = [
    "MOVE", "LOADK", "LOADKX", "LOADBOOL", "LOADNIL", "GETUPVAL", "GETTABUP",
    "GETTABLE", "SETTABUP", "SETUPVAL", "SETTABLE", "NEWTABLE", "SELF", "ADD",
    "SUB", "MUL", "MOD", "POW", "DIV", "IDIV", "BAND", "BOR", "BXOR", "SHL",
    "SHR", "UNM", "BNOT", "NOT", "LEN", "CONCAT", "JMP", "EQ", "LT", "LE",
    "TEST", "TESTSET", "CALL", "TAILCALL", "RETURN", "FORLOOP", "FORPREP",
    "TFORCALL", "TFORLOOP", "SETLIST", "CLOSURE", "VARARG", "EXTRAARG",
]
IABX = {1, 2, 39, 40, 42, 44}
IAX = {46}
RK_OPS = {6, 7, 8, 10, 12, 31, 32, 33, 34, 35}
MAXARG_BX = 0x3FFFF
BIAS = MAXARG_BX >> 1


def walk(proto, path="main", out=None):
    """Flatten a prototype tree into ``[(path, proto)]``."""
    out = [] if out is None else out
    out.append((path, proto))
    for i, p in enumerate(proto["protos"]):
        walk(p, "%s/%d" % (path, i), out)
    return out


def protos_of(data):
    _hdr, _nup, main, _stats = parse(data)
    return walk(main)


def find_protos(data, *needles):
    """Prototypes whose string constants contain all ``needles``."""
    wants = [n.encode("latin1") if isinstance(n, str) else n for n in needles]
    hits = []
    for path, f in protos_of(data):
        blob = b"|".join(v for k, v in f["consts"] if k == "str" and v)
        if all(w in blob for w in wants):
            hits.append((path, f))
    return hits


def const_repr(f, idx):
    try:
        kind, val = f["consts"][idx]
    except IndexError:
        return "?"
    if kind == "str":
        return repr(val[:48])
    if kind == "int":
        return str(val)
    if kind == "num":
        return "%.6g" % val
    if kind == "bool":
        return str(bool(val))
    return "nil"


def decode(ins):
    op = ins & 0x3F
    return {
        "op": op,
        "name": OPNAMES[op] if op < len(OPNAMES) else "OP_%d" % op,
        "A": (ins >> 6) & 0xFF,
        "C": (ins >> 14) & 0x1FF,
        "B": (ins >> 23) & 0x1FF,
        "Bx": (ins >> 14) & MAXARG_BX,
        "Ax": (ins >> 6) & 0x3FFFFFF,
    }


def format_proto(path, f, with_constants=True):
    """Human readable listing of one prototype."""
    lines = ["=" * 78]
    lines.append("proto %s  params=%d vararg=%d maxstack=%d code=%d"
                 % (path, f["numparams"], f["is_vararg"], f["maxstacksize"],
                    len(f["code"])))
    if with_constants and f["consts"]:
        lines.append("constants:")
        for i, (kind, val) in enumerate(f["consts"]):
            show = val[:60] if isinstance(val, bytes) else val
            lines.append("   [%3d] %-5s %r" % (i, kind, show))
    if f["upnames"]:
        lines.append("upvalues:")
        for i, nm in enumerate(f["upnames"]):
            lines.append("   [%2d] %r" % (i, nm))
    lines.append("code:")
    lines.extend(format_code(f))
    return "\n".join(lines)


def format_code(f):
    out = []
    lineinfo = f["lineinfo"]
    for pc, ins in enumerate(f["code"]):
        d = decode(ins)
        op, name = d["op"], d["name"]
        line = lineinfo[pc] if pc < len(lineinfo) else -1
        if op in IABX:
            extra = "Bx=%d" % d["Bx"]
            if op in (39, 40, 42):
                extra += "  -> pc %d" % (pc + 1 + d["Bx"] - BIAS)
            if op == 44:
                extra += "  (closure)"
        elif op in IAX:
            extra = "Ax=%d" % d["Ax"]
        else:
            extra = "A=%-3d B=%-4d C=%-4d" % (d["A"], d["B"], d["C"])
            if op in RK_OPS:
                for tag in ("B", "C"):
                    v = d[tag]
                    if v & 0x100:
                        extra += "  %s=K[%d]%s" % (tag, v & 0xFF, const_repr(f, v & 0xFF))
            if op == 1:
                extra += "  K[%d]%s" % (d["Bx"], const_repr(f, d["Bx"]))
            if op == 30:
                extra += "  -> pc %d" % (pc + 1 + d["Bx"] - BIAS)
            if op in (31, 32, 33):
                extra += "  (skip next when false)"
        out.append("  [%4d] L%-6d %-9s %s" % (pc, line, name, extra))
    return out
