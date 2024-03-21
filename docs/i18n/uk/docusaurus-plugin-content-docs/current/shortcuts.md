---
title: "Гарячі клавіші"
sidebar_position: 2
---


## Keyboard

Є кілька ярликів, які можна використати в редакторі. Деякі з них пишуть під кнопками.

### Загальні налаштування

* `Ctrl` + `N`: новий файл
* `Ctrl` + `Shift` + `N`: новий файл з шаблону
* `Ctrl` + `E`: Експорт файлу
* `Ctrl` + `P`: Друк файлу
* `Ctrl` + `Shift` + `E`: Експорт файлу як зображення
* `Ctrl` + `Alt` + `E`: Експорт файлу як svg
* `Ctrl` + `Alt` + `Shift` + `E`: Export file as svg
* `Ctrl` + `Alt` + `P`: Відкриті пакети
* `Ctrl` + `Alt` + `S`: Відкрити налаштування

### Проект

* `Ctrl` + `Z`: Скасувати
* `Ctrl` + `Y`: Redo
* `Ctrl` + `Shift` + `P`: Open waypoints dialog
* `Ctrl` + `B`: Відкритий фоновий діалог
* `Ctrl` + `S`: зберегти
* `Alt` + `S`: Змінити шлях
* `Ctrl` + (`1` - `0`): Switch to tool
* `Ctrl` + `+`: Масштаб
* `Ctrl` + `-`: Zoom out

## Ручка

За замовчуванням, ручка налаштована для функції в такому випадку:
* `Pen`: налаштована як ручка.
* `First` (Primary button, if supported): Change to hand tool while pressed.
* `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.



## Настроїти {#configure}

Ви можете налаштувати елементи керування надаючи кожному інструмент індексу. The tool indexing starts from the left of the toolbar, with `1` being the first index. Дивитися приклад нижче

![пронумерація панелі інструментів](toolbar_numbered.png)

При цьому 1 відноситься до інструменту лазу, 2 до інструменту сковорідки тощо.

Параметри налаштування наведені таким чином:

* Порожній - інструмент без черги.
* 0 - інструмент функціонує як рух (тобто рука) в цьому моді.
* Додатнє число - Інструмент буде слідувати індексації, як пояснює вище. 


