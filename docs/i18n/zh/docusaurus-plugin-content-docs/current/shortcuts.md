---
title: "快捷键"
sidebar_position: 2
---


## Keyboard

您可以在编辑器中使用一些快捷方式。 其中一些是在按钮下面写的。

### 常规

* `Ctrl` + `N`: 新文件
* `Ctrl` + `Shift` + `N`: 来自模板的新文件
* `Ctrl` + `E`: 导出文件
* `Ctrl` + `P`: 打印文件
* `Ctrl` + `Shift` + `E`: 导出文件为图像
* `Ctrl` + `Alt` + `E`: 导出文件为 svg
* `Ctrl` + `Alt` + `Shift` + `E`: 导出文件为 svg
* `Ctrl` + `Alt` + `P`: 打开包
* `Ctrl` + `Alt` + `S`: 打开设置

### 项目

* `Ctrl` + `Z`: 撤销
* `Ctrl` + `Y`: Redo
* `Ctrl` + `Shift` + `P`: Open waypoints dialog
* `Ctrl` + `B`: 打开后台对话框
* `Ctrl` + `Shift` + `A`: 打开区域对话框
* `Ctrl` + `S`: 保存
* `Alt` + `S`: 更改路径
* `Ctrl` + (`1` - `0`): 切换到工具
* `Ctrl` + `+`: 缩放
* `Ctrl` + `-`: 缩放

## 笔

By default, the the pen is configured to function as the following:
* `Pen`: configured as pen.
* `First` (Primary button, if supported): Change to hand tool while pressed.
* `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.



## 配置 {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

* Empty - the tool is unchaged.
* 0 - the tool will function as moving (i.e., hand) in this mod.
* Positive number - The tool will follow the indexing as explain above. 


