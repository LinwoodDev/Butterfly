---
title: "Pikanäppäimet"
sidebar_position: 2
---


## Keyboard

On olemassa muutamia pikakuvakkeita, joita voit käyttää editorissa. Osa niistä on kirjoitettu painikkeiden alle.

### Yleiset

* `Ctrl` + `N`: Uusi tiedosto
* `Ctrl` + `Vaihto` + `N`: Uusi tiedosto mallista
* `Ctrl` + `E`: Vie tiedosto
* `Ctrl` + `P`: Tulosta tiedosto
* `Ctrl` + `Shift` + `E`: Vie kuva
* `Ctrl` + `Alt` + `E`: Vie tiedosto svg
* `Ctrl` + `Alt` + `Shift` + `E`: Vie tiedosto svg
* `Ctrl` + `Alt` + `P`: Avaa paketit
* `Ctrl` + `Alt` + `S`: Avaa asetukset

### Projekti

* `Ctrl` + `Z`: Kumoa
* `Ctrl` + `Y`: Redo
* `Ctrl` + `Shift` + `P`: Open waypoints dialog
* `Ctrl` + `B`: Avaa taustaikkuna
* `Ctrl` + `Vaihto` + `A`: Avaa alueet -valintaikkuna
* `Ctrl` + `S`: Tallenna
* `Alt` + `S`: Muuta polkua
* `Ctrl` + (`1` - `0`): Vaihda työkaluun
* `Ctrl` + `+`: Lähennä
* `Ctrl` + `-`: Lähennä

## Kynä

By default, the the pen is configured to function as the following:
* `Pen`: configured as pen.
* `First` (Primary button, if supported): Change to hand tool while pressed.
* `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.



## Määritä {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

* Empty - the tool is unchaged.
* 0 - the tool will function as moving (i.e., hand) in this mod.
* Positive number - The tool will follow the indexing as explain above. 


