---
title: Гарячі клавіші
sidebar_position: 2
---

## Keyboard

Є кілька ярликів, які можна використати в редакторі.
Деякі з них пишуть під кнопками.

### Загальні налаштування

- `Ctrl` + `N`: новий файл
- `Ctrl` + `Shift` + `N`: новий файл з шаблону
- `Ctrl` + `E`: Експорт файлу
- `Ctrl` + `P`: Друкувати файл
- `Ctrl` + `Shift` + `E`: експортувати файл як зображення
- `Ctrl` + `Alt` + `E`: Експортувати файл як svg
- `Ctrl` + `Alt` + `Shift` + `E`: Експортувати файл як svg
- `Ctrl` + `Alt` + `P`: Відкриті пакети
- `Ctrl` + `Alt` + `S`: Відкрити налаштування

### Проект

- `Ctrl` + `Z`: Відмінити
- `Ctrl` + `Y`: Повторити
- `Ctrl` + `Shift` + `P`: Відкривати вікно точок
- `Ctrl` + `B`: Відкрити фонове вікно
- `Ctrl` + `Shift` + `A`: Відкритий діалог
- `Ctrl` + `S`: Зберегти
- `Alt` + `S`: Змінити шлях
- `Ctrl` + (`1` - `0`): Перемкнутися на інструмент
- `Ctrl` + `+`: Збільшувати масштаб
- `Ctrl` + `-`: Збільшити

## Ручка

By default, the the pen is configured to function as the following:

- `Pen`: configured as pen.
- `First` (Primary button, if supported): Change to hand tool while pressed.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.

## Configure {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

- Empty - the tool is unchaged.
- 0 - the tool will function as moving (i.e., hand) in this mod.
- Positive number - The tool will follow the indexing as explain above.
