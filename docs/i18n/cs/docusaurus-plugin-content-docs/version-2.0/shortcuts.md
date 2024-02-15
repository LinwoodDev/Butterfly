---
title: Zkratky
sidebar_position: 2
---

## Keyboard

Existuje několik zkratek, které můžete použít v editoru.
Některé z nich jsou zapsány pod tlačítky.

### Obecná ustanovení

- `Ctrl` + `N`: Nový soubor
- `Ctrl` + `Shift` + `N`: Nový soubor ze šablony
- `Ctrl` + `E`: Exportovat soubor
- `Ctrl` + `P`: Tisknout soubor
- `Ctrl` + `Shift` + `E`: Exportovat soubor jako obrázek
- `Ctrl` + `Alt` + `E`: Exportovat soubor jako svg
- `Ctrl` + `Alt` + `Shift` + `E`: Exportovat soubor jako svg
- `Ctrl` + `Alt` + `P`: Otevřené balíčky
- `Ctrl` + `Alt` + `S`: Otevřít nastavení

### Projekt

- `Ctrl` + `Z`: Vrátit zpět
- `Ctrl` + `Y`: Znovu
- `Ctrl` + `Shift` + `P`: Otevřete dialog trasových bodů
- `Ctrl` + `B`: Otevřít dialog na pozadí
- `Ctrl` + `Shift` + `A`: dialogové okno otevřených oblastí
- `Ctrl` + `S`: Uložit
- `Alt` + `S`: Změna cesty
- `Ctrl` + (`1` - `0`): Přepnout na nástroj
- `Ctrl` + `+`: Přiblížení
- `Ctrl` + `-`: Oddálit

## Pec

By default, the the pen is configured to function as the following:

- `Pen`: configured as pen.
- `First` (Primary button, if supported): Change to hand tool while pressed.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.

## Konfigurovat {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

- Empty - the tool is unchaged.
- 0 - the tool will function as moving (i.e., hand) in this mod.
- Positive number - The tool will follow the indexing as explain above.
