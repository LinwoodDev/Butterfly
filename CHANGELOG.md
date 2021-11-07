# Changelog

## 1.0.0-rc.2 (November 7th, 2021)

* Change home page to drawing page ([#17](https://github.com/LinwoodCloud/butterfly/issues/17))
* Fixing zoom issues ([#20](https://github.com/LinwoodCloud/butterfly/issues/20))
* Simplify selection ([#23](https://github.com/LinwoodCloud/butterfly/issues/23))
  * Add more space to select
  * Add calculation to look if the cursor is between two points
  * Add calculation to get the real width and height of the text
  * Add select dialog if there are more than one element on the position
  * Add box that highlights the selection
* Change old home page to open dialog
* Rename old open dialog to import dialog
* Rename old save dialog to export dialog
* Add popup menu in the top right corner of the main view

## 1.0.0-rc.1 (October 30th, 2021)

* Add new graphic engine to allow moving in the negative direction
* Big performance issues were fixed
* New loading screen on web
* Add separate color palette class (new color palette file format)
* Fixing empty names in document name ([#14](https://github.com/LinwoodCloud/butterfly/issues/14))
* Fixing open/save dialog

## 1.0.0-rc.0 (October 20th, 2021)

* Add new design system
* Add image painter and layer
  * Add scale property
* Add open/save dialog
* Add letter spacing to text painter and element
* Add internal property class to simplify equal variables on painter and layer
* Normalize json keys
* Fix lag when zooming out of the viewport
* Split custom painter from view internally

## 1.0.0-beta.0 (October 15th, 2021)

* Add new color picker
  * Multiple palettes
  * Open/save palettes
  * Custom colors
  * Edit palettes
* Add new label properties (font weight, italic, decoration)
* Fix shared preferences bug that prevents starting the app on android

## 1.0.0-alpha.0 (October 10th, 2021)

First release 🎉
