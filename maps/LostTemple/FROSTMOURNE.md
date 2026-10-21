# Lost Temple 霜之哀伤版本

成品地图：`LostTemple_heroes.w3x`

游戏内添加：

```text
additem I105
additem 霜之哀伤
additem frost
additem frostmourne
```

## 对象

| 对象 | ID | 基准 |
|---|---|---|
| 霜之哀伤 | `I105` | `gcel` |
| 冰封践踏 | `A105` | `AOws` |
| 攻击速度 +50% | `A106` | `AIsx` |
| 霜冻攻击 | `A107` | `AIob` |

## 数值

- 攻击速度 +50%
- 普通攻击附加 50 点冰霜伤害
- 普通单位移速降低 65%，持续 4 秒
- 英雄移速降低 65%，持续 2 秒
- 主动技能耗魔 100、冷却 6 秒、范围 550
- 主动伤害 `100 + 最高属性 × 4`
- 普通单位冰冻 5 秒，英雄冰冻 3 秒

## 表现

- 物品图标：`BTNFrostMourne.blp`
- 主动冰爆：`war3campImported\IceStompRaised.mdx`
- 掉落物：无底座的独立霜之哀伤模型
- 地面光环：`war3campImported\Rune-Blue-Aura_Raised20.mdx`
- 每件地面霜之哀伤拥有独立光环
- 拾取时立即销毁对应光环

本版不添加英雄持有剑模型，避免与剑圣原有武器重叠。
