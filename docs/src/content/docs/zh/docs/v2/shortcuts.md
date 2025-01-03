---
title: 快捷键
---

## Keyboard

您可以在编辑器中使用一些快捷方式。
其中一些是在按钮下面写的。

### 常规

- `Ctrl` + `N`: 新建文件
- `Ctrl` + `Shift` + `N`: 模板中的新文件
- `Ctrl` + `E`：导出文件
- `Ctrl` + `P`：打印文件
- `Ctrl` + `Shift` + `E`: 导出文件为图像
- `Ctrl` + `Alt` + `E`: 导出文件为 svg
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as pdf
- `Ctrl` + `Alt` + `P`: 打开包
- `Ctrl` + `Alt` + `S`: 打开设置

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

- “Pen\`：被配置为笔”。
- `First` (主按钮，如果支持的话)：按住时更改为手工具。
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below) while pressed.

## 配置 {#configure}

您可以通过给每个控制器一个工具索引来自定义控件。 工具索引从工具栏左侧开始，第一个索引是 `1` 。 查看下面的示例

![工具栏编号](toolbar_numbered.png)

这里有一个是指激光工具、2个是指pan工具等。

您拥有的配置选项如下：

- 空-工具已解冻。
- 0 - 工具将在这个模组中发挥移动作用(即手)。
- 正数 - 该工具将遵循上面解释的索引。
