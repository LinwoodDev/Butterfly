---
title: Ярлыки
sidebar_position: 2
---

## Клавиатура

Есть несколько ярлыков, которые вы можете использовать в редакторе.
Некоторые из них написаны под кнопками.

### Общие

- `Ctrl` + `N`: Новый файл
- `Ctrl` + `Shift` + `N`: Новый файл из шаблона
- `Ctrl` + `E`: Экспорт файла
- `Ctrl` + `P`: Печать файла
- `Ctrl` + `Shift` + `E`: Экспортировать файл как изображение
- `Ctrl` + `Alt` + `E`: Экспортировать файл как svg
- `Ctrl` + `Alt` + `Shift` + `E`: Экспортировать файл как svg
- `Ctrl` + `Alt` + `P`: Открытые пакеты
- `Ctrl` + `Alt` + `S`: Открыть настройки

### Проект

- `Ctrl` + `Z`: Отменить
- `Ctrl` + `Y`: Повторить
- `Ctrl` + `Shift` + `P`: Открыть диалог точек
- `Ctrl` + `B`: Открыть фоновое окно
- `Ctrl` + `Shift` + `A`: Открыть диалог областей
- `Ctrl` + `S`: Сохранить
- `Alt` + `S`: Изменить путь
- `Ctrl` + (`1` - `0`): Переключиться на инструмент
- `Ctrl` + `+`: Увеличить
- `Ctrl` + `-`: уменьшить масштаб

## Перо

By default, the the pen is configured to function as the following:

- `Pen`: configured as pen.
- `First` (Primary button, if supported): Change to hand tool while pressed.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.

## Настроить {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

- Empty - the tool is unchaged.
- 0 - the tool will function as moving (i.e., hand) in this mod.
- Positive number - The tool will follow the indexing as explain above.
