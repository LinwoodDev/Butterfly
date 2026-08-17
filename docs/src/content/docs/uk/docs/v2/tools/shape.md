---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Конфігурація

|         Властивість |                    Типово                    | Опис                                                                                                                                                                                                                  |
| ------------------: | :------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|               Центр |                   хибність                   | Draws the shape from the center instead of from the corner.                                                                                                                                           |
|               Width |                       0                      | Фіксована ширина площі. Якщо встановлено значення 0, ширина буде розрахована автоматично.                                                                                             |
|              Висота |                       0                      | Фіксована висота зони. Якщо встановити значення 0, висота буде розрахована автоматично.                                                                                               |
|   Відношення сторін |                       0                      | Постійне співвідношення сторін області. Якщо встановити значення 0, співвідношення сторін буде розраховано автоматично. An aspect ratio is defined as width / height. |
|       Ширина штриха |                       5                      | Ширина риски                                                                                                                                                                                                          |
|     Стиль обведення |                     Solid                    | The style of the stroke. Other styles can use dash and gap lengths.                                                                                                                   |
|        Довжина тире |                       1                      | The length of the dash when using a non-solid stroke style                                                                                                                                                            |
|   Довжина прогалини |                       1                      | The length of the gap when using a non-solid stroke style                                                                                                                                                             |
|               Колір |    Solid Color (Black)    | [Customization](../../colors/#further-customization) for the color of the shape                                                                                                                                       |
|               Форма |                  Прямокутник                 | The shape that will be drawn. Available shapes are Rectangle, Triangle, Circle and Line                                                                                                               |
|       Corner radius |                  0, 0, 0, 0                  | The radius of the corners when shape is Rectangle                                                                                                                                                                     |
|       Заливка рядка | Solid Color (Transparent) | [Customization](../../colors/#further-customization) for the color drawn inside the shape. Not available for Line shapes                                                                              |
| Залежність масштабу |                   хибність                   | Це змінить ширину штриха в залежності від рівня збільшення.                                                                                                                                           |