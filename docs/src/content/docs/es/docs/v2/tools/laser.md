---
title: Herramienta láser
---

Con esta herramienta se puede dibujar temporalmente sobre este papel. Después de un tiempo, el dibujo se desvanece.
Add a new drawing to the paper to cancel the previous laser stroke.

## Configuración

|        Propiedad |     Por defecto     | Descripción                                                                                                           |
| ---------------: | :-----------------: | :-------------------------------------------------------------------------------------------------------------------- |
|            Color |         Rojo        | The color that will be drawn.                                                                         |
|  Ancho del trazo |          5          | The width of the stroke.                                                                              |
|      Lanzamiento | 0.4 | The effect of pressure on the stroke size. Set it to `0` for a constant stroke width. |
|         Duración |          5          | The duration in seconds that the drawing will stay visible.                                           |
| Ocultar duración | 0.5 | How long the laser stroke takes to disappear.                                                         |
|        Animación |         Fade        | The animation used when the laser stroke disappears.                                                  |

## Animation modes

| Mode | Descripción                                                         |
| ---: | :------------------------------------------------------------------ |
| Fade | The stroke fades out after the duration has passed. |
| Ruta | The stroke disappears along the drawn path.         |
