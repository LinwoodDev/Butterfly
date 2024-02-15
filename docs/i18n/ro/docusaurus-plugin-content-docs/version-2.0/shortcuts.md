---
title: Scurtături
sidebar_position: 2
---

## Keyboard

Există câteva comenzi rapide pe care le poți folosi în editor.
Unele dintre ele sunt scrise sub butoane.

### Generalități

- `Ctrl` + `N`: Fișier nou
- `Ctrl` + `Shift` + `N`: Fișier nou din șablon
- `Ctrl` + `E`: Export fişier
- `Ctrl` + `P`: Fişier de imprimare
- `Ctrl` + `Shift` + `E`: Exportă fișierul ca imagine
- `Ctrl` + `Alt` + `E`: Export fişier ca svg
- `Ctrl` + `Alt` + `Shift` + `E`: Export file ca svg
- `Ctrl` + `Alt` + `P`: Deschide pachete
- `Ctrl` + `Alt` + `S`: Deschideți setările

### Proiect

- `Ctrl` + `Z`: Undo
- `Ctrl` + `Y`: Redo
- `Ctrl` + `Shift` + `P`: Deschide dialogul cu puncte
- `Ctrl` + `B`: Deschide dialogul de fundal
- `Ctrl` + `Shift` + `A`: Deschide zonele de dialog
- `Ctrl` + `S`: Salvează
- `Alt` + `S`: Schimbă calea
- `Ctrl` + (`1` - `0`): Comută la unealtă
- `Ctrl` + `+`: Zoom in
- `Ctrl` + `-`: Zoom out

## Stiloul

By default, the the pen is configured to function as the following:

- `Pen`: configured as pen.
- `First` (Primary button, if supported): Change to hand tool while pressed.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.

## Configurare {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

- Empty - the tool is unchaged.
- 0 - the tool will function as moving (i.e., hand) in this mod.
- Positive number - The tool will follow the indexing as explain above.
