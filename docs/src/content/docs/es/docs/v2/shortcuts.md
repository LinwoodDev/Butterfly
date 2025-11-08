---
title: Atajos
---

## Keyboard

Hay algunos atajos que puedes usar en el editor.
Algunos de ellos se escriben debajo de los botones.

### General

- `Ctrl` + `N`: Nuevo archivo
- `Ctrl` + `Shift` + `N`: Nuevo archivo de plantilla
- `Ctrl` + `E`: Exportar archivo
- Nightly (2.4): `Ctrl` + `Shift` + `E`: Export file (text based)
- `Ctrl` + `Alt` + `E`: Exportar archivo como svg
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as pdf
- `Ctrl` + `Alt` + `Shift` + `E` (Nightly (2.4): `Ctrl` + `Shift` + `P`): Export file as pdf
- `Ctrl` + `Alt` + `S`: Abrir ajustes
- `Ctrl` + `Alt` + `P`: Abrir paquetes

### Projekt

- `Ctrl` + `K`: Open search
- `Ctrl` + `Z`: Deshacer
- `Ctrl` + `Y`: Rehacer
- `Ctrl` + `Shift` + `P`: Abrir diálogo de waypoints
- `Ctrl` + `B`: Abrir diálogo de fondo
- `Ctrl` + `S`: Guarda
- `Alt` + `S`: Cambia la ruta
- `Ctrl` + (`1` - `0`): Cambia a herramienta
- `Ctrl` + `+`: Acercar en
- `Ctrl` + `-`: Alejar el zoom

## Pen

Por defecto, el lápiz está configurado para funcionar de la siguiente manera:

- `Pen`: configurado como pluma.
- `Primero` (botón primario, si es soportado): Cambia a la herramienta de mano mientras se presiona.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below) while pressed.

## Configuring {#configure}

You can customize your controls by changing which tools your inputs map to.

**Note:** Input configurations will be ignored while certain tools are selected, such as the Lasso Select tool, the Rectangle Select tool, the Label tool, and the Area tool.

To begin, go to `Settings` → `Inputs` and then select the input method you want to configure, such as `Mouse`, `Touch`, or `Pen`. You will be presented with a list of configurable inputs and the tools they are currently mapped to.

After selecting an input, you will have 3 options:

- `Active Tool`: The input will act as the currently selected tool on the toolbar.
- `Hand Tool`: The input will temporarily switch to the hand tool, allowing you to move around the canvas.
- `Specific Tool on Toolbar`: The input will temporarily switch to a tool on your toolbar, based on the position number you specify. Positions are counted starting from the left, so if you specify position `1`, the first tool on the left will be selected. See the screenshot below for an example of how position numbers are counted. For information about how to reorder your tools, see [Customizing the Toolbar](../intro/#customizing-the-toolbar).

![barra de herramientas numerada](toolbar_numbered.png)