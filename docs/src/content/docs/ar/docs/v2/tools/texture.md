---
title: نسيج
---

The texture tool allows you to add a background texture to a small area of the canvas.
Use it when only a part of the canvas should have a background pattern. To change the background of the whole page, use the [background settings](../../background) instead.

## Usage

1. Select the texture tool.
2. Choose the texture and its constraints in the tool configuration.
3. Drag on the canvas to create the textured area.

The created texture behaves like a surface element. You can move, resize, arrange, or delete it like other elements.

## الإعدادات

|         الممتلكات | الافتراضي | الوصف                                                                                                                                                                                          |
| ----------------: | :-------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| يتغير حسب التكبير |    خاطئ   | هذا سيغير عرض السكتة الدماغية بناءً على مستوى التكبير.                                                                                                                         |
|              نسيج |   النمط   | The pattern that should be added.                                                                                                                                              |
|             العرض |     0     | 2 - الارتفاع الثابت للمنطقة. If set to `0`, the width will be calculated automatically.                                                                        |
|          الارتفاع |     0     | 2 - الارتفاع الثابت للمنطقة. If set to `0`, the height will be calculated automatically.                                                                       |
|      نسبة الجوانب |     0     | نسبة الجانب الثابت في المنطقة. If set to `0`, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |

Valid types for texture are:

- [Pattern](../../background#pattern)
