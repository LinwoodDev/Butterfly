---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Configuración

|           Propiedad |                  Por defecto                 | Descripción                                                                                                                                                                                      |
| ------------------: | :------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|             Centrar |                     falso                    | Draws the shape from the center instead of from the corner.                                                                                                                      |
|               Width |                       0                      | Relación de aspecto Si se establece en 0, el ancho se calculará automáticamente.                                                                                                 |
|              Altura |                       0                      | La altura fija del área. Si se establece en 0, la altura se calculará automáticamente.                                                                           |
| Relación de aspecto |                       0                      | El ancho fijo del área. Si se establece en 0, la relación de aspecto se calculará automáticamente. An aspect ratio is defined as width / height. |
|     Ancho del trazo |                       5                      | El ancho del trazo                                                                                                                                                                               |
|     Estilo de trazo |                     Solid                    | The style of the stroke. Other styles can use dash and gap lengths.                                                                                              |
|  Longitud del guión |                       1                      | The length of the dash when using a non-solid stroke style                                                                                                                                       |
|  Longitud del hueco |                       1                      | The length of the gap when using a non-solid stroke style                                                                                                                                        |
|               Color |    Solid Color (Black)    | [Customization](../../colors/#further-customization) for the color of the shape                                                                                                                  |
|               Forma |                  rectángulo                  | The shape that will be drawn. Available shapes are Rectangle, Triangle, Circle and Line                                                                                          |
|    Radio de esquina |                  0, 0, 0, 0                  | The radius of the corners when shape is Rectangle                                                                                                                                                |
|            Rellenar | Solid Color (Transparent) | [Customization](../../colors/#further-customization) for the color drawn inside the shape. Not available for Line shapes                                                         |
| Dependiente de zoom |                     falso                    | Esto cambiará el ancho del trazo basado en el nivel de acercamiento.                                                                                                             |