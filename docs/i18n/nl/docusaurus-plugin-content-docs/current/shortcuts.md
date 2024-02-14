---
title: "Snelkoppelingen"
sidebar_position: 2
---


## Keyboard

Er zijn een paar snelkoppelingen die je in de editor kunt gebruiken. Sommige ervan worden onder de knoppen geschreven.

### Algemeen

* `Ctrl` + `N`: Nieuw bestand
* `Ctrl` + `Shift` + `N`: Nieuw bestand van sjabloon
* `Ctrl` + `E`: Bestand exporteren
* `Ctrl` + `P`: Print bestand
* `Ctrl` + `Shift` + `E`: Bestand als afbeelding exporteren
* `Ctrl` + `Alt` + `E`: Bestand als svg exporteren
* `Ctrl` + `Alt` + `Shift` + `E`: Exporteer bestand als svg
* `Ctrl` + `Alt` + `P`: Open pakketten
* `Ctrl` + `Alt` + `S`: Instellingen openen

### Project

* `Ctrl` + `Z`: Ongedaan maken
* `Ctrl` + `Y`: Opnieuw
* `Ctrl` + `Shift` + `P`: Open waypoints dialog
* `Ctrl` + `B`: Open achtergronddialoog
* `Ctrl` + `Shift` + `A`: Open gebieden dialoog
* `Ctrl` + `S`: Opslaan
* `ALT` + `S`: pad wijzigen
* `Ctrl` + (`1` - `0`): Schakel over naar gereedschap
* `Ctrl` + `+`: inzoomen
* `Ctrl` + `-`: uitzoomen

## pennen

By default, the the pen is configured to function as the following:
* `Pen`: configured as pen.
* `First` (Primary button, if supported): Change to hand tool while pressed.
* `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.



## Configureren {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

* Empty - the tool is unchaged.
* 0 - the tool will function as moving (i.e., hand) in this mod.
* Positive number - The tool will follow the indexing as explain above. 


