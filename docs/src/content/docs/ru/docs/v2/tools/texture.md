---
title: Текстура
---

The texture tool allows you to add a background texture to a small area of the canvas.
Use it when only a part of the canvas should have a background pattern. To change the background of the whole page, use the [background settings](../../background) instead.

## Usage

1. Select the texture tool.
2. Choose the texture and its constraints in the tool configuration.
3. Drag on the canvas to create the textured area.

The created texture behaves like a surface element. You can move, resize, arrange, or delete it like other elements.

## Конфигурация

|                Свойства | По умолчанию | Описание                                                                                                                                                                                                  |
| ----------------------: | :----------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Зависимость от масштаба |     ложь     | Это изменит ширину штриха в зависимости от масштаба масштаба.                                                                                                                             |
|                Текстура |    Шаблон    | The pattern that should be added.                                                                                                                                                         |
|                  Ширина |       0      | Фиксированная ширина области. If set to `0`, the width will be calculated automatically.                                                                                  |
|                  Высота |       0      | Фиксированная высота участка. If set to `0`, the height will be calculated automatically.                                                                                 |
|      Соотношение сторон |       0      | Фиксированное соотношение сторон участка. If set to `0`, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |

Valid types for texture are:

- [Pattern](../../background#pattern)
