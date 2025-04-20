---
title: Verknüpfungen
---

## Tastatur

Es gibt ein paar Verknüpfungen, die Sie im Editor verwenden können.
Einige davon sind unter den Buttons geschrieben.

### Allgemein

- `Strg` + `N`: Neue Datei
- `Ctrl` + `Shift` + `N`: Neue Datei aus Vorlage
- `Strg` + `E`: Datei exportieren
- `Strg` + `P`: Datei drucken
- `Strg` + `Shift` + `E`: Datei als Bild exportieren
- `Strg` + `Alt` + `E`: Datei als svg exportieren
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as pdf
- `Strg` + `Alt` + `P`: Open Packs
- `Strg` + `Alt` + `S`: Einstellungen öffnen

### Projekt

- `Ctrl` + `K`: Open search
- `Strg` + `Z`: Rückgängig
- `Strg` + `Y`: Redo
- `Strg` + `Shift` + `P`: Öffne Wegpunkte Dialog
- `Strg` + `B`: Hintergrunddialog öffnen
- `Strg` + `S`: Speichern
- `Alt` + `S`: Pfad ändern
- `Ctrl` + (`1` - `0`): Wechsele zum Werkzeug
- `Strg` + `+`: Zoom in
- `Strg` + `-`: Verkleinern

## Stift

Standardmäßig ist der Stift so konfiguriert, dass er wie folgt funktioniert:

- `Pen`: als Stift konfiguriert.
- `First` (Primärer Knopf, falls unterstützt): Ändern Sie das Handwerkzeug während Sie gedrückt werden.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below) while pressed.

## Configuring {#configure}

You can customize your controls by changing which tools your inputs map to.

**Note:** Input configurations will be ignored while certain tools are selected, such as the Lasso Select tool, the Rectangle Select tool, the Label tool, and the Area tool.

To begin, go to `Settings` → `Inputs` and then select the input method you want to configure, such as `Mouse`, `Touch`, or `Pen`. You will be presented with a list of configurable inputs and the tools they are currently mapped to.

After selecting an input, you will have 3 options:

- `Active Tool`: The input will act as the currently selected tool on the toolbar.
- `Hand Tool`: The input will temporarily switch to the hand tool, allowing you to move around the canvas.
- `Specific Tool on Toolbar`: The input will temporarily switch to a tool on your toolbar, based on the position number you specify. Positions are counted starting from the left, so if you specify position `1`, the first tool on the left will be selected. See the screenshot below for an example of how position numbers are counted. For information about how to customize your toolbar, see [The Document View](../intro/#important-notes).

![Toolbar nummeriert](toolbar_numbered.png)