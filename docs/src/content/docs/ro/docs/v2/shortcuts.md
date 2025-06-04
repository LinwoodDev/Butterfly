---
title: Scurtături
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
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as pdf
- `Ctrl` + `Alt` + `P`: Deschide pachete
- `Ctrl` + `Alt` + `S`: Deschideți setările
- `Ctrl` + `Alt` + `S`: Deschideți setările

### Proiect

- `Ctrl` + `K`: Open search
- `Ctrl` + `Z`: Undo
- `Ctrl` + `Y`: Redo
- `Ctrl` + `Shift` + `P`: Deschide dialogul cu puncte
- `Ctrl` + `B`: Deschide dialogul de fundal
- `Ctrl` + `S`: Salvează
- `Alt` + `S`: Schimbă calea
- `Ctrl` + (`1` - `0`): Comută la unealtă
- `Ctrl` + `+`: Zoom in
- `Ctrl` + `-`: Zoom out

## Stiloul

În mod implicit, stiloul este configurat pentru a funcţiona astfel:

- `Stilu`: configurat ca stilou injector (pen).
- `First` (buton principal, dacă este suportat): Schimbă cu unealta de mână în timp ce este apăsată.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below) while pressed.

## Configuring {#configure}

You can customize your controls by changing which tools your inputs map to.

**Note:** Input configurations will be ignored while certain tools are selected, such as the Lasso Select tool, the Rectangle Select tool, the Label tool, and the Area tool.

To begin, go to `Settings` → `Inputs` and then select the input method you want to configure, such as `Mouse`, `Touch`, or `Pen`. You will be presented with a list of configurable inputs and the tools they are currently mapped to.

After selecting an input, you will have 3 options:

- `Active Tool`: The input will act as the currently selected tool on the toolbar.
- `Hand Tool`: The input will temporarily switch to the hand tool, allowing you to move around the canvas.
- `Specific Tool on Toolbar`: The input will temporarily switch to a tool on your toolbar, based on the position number you specify. Positions are counted starting from the left, so if you specify position `1`, the first tool on the left will be selected. See the screenshot below for an example of how position numbers are counted. For information about how to reorder your tools, see [Customizing the Toolbar](../intro/#customizing-the-toolbar).

![toolbar numerotat](toolbar_numbered.png)