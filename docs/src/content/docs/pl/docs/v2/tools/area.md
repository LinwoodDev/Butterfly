---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../../areas).

## Akcje

|                      Mysz                     |        Dotknij        |        Akcja       |
| :-------------------------------------------: | :-------------------: | :----------------: |
| Kliknij lewym przyciskiem myszy i przeciągnij | Dotknij i przeciągnij | Utwórz nowy obszar |
|                Kliknij środkowo               |       Dwa palce       |   Przesuń płótno   |
|              Prawy przycisk myszy             |   Długie dotknięcie   |    Edytuj obszar   |

## Konfiguracja

|               Własność | Domyślny | Opis                                                                                                                                                                                                                                                                                                                                                                                                             |
| ---------------------: | :------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|        Zapytaj o nazwę | fałszywy | Whether a name prompt will appear before creation.                                                                                                                                                                                                                                                                                                                                               |
|             Ustawienia |   none   | Various presets for width and height.                                                                                                                                                                                                                                                                                                                                                            |
|                  Width |    `0`   | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                      |
|               Wysokość |    `0`   | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                     |
| Współczynnik proporcji |    `0`   | The fixed aspect ratio for new areas. Select a preset from the segmented control or enter a custom value in the input field. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Istnieją trzy presety proporcji proporcji:

- Kwadrat (1:1)
- Page portrait (1/sqrt(2)) - This is the default aspect ratio of an A4 page in portrait mode.
- Page landscape (sqrt(2)) - This is the default aspect ratio of an A4 page in landscape mode.
