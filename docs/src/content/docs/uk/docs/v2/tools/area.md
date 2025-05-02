---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## Дії

|             Миша             |           Дотик           |          Дія          |
| :--------------------------: | :-----------------------: | :-------------------: |
|  Лівий притиск і перетягніть | Торкніться та перетягніть | Створити нову область |
|         Середній клік        |         Два пальці        |  Перемістити полотно  |
| Клацніть правою кнопкою миші |        Довгий дотик       |   Редагувати область  |

## Конфігурація

|       Властивість | Типово | Опис                                                                                                                                                                                                                                                                                                                                                                                                                   |
| ----------------: | :----: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|             Width |   `0`  | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|            Висота |   `0`  | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| Відношення сторін |   `0`  | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Є три пресети співвідношення сторів:

- Квадрат (1:1)
- Портрет сторінки (/qrt(2)- Це типове співвідношення сторін A4 сторінки в портретному режимі.
- Пейзаж сторінок (1/sqrt(2)) - Це типове співвідношення сторін A4 сторінки в ландшафтному режимі.
