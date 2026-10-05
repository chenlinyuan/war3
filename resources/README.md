# resources · 自定义资源

存放自定义模型、贴图、图标、音效等资源。

## 目录结构

```
resources/
├── models/          # 3D 模型（.mdx / .mdl）
├── textures/        # 贴图（.blp / .tga / .png / .dds）
├── icons/           # 图标（.blp）
├── sounds/          # 音效（.wav / .mp3）
├── music/           # 音乐（.mp3）
├── ui/              # UI 资源（.fdf / .toc / .blp）
└── source/          # 源文件（.psd / .blend / .max 等）
```

## 命名规范

- 使用有意义的英文名。
- 图标遵循 War3 规范：`BTNxxx` / `DISBTNxxx` / `PASBTNxxx`。
- 模型与贴图同名便于对应。

## 导入流程

见 [`../docs/05-资源制作/资源导入.md`](../docs/05-资源制作/资源导入.md)。

## 注意事项

- 大型二进制文件建议使用 **Git LFS**。
- 记录资源来源与授权（避免版权问题）。
- 保留源文件（`.psd` / `.blend`）便于后续修改。

## Git LFS 配置

```powershell
git lfs install
git lfs track "*.mdx" "*.blp" "*.mp3" "*.wav" "*.tga" "*.dds"
git add .gitattributes
```
