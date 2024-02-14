---
title: "Genvägar"
sidebar_position: 2
---


## Keyboard

Det finns några genvägar som du kan använda i editorn. Några av dem är skrivna under knapparna.

### Allmänt

* `Ctrl` + `N`: Ny fil
* `Ctrl` + `Shift` + `N`: Ny fil från mall
* `Ctrl` + `E`: Exportera fil
* `Ctrl` + `P`: Skriv ut fil
* `Ctrl` + `Shift` + `E`: Exportera filen som bild
* `Ctrl` + `Alt` + `E`: Exportera filen som svg
* `Ctrl` + `Alt` + `Shift` + `E`: Exportera filen som svg
* `Ctrl` + `Alt` + `P`: Öppna paket
* `Ctrl` + `Alt` + `S`: Öppna inställningar

### Projekt

* `Ctrl` + `Z`: Ångra
* `Ctrl` + `Y`: Gör om
* `Ctrl` + `Shift` + `P`: Open waypoints dialog
* `Ctrl` + `B`: Öppna bakgrundsdialogrutan
* `Ctrl` + `Shift` + `A`: dialogrutan Öppna områden
* `Ctrl` + `S`: Spara
* `Alt` + `S`: Ändra sökväg
* `Ctrl` + (`1` - `0`): Växla till verktyget
* `Ctrl` + `+`: Zooma in
* `Ctrl` + `-`: Zooma ut

## Penna

By default, the the pen is configured to function as the following:
* `Pen`: configured as pen.
* `First` (Primary button, if supported): Change to hand tool while pressed.
* `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.



## Konfigurera {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

* Empty - the tool is unchaged.
* 0 - the tool will function as moving (i.e., hand) in this mod.
* Positive number - The tool will follow the indexing as explain above. 


