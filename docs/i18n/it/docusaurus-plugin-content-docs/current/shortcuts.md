---
title: "Scorciatoie"
sidebar_position: 2
---


## Keyboard

Ci sono alcune scorciatoie che puoi usare nell'editor. Alcuni di loro sono scritti sotto i pulsanti.

### Generale

* `Ctrl` + `N`: Nuovo file
* `Ctrl` + `Maiusc` + `N`: Nuovo file dal modello
* `Ctrl` + `E`: Esporta file
* `Ctrl` + `P`: Stampa file
* `Ctrl` + `Maiusc` + `E`: Esporta file come immagine
* `Ctrl` + `Alt` + `E`: Esporta file come svg
* `Ctrl` + `Alt` + `Maiusc` + `E`: Esporta file come svg
* `Ctrl` + `Alt` + `P`: Pacchetti aperti
* `Ctrl` + `Alt` + `S`: Apri le impostazioni

### Progetto

* `Ctrl` + `Z`: Annulla
* `Ctrl` + `Y`: Ripeti
* `Ctrl` + `Shift` + `P`: Open waypoints dialog
* `Ctrl` + `B`: Apri finestra di dialogo di sfondo
* `Ctrl` + `Maiusc` + `A`: Apri aree finestra
* `Ctrl` + `S`: Salva
* `Alt` + `S`: Cambia percorso
* `Ctrl` + (`1` - `0`): Passa allo strumento
* `Ctrl` + `+`: Zoom avanti
* `Ctrl` + `-`: Zoom indietro

## Penna

By default, the the pen is configured to function as the following:
* `Pen`: configured as pen.
* `First` (Primary button, if supported): Change to hand tool while pressed.
* `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.



## Configura {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

* Empty - the tool is unchaged.
* 0 - the tool will function as moving (i.e., hand) in this mod.
* Positive number - The tool will follow the indexing as explain above. 


