---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Configuração

|           Propriedade |                    Padrão                    | Descrição                                                                                                                                                                                      |
| --------------------: | :------------------------------------------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|           Centralizar |                     Falso                    | Draws the shape from the center instead of from the corner.                                                                                                                    |
|               Largura |                       0                      | Raio das bordas Se definido como 0, a largura será calculada automaticamente.                                                                                                  |
|                Altura |                       0                      | A altura fixa da área. Se definido como 0, a altura será calculada automaticamente.                                                                            |
|   Proporção da imagem |                       0                      | O rácio de aspecto fixo da área. Se definido para 0, a proporção será calculada automaticamente. An aspect ratio is defined as width / height. |
|    Espessura do traço |                       5                      | A largura do traço                                                                                                                                                                             |
|       Estilo de traço |                    Sólido                    | The style of the stroke. Other styles can use dash and gap lengths.                                                                                            |
|  Comprimento do Traço |                       1                      | The length of the dash when using a non-solid stroke style                                                                                                                                     |
| Comprimento da lacuna |                       1                      | The length of the gap when using a non-solid stroke style                                                                                                                                      |
|                   Cor |    Solid Color (Black)    | [Customization](../../colors/#further-customization) for the color of the shape                                                                                                                |
|                 Forma |                   Retângulo                  | The shape that will be drawn. Available shapes are Rectangle, Triangle, Circle and Line                                                                                        |
|             Preencher |                  0, 0, 0, 0                  | The radius of the corners when shape is Rectangle                                                                                                                                              |
|             Preencher | Solid Color (Transparent) | [Customization](../../colors/#further-customization) for the color drawn inside the shape. Not available for Line shapes                                                       |
|    Dependendo do zoom |                     Falso                    | Isto mudará a largura do traço com base no nível de zoom.                                                                                                                      |