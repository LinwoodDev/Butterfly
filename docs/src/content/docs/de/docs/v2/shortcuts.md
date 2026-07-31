---
title: Verknüpfungen
---

Shortcuts are a way to map specific inputs to an action that influences the editor.

To begin, go to `Settings` → `Inputs` and then select the input method you want to configure, such
as `Mouse`, `Touch`, `Keyboard` or `Pen`. You will be presented with a list of configurable inputs
and the actions they are currently mapped to.

These actions are divided into [tool activators](#tool-activators)
and [document actions](#document-actions).

## Tool activators {#tool-activators}

Sie können Ihre Steuerelemente anpassen, indem Sie ändern, welchen Werkzeugen Ihre Eingaben zugeordnet sind.

**Note:** Tool activators will be ignored while certain tools are selected, such as the Select tool,
the Label tool, and the Area tool.

- `None`: Nothing will happen when using this input.
- `Aktives Werkzeug`: Die Eingabe verhält sich wie das aktuell ausgewählte Werkzeug in der Symbolleiste.
- `Hand Tool`: The input will use the hand tool as a [temporary tool](../tools#temporary-tools),
  allowing you to move around the canvas.
- `Specific Tool on Toolbar`: The input will use the specified tool on the toolbar as
  a [temporary tool](../tools#temporary-tools), based on the position you specify. Positions are
  counted
  starting from the left, so if you specify position `1`, the first tool on the left will be
  selected. Im Screenshot unten sehen Sie ein Beispiel dafür, wie Positionsnummern gezählt werden. For
  information about how to reorder your tools,
  see [Customizing the Toolbar](../intro/#customizing-the-toolbar).

![Toolbar nummeriert](toolbar_numbered.png)

## Document actions {#document-actions}

- `None`: Nothing happens
- `Long press`: Opens the [Context menu](../context_menu)
- `Search`: Searches the document for pages and tools
- `Undo`: Triggers the [Undo tool](../tools/undo)
- `Redo`: Triggers the [Redo tool](../tools/redo)
- `Background`: Opens the [Background dialog](../background)
- `Save`: Saves the document state
- `Change path`: Changes where the document is stored relative to the `Documents` folder
  in [Data directory](../storage/#data-directory).
- `Zoom in`: Zooms into the canvas at the current position. See [Camera](../utilities/camera).
- `Zoom out`: Zooms out of the canvas at the current position. See [Camera](../utilities/camera).
- `Rotate left`: Rotates the canvas counter-clockwise. See [Camera](../utilities/camera).
- `Rotate right`: Rotates the canvas clockwise. See [Camera](../utilities/camera).
- `Full screen`: Toggles [Full screen](../tools/full_screen)
- `Hide UI`: Hides everything except the canvas. To leave this view, click the `Exit` button on the
  bottom right.
- `Next page`: Navigates to the next [page](../pages)
- `Previous page`: Navigates to the previous [page](../pages)
- `Select all`: Selects all elements on the canvas
- `Paste`: Pastes the clipboard
- `Tool 1-10`: Switches the active tool to the specified toolbar position

The canvas rotation and zoom step can be changed in `Settings` → `Behaviours`.

---

## Maus

### Mouse configurations

|                              Objekt | Standard | Beschreibung                                                                                           |
| ----------------------------------: | :------: | :----------------------------------------------------------------------------------------------------- |
| Cursor während Zeichnung ausblenden |   true   | Versteckt den Mauszeiger während des Zeichnens, so dass er den Strich nicht überdeckt. |

### Mouse shortcuts

**Tool activators**:

- `Left`: When holding the left mouse button. Defaults to `Active Tool`
- `Middle`: When holding the mouse wheel. Defaults to `Hand Tool`
- `Right`: When holding the right mouse button. Defaults to `Toolbar Position 2`
- `Back`: When clicking 4th mouse button at the side of some mice.
- `Forward`: When clicking 5th mouse button at the side of some mice.

**Document actions**:

_By default, the mouse document actions are all set to `None`._

- `Double Left`: A double click on the left mouse button
- `Triple Left`: A triple click on the left mouse button
- `Double Middle`: A double click on the mouse wheel
- `Triple Middle`: A triple click on the mouse wheel
- `Double Right`: A double click on the right mouse button
- `Triple Right`: A triple click on the right mouse button
- `Double Back`: A double click on the 4th mouse button at the side of some mice
- `Triple Back`: A triple click on the 4th mouse button at the side of some mice
- `Double Forward`: A double click on the 5th mouse button at the side of some mice
- `Triple Forward`: A triple click on the 5th mouse button at the side of some mice

## Berühren

### Touch configurations

|                Objekt | Standard | Beschreibung                                                                                                     |
| --------------------: | :------: | :--------------------------------------------------------------------------------------------------------------- |
|         Eingabegesten |   true   | Lets you move and zoom the canvas with touch gestures, even while drawing tool is selected.      |
| Verschieben bei Geste |   true   | Lassen Sie uns Multi-Touch-Gesten die Leinwand bewegen, anstatt mit Notizinhalt zu interagieren. |

### Touch shortcuts

**Tool activators**:

- `Touch`: When touching the screen. Defaults to `Active Tool`

**Document actions**:

_By default, the touch document actions are all set to `None`._

- `Double press action`: A double-tap
- `Triple press action`: A triple-tap
- `Two finger tap`: A simultaneous two-finger tap
- `Three finger tap`: A simultaneous three-finger tap

## Tastatur

Keyboard actions are divided into the categories hold shortcuts
for **tool activators**, general and project
for **document actions**.

### Hold shortcuts

_There is no default configuration. You may add any key mappings
to **tool activators**._

### Allgemein

- `Strg` + `N`: Neue Datei
- `Ctrl` + `Shift` + `N`: Neue Datei aus Vorlage
- `Strg` + `E`: Datei exportieren
- `Ctrl` + `Shift` + `E`: Exportieren Datei (text based)
- `Ctrl` + `Alt` + `Shift` + `E`: Exportieren Datei as image
- `Ctrl` + `Shift` + `P`: Export file as PDF
- `Ctrl` + `Alt` + `E`: Export file as SVG
- `Strg` + `Alt` + `S`: Einstellungen öffnen
- `Strg` + `Alt` + `P`: Open Packs
- `Escape`: Escape

### Projekt

- `Strg` + `K`: Suche öffnen
- `Strg` + `Z`: Rückgängig
- `Strg` + `Y`: Redo
- `Strg` + `B`: Hintergrunddialog öffnen
- `Strg` + `S`: Speichern
- `Alt` + `S`: Pfad ändern
- `Strg` + `+`: Zoom in
- `Strg` + `-`: Verkleinern
- `Ctrl` + `Shift` + `Left`: Rotate canvas left
- `Ctrl` + `Shift` + `Right`: Rotate canvas right
- `F11`: Full screen
- `F12`: Hide UI
- `Arrow Right`: Next slide in presentation
- `Arrow Left`: Previous slide in presentation
- `Page Down`: Next page
- `Page Up`: Previous page
- `Ctrl` + `Space`: Pause presentation
- `Ctrl` + `A`: Select all
- `Ctrl` + `V`: Pastes the clipboard
- `Ctrl` + (`1` - `0`): Wechsele zum Werkzeug

## Stift

### Pen configurations

|             Objekt |              Values              | Beschreibung                                                                                                                     |
| -----------------: | :------------------------------: | :------------------------------------------------------------------------------------------------------------------------------- |
|    Nur-Pen-Eingabe | Automatic, Always on, Always off | Prevents accidental marks from your hand or mouse when only pen input can draw.                                  |
| Nur Stift anzeigen |            true, false           | Zeigt einen schnellen Pen-Only Schalter im Editor, nachdem Butterfly einen Stift erkennt.                        |
|    Ignoriere Druck |       Never, First, Always       | Controls whether a pen pressure changes the stroke and works around inaccurate pressure readings from some pens. |

### Pen shortcuts

By default, the pen is configured to function with the
following **tool activators**:

- `Pen`: Using the pen normally. Defaults to `Active Tool`
- `Inverted Pen`: Using the pen in inverted mode. Defaults to `Toolbar Position 4`
- `First`: While holding its primary button, if supported. Defaults to  `Toolbar Position 3` (often
  path-eraser)
- `Second`: While holding its secondary button, if supported. Defaults to `Toolbar Position 2`

_By default, the pen **document actions** are all set to `None`._

- `Double Pen`: Double-tapping using a pen
- `Triple Pen`: Triple-tapping using a pen
- `Double Inverted Pen`: Double-tapping using a pen in inverted mode
- `Triple Inverted Pen`: Triple-tapping using a pen in inverted mode
- `Double First`: Double-tapping using a pen while holding its primary button
- `Triple First`: Triple-tapping using a pen while holding its primary button
- `Double Second`: Double-tapping using a pen while holding its secondary button
- `Triple Second`: Triple-tapping using a pen while holding its secondary button
