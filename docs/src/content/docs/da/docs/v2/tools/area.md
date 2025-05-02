---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## Handlinger

|         Mus         |   Berøring   |       Handling      |
| :-----------------: | :----------: | :-----------------: |
| Venstreklik og træk | Tryk og træk | Opret et nyt område |
|    Midterste klik   |   To fingre  |     Flyt lærred     |
|      Højreklik      |  Langt tryk  |    Rediger område   |

## Konfiguration

|       Egenskab | Standard | Varebeskrivelse                                                                                                                                                                                                                                                                                                                                                                                                        |
| -------------: | :------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          Width |    `0`   | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|          Højde |    `0`   | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| Aspekt forhold |    `0`   | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Der er tre aspektforhold forudindstillinger:

- Kvadrat (1:1)
- Side portræt (sqrt(2)) - Dette er standardformatforholdet for en A4 side i portrættilstand.
- Side liggende (1/sqrt(2)) - Dette er standardformatforholdet for en A4 side i liggende tilstand.
