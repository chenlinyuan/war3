# w3xd-toolkit

[English](README.md) · **简体中文**

把 **魔兽争霸 III：重铸版 3.0** 的战役地图容器（`.w3xd`）解密成普通的 `.w3x` 地图，
按真实路径导出其中的成员，并把内部的 Lua 5.3 字节码反编译回可读源码。

* **不需要密钥** —— license 直接从容器本身恢复。
* **零依赖** —— AES、CCM 和 GF(2) 求解器都是自己实现的。
* 支持 Linux / macOS / Windows（Windows 上会自动走 CNG 加速路径）。
* **53 个单元测试**，全部自行合成容器与归档，不依赖任何游戏数据。

```console
$ w3xd unpack HumanRE01.w3xd
license 0x...  -> HumanRE01.w3x (5,622,820 bytes)
67 members (67 named), 14,351,676 bytes -> HumanRE01.files

$ luac53 decompile HumanRE01.files/war3map.luac
war3map.luac -> war3map.lua (1,945,651 bytes)
```

---

## 目录

| | |
|---|---|
| [背景](#背景) | `.w3xd` 是什么，为什么编辑器打不开 |
| [安装](#安装) | 环境要求与配置 |
| [用法](#用法) | `w3xd` 与 `luac53` 命令参考 |
| [license 值](#license-值) | 为什么不需要事先知道它 |
| [格式文档](#格式文档) | 逆向出来的格式细节 |
| [扫描 CASC 安装目录](#扫描-casc-安装目录) | 找出磁盘上所有容器 |
| [仓库结构](#仓库结构) | 各目录的用途 |
| [参与贡献](#参与贡献) | 怎么帮忙，以及三条底线 |
| [合规声明](#合规声明) | 使用或再分发前请先读这一节 |

---

## 背景

重铸版 3.0 的战役地图以 `.w3xd` 形式分发 —— 地图数据和 `.w3x` 完全一样，
只是外面套了一层容器，由游戏在加载时脱壳：

```
磁盘上的 .w3xd
   |  第 1 层：xorshift32 XOR 流，覆盖整个文件，种子来自 (size, license)
   |  第 2 层：AES-256-CCM，覆盖 payload，密钥由 64 位 license 派生
   v
普通 MPQ 归档  ==  一张标准的 .w3x 地图
```

payload 就是一个再普通不过的 MPQ，世界编辑器本来能打开它 —— 但要先把两层剥掉。
文件里没有任何明文特征，所以 CascView 只能原样导出，编辑器则直接拒绝。

`w3xd-toolkit` 负责剥掉这两层。

## 安装

需要 Python 3.8 或更高版本，不需要安装任何 pip 包。

```bash
git clone https://github.com/mythic-p/w3xd-toolkit
cd w3xd-toolkit
python -m unittest discover -s tests -t .      # 可选：53 个测试，1 秒内跑完
```

就地运行：

```bash
python -m w3xd --help
python -m luac53 --help
```

或者安装命令行入口：

```bash
pip install -e .
w3xd --help
luac53 --help
```

**反编译**（相对解密而言）额外需要 Java 和
[unluac](https://github.com/HansWessels/unluac)，脚本可以自动拉取并编译：

```bash
scripts/get-unluac.sh          # Linux/macOS
scripts\get-unluac.ps1         # Windows PowerShell
```

它会装到 `tools/unluac/`（已被 gitignore）。也可以直接把 `UNLUAC_JAR` 指向任意 unluac jar。

## 用法

### `w3xd` —— 容器

```
w3xd info     FILE.w3xd [--payload] [--key-material]   结构、大小、license
w3xd license  FILE.w3xd [--key]                        打印 license 或 AES 密钥
w3xd decrypt  FILE.w3xd [-o OUT.w3x]                   容器 -> 地图
w3xd extract  FILE.w3x  [-o DIR]                       已解密地图的成员
w3xd unpack   FILE.w3xd [-o OUT.w3x] [-d DIR]          一步完成解密 + 导出
w3xd batch    DIR [-x]                                 批量处理目录下所有 .w3xd
```

```console
$ w3xd info HumanRE02Interlude.w3xd
file          : HumanRE02Interlude.w3xd
size          : 528,645 bytes
xorshift seed : 0x86c7da45  (matches size/license formula: True)
trailer       : version=1 flags=6 block_size=0x40
header size   : 154
payload size  : 528,427 bytes
license       : 0x0123456789abcdef
AES-256 key   : 0d8020a8b4bb2074c00c9d7e98fa787abbd59e421eb3507d6a2d8aa975ba29ad
```

`info` 不需要密钥，也不会解密 payload —— 它只报告从 trailer 里读到的内容。
加 `--payload` 会额外验证 CCM 认证标签并报告 payload 大小和 magic 值，
这是确认容器是否完好的最快方式。

`unpack` 会写出 `<名字>.w3x`，并在旁边生成 `<名字>.files/`，里面按原始路径还原所有成员：

```
HumanRE02Interlude.files/
  war3map.w3i  war3map.w3e  war3map.wts  war3map.luac  war3map.wct  ...
  conversation.json  CustomUI.TOC  3DPoint.mdx
  Abilities/Spells/Orc/LightningBolt/LightningBolt.flac
  doodads/ashenvale/rocks/ashenrock/av_environment_rocks_diffuse.dds
```

### `luac53` —— 编译后的 Lua

```
luac53 info       FILE.luac                       头部、类型宽度、调试信息
luac53 convert    FILE.luac [-o OUT.luac]         转写成标准 Lua 5.3 chunk
luac53 disasm     FILE.luac [--find TEXT...]      反汇编
                            [--lines LO HI] [--no-constants]
luac53 decompile  FILE.luac [-o OUT.lua]          转码 + 调用 unluac
```

平时用 `decompile` 就够了：

```console
$ luac53 info HumanRE01.files/war3map.luac
sizeof(lua_Integer) : 4  (Blizzard build)
sizeof(lua_Number)  : 4  (Blizzard build)
functions           : 3,229
instructions        : 151,440
constants           : 40,650
debug info          : 151,440 lines, 6,796 locals, 5,576 upvalue names

$ luac53 decompile HumanRE01.files/war3map.luac -o war3map.lua
war3map.luac -> war3map.lua (1,945,651 bytes)
```

得到的就是普通的 Lua 5.3 源码：

```lua
udg_F1_Player02_User = nil
udg_Weather_FogDZStart = 0.0
udg_Cache_HumanRE = ""
udg_Cache_MapNames = __jarray("")
...
function Item.updateSlot(slot)
  local ability = slot.ability
  if ability ~= nil and (slot.count or 0) > 0 then
    ability.slot = slot
    BlzFrameSetVisible(slot.icon, true)
    ...
```

当反编译器把某个控制流还原错了，`disasm --find NAME` 就是排查工具 —— 参见
[docs/luac-format.md](docs/luac-format.md)。

## license 值

AES 密钥派生自一个 64 位的 **license**，它是账号绑定的，因此无法公开：
你的容器只为你的 license 加密，别人的打不开。但你并不需要事先提供它，
`w3xd` 会从容器里把它恢复出来：

* trailer 中有 22 个字节必须全为 0 —— 这是已知明文；
* 第 1 层是 GF(2) 上的线性变换，且每字节推进一次状态。

两者结合，就把「22 个已知字节」变成了「32 位未知初始状态的 176 条线性方程」，
用高斯消元可以在毫秒级解出。随机数据满足这些方程的概率约为 `2⁻¹⁴⁴`，
这也正是盲目扫描容器之所以可行的原因。

```console
$ w3xd license HumanRE01.w3xd
0x0123456789abcdef

$ w3xd info HumanRE01.w3xd --key-material
  buffer A    : efcdab896745230157334d4541455330
  buffer B    : efcdab896745230157334d4541455331
  SHA1(A)     : 0d8020a8b4bb2074c00c9d7e98fa787abbd59e42
  SHA1(B)     : 1eb3507d6a2d8aa975ba29ad010dfe2c436f7a4c
```

**你的 license 值属于你自己。** 它不在这里的仓库里，也不是一个常量，
更不应该被你公开 —— 拿到它的人就能解开你的容器。派生过程是纯本地、离线的。

完整推导见 [docs/recovering-the-license.md](docs/recovering-the-license.md)。

## 格式文档

参考文档为英文；本 README 也有 [English](README.md) 版本。

| 文档 | 内容 |
|---|---|
| [docs/container-format.md](docs/container-format.md) | `.w3xd` 布局、两层加密、trailer 字段，以及对应的指令地址（RVA） |
| [docs/recovering-the-license.md](docs/recovering-the-license.md) | 已知明文恢复 license 的完整步骤 |
| [docs/mpq-quirks.md](docs/mpq-quirks.md) | 这批归档在 MPQ 上做的三件「出格」事，会让普通读取器出错 |
| [docs/luac-format.md](docs/luac-format.md) | 暴雪的 Lua 5.3 构建、字符串长度编码、反编译流程 |
| [docs/reverse-engineering.md](docs/reverse-engineering.md) | 方法论、地址表，以及哪些路走不通 |

## 扫描 CASC 安装目录

由于容器判据极其严格，不需要文件清单就能找出 CASC 存储里的每一个 `.w3xd`：
把每个 `BLTE` blob 解码后做指纹判定即可。指纹就是同一套 176 方程系统，
所以命中几乎可以确定就是容器。

开发时用的扫描器没有放进本仓库（它是几百行 CASC 专用管道代码），但思路是：

1. 遍历 `Data/data/data.NNN`，找出所有 `BLTE` 签名；
2. 解析现代 BLTE 头部 —— `+4` 处是 `headerSize`，`+10` 处是 chunk 数量，
   `+12` 起是描述符数组，每项 `{u32 编码长度, u32 解码长度, u8 md5[16]}`，
   并且满足 `headerSize == 12 + 24 × chunkCount`；
3. 只解压最后一个 chunk，对指纹判定来说已经足够；
4. 命中后再完整解码整个 blob，交给 `w3xd`。

完整扫一遍 34 GB 的安装目录大约两分钟。

## 仓库结构

```
w3xd-toolkit/
├── w3xd/                  容器工具
│   ├── xorshift.py            第 1 层
│   ├── aes.py                 AES-256（纯 Python + Windows CNG）
│   ├── ccm.py                 AES-256-CCM，L=5
│   ├── kdf.py                 基于 SHA-1 的密钥派生
│   ├── container.py           布局、license 恢复、解密
│   ├── mpq.py                 MPQ 读取器（三个坑全部处理）
│   └── cli.py                 命令行入口
├── luac53/                Lua 5.3 字节码工具
│   ├── chunk.py               读 / 写 / 转码
│   ├── disasm.py              反汇编器
│   └── cli.py                 命令行入口
├── docs/                  格式文档
├── scripts/               unluac 拉取脚本、批量脚本
├── tests/                 53 个单元测试，不需要游戏数据
└── examples/              完整使用走查
```

## 参与贡献

欢迎贡献 —— 尤其是文档更正，因为这个项目的全部价值就在于「它的结论是可核查的」。

三条没有商量余地的规则：

1. **提交里不能有游戏数据、密钥或反编译出的游戏内容。**
2. **不引入新的运行时依赖。** 本包在不装任何第三方库的情况下可安装、可运行。
3. **任何改动格式的修改都要附测试**，且在干净检出、没有游戏文件的情况下就能通过。

提 PR 前请先读 [CONTRIBUTING.zh-CN.md](CONTRIBUTING.zh-CN.md)，
里面还讲了怎么构造合成测试向量、以及怎么在不粘贴不该粘贴的东西的前提下报告格式错误。简而言之：

```bash
python -m unittest discover -s tests -t .      # 必须通过
```

## 合规声明

这是一个面向**你已合法拥有**的游戏副本的互操作性 / 研究工具。
在使用它、或发布任何衍生内容之前：

* **本仓库不包含任何游戏数据。** 没有地图、没有素材、没有密钥、没有暴雪代码。
  请保持这一点 —— 不要把 `*.files/`、`*.w3x` 的内容或恢复出的 license 提交上来。
* **密钥是账号绑定的。** 恢复出的 license 只能解开为该账号签发的容器，不要公开你的值。
* **不要再分发解出的素材。** 解密你自己拥有的地图用于研究、做模组或做工具是一回事；
  把暴雪的美术、音频、地形或脚本重新发布是另一回事，EULA 明确禁止后者。
* **不要用它绕过你并未获得授权的内容的访问控制。** 你能下载到的战役地图，你当然有权游玩；
  但这项权利不包含再分发。

暴雪的 EULA 禁止规避技术保护措施和再分发游戏资源。
本项目存在的意义是格式分析、保存性研究与互操作性，请据此使用。
Warcraft、Warcraft III 及 Blizzard Entertainment 是 Blizzard Entertainment, Inc. 的商标。
本项目与暴雪无关，也未获得其背书。

## 许可证

MIT —— 见 [LICENSE](LICENSE)。
