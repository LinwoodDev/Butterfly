---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Asetukset

|            Ominaisuus |    Oletus   | Kuvaus                                                                                                                                                                              |
| --------------------: | :---------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                  Väri |    Musta    | The stroke color that will be drawn                                                                                                                                                 |
|        Aivojen leveys |      5      | Aivohalvauksen leveys                                                                                                                                                               |
|          Stroke tyyli |    Solid    | The style of the stroke. Other styles can use dash and gap lengths.                                                                                 |
|           Dash pituus |      1      | The length of the dash when using a non-solid stroke style                                                                                                                          |
|         Vaaran pituus |      1      | The length of the gap when using a non-solid stroke style                                                                                                                           |
| Lähennys riippuvainen |   epätosi   | Tämä muuttaa aivohalvauksen leveyttä, joka perustuu zoomaustasoon.                                                                                                  |
|                 Muoto | Suorakulmio | Se muoto, joka piirretään                                                                                                                                                           |
|                 Width |      0      | Alueen kiinteä leveys. Jos arvo on 0, leveys lasketaan automaattisesti.                                                                             |
|               Korkeus |      0      | Alueen kiinteä korkeus. Jos arvo on 0, korkeus lasketaan automaattisesti.                                                                           |
|             Kuvasuhde |      0      | Alueen kiinteä kuvasuhde on sama. Jos arvo on 0, kuvasuhde lasketaan automaattisesti. An aspect ratio is defined as width / height. |
|            Keskitetty |   epätosi   | Draws the shape from the center instead of from the corner.                                                                                                         |

### Muototyypit

#### Suorakulmio

|    Ominaisuus |    Oletus    | Kuvaus                                     |
| ------------: | :----------: | :----------------------------------------- |
|         Täytä | Läpikuultava | Väri, joka piirretään suorakulmion sisälle |
| Corner radius |  0, 0, 0, 0  | The radius of the corners of the rectangle |

#### Kolmio

| Ominaisuus |    Oletus    | Kuvaus                                           |
| ---------: | :----------: | :----------------------------------------------- |
|      Täytä | Läpikuultava | The color that will be drawn inside the triangle |

#### Ympyrä

| Ominaisuus |    Oletus    | Kuvaus                                         |
| ---------: | :----------: | :--------------------------------------------- |
|      Täytä | Läpikuultava | The color that will be drawn inside the circle |

#### Viiva

_Ei konfiguraatiota saatavilla._
