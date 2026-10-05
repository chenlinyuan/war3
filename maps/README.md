# maps · 地图工程

存放 Warcraft III 地图工程。

## 目录约定

每张地图一个子目录：

```
maps/
├── MyMap/
│   ├── README.md              # 地图说明
│   ├── MyMap.w3x              # 地图文件（或使用 Git LFS）
│   ├── src/                   # 脚本源码（Lua/JASS）
│   │   ├── main.lua
│   │   └── systems/
│   ├── war3map/               # 解包后的 war3map.* 文件
│   │   ├── war3map.w3i
│   │   ├── war3map.w3e
│   │   └── ...
│   └── json/                  # 转换后的 JSON（便于 diff）
└── AnotherMap/
    └── ...
```

## 版本管理建议

地图是二进制文件，直接 Git 管理效果差。推荐：

1. **脚本源码**：直接纳入 Git（`src/`）。
2. **war3map.* 数据**：用 WC3MapTranslator 转为 JSON 后纳入 Git（`json/`）。
3. **.w3x 二进制**：可选，或使用 Git LFS。

### 工作流

```powershell
# 1. 解包地图
MPQEditor.exe extract MyMap.w3x * ./MyMap/war3map

# 2. 转 JSON
wc3maptranslator ./MyMap/war3map --toJson
Move-Item info.json, terrain.json, ... ./MyMap/json/

# 3. Git 提交
git add ./MyMap/src ./MyMap/json
git commit -m "更新地图数据"
```

## 新地图模板

创建新地图时，参考 [`../docs/00-入门/第一个地图.md`](../docs/00-入门/第一个地图.md)。
