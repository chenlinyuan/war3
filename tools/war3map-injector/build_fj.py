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
        # GBK 名称：占位符，稍后替换为 GBK 字节（游戏聊天输入为 GBK）
        lines.append("    set ib_itemNameGbk[%d] = \"@@IGBK%d@@\"" % (idx, idx))
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

# 单位分块 (80/块)
unit_chunks = [units[i:i + CHUNK] for i in range(0, len(units), CHUNK)]
unit_funcs = []
unit_gbk_lines = []
for ci, chunk in enumerate(unit_chunks):
    lines = ["function IB_UnitFill%d takes nothing returns nothing" % ci]
    for k, (uid, nm, armor) in enumerate(chunk):
        idx = ci * CHUNK + k
        lines.append("    set ib_unitList[%d] = '%s'" % (idx, uid))
        lines.append('    set ib_unitName[%d] = "%s"' % (idx, jass_escape(nm)))
        lines.append('    set ib_unitArmor[%d] = "%s"' % (idx, jass_escape(armor)))
        # GBK 名称：占位符，稍后替换为 GBK 字节
        lines.append("    set ib_unitNameGbk[%d] = \"@@GBK%d@@\"" % (idx, idx))
    lines.append("endfunction")
    unit_funcs.append("\n".join(lines))

# 生成 IB_UnitFillStep (匹配实际块数)
unit_fill_step = ["function IB_UnitFillStep takes nothing returns nothing"]
for ci in range(len(unit_chunks)):
    kw = "if" if ci == 0 else "elseif"
    unit_fill_step.append("    %s ib_unFillIdx == %d then" % (kw, ci))
    unit_fill_step.append("        call IB_UnitFill%d()" % ci)
unit_fill_step.append("    endif")
unit_fill_step.append("    set ib_unFillIdx = ib_unFillIdx + 1")
unit_fill_step.append("    if ib_unFillIdx >= ib_unFillTotal then")
unit_fill_step.append("        set ib_unitCount = %d" % len(units))
unit_fill_step.append("        call PauseTimer(ib_unFillTimer)")
unit_fill_step.append("        call DestroyTimer(ib_unFillTimer)")
unit_fill_step.append("        set ib_unFillTimer = null")
unit_fill_step.append("    endif")
unit_fill_step.append("endfunction")
unit_fill_step_block = "\n".join(unit_fill_step)

# IB_Init: 先注册聊天事件,再用 timer 分帧调用各 IB_FillN / IB_SkillFillN / IB_UnitFillN。
init_body = ["function IB_Init takes nothing returns nothing",
             "    set ib_itemCount = 0",
             "    set ib_skillCount = 0",
             "    set ib_unitCount = 0",
             "    call IB_RegisterChat()",
             "    set ib_fillIdx = 0",
             "    set ib_fillTotal = %d" % len(chunks),
             "    set ib_fillTimer = CreateTimer()",
             "    call TimerStart(ib_fillTimer, 0.01, true, function IB_FillStep)",
             "    set ib_skFillIdx = 0",
             "    set ib_skFillTotal = %d" % len(skill_chunks),
             "    set ib_skFillTimer = CreateTimer()",
             "    call TimerStart(ib_skFillTimer, 0.01, true, function IB_SkillFillStep)",
             "    set ib_unFillIdx = 0",
             "    set ib_unFillTotal = %d" % len(unit_chunks),
             "    set ib_unFillTimer = CreateTimer()",
             "    call TimerStart(ib_unFillTimer, 0.01, true, function IB_UnitFillStep)",
             "    call IB_CritInit()",
             "    call IB_FingerCastInit()",
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
# 注意: f.j 可能含上次构建写入的 GBK 字节(ib_unitNameGbk)，用 errors=replace 容错读取；
#       这些字节所在的行会被重新生成，故不影响结果。
with open(FJ, encoding="utf-8", errors="replace") as fh:
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

# 3) 把 @@GBK<idx>@@ 占位替换为真实 GBK 字节（写入时按字节替换）
gbk_map = {i: nm for i, (uid, nm, armor) in enumerate(units)}
for i, nm in gbk_map.items():
    marker = "\x00GBK%d\x00" % i
    txt = txt.replace("@@GBK%d@@" % i, marker)

# 3b) 物品 GBK 名称占位符 -> 标记
item_gbk_map = {i: nm for i, (flag, iid, nm) in enumerate(items)}
for i, nm in item_gbk_map.items():
    marker = "\x00IGBK%d\x00" % i
    txt = txt.replace("@@IGBK%d@@" % i, marker)

# 4) 死亡之指 / 致命一击 技能 ID（可用环境变量覆盖，默认 A000/Azcr）
#    注意: 这两个变量定义在 g.j 中
finger_id = os.environ.get("IB_FINGER_ABILITY", "A000").strip()
crit_id = os.environ.get("IB_CRIT_ABILITY", "Azcr").strip()
gj = os.path.join(REPO, "scripts", "item-browser", "g.j")
gtxt = open(gj, encoding="utf-8").read()
if len(finger_id) == 4:
    gtxt = re.sub(r"integer ib_fingerAbility = '[^']*'",
                  "integer ib_fingerAbility = '%s'" % finger_id, gtxt)
    print("finger ability id = %s" % finger_id)
if len(crit_id) == 4:
    gtxt = re.sub(r"integer ib_critAbility = '[^']*'",
                  "integer ib_critAbility = '%s'" % crit_id, gtxt)
    print("crit ability id = %s" % crit_id)
open(gj, "w", encoding="utf-8").write(gtxt)

# 5) 嵌入"物品技能"判定函数 IB_IsItemAbility（基于游戏 abilitydata.slk X8=item）
itemabil_path = os.path.join(HERE, "_itemabil.txt")
item_abils = []
if os.path.isfile(itemabil_path):
    with open(itemabil_path, encoding="utf-8") as fh:
        for line in fh:
            s = line.strip()
            if len(s) == 4:
                item_abils.append(s)
# 生成 JASS 函数（用 if 链判断，避免大数组）
if item_abils:
    fn = ["function IB_IsItemAbility takes integer abilId returns boolean"]
    for i in range(0, len(item_abils), 8):
        chunk = item_abils[i:i + 8]
        cond = " or ".join("abilId == '%s'" % a for a in chunk)
        kw = "if" if i == 0 else "elseif"
        fn.append("    %s %s then" % (kw, cond))
        fn.append("        return true")
    fn.append("    endif")
    fn.append("    return false")
    fn.append("endfunction")
    itemabil_fn = "\n".join(fn)
    # 先移除旧的 IB_IsItemAbility（幂等重建）
    txt = re.sub(r"function IB_IsItemAbility takes integer abilId returns boolean\n.*?\nendfunction\n\n?",
                 "", txt, flags=re.S)
    # 插入到 f.j 中 IB_SkillIsProtected 函数之前
    txt = txt.replace("function IB_SkillIsProtected takes integer abilId returns boolean",
                      itemabil_fn + "\n\nfunction IB_SkillIsProtected takes integer abilId returns boolean", 1)
    print("embedded %d item abilities" % len(item_abils))

with open(FJ, "wb") as fh:
    # 先按 UTF-8 编码，再把 \x00GBK<idx>\x00 标记替换为 GBK 字节
    data = txt.encode("utf-8")
    for i, nm in gbk_map.items():
        try:
            gbk_bytes = nm.encode("gbk")
        except Exception:
            gbk_bytes = nm.encode("utf-8")
        data = data.replace(("\x00GBK%d\x00" % i).encode("utf-8"), gbk_bytes)
    # 物品 GBK 名称
    for i, nm in item_gbk_map.items():
        try:
            gbk_bytes = nm.encode("gbk")
        except Exception:
            gbk_bytes = nm.encode("utf-8")
        data = data.replace(("\x00IGBK%d\x00" % i).encode("utf-8"), gbk_bytes)
    fh.write(data)

print("embedded %d items (%d) + %d skills (%d) + %d units (%d) into %s" % (
    len(items), len(chunks), len(skills), len(skill_chunks), len(units), len(unit_chunks), FJ))
