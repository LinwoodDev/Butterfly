---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../../areas).

## Handlinger

|         Mus         |     Berør    |        Handling        |
| :-----------------: | :----------: | :--------------------: |
| Venstreklikk og dra | Trykk og dra | Opprett et nytt område |
|    Klikk i midten   |   To fingre  |     Flytt lerretet     |
|      Høyreklikk     |  Langt trykk |     Rediger område     |

## Konfigurasjon

|                Egenskap | Standard | Beskrivelse                                                                                                                                                                                                                                                                                                                                                                                                      |
| ----------------------: | :------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|            Spør om navn |   usann  | Whether a name prompt will appear before creation.                                                                                                                                                                                                                                                                                                                                               |
|   Forhåndsinnstillinger |   none   | Various presets for width and height.                                                                                                                                                                                                                                                                                                                                                            |
|                   Width |    `0`   | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                      |
|                   Høyde |    `0`   | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                     |
| Høyde- og breddeforhold |    `0`   | The fixed aspect ratio for new areas. Select a preset from the segmented control or enter a custom value in the input field. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Det er forhåndsinnstillinger for tre størrelseforhold:

- Kvadrat (1:1)
- Page portrait (1/sqrt(2)) - This is the default aspect ratio of an A4 page in portrait mode.
- Page landscape (sqrt(2)) - This is the default aspect ratio of an A4 page in landscape mode.
