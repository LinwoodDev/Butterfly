---
title: Genveje
sidebar_position: 2
---

## Keyboard

Der er et par genveje, som du kan bruge i editoren.
Nogle af dem er skrevet under knapperne.

### Generelt

- `Ctrl` + `N`: Ny fil
- `Ctrl` + `Shift` + `N`: Ny fil fra skabelon
- `Ctrl` + `E`: Eksporter fil
- `Ctrl` + `P`: Udskriv fil
- `Ctrl` + `Shift` + `E`: Eksportér fil som billede
- `Ctrl` + `Alt` + `E`: Eksportér fil som svg
- `Ctrl` + `Alt` + `Shift` + `E`: Eksporter fil som svg
- `Ctrl` + `Alt` + `P`: Åbn pakker
- `Ctrl` + `Alt` + `S`: Åbn indstillinger

### Projekt

- `Ctrl` + `Z`: Fortryd
- `Ctrl` + `Y`: Fortryd
- `Ctrl` + `Shift` + `P`: Åbn waypoints dialog
- `Ctrl` + `B`: Åbn baggrundsdialog
- `Ctrl` + `Shift` + `A`: Åbn områdedialog
- `Ctrl` + `S`: Gem
- `Alt` + `S`: Skift sti
- `Ctrl` + (`1` - `0`): Skift til værktøj
- `Ctrl` + `+`: Zoom ind
- `Ctrl` + `-`: Zoom ud

## Pen

By default, the the pen is configured to function as the following:

- `Pen`: configured as pen.
- `First` (Primary button, if supported): Change to hand tool while pressed.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.

## Konfigurer {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

- Empty - the tool is unchaged.
- 0 - the tool will function as moving (i.e., hand) in this mod.
- Positive number - The tool will follow the indexing as explain above.
