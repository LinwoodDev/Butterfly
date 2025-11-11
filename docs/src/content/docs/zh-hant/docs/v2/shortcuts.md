---
title: 快速鍵
---

## 鍵盤

There are a few shortcuts that you can use in the editor.
Some of them are written below the buttons.

### 一般

- `Ctrl` + `N`: New file
- `Ctrl` + `Shift` + `N`: New file from template
- `Ctrl` + `E`: Export file
- `Ctrl` + `Shift` + `E`: Export file (text based)
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as image
- `Ctrl` + `Alt` + `E`: Export file as svg
- `Ctrl` + `Shift` + `P`: Export file as pdf
- `Ctrl` + `Alt` + `P`: Open packs
- `Ctrl` + `Alt` + `S`: Open settings

### 專案

- `Ctrl` + `K`: Open search
- `Ctrl` + `Z`: Undo
- `Ctrl` + `Y`: Redo
- `Ctrl` + `Shift` + `P`: Open waypoints dialog
- `Ctrl` + `B`: Open background dialog
- `Ctrl` + `S`: Save
- `Alt` + `S`: Change path
- `Ctrl` + (`1` - `0`): Switch to tool
- `Ctrl` + `+`: Zoom in
- `Ctrl` + `-`: Zoom out

## 筆

By default, the the pen is configured to function as the following:

- `Pen`: configured as pen.
- `First` (Primary button, if supported): Change to hand tool while pressed.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below) while pressed.

## Configuring {#configure}

You can customize your controls by changing which tools your inputs map to.

**Note:** Input configurations will be ignored while certain tools are selected, such as the Lasso Select tool, the Rectangle Select tool, the Label tool, and the Area tool.

To begin, go to `Settings` → `Inputs` and then select the input method you want to configure, such as `Mouse`, `Touch`, or `Pen`. You will be presented with a list of configurable inputs and the tools they are currently mapped to.

After selecting an input, you will have 3 options:

- `Active Tool`: The input will act as the currently selected tool on the toolbar.
- `Hand Tool`: The input will temporarily switch to the hand tool, allowing you to move around the canvas.
- `Specific Tool on Toolbar`: The input will temporarily switch to a tool on your toolbar, based on the position number you specify. Positions are counted starting from the left, so if you specify position `1`, the first tool on the left will be selected. See the screenshot below for an example of how position numbers are counted. For information about how to reorder your tools, see [Customizing the Toolbar](../intro/#customizing-the-toolbar).

![toolbar numbered](toolbar_numbered.png)
