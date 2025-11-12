---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## Действия

|                   Мышь                   |     Прикосновение    |        Действие       |
| :--------------------------------------: | :------------------: | :-------------------: |
| Щелкните левой кнопкой мыши и перетащите | Нажмите и перетащите | Создать новую область |
|               Средний клик               |      Два пальца      |   Переместить холст   |
|                Правый клик               |    Долгое нажатие    | Редактировать область |

## Конфигурация

|           Свойства | По умолчанию | Описание                                                                                                                                                                                                                                                                                                                                                                                                               |
| -----------------: | :----------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|             Ширина |      `0`     | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|             Высота |      `0`     | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| Соотношение сторон |      `0`     | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Предустановки о соотношении трех частей:

- Квадрат (1:1)
- Портрет страницы (sqrt(2)) - Соотношение сторон страницы A4 по умолчанию в портретном режиме.
- Горизонтальный (1/sqrt(2)) - По умолчанию это соотношение сторон страницы A4 в ландшафтном режиме.
