# -*- coding: utf-8 -*-
"""从澄海 3C 6.92（W3x2lni SLK 优化图）逐字段导出英雄包。

与旧版 _hero_extract.py 的区别：
  * 技能字段按 AbilityMetaData.slk 的完整定义映射（含弹速、英雄标记、音效等）
  * 1~4 级取 AbilityData.slk，5 级以上取源图 war3map.w3a 的逐级覆盖
  * 单位字段按 UnitMetaData.slk 映射，数值/字符串类型严格区分
  * 一并导出英雄技能依赖的自定义单位（混乱箭矢 hrtt 等）
  * 保留源图文本（技能名/说明/热键/图标/按钮位置）

用法：python hero_port.py [源图] [--outdir 目录]
"""
import csv
import json
import os
import re
import struct
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.dirname(os.path.dirname(HERE))
sys.path.insert(0, HERE)
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

import war3mpq as W  # noqa: E402
import _hero_scan as HS  # noqa: E402
import objparse as O  # noqa: E402
from _slk_obj import parse  # noqa: E402

SRC = r"H:\Games\War3\Maps\mod\ChengHai_3c_692.w3x"
GAME_MPQS = [r"H:\Games\War3\War3Patch.mpq", r"H:\Games\War3\War3x.mpq"]

# 地图数值档案：3C 原版 1.0；LT 是常规图，按比例缩水。
PROFILES = {
    "3c": {
        "arrow": 1.0, "drain": 1.0, "stampede": 1.0, "swarm": 1.0,
        "rain_count": 1.0, "stampede_count": 1.0, "heal": 1.0,
        "req": {"A029": 10, "ACc3": 30, "A0D4": 10, "A0D5": 30,
                "A0S4": 10, "A0S5": 30},
        "skip": {"A029": 5, "A0D4": 5, "A0S4": 5},
    },
    "lt": {
        "arrow": 0.32, "drain": 0.40, "stampede": 0.35, "swarm": 0.32,
        "rain_count": 0.70, "stampede_count": 0.35, "heal": 0.40,
        "req": {"A029": 5, "ACc3": 8, "A0D4": 8, "A0D5": 10,
                "A0S4": 8, "A0S5": 10},
        "skip": {"A029": 3, "A0D4": 2, "A0S4": 2},
        # LT 10 级平滑曲线：三个主技能每级升 1 级，
        # U1 在 4/8 级，U2 在 10 级。
        "skills": {
            "A0L1": (1, 1), "A0L2": (1, 1), "A0L3": (1, 1),
            "A0L4": (4, 4), "A0L5": (10, 1),
            "A0D1": (1, 1), "A0D2": (1, 1), "A0D3": (1, 1),
            "A0D4": (4, 4), "A0D5": (10, 1),
            "A0S1": (1, 1), "A0S2": (1, 1), "A0S3": (1, 1),
            "A0S4": (4, 4), "A0S5": (10, 1),
        },
    },
    "burning": {
        "arrow": 0.60, "drain": 0.65, "stampede": 0.60, "swarm": 0.60,
        "rain_count": 1.0, "stampede_count": 1.0, "heal": 0.60,
        "req": {"A029": 6, "ACc3": 10, "A0D4": 8, "A0D5": 10,
                "A0S4": 8, "A0S5": 10},
        "skip": {"A029": 4, "A0D4": 2, "A0S4": 2},
        # 燃烧最终章节 20 级：三个主技能按 1/2/1 起学、每 2 级升一档，
        # U1 在 10/20 级，U2 在 20 级；点数按已解锁/已学习自动补足。
        "skills": {
            "A0L1": (1, 2), "A0L2": (2, 2), "A0L3": (1, 2),
            "A0L4": (10, 10), "A0L5": (20, 1),
            "A0D1": (1, 2), "A0D2": (2, 2), "A0D3": (1, 2),
            "A0D4": (10, 10), "A0D5": (20, 1),
            "A0S1": (1, 2), "A0S2": (2, 2), "A0S3": (1, 2),
            "A0S4": (10, 10), "A0S5": (20, 1),
        },
        # 燃烧章节里作者已使用 emtg/hpxe/zmar/owyv 等原版 ID；
        # 移植辅助单位改用独立 ID，避免覆盖作者单位。
        "unit_map": {
            # 首字母必须小写：大写 H 开头的自定义单位会被魔兽归为英雄类型。
            "nskk": "n0K1", "emtg": "e0E1", "hrtt": "h0R1",
            "nanb": "n0N1", "zmar": "z0Z1",
            "osp1": "o0P1", "osp2": "o0P2", "osp3": "o0P3",
            "osp4": "o0P4", "hpxe": "h0H1", "owyv": "o0Y1",
            "otbr": "o0O1",
        },
    },
}
# LS-only LT profile: keep the LT learning curve, but use full 3C damage.
PROFILES["lt_ls3c"] = dict(PROFILES["3c"])
PROFILES["lt_ls3c"]["skills"] = PROFILES["lt"]["skills"]
# Blade Master for LT: keep the complete 3C combat values, while using the
# same 10-level learning curve as the other LT heroes.
PROFILES["lt_blade"] = dict(PROFILES["lt_ls3c"])
PROFILES["lt_blade"]["skills"] = dict(PROFILES["lt"]["skills"])
PROFILES["lt_blade"]["skills"].update({
    "A0B1": (1, 1),
    "A0B2": (1, 1),
    "A0B3": (1, 1),
    "A0B4": (4, 3),
    "A0B5": (10, 1),
})
# Firelord keeps the complete 3C combat data. Only the learning curve is
# compacted for Lost Temple's level-10 cap.
PROFILES["lt_fire"] = dict(PROFILES["3c"])
PROFILES["lt_fire"]["skills"] = {
    "A0F1": (1, 1),
    "A0F2": (1, 1),
    "A0F3": (1, 1),
    "A0F4": (4, 4),
    "A0F5": (10, 1),
}
PROFILES["lt_fire"]["unit_map"] = {
    "nlv1": "n0F1",
    "nlv2": "n0F2",
    "nmpe": "n0F3",
    "ospw": "o0F1",
    "nech": "n0F4",
    "hgyr": "h0F1",
}
# Naga uses the same final level cap and Burning-style scaling as 194213.
PROFILES["naga"] = dict(PROFILES["burning"])
PROFILE = "3c"

# (源技能ID, 新技能ID, 基对象)
ABILITIES = [
    ("ANsi", "A0L1", "ANsi", "沉默魔法"),
    ("A015", "A0L2", "ANrc", "混乱箭雨"),
    ("ANdr", "A0L3", "AHdr", "生命汲取"),
    ("A029", "A0L4", "ANst", "穿梭冰箭"),
    ("ACc3", "A0L5", "AUcs", "重影冰箭"),
    ("A02M", "A0L6", "ANch", "符咒"),
    ("A01A", "A0L7", "Afrb", "霜冻呼吸"),
    ("AInv", "A0L8", "AInv", "英雄物品栏"),
    ("ACc2", "A0L9", "AUcs", "冲击波"),
    ("A00X", "A0LA", "ANin", "混乱箭矢"),
]
REMOTE_ABIL = {a: b for a, b, _c, _n in ABILITIES}

# (源单位ID, 新单位ID, 是否英雄, 是否作为原始对象修改)
# 澄海源图就是把 nskk/emtg/hrtt 这三个标准单位原地改掉；
# 这里保持同样做法，避免自定义单位 ID 在召唤时解析不到。
UNITS = [
    ("Hvwd", "H0L1", True, False),
    ("nskk", "nskk", False, True),
    ("emtg", "emtg", False, True),
    ("hrtt", "hrtt", False, True),
]
REMOTE_UNIT = {u: n for u, n, _h, _o in UNITS}

# 只出现在单位技能表里的标准技能别名
STD_ABIL = {
    "ACmi": "Amim",
    "Adtg": "Atru",
}

HERO_CONFIGS = {
    "light_ranger": {
        "source": "Hvwd",
        "name": "光明游侠",
        "out": "light_ranger",
        "abilities": ABILITIES,
        "units": UNITS,
        "std": STD_ABIL,
        "aliases": ["Hvwd", "lightranger", "ls", "gmyx", "guangmingyouxia"],
        "icons": ["ReplaceableTextures\\CommandButtons\\BTNLS15.blp"],
    },
    "demon_hunter": {
        "source": "Edem",
        "name": "恶魔猎手",
        "out": "demon_hunter",
        "abilities": [
            ("A017", "A0D1", "AHdr", "法力燃烧"),
            ("ACcl", "A0D2", "AOcl", "意念漩涡"),
            ("AEev", "A0D3", "AEev", "闪避"),
            ("AEme", "A0D4", "AEme", "变身"),
            ("A024", "A0D5", "Atau", "恶魔气息"),
            ("Afak", "A0D6", "Afak", "恶魔之力"),
            ("AInv", "A0D7", "AInv", "英雄物品栏"),
            ("ACsm", "A0D8", "AHdr", "法力燃烧(假单位)"),
            ("A053", "A0D9", "Amls", "意念漩涡(假单位)"),
            ("AOls", "A0DA", "AUls", "蝗虫群(假单位)"),
        ],
        "units": [
            ("Edem", "H0D1", True, False),
            ("Edmm", "H0D2", True, False),
            ("hgyr", "hgyr", False, True),
            ("hmtt", "hmtt", False, True),
        ],
        "std": {"ACmi": "Amim", "Adtg": "Atru", "A04N": "", "A03C": ""},
        "aliases": ["Edem", "dh", "demonhunter", "emls"],
        "icons": [],
        "unit_drop": {"Edem": ["A0D6"]},
    },
    "shadow_shaman": {
        "source": "Oshd",
        "name": "暗影猎手",
        "out": "shadow_shaman",
        "abilities": [
            ("AOhw", "A0S1", "AOhw", "医疗波"),
            ("AOhx", "A0S2", "AOhx", "妖术"),
            ("AOsw", "A0S3", "AUcs", "毒蛇守卫"),
            ("AOvd", "A0S4", "AOvd", "巫毒"),
            ("A02R", "A0S5", "ANcl", "远祖祝福"),
            ("Amgl", "A0S6", "Amgl", "弹射之刃"),
            ("AInv", "A0S7", "AInv", "英雄物品栏"),
            ("AChx", "A0S8", "AOhx", "群体妖术(假单位)"),
            ("A044", "A0S9", "AOhw", "医疗精灵"),
            ("A045", "A0SA", "AOcl", "闪电精灵"),
            ("Aegr", "A0SB", "AIdd", "元素抗体"),
        ],
        "units": [
            ("Oshd", "H0S1", True, False),
            ("nanb", "nanb", False, True),
            ("zmar", "zmar", False, True),
            ("osp1", "osp1", False, True),
            ("osp2", "osp2", False, True),
            ("osp3", "osp3", False, True),
            ("osp4", "osp4", False, True),
            ("hpxe", "hpxe", False, True),
            ("owyv", "owyv", False, True),
            ("otbr", "otbr", False, True),
        ],
        "std": {"ACmi": "Amim", "Adtg": "Atru"},
        "aliases": ["Oshd", "sh", "xiaoy", "shadowhunter"],
        "primary": "INT",
        "icons": [],
        "unit_drop": {"nanb": ["Awrs", "A01V", "Aens", "A02W",
                               "A02X", "Ara2", "Acht"]},
    },
    "blade_master": {
        "source": "Obla",
        "name": "剑圣",
        "out": "blade_master",
        "abilities": [
            ("AOwk", "A0B1", "AOwk", "疾风跳砍"),
            ("AOmi", "A0B2", "AOmi", "双重镜像"),
            ("AOcr", "A0B3", "AOcr", "致命一击"),
            ("AOww", "A0B4", "AOww", "闪电剑刃"),
            ("ANsh", "A0B5", "AOsh", "闪电冲刺"),
            ("ACff", "A0B6", "Afae", "利刃破甲"),
            ("A02T", "A0B7", "AUcs", "剑刃闪电"),
            ("A038", "A0B8", "AHtc", "辅助雷霆一击"),
            ("AIil", "A0B9", "AIil", "镜像幻影"),
        ],
        "units": [
            ("Obla", "H0B1", True, False),
            ("hgry", "h0B2", False, False),
            ("hmtt", "hmtt", False, True),
            ("ohun", "h0B3", False, False),
        ],
        "std": {},
        "aliases": ["Obla", "blademaster", "blade", "bm", "js",
                    "jiansheng", "huorenjiansheng", "火刃剑圣"],
        "icons": [],
        "unit_drop": {"hgry": ["A04A"]},
    },
    "firelord": {
        "source": "Nfir",
        "name": "火魔",
        "out": "firelord",
        "abilities": [
            ("ANso", "A0F1", "ANso", "灵魂燃烧"),
            ("ANlm", "A0F2", "ANlm", "召唤炎魔"),
            ("ANic", "A0F3", "ANic", "燃灰"),
            ("A041", "A0F4", "AHfs", "火山爆发"),
            ("A020", "A0F5", "ANcl", "炎之绞杀"),
            ("A00V", "A0F6", "Aspb", "炎魔天赋"),
            ("A00W", "A0F7", "Absk", "火焰护甲"),
            ("AInv", "A0F8", "AInv", "英雄物品栏"),
            ("A00U", "A0F9", "Assk", "石化皮肤"),
            ("ANvc", "A0FA", "ANvc", "火山代理"),
            ("A04N", "A0FB", "ANso", "副目标灵魂燃烧"),
            ("Abu3", "A0FC", "Abur", "自爆"),
            ("ANef", "A0FD", "ANef", "熔炼"),
            ("AIsr", "A0FE", "AIsr", "神秘腰带"),
            ("A039", "A0FF", "AHds", "神圣护甲"),
            ("Amls", "A0F0", "Amls", "空中锁镣"),
            ("Amin", "A0G1", "Amin", "自动引爆"),
            ("Adtg", "A0G2", "Atru", "真实视域"),
        ],
        "units": [
            ("Nfir", "H0F1", True, False),
            ("nlv1", "n0F1", False, False),
            ("nlv2", "n0F2", False, False),
            ("nmpe", "n0F3", False, False),
            ("ospw", "o0F1", False, False),
            ("nech", "n0F4", False, False),
            ("hgyr", "h0F1", False, False),
        ],
        "std": {"ACmi": "Amim", "Adtg": "A0G2"},
        "aliases": ["Nfir", "firelord", "fl", "huomo", "huoyanjumo",
                    "火魔", "火焰巨魔"],
        "icons": [],
        "unit_drop": {"hgyr": ["A03C", "ACsm"]},
    },
}

UNIT_TABLES = ["UnitData", "UnitBalance", "UnitUI", "UnitWeapons", "UnitAbilities"]
UNIT_TABLE_KEY = {
    "UnitData": "unitID",
    "UnitBalance": "unitBalanceID",
    "UnitUI": "unitUIID",
    "UnitWeapons": "unitWeapID",
    "UnitAbilities": "unitAbilID",
}

INT_TYPES = {"int", "bool", "deathType", "attackBits", "versionFlags",
             "teamColor", "silenceFlags", "channelType", "channelFlags",
             "morphFlags"}


def obj_type(t):
    if t == "real":
        return 1
    if t == "unreal":
        return 2
    if t in INT_TYPES:
        return 0
    return 3


def conv(t, v):
    k = obj_type(t)
    if k == 0:
        return int(float(v))
    if k in (1, 2):
        return float(v)
    return str(v)


def read_slk_meta(path):
    hdr, rows = parse(path)
    return [{hdr[c]: v for c, v in r.items() if c in hdr} for r in rows.values()]


def load_meta():
    tmp = os.path.join(HERE, "_hero_port_meta.slk")
    out = {}
    for mpq in GAME_MPQS:
        ar = W.MPQArchive(mpq)
        try:
            ok = True
            for name, key in (("Units\\AbilityMetaData.slk", "ability"),
                              ("Units\\UnitMetaData.slk", "unit")):
                data = ar.read_file(name)
                if not data:
                    ok = False
                    break
                open(tmp, "wb").write(data)
                out[key] = read_slk_meta(tmp)
            if ok:
                print("meta <- %s" % os.path.basename(mpq))
                return out
        finally:
            ar.close()
    raise SystemExit("找不到 AbilityMetaData.slk / UnitMetaData.slk")


class AbilityMeta:
    def __init__(self, rows):
        self.plain = {}
        self.repeat = {}
        self.repeat_by_base = {}
        self.data = {}
        self.unitid = {}
        for r in rows:
            fid = r.get("ID", "")
            field = r.get("field", "")
            typ = r.get("type", "string")
            rep = int(float(r.get("repeat", "0") or 0))
            idx = int(float(r.get("data", "0") or 0))
            specs = [s.strip() for s in r.get("useSpecific", "").split(",") if s.strip()]
            if field == "Data" and idx:
                for s in specs:
                    self.data.setdefault(s, {})[idx] = (fid, typ)
            elif field == "UnitID":
                for s in specs:
                    self.unitid[s] = (fid, typ)
            elif rep:
                if specs:
                    for s in specs:
                        self.repeat_by_base.setdefault(s, {})[field] = (fid, typ, idx)
                else:
                    self.repeat.setdefault(field, (fid, typ, idx))
            else:
                self.plain[field] = (fid, typ)

    def repeat_for(self, base, field):
        spec = self.repeat_by_base.get(base, {}).get(field)
        if spec:
            return spec
        return self.repeat.get(field)


class UnitMeta:
    def __init__(self, rows):
        self.by_slk = {}
        for r in rows:
            slk = r.get("slk", "")
            if not slk:
                continue
            self.by_slk.setdefault((slk, r.get("field", "")), []).append(r)

    def pick(self, slk, field, hero):
        cands = self.by_slk.get((slk, field), [])
        if not cands:
            return None
        flags = ("useHero", "useUnit") if hero else ("useUnit", "useHero")
        for flag in flags:
            for r in cands:
                if r.get(flag, "0") == "1":
                    return r["ID"], r.get("type", "string")
        return cands[0]["ID"], cands[0].get("type", "string")


def split_csv(s):
    if s is None or s == "":
        return []
    try:
        return next(csv.reader([s], skipinitialspace=True, quotechar='"'))
    except Exception:  # noqa: BLE001
        return [s]


def remap_abil_list(s):
    out = []
    for x in split_csv(s):
        x = x.strip()
        if not x:
            continue
        y = REMOTE_ABIL.get(x, STD_ABIL.get(x, x))
        if y and y not in out:
            out.append(y)
    return ",".join(out)


def ability_mods(am, base, row, strings, overrides):
    mods = []
    unknown = []

    def add(mid, t, level, col, val):
        mods.append([mid, t, level, col, val])

    def remap_ref(value, typ):
        if typ in ("abilCode", "abilityList"):
            return ",".join(
                REMOTE_ABIL.get(x.strip(), x.strip())
                for x in split_csv(value)
                if x.strip()
            )
        if typ in ("unitCode", "unitList"):
            return ",".join(
                REMOTE_UNIT.get(x.strip(), x.strip())
                for x in split_csv(value)
                if x.strip()
            )
        return value

    for col, val in row.items():
        if col in ("alias", "code", "comments", "version", "useInEditor", "InBeta"):
            continue
        if val in ("", "-", "_"):
            continue
        rep = re.match(r"^(Area|Cool|Cost|Cast|Dur|HeroDur|Rng|targs|BuffID|EfctID|UnitID)(\d+)$", col)
        if rep:
            key = rep.group(1)
            n = int(rep.group(2))
            if key == "UnitID":
                spec = am.unitid.get(base)
                if not spec:
                    unknown.append(col)
                    continue
                fid, typ = spec
                v = remap_ref(val, typ)
                add(fid, obj_type(typ), n, 0, conv(typ, v))
                continue
            spec = am.repeat_for(base, key)
            if not spec:
                unknown.append(col)
                continue
            fid, typ, idx = spec
            v = remap_ref(val, typ)
            add(fid, obj_type(typ), n, idx, conv(typ, v))
            continue
        if col[:4] == "Data" and col[4:5] in "ABCDEFGHI" and col[5:].isdigit():
            idx = ord(col[4]) - 64
            n = int(col[5:])
            spec = am.data.get(base, {}).get(idx)
            if not spec:
                unknown.append(col)
                continue
            fid, typ = spec
            v = remap_ref(val, typ)
            add(fid, obj_type(typ), n, idx, conv(typ, v))
            continue
        if col == "levels":
            add("alev", 0, 0, 0, int(float(val)))
            continue
        if col in am.plain:
            fid, typ = am.plain[col]
            add(fid, obj_type(typ), 0, 0, conv(typ, val))
            continue
        unknown.append(col)

    # 文本字段
    fixed = {
        "Name": ("anam", "string"),
        "EditorSuffix": ("ansf", "string"),
        "Art": ("aart", "string"),
        "ResearchArt": ("arar", "string"),
        "Requires": ("areq", "string"),
        "Unart": ("auar", "string"),
        "Unhotkey": ("auhk", "string"),
        "CasterArt": ("acat", "string"),
        "TargetArt": ("atat", "string"),
        "SpecialArt": ("asat", "string"),
        "EffectArt": ("aeat", "string"),
        "Missileart": ("amat", "string"),
        "Missilespeed": ("amsp", "int"),
        "Casterattach": ("acap", "string"),
        "Targetattach": ("ata0", "string"),
        "Animnames": ("aani", "string"),
        "Order": ("aord", "string"),
        "Hotkey": ("ahky", "string"),
        "Researchhotkey": ("arhk", "string"),
        "Researchtip": ("aret", "string"),
        "Researchubertip": ("arut", "string"),
        "Effectsound": ("aefs", "string"),
        "Effectsoundlooped": ("aefl", "string"),
        "LightningEffect": ("alig", "string"),
    }
    for key, (fid, typ) in fixed.items():
        v = strings.get(key, "")
        if v not in ("", "-", "_"):
            if key == "Requires":
                v = REMOTE_UNIT.get(v, v)
            add(fid, obj_type(typ), 0, 0, conv(typ, v))

    # Auto-cast abilities (notably 3C's ACff / Faerie Fire) carry separate
    # order strings for toggled-on/off states.  The base object has defaults,
    # but preserving the source strings is required for a faithful port.
    for key, fid in (("Unorder", "aoru"), ("Orderon", "aoro"),
                     ("Orderoff", "aorf")):
        v = strings.get(key, "")
        if v not in ("", "-", "_"):
            add(fid, 3, 0, 0, v)

    for key, (x, y) in (("Buttonpos", ("abpx", "abpy")),
                        ("Researchbuttonpos", ("arpx", "arpy")),
                        ("UnButtonpos", ("aubx", "auby"))):
        v = strings.get(key, "")
        if "," in v:
            a, b = v.split(",", 1)
            if a.strip():
                add(x, 0, 0, 0, int(float(a)))
            if b.strip():
                add(y, 0, 0, 0, int(float(b)))

    for key, fid in (("Tip", "atp1"), ("Ubertip", "aub1"),
                     ("Untip", "aut1"), ("Unubertip", "auu1")):
        vals = split_csv(strings.get(key, ""))
        for i, v in enumerate(vals, 1):
            if v.strip() not in ("", "-", "_"):
                add(fid, 3, i, 0, v.strip())

    # 源图 w3a 里 5 级以上的逐级数据（原样搬过来）
    for mid, t, level, col, v in overrides:
        if level and level > 4:
            add(mid, t, level, col, v)

    # W3x2lni 的 SLK 行是“完整行”：没写出来的数值字段就是 0，
    # 不会从基对象继承。1~4 级必须补齐 0，否则会把基对象的冷却/耗魔带进来。
    # （5 级以上按 WC3 规则沿用第 4 级，或由 w3a 覆盖提供。）
    max_lv = min(4, int(float(row.get("levels", "1") or 1)))
    have = {(m[0], m[2], m[3]) for m in mods}
    for key in ("Area", "Cool", "Cost", "Cast", "Dur", "HeroDur", "Rng"):
        spec = am.repeat_for(base, key)
        if not spec:
            continue
        fid, typ, idx = spec
        zero = 0 if obj_type(typ) == 0 else 0.0
        for lv in range(1, max_lv + 1):
            if (fid, lv, idx) not in have:
                add(fid, obj_type(typ), lv, idx, zero)
    for idx, (fid, typ) in am.data.get(base, {}).items():
        zero = 0 if obj_type(typ) == 0 else (0.0 if obj_type(typ) in (1, 2) else "")
        for lv in range(1, max_lv + 1):
            if (fid, lv, idx) not in have:
                add(fid, obj_type(typ), lv, idx, zero)

    # 自定义技能行里没写的 checkDep/priority/levelSkip 同样是 0
    if row.get("code") != row.get("alias"):
        for key, fid in (("checkDep", "achd"), ("priority", "apri"),
                         ("levelSkip", "alsk")):
            if key not in row:
                add(fid, 0, 0, 0, 0)

    return dedupe(mods), unknown


def dedupe(mods):
    seen = {}
    order = []
    for m in mods:
        key = (m[0], m[2], m[3])
        if key not in seen:
            order.append(key)
        seen[key] = m
    return [seen[k] for k in order]


def complete_ability_levels(mods):
    """Fill missing per-level fields from the nearest lower defined level.

    Warcraft falls back to the base object when a 5-10 level field is absent.
    For a ported 10-level skill that means e.g. ANrc can revert to its default
    Infernal UnitID. Filling the gap keeps the ported source data authoritative.
    """
    max_lv = 1
    for m in mods:
        if m[0] == "alev":
            max_lv = int(m[4])
            break
    if max_lv <= 1:
        return mods
    groups = {}
    for m in mods:
        if m[2] and m[2] > 0:
            groups.setdefault((m[0], m[3]), {})[m[2]] = m
    for (fid, col), vals in groups.items():
        for lv in range(1, max_lv + 1):
            if lv in vals:
                continue
            lower = [x for x in vals if x < lv]
            src = max(lower) if lower else min(vals)
            m = vals[src]
            newm = [fid, m[1], lv, col, m[4]]
            mods.append(newm)
            vals[lv] = newm
    return dedupe(mods)


def apply_profile(new_id, mods, prof):
    """按地图档案缩放数值（build 时直接写进对象数据）。"""
    def scale(mids, factor, minimum=0):
        for m in mods:
            if m[0] in mids and isinstance(m[4], (int, float)):
                v = m[4] * factor
                m[4] = max(minimum, int(round(v)) if isinstance(m[4], int) else round(v, 3))

    if new_id == "A0L2":
        scale(("Nrc2",), prof["rain_count"], 1)
    elif new_id == "A0L3":
        scale(("Ndr1", "Ndr4"), prof["drain"])
    elif new_id == "A0L4":
        scale(("Nst1",), prof.get("stampede_count", prof["stampede"]), 1)
        scale(("Nst3", "Nst4"), prof["stampede"])
    elif new_id == "A0L9":
        scale(("Ucs1",), prof["swarm"])
    elif new_id in ("A0D1", "A0D8"):
        scale(("Ndr1", "Ndr2"), prof["drain"])
    elif new_id == "A0DA":
        scale(("Uls1",), prof["swarm"])
    elif new_id == "A0S1":
        scale(("Ocl1",), prof["heal"])
    elif new_id in ("hrtt", "H0R1"):
        scale(("ua1b",), prof["arrow"], 1)

    plan = prof.get("skills", {}).get(new_id)
    if plan:
        req, skip = plan
        found_req = False
        found_skip = False
        for m in mods:
            if m[0] == "arlv":
                m[4] = req
                found_req = True
            elif m[0] == "alsk":
                m[4] = skip
                found_skip = True
        if not found_req:
            mods.append(["arlv", 0, 0, 0, req])
        if not found_skip:
            mods.append(["alsk", 0, 0, 0, skip])
        return complete_ability_levels(dedupe(mods))

    req_map = {"A0L4": "A029", "A0L5": "ACc3", "A0D4": "A0D4",
               "A0D5": "A0D5", "A0S4": "A0S4", "A0S5": "A0S5"}
    if new_id in req_map:
        key = req_map[new_id]
        for m in mods:
            if m[0] == "arlv":
                m[4] = prof["req"].get(key, m[4])
            if m[0] == "alsk" and key in prof.get("skip", {}):
                m[4] = prof["skip"][key]
    if prof.get("skills"):
        mods = complete_ability_levels(mods)
    return mods


def unit_mods(um, tables, src_id, hero, strings, drop=()):
    mods = []
    unknown = []
    for slk in UNIT_TABLES:
        key = UNIT_TABLE_KEY[slk]
        hdr = None
        row = {}
        for _idx, h, rows in tables.get(key, []):
            for _r, cells in rows.items():
                if cells.get(1, "") == src_id:
                    hdr = h
                    row = {h[c]: v for c, v in cells.items() if c in h}
                    break
            if hdr:
                break
        if not hdr:
            continue
        for col in hdr.values():
            if col in UNIT_TABLE_KEY.values():
                continue
            meta = um.pick(slk, col, hero)
            if not meta:
                if col not in ("name",):
                    unknown.append(slk + "." + col)
                continue
            fid, typ = meta
            val = row.get(col)
            if val is None or val == "":
                val = "" if obj_type(typ) == 3 else 0
            elif val in ("-", "_"):
                val = "" if obj_type(typ) == 3 else 0
            if col in ("abilList", "heroAbilList"):
                val = remap_abil_list(val)
                if drop:
                    val = ",".join(x for x in val.split(",") if x and x not in drop)
                typ = "string"
            mods.append([fid, obj_type(typ), None, None, conv(typ, val)])

    for key, fid in (("Name", "unam"), ("Propernames", "upro"),
                     ("Art", "uico"), ("Tip", "utip"), ("Ubertip", "utub"),
                     ("Hotkey", "uhot"), ("Revivetip", "urev"),
                     ("Awakentip", "uawt")):
        v = strings.get(key, "")
        if v in ("-", "_"):
            v = ""
        if v != "" or key in ("Ubertip", "Tip", "Propernames", "Hotkey",
                              "Revivetip", "Awakentip"):
            mods.append([fid, 3, None, None, v])
    return dedupe(mods), unknown


def write_obj(path, entries, ext):
    orig, cust = [], []
    for e in entries:
        fixed = []
        for mid, t, level, col, v in e["mods"]:
            fixed.append([mid, t, 0 if level is None else level,
                          0 if col is None else col, v])
        target = orig if e.get("orig") else cust
        new_id = "\x00\x00\x00\x00" if e.get("orig") else e["new"]
        target.append({"old": e["old"], "new": new_id, "mods": fixed})
    data = O.build_bytes(2, orig, cust, ext)
    open(path, "wb").write(data)
    print("wrote %s (%d orig + %d custom, %d bytes)" % (
        path, len(orig), len(cust), len(data)), flush=True)


def main():
    global PROFILE, ABILITIES, UNITS, REMOTE_ABIL, REMOTE_UNIT, STD_ABIL
    src = sys.argv[1] if len(sys.argv) > 1 and not sys.argv[1].startswith("--") else SRC
    outdir = os.path.join(BASE, "heroes", "light_ranger")
    if "--outdir" in sys.argv:
        outdir = sys.argv[sys.argv.index("--outdir") + 1]
    if "--profile" in sys.argv:
        PROFILE = sys.argv[sys.argv.index("--profile") + 1]
        if PROFILE not in PROFILES:
            raise SystemExit("未知数值档案: %s" % PROFILE)
    os.makedirs(outdir, exist_ok=True)
    hero = "light_ranger"
    if "--hero" in sys.argv:
        hero = sys.argv[sys.argv.index("--hero") + 1]
    if hero not in HERO_CONFIGS:
        raise SystemExit("unknown hero: %s" % hero)
    cfg = HERO_CONFIGS[hero]
    ABILITIES = cfg["abilities"]
    UNITS = cfg["units"]
    unit_map = PROFILES[PROFILE].get("unit_map", {})
    if unit_map:
        UNITS = [
            (src, unit_map.get(src, dst), is_hero,
             False if unit_map.get(src, dst) != dst else is_orig)
            for src, dst, is_hero, is_orig in UNITS
        ]
    REMOTE_ABIL = {a: b for a, b, _c, _n in ABILITIES}
    REMOTE_UNIT = {u: n for u, n, _h, _o in UNITS}
    STD_ABIL = cfg["std"]
    if "--outdir" not in sys.argv:
        outdir = os.path.join(BASE, "heroes", cfg["out"])
    os.makedirs(outdir, exist_ok=True)

    blocks = HS.read_all_blocks(src)
    tables = HS.slk_tables(blocks)
    secs = HS.text_sections(blocks)
    meta = load_meta()
    am = AbilityMeta(meta["ability"])
    um = UnitMeta(meta["unit"])

    overrides = {}
    for _idx, d in blocks:
        try:
            _v, orig, _cust = O.read_bytes(d, "w3a")
        except Exception:  # noqa: BLE001
            continue
        if orig:
            for e in orig + _cust:
                overrides.setdefault(e["old"], []).extend(e["mods"])
            break
    print("源图 w3a 覆盖: %d 个技能" % len(overrides))

    abil_entries = []
    manifest_abil = []
    for src_id, new_id, base, cn in ABILITIES:
        if src_id == "AItc":
            # AItc/AIat is the standard green attack-damage bonus ability.
            # It lives in the game MPQs rather than the 3C map's optimized
            # ability tables, so provide the small synthetic row explicitly.
            row = {"alias": "AItc", "code": "AIat", "levels": "10",
                   "reqLevel": "0", "levelSkip": "0"}
            for i in range(1, 11):
                row["DataA%d" % i] = str(i * 120)
            strings = {"Name": "疾风攻击加成"}
        else:
            row = HS.row_by_key(tables.get("alias"), src_id)
            if not row:
                raise SystemExit("源图没有技能 %s" % src_id)
            strings = secs.get(src_id, {})
        mods, unknown = ability_mods(am, base, row, strings, overrides.get(src_id, []))
        # The extra 3C mirror phantoms are authored as 5-second AIil
        # illusions.  Keep the source duration; only replace the LT legacy
        # "幻象物品" display with the requested deceptive label.
        if src_id == "AIil":
            for m in mods:
                if m[0] == "anam":
                    m[4] = "分身"
        if False:
            # The green attack-bonus experiment carries the fixed damage;
            # keep native Wind Walk from adding it a second time.
            for m in mods:
                if m[0] == "Owk3":
                    m[4] = 0.0
        if src_id in ("ANsi", "A015", "ANdr", "A029", "ACc3",
                      "A017", "ACcl", "AEev", "AEme", "A024",
                      "AOwk", "AOmi", "AOcr", "AOww", "ANsh",
                      "ANso", "ANlm", "ANic", "A041", "A020"):
            mods = [m for m in mods if m[0] != "aher"]
            mods.insert(0, ["aher", 0, 0, 0, 1])
        # 用户要求混乱箭雨保留冰箭、去掉源图的陨石特效（XErc）
        if src_id == "A015":
            mods = [m for m in mods if m[0] != "aeff"]
            for lv in range(1, 5):
                mods.append(["aeff", 3, lv, 0, ""])
        # 源图 A01A 的 Art 是空字符串，游戏里会显示绿块；换成霜冻呼吸图标
        if src_id == "A01A":
            frost_icon = r"ReplaceableTextures\PassiveButtons\PASBTNFreezingBreath.blp"
            mods = [m for m in mods if m[0] not in ("aart", "arar")]
            mods.append(["aart", 3, 0, 0, frost_icon])
            mods.append(["arar", 3, 0, 0, frost_icon])
        # 混乱箭矢（ANin）继承基对象的 EffectArt=InfernalBirth（地狱火从天而降），
        # 清掉它，避免每一波箭雨里还夹着地狱火。
        if src_id == "A00X":
            mods = [m for m in mods if m[0] != "aeat"]
            mods.append(["aeat", 3, 0, 0, ""])
            # 雨里每支箭可能以不同等级施放；1~4 级全部指向 hrtt
            lv1 = [m for m in mods if m[2] == 1]
            for lv in (2, 3, 4):
                for mid, t, _l, col, val in lv1:
                    if mid in ("Uin1", "Uin2", "Uin3", "Uin4", "adur", "ahdu",
                               "aare", "aran", "atar", "abuf"):
                        mods.append([mid, t, lv, col, val])
            mods = dedupe(mods)
        # 重影冰箭（AUcs）会继承腐臭蜂群的 Missileart/SpecialArt，
        # 换成和假单位 ACc2 一样的冰箭/冰霜特效。
        if src_id == "ACc3":
            frost = r"Abilities\Spells\Other\FrostDamage\FrostDamage.mdl"
            missile = r"Abilities\Weapons\ColdArrow\ColdArrowMissile.mdl"
            mods = [m for m in mods if m[0] not in ("amat", "asat", "aeat")]
            mods.append(["amat", 3, 0, 0, missile])
            mods.append(["asat", 3, 0, 0, frost])
            mods.append(["aeat", 3, 0, 0, ""])
            mods = dedupe(mods)
        # 恶魔气息：BTNDispelMagic 没有 DISBTN，学习面板会绿块；
        # 命令卡保留原图标，学习面板换成有 DISBTN 的 Howl of Terror。
        if src_id == "A024":
            mods = [m for m in mods if m[0] != "arar"]
            mods.append(["arar", 3, 0, 0,
                         r"ReplaceableTextures\CommandButtons\BTNHowlOfTerror.blp"])
            mods = dedupe(mods)
        # 意念漩涡：源图目标表带 hero，LT 里点野怪会没有指针；
        # 去掉 hero 限制，触发器仍然只拴英雄。
        if src_id == "ACcl":
            for m in mods:
                if m[0] == "atar" and isinstance(m[4], str):
                    m[4] = ",".join(x for x in m[4].split(",") if x and x != "hero")
        # 法力燃烧主目标会长时间挂着 ManaBurnTarget 火焰；去掉目标艺术，
        # 只保留 MBUR 吸取光束和假单位的伤害波。
        if src_id == "A017":
            mods = [m for m in mods if m[0] != "atat"]
        # 游戏基础 AOwd 只有 1 级容量；3C 的 SLK 把它扩到了 10 级。
        # LT 没有这张 SLK，任何 >1 级的 UnitID/数量都会越界崩溃。
        # 这里把技能压成 1 级，守卫数量/等级由触发器按英雄等级生成。
        # 远祖祝福的源数据 Options=30 也不含 Visible 位，补上 0x01
        if src_id == "A02R":
            mods = [m for m in mods if m[0] not in ("Ncl1", "Ncl2", "Ncl4")]
            # Ncl1 = Follow Through Time. 30 秒不是冷却，而是 Channel
            # 让施法者维持引导的时间；Ncl4 是施法美术时长，不要写成 30。
            mods.append(["Ncl1", 2, 1, 1, 30.0])
            mods.append(["Ncl2", 0, 1, 2, 0])
            mods.append(["Ncl3", 0, 1, 3, 1])
            mods.append(["Ncl4", 2, 1, 4, 0.0])
            mods.append(["auar", 3, 0, 0,
                         r"ReplaceableTextures\CommandButtons\BTNSH30.blp"])
            mods = dedupe(mods)
        # 群体妖术的假单位会按施法者的妖术等级施放 A0S8。AOhx 的
        # 第 5~10 级在 LT 没有完整数据，假单位会回退到基础妖术的高耗魔，
        # 结果只能对主目标生效。把 1~4 级模板补满 10 级，并让假技能免魔。
        if src_id == "AChx":
            for m in list(mods):
                if m[2] and m[2] <= 4:
                    for lv in range(5, 11):
                        if not any(n[0] == m[0] and n[2] == lv and
                                   n[3] == m[3] for n in mods):
                            mods.append([m[0], m[1], lv, m[3], m[4]])
            for m in mods:
                if m[0] == "amcs":
                    m[4] = 0
                elif m[0] == "acdn":
                    m[4] = 0.0
                elif m[0] == "aran":
                    m[4] = 800.0
            mods = dedupe(mods)
        # AOwd/AOsw 在 LT 上都会崩；用点目标、无召唤数据的 AUcs 做施法壳，
        # 守卫由触发器按英雄等级生成。
        if src_id == "AOsw":
            mods = [m for m in mods if m[0] not in ("Hwe1", "Hwe2")]
            for m in mods:
                if m[0] == "aord":
                    m[4] = "carrionswarm"
            mods = [m for m in mods if m[0] not in
                    ("aani", "alev", "Ucs1", "Ucs2", "Ucs3", "Ucs4")]
            mods.append(["alev", 0, 0, 0, 10])
            mods.append(["aani", 3, 0, 0, "spell"])
            # AUcs 的 MissileArt/SpecialArt 会带出腐臭蜂群飞行特效；
            # 守卫由触发器创建，只需要施法动作，不需要蜂群美术。
            mods = [m for m in mods if m[0] not in
                    ("amat", "asat", "aeat", "acat", "atat", "alig")]
            mods.append(["amat", 3, 0, 0, ""])
            mods.append(["asat", 3, 0, 0, ""])
            mods.append(["aeat", 3, 0, 0, ""])
            mods.append(["acat", 3, 0, 0, ""])
            mods.append(["atat", 3, 0, 0, ""])
            mods.append(["alig", 3, 0, 0, ""])
            for lv in range(1, 11):
                mods.append(["Ucs1", 2, lv, 1, 0.0])
                mods.append(["Ucs2", 2, lv, 2, 0.0])
                mods.append(["Ucs3", 2, lv, 3, 0.0])
                mods.append(["Ucs4", 2, lv, 4, 0.0])
            for key in ("Area", "Cool", "Cost", "Cast", "Dur",
                        "HeroDur", "Rng"):
                spec = am.repeat_for(base, key)
                if not spec:
                    continue
                fid, typ, idx = spec
                zero = 0 if obj_type(typ) == 0 else 0.0
                have = {(m[0], m[2], m[3]) for m in mods}
                for lv in range(1, 11):
                    if (fid, lv, idx) not in have:
                        mods.append([fid, obj_type(typ), lv, idx, zero])
            for m in mods:
                if m[0] in ("adur", "ahdu"):
                    m[4] = 36.0
            for m in mods:
                if m[0] == "aub1" and isinstance(m[4], str):
                    m[4] = m[4].replace("持续36秒", "守卫等级随技能提升，持续36秒")
            mods = dedupe(mods)
        mods = apply_profile(new_id, mods, PROFILES[PROFILE])
        abil_entries.append({"old": base, "new": new_id, "mods": mods})
        manifest_abil.append({
            "source": src_id, "base": base, "id": new_id,
            "name": strings.get("Name", cn),
            "levels": int(float(row.get("levels", "1") or 1)),
        })
        print("ability %-5s -> %-4s (%s) %-8s mods=%-3d 未映射=%s" % (
            src_id, new_id, base, strings.get("Name", cn), len(mods),
            ",".join(unknown) if unknown else "无"))
    write_obj(os.path.join(outdir, "hero.w3a"), abil_entries, "w3a")

    unit_entries = []
    for src_id, new_id, is_hero, is_orig in UNITS:
        strings = secs.get(src_id, {})
        drop = cfg.get("unit_drop", {}).get(src_id, ())
        mods, unknown = unit_mods(um, tables, src_id, is_hero, strings, drop)
        if new_id == "h0B2":
            # The LT mirror illusion template inherits an old visible name
            # from the base object; use the requested deceptive label.
            for m in mods:
                if m[0] == "unam":
                    m[4] = "分身"
        if new_id == "H0F1":
            # The hero frame uses upro for the proper name and unam for the
            # class shown after the level. Keep them distinct and explicit.
            replacements = {
                "unam": "火焰巨魔",
                "upro": "拉格纳罗斯(FL)",
                "utip": "火焰巨魔",
                "uico": (
                    r"ReplaceableTextures\CommandButtons"
                    r"\BTNFirelordAvatar_30HD.blp"
                ),
                "ussi": (
                    r"ReplaceableTextures\CommandButtons"
                    r"\BTNFirelordAvatar_30HD.blp"
                ),
            }
            present = {m[0] for m in mods}
            for mod in mods:
                if mod[0] in replacements:
                    mod[4] = replacements[mod[0]]
                elif mod[0] == "upru":
                    mod[4] = 1
            for field, value in replacements.items():
                if field not in present:
                    mods.append([field, 3, None, None, value])
            if "upru" not in present:
                mods.append(["upru", 0, None, None, 1])
        elif new_id == "h0F1":
            # 1.27 resolves some custom-unit UI lookups case-insensitively.
            # This helper shares the same letters as H0F1 and would otherwise
            # leak its "Flying Machine" icon and empty proper name into the
            # Firelord's hero frame.
            replacements = {
                "unam": "火焰巨魔",
                "upro": "拉格纳罗斯(FL)",
                "utip": "火焰巨魔",
                "uico": (
                    r"ReplaceableTextures\CommandButtons"
                    r"\BTNFirelordAvatar_30HD.blp"
                ),
                "ussi": (
                    r"ReplaceableTextures\CommandButtons"
                    r"\BTNFirelordAvatar_30HD.blp"
                ),
            }
            present = {m[0] for m in mods}
            for mod in mods:
                if mod[0] in replacements:
                    mod[4] = replacements[mod[0]]
                elif mod[0] == "upru":
                    mod[4] = 1
            for field, value in replacements.items():
                if field not in present:
                    mods.append([field, 3, None, None, value])
            if "upru" not in present:
                mods.append(["upru", 0, None, None, 1])
        primary = cfg.get("primary")
        if primary:
            for m in mods:
                if m[0] == "upra":
                    m[4] = primary
        tier = {"osp1": 1, "osp2": 2, "hpxe": 3,
                "osp4": 4, "osp3": 5}.get(src_id)
        if tier:
            for m in mods:
                if m[0] == "unam":
                    m[4] = "毒蛇守卫 |cffffcc00[等级 %d]|r" % tier
                elif m[0] == "utub":
                    m[4] = "固定不动的毒蛇守卫，攻击地面和空中单位。魔法免疫。36秒后自动消失。"
        mods = apply_profile(new_id, mods, PROFILES[PROFILE])
        unit_entries.append({"old": src_id, "new": new_id, "mods": mods,
                             "orig": is_orig})
        print("unit %-5s -> %-4s %-8s mods=%-3d %s 未映射=%s" % (
            src_id, new_id, strings.get("Name", ""), len(mods),
            "orig" if is_orig else "custom",
            ",".join(unknown) if unknown else "无"))
    write_obj(os.path.join(outdir, "hero.w3u"), unit_entries, "w3u")

    hero_row = HS.row_by_key(tables.get("unitBalanceID"), cfg["source"])
    manifest = {
        "hero": cfg["name"],
        "profile": PROFILE,
        "source_map": src,
        "source_unit": cfg["source"],
        "unit": UNITS[0][1],
        "aliases": cfg.get("aliases", []),
        "units": {u: n for u, n, _h, _o in UNITS},
        "abilities": manifest_abil,
        "stats": hero_row,
        "icon_files": cfg.get("icons", []),
    }
    open(os.path.join(outdir, "manifest.json"), "w", encoding="utf-8").write(
        json.dumps(manifest, ensure_ascii=False, indent=2))
    print("manifest ->", os.path.join(outdir, "manifest.json"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
