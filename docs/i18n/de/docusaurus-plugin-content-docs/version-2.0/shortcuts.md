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

Standardmäßig ist der Stift so konfiguriert, dass er wie folgt funktioniert:

- `Pen`: als Stift konfiguriert.
- `First` (Primärer Knopf, falls unterstützt): Ändern Sie das Handwerkzeug während Sie gedrückt werden.
- `Second` (sekundäre Schaltfläche, falls unterstützt): Wechseln Sie zum zweiten Werkzeug (siehe [configure](#configure) Abschnitt unten, während Sie gedrückt werden.

## Konfiguriere {#configure}

Sie können die Steuerelemente anpassen, indem Sie jeder Steuerung einen Werkzeugindex geben. Die Werkzeug-Indexierung beginnt links neben der Werkzeugleiste, wobei `1` der erste Index ist. Siehe Beispiel unten

![Toolbar nummeriert](toolbar_numbered.png)

Hier bezieht sich 1 auf das Lasso-Werkzeug, 2, das Pfangenwerkzeug usw.

Die Konfigurationsoptionen, die Sie haben, sind folgende:

- Leer - das Werkzeug ist freigeschaltet.
- 0 - das Werkzeug funktioniert als Bewegung (d.h. Hand) in diesem Mod.
- Positive Nummer - Das Tool folgt der Indizierung wie oben beschrieben.
