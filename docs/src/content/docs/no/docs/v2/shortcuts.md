---
title: Snarveier
---

## Keyboard

Det er noen snarveier du kan benytte i editoren.
Noen av dem er skrevet under knappene.

### Generelt

- `Ctrl` + `N`: Ny fil
- `Ctrl` + `Shift` + `N`: Ny fil fra mal
- `Ctrl` + `E`: Eksporter fil
- `Ctrl` + `P`: Skriv ut fil
- `Ctrl` + `Alt` + `E`: Eksporter filen som svg
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as pdf
- `Ctrl` + `Alt` + `P`: Åpne pakker
- `Ctrl` + `Alt` + `S`: Åpne innstillinger
- `Ctrl` + `Alt` + `S`: Åpne innstillinger

### Prosjekt

- `Ctrl` + `K`: Open search
- `Ctrl` + `Z`: Angre
- `Ctrl` + `Y`: Omgjør
- `Ctrl` + `Shift` + `P`: Open waypoint dialog
- `Ctrl` + `B`: Åpne bakgrunnsdialog
- `Ctrl` + `S`: lagre
- `Alt` + `S`: Endringsbane
- `Ctrl` + (`1` - `0`): Bytt til verktøy
- `Ctrl` + `+`: Zoom inn
- `Ctrl` + `-`: Zoom ut

## Penn

Som standard konfigureres pennen til å fungere som følgende:

- En penn: konfigurert som penn.
- `Først` (Primærknapp, hvis støttet): Bytt til håndverktøy mens du trykker.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below) while pressed.

## Configuring {#configure}

You can customize your controls by changing which tools your inputs map to.

**Note:** Input configurations will be ignored while certain tools are selected, such as the Lasso Select tool, the Rectangle Select tool, the Label tool, and the Area tool.

To begin, go to `Settings` → `Inputs` and then select the input method you want to configure, such as `Mouse`, `Touch`, or `Pen`. You will be presented with a list of configurable inputs and the tools they are currently mapped to.

After selecting an input, you will have 3 options:

- `Active Tool`: The input will act as the currently selected tool on the toolbar.
- `Hand Tool`: The input will temporarily switch to the hand tool, allowing you to move around the canvas.
- `Specific Tool on Toolbar`: The input will temporarily switch to a tool on your toolbar, based on the position number you specify. Positions are counted starting from the left, so if you specify position `1`, the first tool on the left will be selected. See the screenshot below for an example of how position numbers are counted. For information about how to reorder your tools, see [Customizing the Toolbar](../intro/#customizing-the-toolbar).

\==verktøylinje nummerert](toolbar_numbered.png)