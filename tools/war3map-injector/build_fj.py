"""Rebuild scripts/item-browser/f.j by embedding the item ID + cleaned name list.

Reads _itemids.txt (flag<TAB>id<TAB>name, flag = S standard / C custom).
Names are PRE-CLEANED here (strip |cXXXXXXXX / |r colour codes, trim,
ASCII-lowercase) so the runtime script does NO string transformation — this
avoids corrupting multibyte UTF-8/GBK Chinese.

Embeds ib_itemList[i] (ID), ib_itemName[i] (cleaned name) and
ib_itemCustom[i] (1 = custom item, 0 = standard).
"""
import os, re

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, "..", ".."))
FJ = os.path.join(REPO, "scripts", "item-browser", "f.j")


def clean_name(s):
    s = re.sub(r"\|c[0-9a-fA-F]{8}", "", s)
    s = re.sub(r"\|r", "", s)
    s = s.strip()
    return "".join(chr(ord(c) + 32) if "A" <= c <= "Z" else c for c in s)


# Read flag + id + name
items = []
with open(os.path.join(HERE, "_itemids.txt"), encoding="utf-8") as fh:
    for line in fh:
        parts = line.rstrip("\n").split("\t")
        if len(parts) >= 3:
            flag, iid, nm = parts[0].strip(), parts[1].strip(), parts[2].strip()
        elif len(parts) == 2:
            flag, iid, nm = "S", parts[0].strip(), parts[1].strip()
        else:
            continue
        if len(iid) == 4:
            items.append((flag, iid, clean_name(nm)))


def jass_escape(s):
    return s.replace("\\", "\\\\").replace('"', '\\"')


# Split into chunks to avoid War3's per-function statement limit.
CHUNK = 80
chunks = [items[i:i + CHUNK] for i in range(0, len(items), CHUNK)]

chunk_funcs = []
for ci, chunk in enumerate(chunks):
    lines = ["function IB_Fill%d takes nothing returns nothing" % ci]
    for k, (flag, iid, nm) in enumerate(chunk):
        idx = ci * CHUNK + k
        lines.append("    set ib_itemList[%d] = '%s'" % (idx, iid))
        lines.append('    set ib_itemName[%d] = "%s"' % (idx, jass_escape(nm)))
        lines.append("    set ib_itemCustom[%d] = %d" % (idx, 1 if flag == "C" else 0))
    lines.append("endfunction")
    chunk_funcs.append("\n".join(lines))

# IB_Init: 先注册聊天事件,再用 timer 分帧调用各 IB_FillN。
# 这样避免在 main 阶段一次性执行所有填充语句而超操作数上限
# (否则 IB_Init 会中途静默失败,导致 IB_RegisterChat 不执行、search 无反应)。
init_body = ["function IB_Init takes nothing returns nothing",
             "    set ib_itemCount = 0",
             "    call IB_RegisterChat()",
             "    call DisplayTimedTextToPlayer(Player(0), 0, 0, 60.0, \"|cff00ff00[装备]|r IB_Init 已执行\")",
             "    set ib_fillIdx = 0",
             "    set ib_fillTotal = %d" % len(chunks),
             "    set ib_fillTimer = CreateTimer()",
             "    call TimerStart(ib_fillTimer, 0.01, true, function IB_FillStep)",
             "endfunction"]
init_block = "\n".join(init_body)

# 分帧填充函数:每帧调用一个 IB_FillN
fill_step = ["function IB_FillStep takes nothing returns nothing"]
for ci in range(len(chunks)):
    kw = "if" if ci == 0 else "elseif"
    fill_step.append("    %s ib_fillIdx == %d then" % (kw, ci))
    fill_step.append("        call IB_Fill%d()" % ci)
fill_step.append("    endif")
fill_step.append("    set ib_fillIdx = ib_fillIdx + 1")
fill_step.append("    if ib_fillIdx >= ib_fillTotal then")
fill_step.append("        set ib_itemCount = %d" % len(items))
fill_step.append("        call PauseTimer(ib_fillTimer)")
fill_step.append("        call DestroyTimer(ib_fillTimer)")
fill_step.append("        set ib_fillTimer = null")
fill_step.append("    endif")
fill_step.append("endfunction")
fill_step_block = "\n".join(fill_step)

# Insert chunk functions right before IB_Init, and replace IB_Init body.
with open(FJ, encoding="utf-8") as fh:
    txt = fh.read()

# 1) Remove any previously generated IB_Fill* / IB_FillStep functions (idempotent rebuild)
txt = re.sub(r"function IB_FillStep takes nothing returns nothing\n.*?\nendfunction\n\n?", "", txt, flags=re.S)
txt = re.sub(r"function IB_Fill\d+ takes nothing returns nothing\n.*?\nendfunction\n\n?", "", txt, flags=re.S)

# 2) Replace IB_Init body (整块替换到 endfunction)
pattern = re.compile(
    r"function IB_Init takes nothing returns nothing\n.*?\nendfunction",
    re.S)
if not pattern.search(txt):
    raise SystemExit("IB_Init block not found in f.j")
# 顺序: chunk 函数 -> IB_FillStep -> IB_Init (JASS 要求先定义后引用)
combined = "\n".join(chunk_funcs) + "\n\n" + fill_step_block + "\n\n" + init_block
txt = pattern.sub(lambda m: combined, txt, count=1)

with open(FJ, "w", encoding="utf-8") as fh:
    fh.write(txt)

print("embedded %d items (id+name) in %d chunks into %s" % (len(items), len(chunks), FJ))
