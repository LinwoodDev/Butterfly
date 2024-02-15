---
title: Verknüpfungen
sidebar_position: 2
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
- `Ctrl` + `Alt` + `Shift` + `E`: Datei als svg exportieren
- `Strg` + `Alt` + `P`: Open Packs
- `Strg` + `Alt` + `S`: Einstellungen öffnen

### Projekt

- `Strg` + `Z`: Rückgängig
- `Strg` + `Y`: Redo
- `Strg` + `Shift` + `P`: Öffne Wegpunkte Dialog
- `Strg` + `B`: Hintergrunddialog öffnen
- `Strg` + `Shift` + `A`: Öffne Bereiche Dialog
- `Strg` + `S`: Speichern
- `Alt` + `S`: Pfad ändern
- `Ctrl` + (`1` - `0`): Wechsele zum Werkzeug
- `Strg` + `+`: Zoom in
- `Strg` + `-`: Verkleinern

## Stift

By default, the the pen is configured to function as the following:

- `Pen`: configured as pen.
- `First` (Primary button, if supported): Change to hand tool while pressed.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.

## Konfiguriere {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

- Empty - the tool is unchaged.
- 0 - the tool will function as moving (i.e., hand) in this mod.
- Positive number - The tool will follow the indexing as explain above.
