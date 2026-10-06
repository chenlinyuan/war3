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

# 读取技能列表 (id<TAB>name), 技能名同样预清洗
skills = []
skill_path = os.path.join(HERE, "_skillids.txt")
if os.path.isfile(skill_path):
    with open(skill_path, encoding="utf-8") as fh:
        for line in fh:
            parts = line.rstrip("\n").split("\t")
            if len(parts) >= 2 and len(parts[0].strip()) == 4:
                sid = parts[0].strip()
                nm = clean_name(parts[1].strip())
                # 标准技能 = 4字符且非 A000-A999 之外; 简化: 以 A 开头且第2字符是数字视为自定义
                is_custom = 1 if (len(sid) == 4 and sid[0] == "A" and sid[1].isdigit()) else 0
                skills.append((is_custom, sid, nm))

# 读取单位列表 (id<TAB>name<TAB>armor)
units = []
unit_path = os.path.join(HERE, "_unitids.txt")
if os.path.isfile(unit_path):
    with open(unit_path, encoding="utf-8") as fh:
        for line in fh:
            parts = line.rstrip("\n").split("\t")
            if len(parts) >= 3 and len(parts[0].strip()) == 4:
                uid = parts[0].strip()
                nm = clean_name(parts[1].strip())
                armor = parts[2].strip()
                units.append((uid, nm, armor))


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

# 技能分块 (80/块)
skill_chunks = [skills[i:i + CHUNK] for i in range(0, len(skills), CHUNK)]
skill_funcs = []
for ci, chunk in enumerate(skill_chunks):
    lines = ["function IB_SkillFill%d takes nothing returns nothing" % ci]
    for k, (cus, sid, nm) in enumerate(chunk):
        idx = ci * CHUNK + k
        lines.append("    set ib_skillList[%d] = '%s'" % (idx, sid))
        lines.append('    set ib_skillName[%d] = "%s"' % (idx, jass_escape(nm)))
        lines.append("    set ib_skillCustom[%d] = %d" % (idx, cus))
    lines.append("endfunction")
    skill_funcs.append("\n".join(lines))

# 生成 IB_SkillFillStep (匹配实际块数)
skill_fill_step = ["function IB_SkillFillStep takes nothing returns nothing"]
for ci in range(len(skill_chunks)):
    kw = "if" if ci == 0 else "elseif"
    skill_fill_step.append("    %s ib_skFillIdx == %d then" % (kw, ci))
    skill_fill_step.append("        call IB_SkillFill%d()" % ci)
skill_fill_step.append("    endif")
skill_fill_step.append("    set ib_skFillIdx = ib_skFillIdx + 1")
skill_fill_step.append("    if ib_skFillIdx >= ib_skFillTotal then")
skill_fill_step.append("        set ib_skillCount = %d" % len(skills))
skill_fill_step.append("        call PauseTimer(ib_skFillTimer)")
skill_fill_step.append("        call DestroyTimer(ib_skFillTimer)")
skill_fill_step.append("        set ib_skFillTimer = null")
skill_fill_step.append("    endif")
skill_fill_step.append("endfunction")
skill_fill_step_block = "\n".join(skill_fill_step)

# 单位分块 (已移除: 变身/listunit 功能未验证, 不再生成)
unit_chunks = []
unit_funcs = []
unit_fill_step_block = ""

# IB_Init: 先注册聊天事件,再用 timer 分帧调用各 IB_FillN / IB_SkillFillN。
init_body = ["function IB_Init takes nothing returns nothing",
             "    set ib_itemCount = 0",
             "    set ib_skillCount = 0",
             "    call IB_RegisterChat()",
             "    set ib_fillIdx = 0",
             "    set ib_fillTotal = %d" % len(chunks),
             "    set ib_fillTimer = CreateTimer()",
             "    call TimerStart(ib_fillTimer, 0.01, true, function IB_FillStep)",
             "    set ib_skFillIdx = 0",
             "    set ib_skFillTotal = %d" % len(skill_chunks),
             "    set ib_skFillTimer = CreateTimer()",
             "    call TimerStart(ib_skFillTimer, 0.01, true, function IB_SkillFillStep)",
             "    call IB_CritInit()",
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

# 1) Remove any previously generated IB_Fill* / IB_FillStep / IB_SkillFill* / IB_UnitFill* functions (idempotent rebuild)
txt = re.sub(r"function IB_FillStep takes nothing returns nothing\n.*?\nendfunction\n\n?", "", txt, flags=re.S)
txt = re.sub(r"function IB_Fill\d+ takes nothing returns nothing\n.*?\nendfunction\n\n?", "", txt, flags=re.S)
txt = re.sub(r"function IB_SkillFillStep takes nothing returns nothing\n.*?\nendfunction\n\n?", "", txt, flags=re.S)
txt = re.sub(r"function IB_SkillFill\d+ takes nothing returns nothing\n.*?\nendfunction\n\n?", "", txt, flags=re.S)
txt = re.sub(r"function IB_UnitFillStep takes nothing returns nothing\n.*?\nendfunction\n\n?", "", txt, flags=re.S)
txt = re.sub(r"function IB_UnitFill\d+ takes nothing returns nothing\n.*?\nendfunction\n\n?", "", txt, flags=re.S)

# 2) Replace IB_Init body (整块替换到 endfunction)
pattern = re.compile(
    r"function IB_Init takes nothing returns nothing\n.*?\nendfunction",
    re.S)
if not pattern.search(txt):
    raise SystemExit("IB_Init block not found in f.j")
# 顺序: chunk 函数 -> FillStep -> IB_Init (JASS 要求先定义后引用)
combined = ("\n".join(chunk_funcs) + "\n\n" + "\n".join(skill_funcs) + "\n\n"
            + "\n".join(unit_funcs) + "\n\n"
            + fill_step_block + "\n\n" + skill_fill_step_block + "\n\n"
            + unit_fill_step_block + "\n\n" + init_block)
txt = pattern.sub(lambda m: combined, txt, count=1)

with open(FJ, "w", encoding="utf-8") as fh:
    fh.write(txt)

print("embedded %d items (%d) + %d skills (%d) + %d units (%d) into %s" % (
    len(items), len(chunks), len(skills), len(skill_chunks), len(units), len(unit_chunks), FJ))
