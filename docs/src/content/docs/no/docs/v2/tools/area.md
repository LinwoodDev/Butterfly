---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## Handlinger

|         Mus         |     Berør    |        Handling        |
| :-----------------: | :----------: | :--------------------: |
| Venstreklikk og dra | Trykk og dra | Opprett et nytt område |
|    Klikk i midten   |   To fingre  |     Flytt lerretet     |
|      Høyreklikk     |  Langt trykk |     Rediger område     |

## Konfigurasjon

|                Egenskap | Standard | Beskrivelse                                                                                                                                                                                                                                                                                                                                                                                                            |
| ----------------------: | :------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                   Width |    `0`   | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|                   Høyde |    `0`   | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| Høyde- og breddeforhold |    `0`   | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Det er forhåndsinnstillinger for tre størrelseforhold:

- Kvadrat (1:1)
- Sideportrett (sqrt(2)) - Dette er standardsidesideforhold for en A4-side i portrett modus.
- Sidelandskap (1/sqrt(2)) - Dette er standardstørrelsesforholdet til en A4-side i landskapsmodus.
