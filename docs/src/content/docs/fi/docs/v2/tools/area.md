---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## Toiminnot

|          Hiiri          |     Kosketa     |     Toiminto    |
| :---------------------: | :-------------: | :-------------: |
| Vasen napsautus ja vedä | Napauta ja vedä |  Luo uusi alue  |
|    Keskeinen klikkaus   |   Kaksi sormea  |  Siirrä kangas  |
| Oikealla napsautuksella |  Pitkä napautus | Muokkaa aluetta |

## Asetukset

| Ominaisuus | Oletus | Kuvaus                                                                                                                                                                                                                                                                                                                                                                                                                 |
| ---------: | :----: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|      Width |   `0`  | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|    Korkeus |   `0`  | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
|  Kuvasuhde |   `0`  | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

On olemassa kolme kuvasuhteen esiasetuksia:

- Neliö (1:1)
- Sivun muotokuva (sqrt(2)) - Tämä on A4-sivun oletuskuvasuhde pystytilassa.
- Sivun vaakakuva (1/sqrt(2)) - Tämä on A4-sivun oletuskuvasuhde vaakatilassa.
