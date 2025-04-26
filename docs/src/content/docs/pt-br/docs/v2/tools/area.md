---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## Ações.

|                 Mouse                 |      Toque      |         Acão        |
| :-----------------------------------: | :-------------: | :-----------------: |
| Clique com o botão esquerdo e arraste | Toque e arraste | Criar uma nova área |
|             Clique do meio            |    Dois dedos   |      Mover tela     |
|             Clique direito            |   Toque longo   |     Editar área     |

## Configuração

|         Propriedade | Padrão | Descrição                                                                                                                                                                                                                                                                                                                                                                                                              |
| ------------------: | :----: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|             Largura |   `0`  | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|              Altura |   `0`  | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| Proporção da imagem |   `0`  | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Existem três predefinições da relação de aspectos:

- Quadrado (1:1)
- Retrato da página (sqrt(2)) - Esta é a proporção padrão de proporção de uma página A4 no modo retrato.
- Paisagem da página (1/sqrt(2)) - Essa é a proporção padrão de aspecto de uma página A4 em modo paisagem.
