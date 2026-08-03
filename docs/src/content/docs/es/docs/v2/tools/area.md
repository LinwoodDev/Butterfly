---
title: Herramienta de área
---

La herramienta de área te permite crear, editar y remover áreas.

For an overview of how areas work, see [Areas](../../areas).

## Acciones

|           Ratón           |      Pulsar     |        Acción        |
| :-----------------------: | :-------------: | :------------------: |
| Clic izquierdo y arrastre | Toca y arrastra | Crear una nueva área |
|        Clic central       |    Dos dedos    |     Mover lienzo     |
|        Clic derecho       | Pulsación larga |      Editar área     |

## Configuración

|           Propiedad | Por defecto | Descripción                                                                                                                                                                                                                                                                                                                                                                                                                      |
| ------------------: | :---------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|    Solicitar nombre |    falso    | Whether a name prompt will appear before creation.                                                                                                                                                                                                                                                                                                                                                               |
|          Preajustes |     none    | Various presets for width and height.                                                                                                                                                                                                                                                                                                                                                                            |
|               Ancho |      0      | El ancho fijo de nuevas áreas. Si puesto en 0, esta configuración será ignorada.                                                                                                                                                                                                                                                                                                                 |
|              Altura |      0      | La altura fija para nuevas áreas. Si puesto en 0, esta configuración será ignorada.                                                                                                                                                                                                                                                                                                              |
| Relación de aspecto |      0      | La relación de aspecto fija para nuevas áreas. Select a preset from the segmented control or enter a custom value in the input field. Una relación de aspecto está definida cómo ancho / altura, así que valores menores que 1 serán más altos que anchos, y valores mayores que 1 serán más anchos que altos. Si puesto en 0, esta configuración será ignorada. |

Hay tres ajustes predeterminados de relación de aspecto:

- Cuadrado (1:1)
- Page portrait (1/sqrt(2)) - This is the default aspect ratio of an A4 page in portrait mode.
- Page landscape (sqrt(2)) - This is the default aspect ratio of an A4 page in landscape mode.
