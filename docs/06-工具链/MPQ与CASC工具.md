# MPQ 与 CASC 工具

## 一、MPQ 工具

### 1.1 MPQ Editor

> 最常用的 MPQ 编辑工具。

**功能**：
- 打开/编辑 `.mpq`、`.w3x`、`.w3m`、`.w3n`
- 添加/删除/提取文件
- 创建新 MPQ
- 批量操作

**使用**：
```
# 列出文件
MPQEditor.exe list MyMap.w3x

# 提取全部
MPQEditor.exe extract MyMap.w3x * ./output

# 提取单个文件
MPQEditor.exe extract MyMap.w3x war3map.j ./output

# 添加文件
MPQEditor.exe add MyMap.w3x ./files\* /r
```

### 1.2 Ladik's MPQ Editor

> 图形化 MPQ 编辑器。

**特点**：
- 直观的树形界面
- 支持拖放
- 支持加密 MPQ

### 1.3 StormLib

> MPQ 读写库（C/C++）。

**链接**：https://github.com/ladislav-zezula/StormLib

**示例**：
```cpp
#include "StormLib.h"

HANDLE hMpq;
if (SFileOpenArchive("MyMap.w3x", 0, 0, &hMpq)) {
    // 打开文件
    HANDLE hFile;
    if (SFileOpenFileEx(hMpq, "war3map.j", 0, &hFile)) {
        DWORD size = SFileGetFileSize(hFile, NULL);
        char* buf = new char[size];
        SFileReadFile(hFile, buf, size, NULL, NULL);
        // 使用 buf
        delete[] buf;
        SFileCloseFile(hFile);
    }
    SFileCloseArchive(hMpq);
}
```

### 1.4 其他 MPQ 工具

| 工具 | 语言/平台 | 说明 |
| --- | --- | --- |
| **mpyq** | Python | 简单 MPQ 读写 |
| **stormlib-py** | Python | StormLib 绑定 |
| **MpqToolkit** | C# | .NET MPQ 库 |
| **StormLibSharp** | C# | StormLib 绑定 |
| **War3Net** | C# | 完整地图读写 |

## 二、CASC 工具

> Reforged 1.32+ 游戏数据使用 CASC 存储。

### 2.1 CascView

> 浏览 CASC 存储的图形化工具。

**功能**：
- 浏览游戏文件
- 提取文件
- 搜索

**使用**：
1. 打开 CascView。
2. 选择游戏目录（`_retail_`）。
3. 浏览/提取文件。

### 2.2 CascLib

> CASC 读写库。

**链接**：https://github.com/ladislav-zezula/CascLib

### 2.3 常用 CASC 路径

| 路径 | 内容 |
| --- | --- |
| `units\` | 单位模型/数据 |
| `war3.mpq` 等 | 经典数据（CASC 中） |
| `UI\` | 界面 |
| `Sound\` | 音效 |
| `Units\` | 单位数据 SLK |

## 三、地图解包/打包流程

### 3.1 解包

```
1. 用 MPQ Editor 打开 MyMap.w3x
2. 提取所有文件到 ./MyMap_unpacked/
3. 得到 war3map.* 文件
```

### 3.2 转换为可读格式

```bash
# 安装 WC3MapTranslator
npm install -g wc3maptranslator

# 转为 JSON（便于 diff）
wc3maptranslator ./MyMap_unpacked --toJson

# 转回二进制
wc3maptranslator ./MyMap_json --toWar
```

### 3.3 打包

```
1. 用 MPQ Editor 创建新 MPQ
2. 添加所有 war3map.* 文件
3. 保存为 .w3x
4. 注意保持文件路径正确
```

### 3.4 使用 War3Net（C#）

```csharp
// 读取
var map = Map.Open("MyMap.w3x");
// 修改...
map.Save("MyMap_modified.w3x");
```

## 四、加密地图处理

| 加密手段 | 处理 |
| --- | --- |
| 移除 listfile | 用已知文件名扫描 |
| 加密 war3map.j | 需密钥，或放弃 |
| 删除 war3map.wtg | 从 war3map.j 恢复逻辑 |
| 混淆变量名 | 手动分析 |

> ⚠️ 破解他人加密地图可能违反社区规范，请仅用于学习分析。

## 五、常见问题

| 问题 | 解决 |
| --- | --- |
| 无法打开地图 | 检查是否为加密 MPQ |
| 提取文件乱码 | 检查是否加密 |
| 打包后地图无法运行 | 检查文件路径/格式 |
| CASC 文件找不到 | 更新 CascView 版本 |

## 参考

- StormLib：https://github.com/ladislav-zezula/StormLib
- CascLib：https://github.com/ladislav-zezula/CascLib
- MPQ 格式规范：https://github.com/ladislav-zezula/StormLib/blob/master/doc/MPQ_Format.txt
- War3Net：https://github.com/Drake53/War3Net
