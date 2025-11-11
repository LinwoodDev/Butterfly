---
title: Snelkoppelingen
---

## Keyboard

Er zijn een paar snelkoppelingen die je in de editor kunt gebruiken.
Sommige ervan worden onder de knoppen geschreven.

### Algemeen

- `Ctrl` + `N`: Nieuw bestand
- `Ctrl` + `Shift` + `N`: Nieuw bestand van template
- `Ctrl` + `E`: Bestand exporteren
- `Ctrl` + `Shift` + `E`: Export file (text based)
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as image
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as pdf
- `Ctrl` + `Shift` + `P`: Export file as pdf
- `Ctrl` + `Alt` + `S`: Instellingen openen
- `Ctrl` + `Alt` + `P`: Open pakketjes

### Project

- `Ctrl` + `K`: Open search
- `Ctrl` + `Z`: Herstel
- `Ctrl` + `Y`: Opnieuw
- `Ctrl` + `Shift` + `P`: Open waypoints dialoogvenster
- `Ctrl` + `B`: Open achtergrondvenster
- `Ctrl` + `S`: Opslaan
- `Alt` + `S`: verander pad
- `Ctrl` + (`1` - `0`): Wissel naar tool
- `Ctrl` + `+`: Zoom in
- `Ctrl` + `-`: Zoom uit

## pennen

Standaard is de pen geconfigureerd om als volgt te functioneren:

- `Pen`: geconfigureerd als pen.
- `Eer` (Primaire knop, indien ondersteund): Verander naar handgereedschap terwijl je wordt ingedrukt.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below) while pressed.

## Configuring {#configure}

You can customize your controls by changing which tools your inputs map to.

**Note:** Input configurations will be ignored while certain tools are selected, such as the Lasso Select tool, the Rectangle Select tool, the Label tool, and the Area tool.

To begin, go to `Settings` → `Inputs` and then select the input method you want to configure, such as `Mouse`, `Touch`, or `Pen`. You will be presented with a list of configurable inputs and the tools they are currently mapped to.

After selecting an input, you will have 3 options:

- `Active Tool`: The input will act as the currently selected tool on the toolbar.
- `Hand Tool`: The input will temporarily switch to the hand tool, allowing you to move around the canvas.
- `Specific Tool on Toolbar`: The input will temporarily switch to a tool on your toolbar, based on the position number you specify. Positions are counted starting from the left, so if you specify position `1`, the first tool on the left will be selected. See the screenshot below for an example of how position numbers are counted. For information about how to reorder your tools, see [Customizing the Toolbar](../intro/#customizing-the-toolbar).

![werkbalk nummerd](toolbar_numbered.png)
