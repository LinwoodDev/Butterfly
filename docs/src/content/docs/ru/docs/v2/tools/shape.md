---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Конфигурация

|                Свойства |                 По умолчанию                 | Описание                                                                                                                                                                                                                    |
| ----------------------: | :------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|               По центру |                     ложь                     | Draws the shape from the center instead of from the corner.                                                                                                                                                 |
|                  Ширина |                       0                      | Соотношение сторон Если установлено значение 0, то ширина будет рассчитываться автоматически.                                                                                                               |
|                  Высота |                       0                      | Фиксированная высота участка. Если установлено значение 0, высота будет рассчитываться автоматически.                                                                                       |
|      Соотношение сторон |                       0                      | Фиксированное соотношение сторон участка. Если установлено значение 0, соотношение сторон будет рассчитываться автоматически. An aspect ratio is defined as width / height. |
|           Ширина штриха |                       5                      | Толщина линии                                                                                                                                                                                                               |
|           Стиль обводки |                   Сплошной                   | The style of the stroke. Other styles can use dash and gap lengths.                                                                                                                         |
|              Длина тире |                       1                      | The length of the dash when using a non-solid stroke style                                                                                                                                                                  |
|           Длина разрыва |                       1                      | The length of the gap when using a non-solid stroke style                                                                                                                                                                   |
|                    Цвет |    Solid Color (Black)    | [Customization](../../colors/#further-customization) for the color of the shape                                                                                                                                             |
|                  Фигура |                 Прямоугольник                | The shape that will be drawn. Available shapes are Rectangle, Triangle, Circle and Line                                                                                                                     |
|       Радиус скругления |                  0, 0, 0, 0                  | The radius of the corners when shape is Rectangle                                                                                                                                                                           |
|               Заполнить | Solid Color (Transparent) | [Customization](../../colors/#further-customization) for the color drawn inside the shape. Not available for Line shapes                                                                                    |
| Зависимость от масштаба |                     ложь                     | Это изменит ширину штриха в зависимости от масштаба масштаба.                                                                                                                                               |