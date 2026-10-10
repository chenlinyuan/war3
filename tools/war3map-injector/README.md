# war3map-injector · War3 地图脚本/数据注入工具

把自定义 JASS 脚本与对象数据（w3a/w3t/w3h/…）注入任意 War3 地图，
支持加密/保护地图。

## 一句话现状

**入口是 `inject_all.py`：一次 HKE 会话干完所有事。**
旧的 `inject_map.py` / `inject_file.py` 每次调用都要完整开关一次工具，
一次部署要开关 4 次、还容易把重压缩强杀掉，已不推荐（保留可用）。

```powershell
# 脚本 + 三个对象数据，一次会话搞定（实测约 30s，旧流程 100s+）
python tools/war3map-injector/inject_all.py "maps/LostTemple/LostTemple_ft_hand.w3x" --script `
    --file tools/war3map-injector/_lt_hand.w3a=war3map.w3a `
    --file tools/war3map-injector/_hand.w3t=war3map.w3t `
    --file tools/war3map-injector/_hand_buff.w3h=war3map.w3h `
    --deploy "LostTemple_ft_阿克蒙德之手.w3x"
```

## 为什么必须用 HKE（不能纯 Python）

实测：`war3mpq.py` 对本项目所有地图都读不出 `war3map.j`——
哈希表解密后 `EMPTY` 条目数为 0，整张表用非标准密钥加密。
所以**优化空间只在"减少 HKE 会话次数"，不在"绕开 HKE"**。

## 工具清单

### 推荐使用

| 文件 | 用途 |
| --- | --- |
| `inject_all.py` | **一键批量注入**：一次会话完成脚本 + 任意多个内部文件替换 |
| `hke_session.py` | HKE 会话层（供上面两个脚本复用，也可被自己的脚本 import） |
| `verify_inject.py` | 注入后校验：另开一次会话解压，检查标记与逐字节一致性 |

`inject_all.py` 常用参数：

| 参数 | 说明 |
| --- | --- |
| `--script [DIR]` | 注入 DIR 的 f.j/g.j/m.j（默认 `scripts/item-browser`） |
| `--file SRC[=内部名]` | 替换地图内部文件，可重复；内部名省略时取文件名 |
| `--script-mode manual\|native\|auto` | 默认 `manual`（自己拼脚本，最稳） |
| `--deploy NAME` | 成功后复制到 `H:\Games\War3\Maps\mod\NAME`（自动清同名前缀旧版本） |
| `--list` | 只列出地图内部文件（诊断用） |
| `--recompress` | 额外点一次「重压缩」（默认不点，见下文） |
| `--kill-stale` | 开始前清理上一次被强杀残留的 HKE 进程 |

### 仍可用（旧流程）

| 文件 | 用途 |
| --- | --- |
| `inject_map.py` | 单次脚本注入（一次开关工具） |
| `inject_file.py` | 单次文件替换（一次开关工具） |
| `inject_script_manual.py` | 自己拼脚本再替换 war3map.j（YDWE 图必需，已被 inject_all 吸收） |
| `inject_campaign_chapters.py` | 批量注入战役各章节脚本 |
| `replace_campaign_chapters.py` | 把改好的章节替换回 .w3n |
| `fix_globals_order.py` | 把自定义变量移到 constant 之后（已被 inject_all 的 native 模式吸收） |

### 数据生成 / 解析

| 文件 | 用途 |
| --- | --- |
| `gen_w3t.py` / `gen_w3a.py` / `gen_w3a_finger.py` / `gen_w3a_crit.py` | 生成物品/技能（war3map.w3t / w3a） |
| `gen_item_abils.py` | 生成物品技能（攻击力光环/攻速） |
| `gen_w3h.py` | 生成/覆盖 buff（war3map.w3h） |
| `merge_w3a.py` / `append_w3obj.py` | 合并/追加 w3obj（append 会保留目标 origCount） |
| `collect_items.py` / `collect_map_items.py` / `collect_skills.py` / `collect_units.py` | 收集物品/技能/单位清单 |
| `build_fj.py` | 把清单嵌入 f.j |
| `validate_dir.py` | 用 pjass 校验脚本目录 |
| `deploy_mod.py` | 部署到 `H:\Games\War3\Maps\mod` |

### 实验性（实测不可用，留作记录）

| 文件 | 状态 |
| --- | --- |
| `war3mpq.py` | 纯 Python MPQ 读；对加密表地图读不出（哈希表 0 个 EMPTY） |
| `inject.py` | 纯 Python 注入；依赖 `war3mpq.py`，同上不可用 |
| `war3mpq.py` 的 list/提取能力仅适用于未加密图 |

## 环境要求

- Windows + Python 3.8+（本机 `C:\Python313\python.exe`）
- `HkeW3mModifier2.0.exe`，路径见 `inject_map.py` 的 `TOOL` 常量
  （`H:\Games\War3\Tools\151个常用脚本\脚本\HKE1.25(5.17美化版）\...`）

## 脚本三部分约定

| 文件 | 注入位置 | 内容 |
| --- | --- | --- |
| `g.j` | `globals ... endglobals` 内（所有 `constant` 之后） | 全局变量 |
| `f.j` | `function main` 之前 | 函数定义 |
| `m.j` | `function main` 开头 | 初始化调用 |

### 编码

本仓库脚本以 **UTF-8** 保存，注入时**按字节原样嵌入**，不做转码。
（`ib_unitNameGbk` 等数组内嵌的是原始 GBK 字节，整体转码会破坏它。）
War3 1.27 按 UTF-8 解析字符串字面量，UTF-8 中文正常；用 `IB_ENCODING` 可覆盖。

## 实测要点（重要，务必先读）

完整记录见 [`docs/06-工具链/HKE行为实测.md`](../../docs/06-工具链/HKE行为实测.md)，
这里只列最容易踩的几条：

1. **「重压缩」可以不用。** 点「添加/替换文件」时地图文件当场就已写好；
   再点「重压缩」实测 30s 内文件毫无变化。工具自带提示
   「重压缩卡死可试试修复MPQ头」，旧脚本点完只等 6~8s 就 `taskkill`，有写坏图的风险。
2. **添加文件前必须先点「自定义文件」。** 默认的「Jass脚本」会把目标名强行
   设成 `war3map.j`，连续替换 w3a/w3t/w3h 会把三个文件全写进 `war3map.j`。
3. **目标名只取文件名。** 源文件要先复制成"文件名 == 内部名"
   （如 `_rep\war3map.w3a`）再选。
4. **列表选择要补发 `LBN_SELCHANGE`。** 只发 `LB_SETCURSEL` 的话，
   「解压文件」会解出上一次的文件。
5. **会话别做太多事。** 多次替换后「解压文件」会失灵（工具说明自己写着
   「不稳定就重启」）。所以：先解压读取，再替换写入；校验另开会话。
6. **别用 `taskkill /IM`。** 会杀掉用户自己开的 HKE；应只结束自己启动的 PID。

## 校验注入

```powershell
python tools/war3map-injector/verify_inject.py "maps/LostTemple/LostTemple_ft_hand.w3x" `
    tools/war3map-injector/_hand.w3t=war3map.w3t
```

输出示例：

```
war3map.j 445714 字节: IB_Init 定义=True, call IB_Init()=1 处, 变量顺序正确=True
war3map.w3t          509 字节, 与源文件一致=True
=== 校验通过 ===
```

## 大批量场景（战役 `血色使命`）

```powershell
# 逐章注入脚本（脚本在本地拼好，绕开 HKE 的 endglobals 重复插入 bug）
python tools/war3map-injector/inject_all.py "maps/campaign/chapter1.w3x" --script

# 战役级共享数据一次替换，而不是每章开一次工具
python tools/war3map-injector/inject_all.py "<战役>.w3n" --no-script `
    --file tools/war3map-injector/_camp_hand.w3a=war3campaign.w3a `
    --file tools/war3map-injector/_camp_hand.w3t=war3campaign.w3t
```

## 仍然需要人工判断的两件事

- **加密类型**：`KKWE 保护`（如 `侏罗纪世界 轮回`）无法注入，HKE 报告"注入成功"
  但 `war3map.j` 不会变，属正常现象。
- **脚本体积**：War3 1.27 的脚本执行上限约 3MB，超了要换更小的图或精简脚本。

## 参考

- HkeW3mModifier2.0（HKE，2010）
- [`docs/06-工具链/地图脚本注入.md`](../../docs/06-工具链/地图脚本注入.md)
- [`docs/06-工具链/HKE行为实测.md`](../../docs/06-工具链/HKE行为实测.md)

## 许可

仅用于**学习与个人单机游戏**，请勿用于作弊或侵犯他人作品。
