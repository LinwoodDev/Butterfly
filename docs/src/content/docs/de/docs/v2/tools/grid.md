---
title: Rasterwerkzeug
---

:::note[🔘 Toggleable Werkzeug]

Dies ist ein spezielles Werkzeug.
It can't be selected and will run the action immediately when you click on it.

:::

Mit diesem Werkzeug können Sie ein Raster über der Leinwand anzeigen.
Eingaben werden am Raster ausgerichtet.

## Konfiguration

|            Objekt |           Standard          | Beschreibung                                                                                           |
| ----------------: | :-------------------------: | :----------------------------------------------------------------------------------------------------- |
|             Größe | (20, 20) | The size of the grid cells on the x and y axis.                                        |
|           Versatz |  (0, 0)  | The offset of the grid on the x and y axis.                                            |
|             Farbe |           Schwarz           | The color of the grid.                                                                 |
|             Alpha |             255             | The opacity of the grid lines.                                                         |
|            Stroke |              1              | The width of the grid lines.                                                           |
|      Zoomabhängig |            falsch           | Changes the grid cell spacing and snapping behavior relative to the zoom level.        |
| Positionsabhängig |            falsch           | Makes the grid depend on the canvas position instead of staying fixed on the viewport. |
