---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../../areas).

## Azioni

|             Mouse             |       Tocco      |        Azione       |
| :---------------------------: | :--------------: | :-----------------: |
| Clic sinistro e trascinamento | Tocca e trascina | Crea una nuova area |
|         Clic centrale         |     Due dita     |  Sposta superficie  |
|          Clic destro          |    Tocco lungo   |    Modifica area    |

## Configurazione

|           Proprietà | Predefinito | Descrizione                                                                                                                                                                                                                                                                                                                                                                                                      |
| ------------------: | :---------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|         Chiedi nome |    falso    | Whether a name prompt will appear before creation.                                                                                                                                                                                                                                                                                                                                               |
|         Predefiniti |     none    | Various presets for width and height.                                                                                                                                                                                                                                                                                                                                                            |
|           Larghezza |     `0`     | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                      |
|             Altezza |     `0`     | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                     |
| Rapporto dimensioni |     `0`     | The fixed aspect ratio for new areas. Select a preset from the segmented control or enter a custom value in the input field. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Ci sono tre preimpostazioni del rapporto di aspetto:

- Quadrato (1:1)
- Page portrait (1/sqrt(2)) - This is the default aspect ratio of an A4 page in portrait mode.
- Page landscape (sqrt(2)) - This is the default aspect ratio of an A4 page in landscape mode.
