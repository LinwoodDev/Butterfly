---
title: Zkratky
---

## Klávesnice

Existuje několik zkratek, které můžete použít v editoru.
Některé z nich jsou zapsány pod tlačítky.

### Obecná ustanovení

- `Ctrl` + `N`: Nový soubor
- `Ctrl` + `Shift` + `N`: Nový soubor ze šablony
- `Ctrl` + `E`: Exportovat soubor
- `Ctrl` + `P`: Tisknout soubor
- `Ctrl` + `Alt` + `E`: Exportovat soubor jako svg
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as pdf
- `Ctrl` + `Alt` + `P`: Otevřené balíčky
- `Ctrl` + `Alt` + `S`: Otevřít nastavení
- `Ctrl` + `Alt` + `S`: Otevřít nastavení

### Projekt

- `Ctrl` + `K`: Open search
- `Ctrl` + `Z`: Vrátit zpět
- `Ctrl` + `Y`: Znovu
- `Ctrl` + `Shift` + `P`: Otevřete dialog trasových bodů
- `Ctrl` + `B`: Otevřít dialog na pozadí
- `Ctrl` + `S`: Uložit
- `Alt` + `S`: Změna cesty
- `Ctrl` + (`1` - `0`): Přepnout na nástroj
- `Ctrl` + `+`: Přiblížení
- `Ctrl` + `-`: Oddálit

## Pec

Ve výchozím nastavení je pero nastaveno tak, aby fungovalo:

- `Pen`: nakonfigurován jako pen.
- `First` (Primární tlačítko, pokud je podporováno): Přepnout na ruční nástroj při stisknutí.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below) while pressed.

## Configuring {#configure}

You can customize your controls by changing which tools your inputs map to.

**Note:** Input configurations will be ignored while certain tools are selected, such as the Lasso Select tool, the Rectangle Select tool, the Label tool, and the Area tool.

To begin, go to `Settings` → `Inputs` and then select the input method you want to configure, such as `Mouse`, `Touch`, or `Pen`. You will be presented with a list of configurable inputs and the tools they are currently mapped to.

After selecting an input, you will have 3 options:

- `Active Tool`: The input will act as the currently selected tool on the toolbar.
- `Hand Tool`: The input will temporarily switch to the hand tool, allowing you to move around the canvas.
- `Specific Tool on Toolbar`: The input will temporarily switch to a tool on your toolbar, based on the position number you specify. Positions are counted starting from the left, so if you specify position `1`, the first tool on the left will be selected. See the screenshot below for an example of how position numbers are counted. For information about how to reorder your tools, see [Customizing the Toolbar](../intro/#customizing-the-toolbar).

![toolbar numbered](toolbar_numbered.png)