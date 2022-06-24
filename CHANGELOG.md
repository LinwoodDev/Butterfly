# Changelog

<!--ENTER CHANGELOG HERE-->

## 1.4.0-alpha.2 (2022-06-24)

* Add remote storage ([#88](https://github.com/LinwoodCloud/Butterfly/issues/88))
    * Add remote settings
    * Add storage option to template and open dialog
    * Specify remote in title
* Exporting on web now downloads the file
* Remove cdns on the web
* Redesign settings with cards
* Fix settings rounded corners

## 1.4.0-alpha.0 (2022-06-20)

* Fix invalid namespace on android

## 1.4.0-alpha.0 (2022-06-17)

* Add laser painter to paint strokes temporarily
* Add duplicate to change document path
* Add color view to label, pen and laser painter
* Add spanish translation
* Add quality slider to pdf ([#184](https://github.com/LinwoodCloud/Butterfly/issues/184))
* Add copy to change document path ([#180](https://github.com/LinwoodCloud/Butterfly/issues/180))

## 1.3.2 (2022-06-10)

* Add quality slider to pdf
* Add material palette to default templates
* Fixing area issues
    * Fix bug when area has negative values
    * Fix bug when area is not visible when changing the painter
    * Fix app bar title does not change after exiting the area
* Improve spacing of selection rect based on the zoom
* Move android storage to external
* Center image on moving ([#185](https://github.com/LinwoodCloud/Butterfly/issues/185))
* Fix image low quality
* Fix missing constraints button in image element dialog
* Fix window_manager errors on mobile devices
* Remove image painter for file-version < 5

## 1.3.1 (2022-06-03)

* Reimplement color field
* Fix bake issues when moving the camera with a gesture
* Fix move gesture relative to viewport
* Fix fill mode
* Fix hard edges in settings dialog
* Fix firefox bug when creating a new path
* Fix undo/redo buttons
* Fix invalid elements after changing the layer
* Fix background dialog slider
* Fix svg export
    * Only export elements that are in this bounds
    * Fix option to disable background
    * Fix offset of eraser mask
* Fix loading of templates in old version
* Add reset button in templates
* Ignore invalid templates

## 1.3.0 (2022-05-26)

* Fix bug where document will be cleared after removing a layer or rename a layer

Read the whole 1.3 changelog at https://go.linwood.dev/butterfly/1-3

<details>
 <summary>1.3 Nightly Changelog</summary>

### 1.3.0-rc.2 (2022-05-22)

* Fix layout on bigger screens
* Fix image export
* Improve position of submenus

### 1.3.0-rc.1 (2022-05-18)

* Fix undo on scrolling
* Replace text buttons to icon buttons in dialog actions
* Fix appbar title
* Change scroll focus point relative to the zoom
* Fix zoom multiplier when using multiple fingers
* Add alwaysontop, move fullscreen to right top corner on desktop
* Add tooltips on window buttons
* Disable window buttons in full screen
* Fix file system on web (Creating directory if not exist)#
* Fix file system directory error
* Fix baking issues

### 1.3.0-rc.0 (2022-05-13)

* Implement drag resize area and popup window menu on desktop platforms
* Fix pixel ratio
* Fixing safe area bug in settings
* Fix embedding
* Upgrade to flutter 3
* Show error message if an error occurred while inserting

### 1.3.0-beta.2 (2022-05-06)

* Implement embed functionality
* Fixing a lot of bugs ([#158](https://github.com/LinwoodCloud/Butterfly/issues/158), Thanks to vi)
    * Add move/duplicate indicator
    * Add layer suggestions
    * Add multi element selection context menu
    * Remove delete confirmation when trying to delete an element or a painter
    * Fixing pixelated view when paint on it
    * Fix error when trying to delete the painter
    * Fix undo does not work on path eraser
    * Fix Drawing with multiple fingers leave multiple trails
    * Fix error while trying to delete an element
    * Fix error after deleting a painter
* Remove settings window buttons
* Change size of start dialog
* Add padding to pdf import dialog
* Add responsive slider
* Highlight primary button in dialogs
* Remove autosave on web

### 1.3.0-beta.1 (2022-04-29)

* Add custom designs
* Add material 3 components
* Add start, update and app introduction dialog
* Add settings to disable start dialog
* Implement pdf import
* Reimplement undo/redo
* Round scale
* Redesigned settings dialog

### 1.3.0-beta.0 (2022-04-20)

* Add svg export
* Add constraints to label and image
* Add horizontal and vertical alignment to label
* Reimplement eraser
* Fixing stroke width

### 1.3.0-alpha.1 (2022-04-12)

* Change scroll behavior to move
    * Add shift to inverse
* Move zoom options and undo/redo in popup menu
* Move overflow menu to the left and replace icon to logo
* Add scrollbar to tools
* Enable share of data for all platforms
* Restructure the code to separate the logic from the UI
* Add an introduction screen for the first start and for a new version
* Fix open file issues when opening by clicking on the file
* Fix full screen
* Temporarily disable undo/redo
* Fix duplicated keybind of insert and export

### 1.3.0-alpha.0 (2022-03-05)

* Add areas
    * Export areas
* Add area painter to declare areas
* Add full screen
* Update flutter version

</details>

## 1.2.1 (2022-03-05)

* Fix label creation
* Fix help links
* Fix move and duplicate in file system dialog

## 1.2.0 (2022-02-22)

* Add baking of the viewport ([#89](https://github.com/LinwoodCloud/Butterfly/issues/89))
* Add templates dialogs and presets
* Add change document path option ([#96](https://github.com/LinwoodCloud/Butterfly/issues/96))
* Add insert dialog to add simplification of the user interface
  * Add image insert
  * Add camera insert
* Add sensitive settings ([#91](https://github.com/LinwoodCloud/Butterfly/issues/91))
* Add background presets
* Add document name editing in the appbar
* Remove image painter in favor of the insert dialog
* Use minSdkVersion 21 instead of 16 (The minimum version of android is 5.0 (Lollipop))
* Move undo/redo button to the left of the appbar

## 1.1.2 (2022-01-21)

* Move color picker in background context menu
* Set the export properties automatically to the current view
* Enable tapping on the expansion panel header to collapse/expand in the background dialog
* Change move window button on desktop to exclude buttons
* Change waypoints shortcut to Ctrl + Shift + P (was Ctrl + W) to avoid conflicts with web browsers
* Change background stroke width relative to the zoom level
* Change initial tool to first tool in the list
* Change alpha to 0.25 for the highlight color
* Fix bug where content gets reset when using the layer tool
* Fix color picker
* Fix label property in painter dialog
* Fix move/duplicate dialog in file system dialog
* Fix color not updating when changing the palette
* Fix waypoint create context
* Fix redo/undo context

## 1.1.1 (2022-01-14)

* Fix image loading ([#83](https://github.com/LinwoodCloud/Butterfly/issues/83))
* Fix image hit box
* Reimplement spaces in box background
* Fix box background
* Fix text editing dialog

## 1.1.0 (2022-01-05)

* Add layers to group elements
* Add layer painter to change the layer of the elements
* Add natural zoom
* Add ink well and rounding borders to painter buttons
* Fix open dialog crash when the dialog is closed by the user.

## 1.0.0 (2021-12-24)

* Adding deb and AppImage export type for linux
* Improve responsive file system dialog

<details>
 <summary>1.0 Nightly Changelog</summary>

### 1.0.0-rc.6 (2021-12-18)

* Add context menu
* Add zoom-dependent stroke width ([#31](https://github.com/LinwoodCloud/Butterfly/issues/31))
* Move background and waypoints to background context menu
* Move color palette to three points menu
* Fix internal router, use / instead of hash
* Fix responsive issues on color picker, file system and image export

### 1.0.0-rc.5 (2021-12-10)

* Add eraser exclude property for the hand
* Add folder creation feature to the file system
* Add move feature to the file system
* Add search to waypoints dialog
* Add path and search widget to open dialog
* Add hand properties
* Add nightly icon
* Add pwa documentation
* Implement move/duplicate for elements
* Prevent browser behaviors on the web version
* Fixing file system on native platforms
* Fix splash screen on screen readers
* Fix some dialog themes to have rounded corners

### 1.0.0-rc.4 (2021-11-27)

* Add file system with files and folders native and indexeddb in web ([#53](https://github.com/LinwoodCloud/butterfly/pull/53))
  * Custom save location
  * Added file names
* Add behavior options for multi gestures ([#45](https://github.com/LinwoodCloud/butterfly/issues/45))
* Add version to information dialog ([#50](https://github.com/LinwoodCloud/butterfly/issues/50))
* Fixing dialogs will open multiple times ([#47](https://github.com/LinwoodCloud/butterfly/issues/47))
* Improve performance for images ([#35](https://github.com/LinwoodCloud/butterfly/issues/35))

### 1.0.0-rc.3 (2021-11-14)

* Add shortcuts
* Add default name for documents
* Reimplement fill feature
* Fixing zooming
* Fixing version on windows installer

### 1.0.0-rc.2 (2021-11-07)

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

### 1.0.0-rc.1 (2021-10-30)

* Add new graphic engine to allow moving in the negative direction
* Big performance issues were fixed
* New loading screen on web
* Add separate color palette class (new color palette file format)
* Fixing empty names in document name ([#14](https://github.com/LinwoodCloud/butterfly/issues/14))
* Fixing open/save dialog

### 1.0.0-rc.0 (2021-10-20)

* Add new design system
* Add image painter and layer
  * Add scale property
* Add open/save dialog
* Add letter spacing to text painter and element
* Add internal property class to simplify equal variables on painter and layer
* Normalize json keys
* Fix lag when zooming out of the viewport
* Split custom painter from view internally

### 1.0.0-beta.0 (2021-10-15)

* Add new color picker
  * Multiple palettes
  * Open/save palettes
  * Custom colors
  * Edit palettes
* Add new label properties (font weight, italic, decoration)
* Fix shared preferences bug that prevents starting the app on android

### 1.0.0-alpha.0 (2021-10-10)

First release 🎉

</details>
