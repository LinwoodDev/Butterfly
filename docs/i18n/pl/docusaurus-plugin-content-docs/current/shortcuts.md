---
title: "Skróty"
sidebar_position: 2
---


## Keyboard

Jest kilka skrótów, których możesz użyć w edytorze. Niektóre z nich są napisane pod przyciskami.

### Ogólny

* `Ctrl` + `N`: Nowy plik
* `Ctrl` + `Shift` + `N`: Nowy plik z szablonu
* `Ctrl` + `E`: Eksportuj plik
* `Ctrl` + `P`: Wydrukuj plik
* `Ctrl` + `Shift` + `E`: Eksportuj plik jako obraz
* `Ctrl` + `Alt` + `E`: Eksportuj plik jako svg
* `Ctrl` + `Alt` + `Shift` + `E`: Eksportuj plik jako svg
* `Ctrl` + `Alt` + `P`: Otwórz pakiety
* `Ctrl` + `Alt` + `S`: Otwórz ustawienia

### Projekt

* `Ctrl` + `Z`: Cofnij
* `Ctrl` + `Y`: Ponów
* `Ctrl` + `Shift` + `P`: Open waypoints dialog
* `Ctrl` + `B`: Otwórz okno w tle
* `Ctrl` + `Shift` + `A`: Otwarte okno dialogowe
* `Ctrl` + `S`: Zapisz
* `Alt` + `S`: Zmień ścieżkę
* `Ctrl` + (`1` - `0`): Przełącz na narzędzie
* `Ctrl` + `+`: Przybliż
* `Ctrl` + `-`: Pomniejsz

## Długopis

By default, the the pen is configured to function as the following:
* `Pen`: configured as pen.
* `First` (Primary button, if supported): Change to hand tool while pressed.
* `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.



## Skonfiguruj {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

* Empty - the tool is unchaged.
* 0 - the tool will function as moving (i.e., hand) in this mod.
* Positive number - The tool will follow the indexing as explain above. 


