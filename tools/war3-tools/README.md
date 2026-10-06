# war3-tools · 第三方 War3 工具备份

`H:\Games\War3\Tools` 的完整备份，防止本机工具丢失。

> 备份时间：2026-10-06
> 来源：`H:\Games\War3\Tools`
> 规模：1133 文件，约 81 MB

## 内容

| 目录 / 文件 | 说明 |
| --- | --- |
| `151个常用脚本/` | 151 个常用作弊脚本合集，含 **HKE1.25(5.17美化版)** 脚本注入器 |
| `151个常用脚本.zip` | 上述目录的原始压缩包 |
| `66网脚本注入器/` | 66 网脚本注入器（含 HKE 脚本数据） |
| `66网脚本注入器.zip` | 上述目录的原始压缩包 |
| `偶久改图一条龙工具包/` | 偶久改图工具合集，含 **pjass / JassCraft / MPQMaster / YD作弊 / Wc3MapExtractor** 等 |
| `偶久改图一条龙工具包.rar` | 上述目录的原始压缩包 |
| `最强脚本注入（魔兽1.27版本）/` | 最强脚本注入器（1.27 专用）+ MPQ/地图资源编辑提取工具 |

## 本项目实际使用的工具

| 工具 | 路径（相对本目录） | 用途 |
| --- | --- | --- |
| **HkeW3mModifier2.0.exe** | `151个常用脚本/脚本/HKE1.25(5.17美化版）/HKE1.25(5.17美化版）/HkeW3mModifier2.0.exe` | 地图脚本注入（无视 MPQ 加密） |
| **pjass.exe** | `偶久改图一条龙工具包/tools/JassCraft/pjass.exe` | JASS 语法校验 |
| **common.j / blizzard.j** | `偶久改图一条龙工具包/tools/JassCraft/` | pjass 校验所需的函数声明 |

> 这些路径在 `tools/war3map-injector/*.py` 中硬编码为 `H:\Games\War3\Tools\...`。
> 若本机工具丢失，可从本目录恢复（拷回 `H:\Games\War3\Tools\` 对应路径）。

## 恢复方法

```powershell
# 从仓库恢复工具到本机（示例）
Copy-Item -Recurse "tools\war3-tools\*" "H:\Games\War3\Tools\" -Force
```

## 注意

- 本目录为**第三方二进制备份**，仅作存档，不参与构建。
- 部分工具可能含 `HkeData/` 临时输出（注入脚本时的中间产物），可忽略。
- 工具版权归原作者所有；本仓库仅作本地备份，不用于分发。
