# War3 Mod 工作仓库

Warcraft III（魔兽争霸3）地图编辑 / Mod 制作工作目录。

所有 mod 工程、脚本、资源与知识库资料均在此仓库中管理，并推送到
`git@github.com:chenlinyuan/war3.git`。

## 目录结构

```
war3/
├── README.md                  # 本文件：仓库总览
├── .gitignore                 # 忽略临时/编译产物
├── docs/                      # 📚 知识库（地图编辑资料）
│   ├── README.md              # 知识库索引
│   ├── 00-入门/               # 环境搭建、工具链、快速上手
│   ├── 01-地图文件格式/       # w3x/w3m 内部文件格式规范
│   ├── 02-脚本编程/           # JASS / vJASS / Lua / Wurst 编程
│   ├── 03-对象数据/           # 单位、技能、物品、升级等对象编辑器数据
│   ├── 04-触发器与GUI/        # 触发器编辑器与 GUI
│   ├── 05-资源制作/           # 模型、贴图、图标、音效
│   ├── 06-工具链/             # 第三方编辑器与工具
│   ├── 07-参考/               # API 参考、常量表、常用链接
│   └── 99-模板与片段/         # 可复用代码模板
├── maps/                      # 地图工程（.w3x / 解包后的 war3map 文件）
│   └── LostTemple/            # Lost Temple 改图工程（已注入装备系统）
├── scripts/                   # 可注入的 JASS 脚本（f.j/g.j/m.j）
│   └── item-browser/          # 装备搜索与添加系统
├── resources/                 # 自定义资源（模型/贴图/音效源文件）
├── tools/                     # 本地工具、脚本
│   └── war3map-injector/      # 地图脚本注入工具链
└── skills/                    # 可复用的 AI 技能（skill）定义
```

## 快速开始

1. 阅读 [`docs/README.md`](docs/README.md) 了解知识库结构。
2. 新手上路请看 [`docs/00-入门/环境搭建.md`](docs/00-入门/环境搭建.md)。
3. 写脚本请看 [`docs/02-脚本编程/`](docs/02-脚本编程/)。
4. 了解地图内部结构请看 [`docs/01-地图文件格式/`](docs/01-地图文件格式/)。

## 主要工程

### 🎮 Lost Temple 改图

在官方对战地图上注入**装备搜索/添加系统**：

```
search 吸血          → 搜索名称含"吸血"的装备
additem 吸血面罩      → 给选中英雄添加装备
```

- 工程目录：[`maps/LostTemple/`](maps/LostTemple/)
- 脚本源码：[`scripts/item-browser/`](scripts/item-browser/)
- 注入工具：[`tools/war3map-injector/`](tools/war3map-injector/)

一键注入：

```powershell
python tools/war3map-injector/inject_map.py "maps/LostTemple/LostTemple.w3m" scripts/item-browser
```

### 🛠 地图脚本注入工具

支持**加密/保护地图**的脚本注入，基于 HkeW3mModifier2.0 + Python 自动化。

详见 [`tools/war3map-injector/README.md`](tools/war3map-injector/README.md)。

## 仓库约定

- 地图工程放在 `maps/<地图名>/`，解包后的 `war3map.*` 文件以文本/JSON 形式存储，便于 diff。
- 大型二进制资源（.blp/.mdx/.mp3）建议使用 Git LFS（见 `.gitattributes`）。
- 知识库文档使用 Markdown，中文为主，代码与专有名词保留英文。

## 远程仓库

```bash
git remote -v
# origin  git@github.com:chenlinyuan/war3.git (fetch)
# origin  git@github.com:chenlinyuan/war3.git (push)
```

SSH 已配置（`~/.ssh/id_ed25519`），可直接 push。
