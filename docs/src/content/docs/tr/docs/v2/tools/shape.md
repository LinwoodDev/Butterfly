---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Yapılandırma

|               Özellik |                  Varsayılan                  | Tanım                                                                                                                                                                                                  |
| --------------------: | :------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                  Orta |                     false                    | Draws the shape from the center instead of from the corner.                                                                                                                            |
|              Genişlik |                       0                      | Kontur genişliği Eğer 0 olarak ayarlanırsa genişlik otomatik olarak hesaplanacaktır.                                                                                                   |
|             Yükseklik |                       0                      | Alan yüksekliğini sabitleme. Eğer 0 olarak ayarlanırsa yükseklik otomatik olarak hesaplanacaktır.                                                                      |
|          En boy oranı |                       0                      | Alanın en boy oranını sabitleme. Eğer 0 olarak ayarlanırsa en boy oranı otomatik olarak hesaplanacaktır. An aspect ratio is defined as width / height. |
|      Kontur genişliği |                       5                      | Dolgu                                                                                                                                                                                                  |
|          Stroke style |                     Katı                     | The style of the stroke. Other styles can use dash and gap lengths.                                                                                                    |
|           Dash length |                       1                      | The length of the dash when using a non-solid stroke style                                                                                                                                             |
|            Gap length |                       1                      | The length of the gap when using a non-solid stroke style                                                                                                                                              |
|                  Renk |    Solid Color (Black)    | [Customization](../../colors/#further-customization) for the color of the shape                                                                                                                        |
|                 Şekil |                  Dikdörtgen                  | The shape that will be drawn. Available shapes are Rectangle, Triangle, Circle and Line                                                                                                |
|     Köşe yuvarlaklığı |                  0, 0, 0, 0                  | The radius of the corners when shape is Rectangle                                                                                                                                                      |
|                 Dolgu | Solid Color (Transparent) | [Customization](../../colors/#further-customization) for the color drawn inside the shape. Not available for Line shapes                                                               |
| Bağımlı yakınlaştırma |                     false                    | Bu, yakınlaştırma düzeyine bağlı olarak kontur genişliğini değiştirecektir.                                                                                                            |