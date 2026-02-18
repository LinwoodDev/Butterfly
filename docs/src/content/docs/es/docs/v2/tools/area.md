---
title: Herramienta de área
---

La herramienta de área te permite crear, editar y remover áreas.

Para una descripción general de cómo funcionan las áreas, véase [Áreas](../areas).

## Acciones

|           Ratón           |      Pulsar     |        Acción        |
| :-----------------------: | :-------------: | :------------------: |
| Clic izquierdo y arrastre | Toca y arrastra | Crear una nueva área |
|        Clic central       |    Dos dedos    |     Mover lienzo     |
|        Clic derecho       | Pulsación larga |      Editar área     |

## Configuración

|           Propiedad | Por defecto | Descripción                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| ------------------: | :---------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|               Ancho |      0      | El ancho fijo de nuevas áreas. Si puesto en 0, esta configuración será ignorada.                                                                                                                                                                                                                                                                                                                                                    |
|              Altura |      0      | La altura fija para nuevas áreas. Si puesto en 0, esta configuración será ignorada.                                                                                                                                                                                                                                                                                                                                                 |
| Relación de aspecto |      0      | La relación de aspecto fija para nuevas áreas. Presiona el botón de <DotsThreeVertical className="inline-icon"/> para acceder a algunos ajustes predeterminados comunes. Una relación de aspecto está definida cómo ancho / altura, así que valores menores que 1 serán más altos que anchos, y valores mayores que 1 serán más anchos que altos. Si puesto en 0, esta configuración será ignorada. |

Hay tres ajustes predeterminados de relación de aspecto:

- Cuadrado (1:1)
- Retrato de página (sqrt(2)) - Esta es la relación de aspecto predeterminada de una página A4 en modo vertical.
- Paisaje de página (1/sqrt(2)) - Esta es la relación de aspecto predeterminada de una página A4 en modo horizontal.
