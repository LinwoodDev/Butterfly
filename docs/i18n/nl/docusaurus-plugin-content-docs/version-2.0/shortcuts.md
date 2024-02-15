---
title: Snelkoppelingen
sidebar_position: 2
---

## Keyboard

Er zijn een paar snelkoppelingen die je in de editor kunt gebruiken.
Sommige ervan worden onder de knoppen geschreven.

### Algemeen

- `Ctrl` + `N`: Nieuw bestand
- `Ctrl` + `Shift` + `N`: Nieuw bestand van template
- `Ctrl` + `E`: Bestand exporteren
- `Ctrl` + `P`: bestand afdrukken
- `Ctrl` + `Shift` + `E`: Exporteer bestand als afbeelding
- `Ctrl` + `Alt` + `E`: Exporteer bestand als svg
- `Ctrl` + `Alt` + `Shift` + `E`: Exporteer bestand als svg
- `Ctrl` + `Alt` + `P`: Open pakketjes
- `Ctrl` + `Alt` + `S`: Instellingen openen

### Project

- `Ctrl` + `Z`: Herstel
- `Ctrl` + `Y`: Opnieuw
- `Ctrl` + `Shift` + `P`: Open waypoints dialoogvenster
- `Ctrl` + `B`: Open achtergrondvenster
- `Ctrl` + `Shift` + `A`: Open venster gebieden
- `Ctrl` + `S`: Opslaan
- `Alt` + `S`: verander pad
- `Ctrl` + (`1` - `0`): Wissel naar tool
- `Ctrl` + `+`: Zoom in
- `Ctrl` + `-`: Zoom uit

## pennen

By default, the the pen is configured to function as the following:

- `Pen`: configured as pen.
- `First` (Primary button, if supported): Change to hand tool while pressed.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.

## {#configure} configureren

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

- Empty - the tool is unchaged.
- 0 - the tool will function as moving (i.e., hand) in this mod.
- Positive number - The tool will follow the indexing as explain above.
