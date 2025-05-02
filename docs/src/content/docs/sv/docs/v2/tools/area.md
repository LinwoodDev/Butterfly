---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## Åtgärder

|          Mus          |     Tryck     |         Åtgärd        |
| :-------------------: | :-----------: | :-------------------: |
| Vänsterklicka och dra | Tryck och dra | Skapa ett nytt område |
|      Mitten klick     |  Två fingrar  |     Flytta canvas     |
|      Högerklicka      |   Långtryck   |    Redigera område    |

## Konfiguration

|        Egenskap | Standard | Beskrivning                                                                                                                                                                                                                                                                                                                                                                                                            |
| --------------: | :------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|           Width |    `0`   | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|            Höjd |    `0`   | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| Bildförhållande |    `0`   | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Det finns tre förinställningar för bildförhållande:

- Kvadrat (1:1)
- Sida porträtt (sqrt(2)) - Detta är standardformatet för en A4-sida i porträttläge.
- Sida landskap (1/sqrt(2)) - Detta är standard bildförhållande av en A4-sida i liggande läge.
