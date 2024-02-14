---
title: "Atalhos"
sidebar_position: 2
---


## Keyboard

Existem alguns atalhos que você pode usar no editor. Alguns deles estão escritos abaixo dos botões.

### Gerais

* `Ctrl` + `N`: Novo arquivo
* `Ctrl` + `Shift` + `N`: Novo arquivo a partir do modelo
* `Ctrl` + `E`: Exportar arquivo
* `Ctrl` + `P`: Imprimir arquivo
* `Ctrl` + `Shift` + `E`: Exportar o arquivo como imagem
* `Ctrl` + `Alt` + `E`: Exportar o arquivo como svg
* `Ctrl` + `Alt` + `Shift` + ``: Exportar arquivo como svg
* `Ctrl` + `Alt` + `P`: Abrir pacotes
* `Ctrl` + `Alt` + `S`: Abrir configurações

### Projecto

* `Ctrl` + `Z`: Desfazer
* `Ctrl` + `Y`: Refazer
* `Ctrl` + `Shift` + `P`: Open waypoints dialog
* `Ctrl` + `B`: Abrir diálogo em segundo plano
* `Ctrl` + `Shift` + `A`: Abrir diálogo de áreas
* `Ctrl` + `S`: Salvar
* `Alt` + `S`: Mudar caminho
* `Ctrl` + (`1` - `0`): Mudar para ferramenta
* `Ctrl` + `+`: Zoom para
* `Ctrl` + `-`: Zoom para fora

## Caneta

By default, the the pen is configured to function as the following:
* `Pen`: configured as pen.
* `First` (Primary button, if supported): Change to hand tool while pressed.
* `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.



## Configurar {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

* Empty - the tool is unchaged.
* 0 - the tool will function as moving (i.e., hand) in this mod.
* Positive number - The tool will follow the indexing as explain above. 


