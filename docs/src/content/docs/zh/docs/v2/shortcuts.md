---
title: 快捷键
---

## Keyboard

您可以在编辑器中使用一些快捷方式。
其中一些是在按钮下面写的。
其中一些是在按钮下面写的。

### 常规

- `Ctrl` + `N`: 新建文件
- `Ctrl` + `Shift` + `N`: 模板中的新文件
- `Ctrl` + `E`：导出文件
- Nightly (2.4): `Ctrl` + `Shift` + `E`: Export file (text based)
- `Ctrl` + `P`：打印文件
- `Ctrl` + `Shift` + `E`: 导出文件为图像
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as pdf
- `Ctrl` + `Alt` + `Shift` + `E` (Nightly (2.4): `Ctrl` + `Shift` + `P`): Export file as pdf
- `Ctrl` + `Alt` + `S`: 打开设置
- `Ctrl` + `Alt` + `P`: 打开包

### 项目

- `Ctrl` + `K`: Open search
- `Ctrl` + `Z`: 撤销
- `Ctrl` + `Y`: Redo
- `Ctrl` + `Shift` + `P`: 打开航点对话框
- `Ctrl` + `B`: 打开背景对话框
- `Ctrl` + `S`: 保存
- `Alt` + `S`: 更改路径
- `Ctrl` + (`1` - `0`): 切换到工具
- `Ctrl` + `+`: 缩放
- `Ctrl` + `-`：缩放

## 笔

默认情况下，钢笔配置为如下功能：

- “Pen\\`：被配置为笔”。
- `First` (主按钮，如果支持的话)：按住时更改为手工具。
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below) while pressed.

## Configuring {#configure}

You can customize your controls by changing which tools your inputs map to.

**Note:** Input configurations will be ignored while certain tools are selected, such as the Lasso Select tool, the Rectangle Select tool, the Label tool, and the Area tool.

To begin, go to `Settings` → `Inputs` and then select the input method you want to configure, such as `Mouse`, `Touch`, or `Pen`. You will be presented with a list of configurable inputs and the tools they are currently mapped to.

After selecting an input, you will have 3 options:

- `Active Tool`: The input will act as the currently selected tool on the toolbar.
- `Hand Tool`: The input will temporarily switch to the hand tool, allowing you to move around the canvas.
- `Specific Tool on Toolbar`: The input will temporarily switch to a tool on your toolbar, based on the position number you specify. Positions are counted starting from the left, so if you specify position `1`, the first tool on the left will be selected. See the screenshot below for an example of how position numbers are counted. For information about how to reorder your tools, see [Customizing the Toolbar](../intro/#customizing-the-toolbar).

![工具栏编号](toolbar_numbered.png)