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

Por defecto, el lápiz está configurado para funcionar de la siguiente manera:

- `Pen`: configurado como pluma.
- `Primero` (botón primario, si es soportado): Cambia a la herramienta de mano mientras se presiona.
- `Segundo` (botón secundario, si es soportado): Cambia a la segunda herramienta (ver la sección [configure](#configurado) abajo) mientras se pulsa.

## Configurar {#configure}

Puede personalizar los controles dando a cada control un índice de herramientas. La indexación de la herramienta comienza desde la izquierda de la barra de herramientas, siendo `1` el primer índice. Ver ejemplo a continuación

![barra de herramientas numerada](toolbar_numbered.png)

Aquí, 1 se refiere a la herramienta lasso 2, a la herramienta pan etc.

Las opciones de configuración son las siguientes:

- Vaciar - la herramienta no está encajada.
- 0 - la herramienta funcionará como moviendo (es decir, mano) en este mod.
- Número positivo - La herramienta seguirá la indexación como explicamos arriba.
