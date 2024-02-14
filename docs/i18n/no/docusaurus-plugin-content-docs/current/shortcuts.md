---
title: "Snarveier"
sidebar_position: 2
---


## Keyboard

Det er noen snarveier du kan benytte i editoren. Noen av dem er skrevet under knappene.

### Generelt

* `Ctrl` + `N`: Ny fil
* `Ctrl` + `Shift` + `N`: Ny fil fra mal
* `Ctrl` + `E`: Eksportfil
* `Ctrl` + `P`: Skriv ut fil
* `Ctrl` + `Shift` + `E`: Eksporter fil som bilde
* `Ctrl` + `Alt` + `E`: Eksporter filen som svg
* `Ctrl` + `Alt` + `Skift` + `E`: Eksporter filen som svg
* `Ctrl` + `Alt` + `P`: Åpne pakker
* `Ctrl` + `Alt` + `S`: Åpne innstillinger

### Prosjekt

* `Ctrl` + `Z`: Angre
* `Ctrl` + `Y`: Gjør om igjen
* `Ctrl` + `Shift` + `P`: Open waypoints dialog
* `Ctrl` + `B`: Åpne bakgrunnsdialog
* `Ctrl` + `Shift` + `A`: Åpne områder dialog
* `Ctrl` + `S`: Lagre
* `Alt` + `S`: Endre bane
* `Ctrl` + (`1` - `0`): Bytt til verktøy
* `Ctrl` + `+`: Zoom inn
* `Ctrl` + `-`: Zoom ut

## Penn

By default, the the pen is configured to function as the following:
* `Pen`: configured as pen.
* `First` (Primary button, if supported): Change to hand tool while pressed.
* `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.



## Konfigurer {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

* Empty - the tool is unchaged.
* 0 - the tool will function as moving (i.e., hand) in this mod.
* Positive number - The tool will follow the indexing as explain above. 


