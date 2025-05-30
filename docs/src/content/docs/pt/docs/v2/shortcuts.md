---
title: Atalhos
---

## Teclado

Existem alguns atalhos que você pode usar no editor.
Alguns deles estão escritos abaixo dos botões.

### Geral

- `Ctrl` + `N`: Novo arquivo
- `Ctrl` + `Shift` + `N`: Novo arquivo do template
- `Ctrl` + `E`: Exportar arquivo
- Nightly (2.4): `Ctrl` + `Shift` + `E`: Export file (text based)
- `Ctrl` + `P`: Imprimir arquivo
- `Ctrl` + `Shift` + `E` (Nightly (2.4): `Ctrl` + `Alt` + `Shift` + `E`): Export file as image
- `Ctrl` + `Alt` + `E`: Exportar arquivo como svg
- `Ctrl` + `Alt` + `Shift` + `E` (Nightly (2.4): `Ctrl` + `Shift` + `P`): Export file as pdf
- `Ctrl` + `Alt` + `P`: Abrir pacotes
- `Ctrl` + `Alt` + `S`: Abra as configurações

### Projecto

- `Ctrl` + `K`: Open search
- `Ctrl` + `Z`: Desfazer
- `Ctrl` + `Y`: Refazer
- `Ctrl` + `Shift` + `P`: Abrir diálogo de waypoints
- `Ctrl` + `B`: Abrir diálogo em segundo plano
- `Ctrl` + `S`: Salvar
- `Alt` + `S`: Mudar caminho
- `Ctrl` + (`1` - `0`): Mude para a ferramenta
- `Ctrl` + `+`: Zoom para
- `Ctrl` + `-`: Zoom para fora

## Caneta

Por padrão, a caneta está configurada para funcionar como o seguinte:

- `Pen`: configurado como caneta.
- `Primeiro` (botão principal, se suportado): Mude a ferramenta enquanto pressionado.
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