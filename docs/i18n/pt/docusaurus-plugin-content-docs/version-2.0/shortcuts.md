---
title: Atalhos
sidebar_position: 2
---

## Keyboard

Existem alguns atalhos que você pode usar no editor.
Alguns deles estão escritos abaixo dos botões.

### Gerais

- `Ctrl` + `N`: Novo arquivo
- `Ctrl` + `Shift` + `N`: Novo arquivo do template
- `Ctrl` + `E`: Exportar arquivo
- `Ctrl` + `P`: Imprimir arquivo
- `Ctrl` + `Shift` + `E`: Exportar arquivo como imagem
- `Ctrl` + `Alt` + `E`: Exportar arquivo como svg
- `Ctrl` + `Alt` + `Shift` + `E`: Exportar arquivo como svg
- `Ctrl` + `Alt` + `P`: Abrir pacotes
- `Ctrl` + `Alt` + `S`: Abra as configurações

### Projecto

- `Ctrl` + `Z`: Desfazer
- `Ctrl` + `Y`: Refazer
- `Ctrl` + `Shift` + `P`: Abrir diálogo de waypoints
- `Ctrl` + `B`: Abrir diálogo em segundo plano
- `Ctrl` + `Shift` + `A`: Abrir diálogo de áreas
- `Ctrl` + `S`: Salvar
- `Alt` + `S`: Mudar caminho
- `Ctrl` + (`1` - `0`): Mude para a ferramenta
- `Ctrl` + `+`: Zoom para
- `Ctrl` + `-`: Zoom para fora

## Caneta

Por padrão, a caneta está configurada para funcionar como o seguinte:

- `Pen`: configurado como caneta.
- `Primeiro` (botão principal, se suportado): Mude a ferramenta enquanto pressionado.
- `Segundo` (botão secundário, se suportado): Altere para a segunda ferramenta (veja [configure](#configure) seção abaixo) enquanto pressionado.

## Configurar {#configure}

Você pode personalizar os controles dando a cada controle uma ferramenta índice. A indexação de ferramentas começa à esquerda da barra de ferramentas, com `1` sendo o primeiro índice. Ver exemplo abaixo

![toolbar numbered](toolbar_numbered.png)

Aqui, 1 se refere à ferramenta laço, 2, à ferramenta panaceia, etc.

As opções de configuração que você tem são as seguintes:

- Vazio - a ferramenta está desencurralada.
- 0 - a ferramenta irá funcionar como movimento (ou seja, mão) neste mod.
- Número positivo - A ferramenta seguirá a indexação conforme explicação acima.
