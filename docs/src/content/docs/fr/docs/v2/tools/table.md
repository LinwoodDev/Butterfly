---
title: Table tool
---

Use the Table tool to add a grid of cells to the canvas. Add it from **Add → Surfaces**, select it, then tap or click an empty spot to create a table. The default table has three rows and three columns. Its initial size follows the row and column count unless you set a fixed width or height in the tool properties.

## Configure the tool

Select the Table tool again to open its properties. You can set the number of rows and columns, width and height, border color, stroke width and style, fill color, and whether its appearance depends on zoom. These settings apply to tables you create with that tool.

## Edit an existing table

- Select a cell with the Table tool. Drag across cells to select a range.
- Open a cell's context menu to insert a row above or below it, insert a column before or after it, or delete its row or column. A table must retain at least one row and one column.
- Open **Properties** from the context menu to change the selected cell's fill, borders, row height, or column width. Changes to row height and column width affect the corresponding row or column.
- Select a border line to edit the full line. Select the same line again to target one border segment. Open **Properties** to change its color, width, or stroke style.
- Drag an internal border to resize adjacent rows or columns.

To change the whole table, select the table element and use its properties to change the row and column counts, border, and fill. Use the [Select tool](../select/) for moving or arranging the table with other canvas elements.

The Table tool creates a visual grid. It does not provide spreadsheet formulas or text editing inside cells; add [labels](../label/) separately if you need text over a table.

## Configuration

These settings apply to new tables. Select an existing table to edit that element's properties.

| Propriété         | Par défaut            | Libellé                                                                                                                             |
| ----------------- | --------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| Lignes            | 3                     | Initial number of rows.                                                                                             |
| Colonnes          | 3                     | Initial number of columns.                                                                                          |
| Largeur           | 0                     | Fixed table width; `0` uses the default width based on the columns.                                                 |
| Hauteur           | 0                     | Fixed table height; `0` uses the default height based on the rows.                                                  |
| Border            | Black, solid, width 1 | Color, width, and stroke style of table borders. Non-solid styles also expose dash and gap lengths. |
| Remplir           | Transparence          | Table background color and alpha.                                                                                   |
| Dépendant du zoom | Désactivé             | Changes table creation size based on the zoom level.                                                                |
