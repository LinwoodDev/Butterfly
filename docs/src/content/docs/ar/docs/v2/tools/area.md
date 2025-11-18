---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## الإجراءات

|          الفأرة         |     المس     |       اجراء       |
| :---------------------: | :----------: | :---------------: |
| انقر بالزر الأيسر واسحب |  انقر واسحب  | إنشاء منطقة جديدة |
|       النقر الأوسط      |    إصبعين    |      نقل قماش     |
|    انقر بالزر الأيمن    | النقر الطويل |   تحرير المنطقة   |

## الإعدادات

|    الممتلكات | الافتراضي | الوصف                                                                                                                                                                                                                                                                                                                                                                                                                  |
| -----------: | :-------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|        العرض |    `0`    | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|     الارتفاع |    `0`    | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| نسبة الجوانب |    `0`    | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

هناك ثلاثة عناصر مسبقة لنسبة الوضع:

- مربع (1:1)
- صفحة عمودية (sqrt(2)) - هذه نسبة الجانب الافتراضية لصفحة A4 في الوضع العمودي.
- الصورة الأفقية للصفحة (1/sqrt(2)) - هذه هي نسبة الجانب الافتراضية لصفحة A4 في الوضع الأفقي.
