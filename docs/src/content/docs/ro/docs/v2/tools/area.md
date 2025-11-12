---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## Acțiuni

|            Șoricel            |       Atingere      |       Acțiune       |
| :---------------------------: | :-----------------: | :-----------------: |
| Faceți clic stânga și trageți | Atingeți și trageți | Creează o nouă zonă |
|         Clic mijlociu         |     Două degete     |      Mută pânză     |
|          Clic dreapta         |    Atingere lungă   |     Editare zonă    |

## Configurare

|      Proprietate | Implicit | Descriere                                                                                                                                                                                                                                                                                                                                                                                                              |
| ---------------: | :------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|            Width |    `0`   | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|         Înălțime |    `0`   | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| Raport de aspect |    `0`   | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Există trei presetări ale raportului de aspect:

- Patrat (1:1)
- Portret pagină (sqrt(2)) - Acesta este raportul de aspect implicit al unei pagini A4 în modul portret.
- Peisaj pagină (1/sqrt(2)) - Acesta este raportul de aspect implicit al unei pagini A4 în modul peisaj.
