---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## Acciones

|           Ratón           |      Pulsar     |        Accin        |
| :-----------------------: | :-------------: | :-----------------: |
| Clic izquierdo y arrastre | Toca y arrastra | Crear un nuevo área |
|        Clic central       |    Dos dedos    |     Mover lienzo    |
|        Clic derecho       | Pulsación larga |     Editar área     |

## Configuración

|           Propiedad | Por defecto | Descripción                                                                                                                                                                                                                                                                                                                                                                                                            |
| ------------------: | :---------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|               Width |     `0`     | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|              Altura |     `0`     | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| Relación de aspecto |     `0`     | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Hay tres ajustes predeterminados de relación de aspecto:

- Cuadrado (1:1)
- Portrait de página (sqrt(2)) - Esta es la relación de aspecto predeterminada de una página A4 en modo vertical.
- Paisaje de página (1/sqrt(2)) - Esta es la relación de aspecto predeterminada de una página A4 en modo horizontal.
