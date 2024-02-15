---
title: Atajos
sidebar_position: 2
---

## Keyboard

Hay algunos atajos que puedes usar en el editor.
Algunos de ellos se escriben debajo de los botones.

### General

- `Ctrl` + `N`: Nuevo archivo
- `Ctrl` + `Shift` + `N`: Nuevo archivo de plantilla
- `Ctrl` + `E`: Exportar archivo
- `Ctrl` + `P`: Imprime el archivo
- `Ctrl` + `Shift` + `E`: Exportar archivo como imagen
- `Ctrl` + `Alt` + `E`: Exportar archivo como svg
- `Ctrl` + `Alt` + `Shift` + `E`: Exportar archivo como svg
- `Ctrl` + `Alt` + `P`: Abrir paquetes
- `Ctrl` + `Alt` + `S`: Abrir ajustes

### Projekt

- `Ctrl` + `Z`: Deshacer
- `Ctrl` + `Y`: Rehacer
- `Ctrl` + `Shift` + `P`: Abrir diálogo de waypoints
- `Ctrl` + `B`: Abrir diálogo de fondo
- `Ctrl` + `Shift` + `A`: Abrir diálogo de áreas
- `Ctrl` + `S`: Guarda
- `Alt` + `S`: Cambia la ruta
- `Ctrl` + (`1` - `0`): Cambia a herramienta
- `Ctrl` + `+`: Acercar en
- `Ctrl` + `-`: Alejar el zoom

## Pen

By default, the the pen is configured to function as the following:

- `Pen`: configured as pen.
- `First` (Primary button, if supported): Change to hand tool while pressed.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.

## Configurar {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

- Empty - the tool is unchaged.
- 0 - the tool will function as moving (i.e., hand) in this mod.
- Positive number - The tool will follow the indexing as explain above.
