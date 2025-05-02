---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## Azioni

|             Mouse             |       Tocco      |        Azione       |
| :---------------------------: | :--------------: | :-----------------: |
| Clic sinistro e trascinamento | Tocca e trascina | Crea una nuova area |
|         Clic centrale         |     Due dita     |  Sposta superficie  |
|          Clic destro          |    Tocco lungo   |    Modifica area    |

## Configurazione

|           Proprietà | Predefinito | Descrizione                                                                                                                                                                                                                                                                                                                                                                                                            |
| ------------------: | :---------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|           Larghezza |     `0`     | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|             Altezza |     `0`     | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| Rapporto dimensioni |     `0`     | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Ci sono tre preimpostazioni del rapporto di aspetto:

- Quadrato (1:1)
- Ritratto pagina (sqrt(2)) - Questo è il rapporto di aspetto predefinito di una pagina A4 in modalità verticale.
- Paesaggio pagina (1/sqrt(2)) - Questo è il rapporto di aspetto predefinito di una pagina A4 in modalità orizzontale.
