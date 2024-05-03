---
title: "Shortcuts"
sidebar_position: 2
---


## Bàn phím

There are a few shortcuts that you can use in the editor. Some of them are written below the buttons.

### Chung

* `Ctrl` + `N`: New file
* `Ctrl` + `Shift` + `N`: New file from template
* `Ctrl` + `E`: Export file
* `Ctrl` + `P`: Print file
* `Ctrl` + `Shift` + `E`: Export file as image
* `Ctrl` + `Alt` + `E`: Export file as svg
* `Ctrl` + `Alt` + `Shift` + `E`: Export file as svg
* `Ctrl` + `Alt` + `P`: Open packs
* `Ctrl` + `Alt` + `S`: Open settings

### Project

* `Ctrl` + `K`: Open search
* `Ctrl` + `Z`: Undo
* `Ctrl` + `Y`: Redo
* `Ctrl` + `Shift` + `P`: Open waypoints dialog
* `Ctrl` + `B`: Open background dialog
* `Ctrl` + `S`: Save
* `Alt` + `S`: Change path
* `Ctrl` + (`1` - `0`): Switch to tool
* `Ctrl` + `+`: Zoom in
* `Ctrl` + `-`: Zoom out

## Bút vẽ

By default, the the pen is configured to function as the following:
* `Pen`: configured as pen.
* `First` (Primary button, if supported): Change to hand tool while pressed.
* `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.



## Configure {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

* Empty - the tool is unchaged.
* 0 - the tool will function as moving (i.e., hand) in this mod.
* Positive number - The tool will follow the indexing as explain above. 


