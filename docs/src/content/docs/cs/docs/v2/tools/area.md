---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../../areas).

## Akce

|                     Myš                     |      Dotkněte se      |          Akce         |
| :-----------------------------------------: | :-------------------: | :-------------------: |
| Kliknutím levým tlačítkem myši a přetažením | Klepněte a přetáhněte | Vytvořit novou oblast |
|              Kliknutí na střed              |       Dva prsty       |    Přesunout plátno   |
|          Kliknutí pravým tlačítkem          |   Dlouhým poklepáním  |     Upravit oblast    |

## Konfigurace

|         Majetek |  Výchozí | L 343, 22.12.2009, s. 1).                                                                                                                                                                                                                                                                                                                        |
| --------------: | :------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Požádat o název | nepravda | Whether a name prompt will appear before creation.                                                                                                                                                                                                                                                                                                                                               |
|       Předvolby |   none   | Various presets for width and height.                                                                                                                                                                                                                                                                                                                                                            |
|           Šířka |    `0`   | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                      |
|           Výška |    `0`   | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                     |
|     Poměr stran |    `0`   | The fixed aspect ratio for new areas. Select a preset from the segmented control or enter a custom value in the input field. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Jsou zde tři předvolby poměru:

- Čtverce (1:1)
- Page portrait (1/sqrt(2)) - This is the default aspect ratio of an A4 page in portrait mode.
- Page landscape (sqrt(2)) - This is the default aspect ratio of an A4 page in landscape mode.
