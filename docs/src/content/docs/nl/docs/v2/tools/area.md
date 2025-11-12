---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## acties

|                 Muis                |    Aanraking   |         actie         |
| :---------------------------------: | :------------: | :-------------------: |
| Klik met de linkermuisknop en sleep |  Tik en sleep  | Maak een nieuw gebied |
|            Middelste klik           |  Twee vingers  |   Canvas verplaatsen  |
|       Klik met rechtermuisknop      | Lang indrukken |    Gebied bewerken    |

## Configuratie

|        Eigenschap | Standaard | Beschrijving                                                                                                                                                                                                                                                                                                                                                                                                           |
| ----------------: | :-------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|             Width |    `0`    | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|             Højde |    `0`    | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| Aspect verhouding |    `0`    | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Er zijn drie beeldverhouding voorinstellingen:

- Vierkant (1:1)
- Pagina portret (qrt(2)) - Dit is de standaard hoogte-breedteverhouding van een A4 pagina in portret modus.
- Pagina liggend (1/sqrt(2)) - Dit is de standaard hoogte-breedteverhouding van een A4 pagina in liggende modus.
