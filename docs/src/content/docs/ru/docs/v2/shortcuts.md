---
title: Ярлыки
---

## Клавиатура

Есть несколько ярлыков, которые вы можете использовать в редакторе.
Некоторые из них написаны под кнопками.

### Общие

- `Ctrl` + `N`: Новый файл
- `Ctrl` + `Shift` + `N`: Новый файл из шаблона
- `Ctrl` + `E`: Экспорт файла
- `Ctrl` + `Alt` + `E`: Экспортировать файл как svg
- `Ctrl` + `Shift` + `E`: Экспортировать файл как изображение
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as pdf
- `Ctrl` + `Alt` + `Shift` + `E` (Nightly (2.4): `Ctrl` + `Shift` + `P`): Export file as pdf
- `Ctrl` + `Alt` + `S`: Открыть настройки
- `Ctrl` + `Alt` + `P`: Открытые пакеты

### Проект

- `Ctrl` + `K`: Open search
- `Ctrl` + `Z`: Отменить
- `Ctrl` + `Y`: Повторить
- `Ctrl` + `Shift` + `P`: Открыть диалог точек
- `Ctrl` + `B`: Открыть фоновое окно
- `Ctrl` + `S`: Сохранить
- `Alt` + `S`: Изменить путь
- `Ctrl` + (`1` - `0`): Переключиться на инструмент
- `Ctrl` + `+`: Увеличить
- `Ctrl` + `-`: уменьшить масштаб

## Перо

По умолчанию, ручка настроена на работу следующим образом:

- `Pen`: сконфигурирован как pen.
- `First` (основная кнопка, если поддерживается): Измените на инструмент вручную.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below) while pressed.

## Configuring {#configure}

You can customize your controls by changing which tools your inputs map to.

**Note:** Input configurations will be ignored while certain tools are selected, such as the Lasso Select tool, the Rectangle Select tool, the Label tool, and the Area tool.

To begin, go to `Settings` → `Inputs` and then select the input method you want to configure, such as `Mouse`, `Touch`, or `Pen`. You will be presented with a list of configurable inputs and the tools they are currently mapped to.

After selecting an input, you will have 3 options:

- `Active Tool`: The input will act as the currently selected tool on the toolbar.
- `Hand Tool`: The input will temporarily switch to the hand tool, allowing you to move around the canvas.
- `Specific Tool on Toolbar`: The input will temporarily switch to a tool on your toolbar, based on the position number you specify. Positions are counted starting from the left, so if you specify position `1`, the first tool on the left will be selected. See the screenshot below for an example of how position numbers are counted. For information about how to reorder your tools, see [Customizing the Toolbar](../intro/#customizing-the-toolbar).

![номер панели инструментов](toolbar_numbered.png)