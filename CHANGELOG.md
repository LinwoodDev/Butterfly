# Changelog

<!--ENTER CHANGELOG HERE-->

## 2.4.1-rc.4 (2025-11-10)

* Add preview in snackbar after capturing thumbnail
* Add progress indicator when exporting PDF
* Migrate to new PDF rendering and file handling system
* Fix crashes on importing and exporting large files on Android
* Fix crash when zooming on a PDF element ([#960](https://github.com/LinwoodDev/Butterfly/issues/960))
* Fix memory leak in PDFs
* Fix changing arrangement not working correctly
* Fix eye dropper not working correctly for selecting a color for current tool
* Fix pasting won't preserve relative position when pasting multiple elements
* Fix paste menu will be shown if trying to deselect with select tool
* Fix transformation/duplicate not working correctly on touch devices
* Remove print option from pdf dialog

Read more here: https://linwood.dev/butterfly/2.4.1-rc.4

## 2.4.1-rc.3 (2025-11-03)

* Add tooltips for texts that can be ellipsized
* Fix performance problems when saving large notes
* Fix templates and packs could not be imported if no document is opened
* Fix state will not be saved if changes are made during autosave
* Fix sequential events like element removing will wait for autosave to finish
* Fix classic theme name first letter not capitalized in personalization settings
* Fix temporary tool will be resetted although it is the same index making duplication in selected tool not working ([#953](https://github.com/LinwoodDev/Butterfly/issues/953))
* Fix mouse cannot double click for context menu in select tool
* Fix scaling of multiple elements
* Fix scaling pen elements will jump to wrong position
* Fix thumbnails not having correct position if viewport is scaled
* Fix invisible layers will get visible after moving camera

Read more here: https://linwood.dev/butterfly/2.4.1-rc.3

## 2.4.1-rc.2 (2025-10-29)

* Fix loading documents does not load metadata and info
* Fix autosaving will save multiple times
* Fix templates will be recreated on every app start
* Fix duplicating opens context menu and selects the old element
* Fix search results does not show page as untitled

Read more here: https://linwood.dev/butterfly/2.4.1-rc.2

## 2.4.1-rc.1 (2025-10-27)

* Add templates tbfly export option ([#931](https://github.com/LinwoodDev/Butterfly/issues/931))
* Add option to selectively export templates ([#931](https://github.com/LinwoodDev/Butterfly/issues/931))
* Improve empty description in pdf dialog ([#943](https://github.com/LinwoodDev/Butterfly/943))
* Fix templates cannot be imported in tbfly format ([#931](https://github.com/LinwoodDev/Butterfly/issues/931))
* Fix flickering while drawing ([#935](https://github.com/LinwoodDev/Butterfly/issues/935))
* Fix issues with eraser tool creating artifacts ([#935](https://github.com/LinwoodDev/Butterfly/issues/935))
* Fix eraser tool creates elements with duplicate IDs ([#935](https://github.com/LinwoodDev/Butterfly/issues/935))
* Fix color palette dialog not updating and loading correctly ([#938](https://github.com/LinwoodDev/Butterfly/issues/938))
* Fix background lines don't render last row or column if only partially visible ([#932](https://github.com/LinwoodDev/Butterfly/issues/932))
* Fix files in grid view not having correctly spacing
* Fix concurrent file system operation, causing templates being initialized multiple times ([#940](https://github.com/LinwoodDev/Butterfly/issues/940))
* Fix file name goes into second line in file list view in desktop mode ([#941](https://github.com/LinwoodDev/Butterfly/issues/941))
* Fix file is duplicated when name is the same ([#951](https://github.com/LinwoodDev/Butterfly/issues/951))
* Fix thumbnail does not capture center of viewport ([#946](https://github.com/LinwoodDev/Butterfly/issues/946))
* Fix pages cannot be removed sometimes
* Fix default page will be recreated on opening ([#952](https://github.com/LinwoodDev/Butterfly/issues/952))
* Fix error when trying to import archive
* Fix temporary tool will be resetted although it is the same index making duplication in selected tool not working ([#953](https://github.com/LinwoodDev/Butterfly/issues/953))
* Fix absolute read only files not being correctly saved ([#949](https://github.com/LinwoodDev/Butterfly/issues/949))
* Fix absolute read only files being saved on closed
* Fix imported documents have file extension in their name

Read more here: https://linwood.dev/butterfly/2.4.1-rc.1

## 2.4.1-rc.0 (2025-10-20)

* Add delayed autosave ([#883](https://github.com/LinwoodDev/Butterfly/issues/883))
* Add save state as tooltip
* Improve memory usage and performance for importing large assets ([#917](https://github.com/LinwoodDev/Butterfly/issues/917))
* Improve smoothness of elements creation for releasing pen
* Fix bfly files cannot be imported into existing documents
* Fix various memory leaks ([#925](https://github.com/LinwoodDev/Butterfly/issues/925))
* Fix header text color on certain themes
* Fix theme names not displaying correctly in personalization settings
* Fix metadata file version not updating if file version is null
* Fix cache settings not editable correctly
* Fix elements are duplicated on creation
* Fix importing does not respect current directory
* Fix high render resolution description
* Fix elements cannot be imported on web
* Add 16kb page size support for android

Read more here: https://linwood.dev/butterfly/2.4.1-rc.0

## 2.4.0 (2025-09-22)

Changes since 2.3.0-rc.1:
* Fix updated assets cannot be removed

This is a stable release, it includes all the changes from the 2.3.0 nightly releases.
Read more here: https://linwood.dev/butterfly/2.3

## 2.4.0-rc.4 (2025-09-19)

* Add safearea on toolbar
* Fix duplicated refresh button in files view
* Fix alignment of create buttons in pages navigator page
* Fix freeze when importing
* Fix crash when having large pdf to import
* Fix error if pages have same name
* Fix problem in save system leading to duplicated pages in some cases
* Revert 16kb page size support effort

Read more here: https://linwood.dev/butterfly/2.4.0-rc.4

## 2.4.0-rc.3 (2025-09-15)

* Allow duration of laser to be 0
* Improve performance of document reloading
* Fix broken images/pdfs after undo/redo
* Fix duplicate has file extension in name dialog
* Fix template dialog not being correctly updated sometimes
* Fix core pack not being created on fetching packs
* Fix laser tool color not being animated

Read more here: https://linwood.dev/butterfly/2.4.0-rc.3

## 2.4.0-rc.2 (2025-09-12)

* Add restoration support for routes
* Improve performance of elements removing
* Fix baking sometimes duplicates renderers
* Fix images and pdfs not being rendered on viewport setup
* Fix eraser cursor size
* Add apk legacy build
* Add support for 16kb page size on android

Read more here: https://linwood.dev/butterfly/2.4.0-rc.2

## 2.4.0-rc.1 (2025-09-08)

* Add temporary toolbar ([#900](https://github.com/LinwoodDev/Butterfly/issues/900))
* Optimize pages events
* Update stroke drawing algorithm
* Improve stroke width controls in color toolbar
* Fix loading overlay having error on multiple closes
* Fix pdf spread pages import not being optimized

Read more here: https://linwood.dev/butterfly/2.4.0-rc.1

## 2.4.0-rc.0 (2025-09-04)

* Add support for math in rich text ([#725](https://github.com/LinwoodDev/Butterfly/issues/725))
* Add support for custom import names for pdf import
* Fix default page name
* Fix latex not rendering and rendered centered
* Fix no style sheet and palette not being selected
* Fix templates not being editable in dialog ([#898](https://github.com/LinwoodDev/Butterfly/issues/898))
* Fix home page header not aligned properly and has wrong colors
* Fix safe area in navigator rail
* Fix overflows in page navigator
* Fix pixel ratio gets resetted when unbaking the viewport
* Port linux appdata from flathub version
* Disable custom data directory selection on iOS

Read more here: https://linwood.dev/butterfly/2.4.0-rc.0

## 2.4.0-beta.3 (2025-08-28)

* Add search bar to waypoint view
* Rework pdf system ([#327](https://github.com/LinwoodDev/Butterfly/issues/327))
  * Add pdf element
  * Add pdf elements on pdf import instead converting to image
* Improve rotation based scaling ([#518](https://github.com/LinwoodDev/Butterfly/issues/518))
* Improve performance of pdf and image loading by rendering only visible elements
* Use minSdkVersion 24 instead of 23 (The minimum version of android is 7.0 (Nougat))
* Upgrade to flutter 3.35

Read more here: https://linwood.dev/butterfly/2.4.0-beta.3

## 2.4.0-beta.2 (2025-08-13)

* Add stroke width to polygon tool toolbar
* Add latex support for markdown ([#725](https://github.com/LinwoodDev/Butterfly/issues/725))
* Add ignore pressure setting to fix pressure values on some devices
* Save files in different thread ([#883](https://github.com/LinwoodDev/Butterfly/issues/883))
* Fix delete key not working in markdown mode
* Fix export to multipage PDF leads to empty pages except the current one ([#878](https://github.com/LinwoodDev/Butterfly/issues/878))
* Fix undo/redo not working correctly and freezing the app
* Big translation updates

Upstreamed from 2.3.3:
* Add support for arm AppImage builds
* Add more alternative linux builds
* Fix snap builds
* Fix laser fade animation not smoothly fading out ([#877](https://github.com/LinwoodDev/Butterfly/issues/877))

Read more here: https://linwood.dev/butterfly/2.4.0-beta.2

## 2.4.0-beta.1 (2025-07-14)

* Add polygon tool and element
* Add stroke width to toolbar ([#797](https://github.com/LinwoodDev/Butterfly/issues/797))
* Add txt support ([#874](https://github.com/LinwoodDev/Butterfly/issues/874))
* Reimplement renaming of styles and palettes in pack dialog
* Implement renaming of components in pack dialog
* Fix migration issues with new text based file format
* Fix loading of text based files (tbfly)
* Fix directory not respected when creating a document from a template
* Fix add to pack dialog not saving the component
* Fix navigator page dialogs not rounded
* Fix app is registered on all file types on android ([#874](https://github.com/LinwoodDev/Butterfly/issues/874))

Read more here: https://linwood.dev/butterfly/2.4.0-beta.1

## 2.4.0-beta.0 (2025-06-18)

* Add ctrl + enter to create new text element below current text element ([#858](https://github.com/LinwoodDev/Butterfly/issues/858))
* Add text based file format ([#823](https://github.com/LinwoodDev/Butterfly/issues/823))
* Add specific fill color ([#802](https://github.com/LinwoodDev/Butterfly/issues/802))
* Redesign pack system ([#805](https://github.com/LinwoodDev/Butterfly/issues/805))
* Improve error resistence in webdav file system ([#857](https://github.com/LinwoodDev/Butterfly/issues/857))
* Fix temporary handler not working correctly
* Fix text elements not correctly movable on pasting
* Fix new line not working in label tool
* Remove duplicated name property in pack items
* Fix server crash when invalid request is made
* Upgrade to flutter 3.32

Read more here: https://linwood.dev/butterfly/2.4.0-beta.0

## 2.3.4 (2025-08-21)

This is a hotfix update, cherry picking some important fixes from the last 2.4.0-beta.2 nightly release.

Cherry picks:
* Save files in different thread ([#883](https://github.com/LinwoodDev/Butterfly/issues/883))
* Fix delete key not working in markdown mode
* Fix export to multipage PDF leads to empty pages except the current one ([#878](https://github.com/LinwoodDev/Butterfly/issues/878))
* Fix undo/redo not working correctly and freezing the app
* Big translation updates

Read more here: https://linwood.dev/butterfly/2.3.4

## 2.3.3 (2025-08-01)

This is a hotfix update, cherry picking some important fixes from the last 2.4.0-beta.1 nightly release.

* Upgrade to flutter 3.32
* Add support for arm AppImage builds
* Add more alternative linux builds
* Publish app to microsoft store
* Fix snap builds
* Fix laser fade animation not smoothly fading out ([#877](https://github.com/LinwoodDev/Butterfly/issues/877))

Cherry picks:
* Fix navigator page dialogs not rounded
* Fix directory not respected when creating a document from a template

Read more here: https://linwood.dev/butterfly/2.3.3

## 2.3.2 (2025-06-23)

This is a hotfix update, cherry picking some important fixes from the last 2.4.0-beta.0 nightly release.

Cherry picks:
* Improve error resistence in webdav file system ([#857](https://github.com/LinwoodDev/Butterfly/issues/857))
* Fix temporary handler not working correctly
* Fix text elements not correctly movable on pasting
* Fix new line not working in label tool

Read more here: https://linwood.dev/butterfly/2.3.2

## 2.3.1 (2025-05-21)

Changes since 2.3.1-rc.1:
* Fix property view divider height
* Fix navigator appbar
* Remove recently files in file navigator

This is a stable release, it includes all the changes from the 2.3.1 nightly releases.
Read more here: https://linwood.dev/butterfly/2.3.1

## 2.3.1-rc.1 (2025-05-12)

* Add input mapping for inverted stylus ([#850](https://github.com/LinwoodDev/Butterfly/pull/850))
* Respect Input mappings when lasso select tool is selected ([#821](https://github.com/LinwoodDev/Butterfly/issues/821))
* Redesign mobile navigator pages to improve usability ([#853](https://github.com/LinwoodDev/Butterfly/issues/853))
* Redesign collaboration start dialog
* Add support for starting collaboration server with swamp on web
* Use modern material progress indicator
* Fix layers not reoderable on mobile
* Fix readonly files can change tool
* Fix file preview has window handles on desktop
* Update to agb 8.10

Read more here: https://linwood.dev/butterfly/2.3.1-rc.1

## 2.3.1-rc.0 (2025-05-05)

* Add copy button to the collaboration dialog
* Add process intent queries in android to fix internal flutter android processing
* Improve sharing files
* Improve default template when creating a new document ([#848](https://github.com/LinwoodDev/Butterfly/issues/848))
* Fix camera is required for android app
* Fix newly created elements created with pen or label desyncs in collaboration
* Fix undo/redo in collaboration
* Fix collaboration dialog dialog constraints
* Fix toolbar on mobile below the system ui ([#847](https://github.com/LinwoodDev/Butterfly/issues/847))
* Fix appbar menu overlays with system ui
* Fix initial save state to saved
* Fix window can't be moved on the title text area
* Fix window title bar height to be too big on some pages
* Update branding color on linux in appdata

Read more here: https://linwood.dev/butterfly/2.3.1-rc.0

## 2.3.0 (2025-04-20)

Happy Easter! 🐰

Changes since 2.3.0-rc.1:
* Fix exporting svg

This is a stable release, it includes all the changes from the 2.3.0 nightly releases.
Read more here: https://linwood.dev/butterfly/2.3

## 2.3.0-rc.1 (2025-04-16)

* Reduce crashes during canvas movement ([#838](https://github.com/LinwoodDev/Butterfly/pull/838))
* Upload the butterfly image file on the Docker website ([#756](https://github.com/LinwoodDev/Butterfly/issues/756))
* Improve android file association
* Improve error display page
* Fix opening files with intent not working on android
* Fix document was saved regardless if the file is up to date
* Fix error not appearing after failed import
* Fix bfly imports not working ([#839](https://github.com/LinwoodDev/Butterfly/issues/839))

Read more here: https://linwood.dev/butterfly/2.3.0-rc.1

## 2.3.0-rc.0 (2025-04-13)

* Add option to add custom user name for collaboration
* Add lock layer option to restrict editing to current layer
* Redesign collaboration dialog
* Move collaboration button to popup menu
* Add scroll to navigator ([#836](https://github.com/LinwoodDev/Butterfly/pull/836))
* Use opened document parent directory as initial path in file navigator
* Improve disconnect with collaboration
* Fix issue with editing text in the navigation rail on tablet ([#836](https://github.com/LinwoodDev/Butterfly/pull/836))
* Fix importing non butterfly files result in error ([#829](https://github.com/LinwoodDev/Butterfly/issues/829))
* Fix scroll sensitivity not changing move speed
* Fix thumbnail capture not using the current viewport
* Fix background dialog shows wrong content after deleting one layer
* Fix local storage not using specified path ([#835](https://github.com/LinwoodDev/Butterfly/issues/835))
* Fix performance drop after using path eraser or deleting elements ([#831](https://github.com/LinwoodDev/Butterfly/pull/831))
* Fix resolution size not centered
* Fix opened document not highlighted inside file navigator

Read more here: https://linwood.dev/butterfly/2.3.0-rc.0

## 2.3.0-beta.4 (2025-03-31)

* Add safe area around navigator
* Add tooltips to the close icon button
* Add swamp collaboration system in collaboration experiment
* Add new material 3 slider
* Add qr code for sharing collaboration link
* Add barcode tool ([#818](https://github.com/LinwoodDev/Butterfly/issues/818))
* Add ability to replace waypoints and customize origin ([#817](https://github.com/LinwoodDev/Butterfly/pull/817))
* Rework settings cards ([#822](https://github.com/LinwoodDev/Butterfly/pull/822))
* Rework input settings ui ([#822](https://github.com/LinwoodDev/Butterfly/pull/822))
* Draw selection rect at the bounds of the canvas if it's outside the canvas
* Use launch url as share link for collaboration
* Rename xopp to Xournal++
* Change ZIP export button label for clarity ([#810](https://github.com/LinwoodDev/Butterfly/pull/810))
* Improve pattern background settings
* Add search for term in caption in add dialog
* Fix file list not refreshing when returning to home screen on desktop ([#813](https://github.com/LinwoodDev/Butterfly/issues/813))
* Fix spacing in file preview on android ([#814](https://github.com/LinwoodDev/Butterfly/issues/814))
* Fix temporary tool not being removed ([#809](https://github.com/LinwoodDev/Butterfly/issues/809))
* Fix editable list tile subtitle not aligned with title
* Fix svg images doesn't use the correct size
* Fix opening a note from a recent files tile loads an outdated note and saves it ([#816](https://github.com/LinwoodDev/Butterfly/issues/816))
* Fix filter chips in add dialog in comfortable ui
* Fix editable list tile not having selected color
* Fix setting the input mapping to a blank string would revert to the input's default setting after the app was restarted ([#822](https://github.com/LinwoodDev/Butterfly/pull/822))
* Fix settings for "Pen only input" and "Input gestures" would be reverted after the app was restarted ([#822](https://github.com/LinwoodDev/Butterfly/pull/822))
* Remove unsupported connections settings page on web

Read more here: https://linwood.dev/butterfly/2.3.0-beta.4

## 2.3.0-beta.3 (2025-03-17)

* Add file preview to files navigator ([#736](https://github.com/LinwoodDev/Butterfly/issues/736))
* Add min and max pressure info to pointer test
* Add option to import and export settings
* Add inline property name editing ([#797](https://github.com/LinwoodDev/Butterfly/issues/797))
* Only change file path on creating document, show indicator for creating document
* Improve pressure simulation
* Fix NaN values for pressure ([#748](https://github.com/LinwoodDev/Butterfly/issues/748))
* Fix importing documents ([#807](https://github.com/LinwoodDev/Butterfly/issues/807))
* Fix editable text submit button making it editable again
* Fix selection menu in template dialog not showing without opening a document
* Add version name on desktop if banner was hidden
* Update to agb 8.9

Read more here: https://linwood.dev/butterfly/2.3.0-beta.3

## 2.3.0-beta.2 (2025-03-04)

* Add indicator for scale proportion ([#616](https://github.com/LinwoodDev/Butterfly/issues/616))
* Add release name to home page header, appbar and version (currently Adonis Blue)
* Add multiple background support ([#778](https://github.com/LinwoodDev/Butterfly/issues/778))
* Add transparent option for pattern texture
* Add area property view
* Add flip horizontal, vertical and gray scale operation on images ([#794](https://github.com/LinwoodDev/Butterfly/issues/794))
* Add svg background support
* Add element count to layer list
* Add subtitle to property view for tools
* Add warning to experiments settings page and allow using them on stable
* Add move on gesture setting
* Grid and ruler will now influence shape, stamp, area and texture tool
* Add setting in shape tool to draw from center ([#800](https://github.com/LinwoodDev/Butterfly/issues/800))
* Improve ctrl and shift functionality on pasting tools
* Improve ruler rotation handling
* Improve selection change animation
* Improve responsiveness of file list view
* Improve grid tool
  * Add stroke width
  * Add option for position and zoom dependent
  * Fix snap if size is 0
* Improve add dialog with filters
* Improve hit calculations in rectangle and polygon mode ([#799](https://github.com/LinwoodDev/Butterfly/issues/799))
  * Circle
  * Lines
  * Rectangle
  * Triangles
* Improve template dialog
  * Add select all and deselect button
  * Change create button to floating action button
* Use random colors for cursors in collaboration mode
* Change texture tool icon since it was the same as the grid tool
* Add switch animation in navigator drawer
* Move hide cursor while drawing to mouse settings
* Fix unnecessary saving
* Fix offset list tile
* Fix resolution shift issues ([#793](https://github.com/LinwoodDev/Butterfly/issues/793))
* Fix saving issues
* Fix background assets not removed on delete
* Fix asset svg exports
* Fix pattern background position
* Fix conversion to hex color on svg export and color pick
* Fix some special-characters not working for file names
* Fix file name validator missing on file rename
* Fix flipped title and subtitle in search results
* Fix windows portable archive
* Fix hover in pattern texture view
* Fix rectangle selection preview wrongly having a rotation handle line
* Fix debian arm build ([#801](https://github.com/LinwoodDev/Butterfly/issues/801))
* Fix zoom dependent not working on shape tool
* Fix pressure if os wrongly gives 0 as input
* Fix template override menu item wrongly labeled as delete
* Remove http sources
* Upgrade to flutter 3.29

Read more here: https://linwood.dev/butterfly/2.3.0-beta.2

## 2.3.0-beta.1 (2025-01-20)

* Add search bar for components navigator page
* Improve document settings UI
  * Remove duplicated name field in document settings
  * Change description only on submit
  * Improve encryption and thumbnail buttons
* Add error boundaries for corrupted files
* Fix export button in data settings not working
* Fix export button for file view not visible
* Fix file view showing wrong aspect ratio for thumbnails
* Fix line transform changes rotation and scaling not working correctly ([#786](https://github.com/LinwoodDev/Butterfly/issues/786))
* Fix lock collection wrongly labeled as Layer
* Update secure storage dependency
* Use minSdkVersion 23 instead of 21 (The minimum version of android is 6.0 (Marshmallow))
* Improve collaboration system
  * Use wss default if no protocol is provided
  * Fix networking server/client not starting
  * Fix initializaton not sent by server
  * Improve performance when joining a room
* Add linux arm binaries
* Upgrade to agb 8.8

Read more here: https://linwood.dev/butterfly/2.3.0-beta.1

## 2.3.0-beta.0 (2025-01-06)

* Redesign mobile home page
  * Use tabs for easier navigation
  * Dedicated files view
  * Move settings into a tab
* Add toggleable tools
* Add palette name and pack to color picker dialog
* Add stroke width slider to pattern texture
* Move ruler into own tool
  * Add color property
  * Add size property
* Move grid into own tool
  * Add offset property
* Move background button from project settings to top corner button
* Add password protected notes ([#771](https://github.com/LinwoodDev/Butterfly/issues/771))
* Add option to import svg as text ([#596](https://github.com/LinwoodDev/Butterfly/issues/596))
* Improve grid files view
* Improve slider and double input list tiles
* Change aspect ratio to use 3 fraction digits for area
* Fix undo/redo tools not showing status correctly
* Fix grid not working correctly
* Fix capture thumbnail uses wrong position
* Fix zoom slider is not centered
* Fix shape detection list tile not clickable
* Fix svg export shows wrong initial preset
* Fix default stroke width ([#779](https://github.com/LinwoodDev/Butterfly/issues/779))

Read more here: https://linwood.dev/butterfly/2.3.0-beta.0

## 2.2.4 (2025-01-13)

This is a hotfix update, cherry picking some important fixes from the last 2.3.0-beta.0 nightly release.

* Add error boundaries for corrupted files
* Fix export button in data settings not working
* Fix utilties state resetted after undo
* Fix file view showing wrong aspect ratio for thumbnails

Cherry picks:
* Fix default stroke width ([#779](https://github.com/LinwoodDev/Butterfly/issues/779))
* Fix svg export shows wrong initial preset
* Fix capture thumbnail uses wrong position
* Fix zoom slider is not centered
* Fix shape detection list tile not clickable
* Fix corrupting files when saving ([#777](https://github.com/LinwoodDev/Butterfly/issues/777))
* Fix action tools not updating

Read more here: https://linwood.dev/butterfly/2.2.4

## 2.2.3 (2024-12-24)

Merry Christmas! 🎄

This is a stable release, it includes all the changes from the 2.2.3 nightly releases.
Read more here: https://linwood.dev/butterfly/2.2.3

## 2.2.3-rc.2 (2024-12-20)

* Add area options to context menu in area navigator page
* Add error icon to asset card
* Move create button to the top right of the template dialog
* Improve mobile color picker
* Align no elements text to the center
* Fix thumbnail in files view
* Fix spacing in home page
* Fix baking not working correctly when zooming in
* Fix docker image ([#769](https://github.com/LinwoodDev/Butterfly/pull/769))

Read more here: https://linwood.dev/butterfly/2.2.3-rc.2

## 2.2.3-rc.1 (2024-12-16)

* Improve template dialog
  * Add override tools in context menu
  * Add information button
  * Add duplicate button
  * Change create template button to save icon
  * Improve thumbnail display to have rounded corners
* Add color wheel to color picker
* Add render resolution to improve moving on canvas
* Redesign search to material 3
  * Improve tool results
* Improve responsiveness of exact slider
* Change zoom dependent to false by default
* Use material blue and red as default colors
* Improve sliders for background dialog
* Add additional selection ui options to the pen element
* Add tooltip to preset icons in export dialog
* Change general icon on background to grid
* Limit search results to 10
* Fix export on web
* Fix shape detection always enabled in pen tool
* Fix ruler not working correctly in pen tool
* Fix ruler position is wrong when moving on the canvas
* Fix zoom dependent not working correctly with the label tool ([#765](https://github.com/LinwoodDev/Butterfly/issues/765))
* Fix temporary import handler does not get removed after clicking
* Fix asset hash not correctly working with filenames
* Fix duplicated asset importing
* Fix aspect ratio label in area tool selection view
* Fix add dialog shows "No element" if there is only import search results
* Fix document isn't saved when clicking home
* Fix stamp don't use unique element ids
* Fix render order when creating multiple elements when baking
* Fix some color fields don't keep alpha value
* Fix color fields preview shows alpha value
* Fix min slider value of stroke width
* Fix selection not working correctly when editing multiple elements
* Fix search on web
* Fix temporary stamp
* Show git hash instead of version in web version
* Upgrade to flutter 3.27

Read more here: https://linwood.dev/butterfly/2.2.3-rc.1

## 2.2.3-rc.0 (2024-12-02)

* Add toggle for color toolbar ([#611](https://github.com/LinwoodDev/Butterfly/issues/611))
* Add save button indicator for autosave ([#757](https://github.com/LinwoodDev/Butterfly/issues/757))
* Add duplicate layer button
* Add tool options panel position
* Add path laser animation
* Separate laser duration in normal duration and hide duration
* Use long press to move tools on all platforms to improve desktop touch behavior
* Use sha checksum for assets
* Update dropdown buttons in shape and constraints to material 3
* Separate personalization settings in new view settings
* Fix webdav on windows

Read more here: https://linwood.dev/butterfly/2.2.3-rc.0

## 2.2.2 (2024-11-11)

* Fix loading screen showing after error
* Fix packs dialog file system operations
* Downgrade pdfjs on web

This is a stable release, it includes all the changes from the 2.2.2 nightly releases.
Read more here: https://linwood.dev/butterfly/2.2.2

## 2.2.2-rc.1 (2024-11-04)

* Add checksums to release assets ([#753](https://github.com/LinwoodDev/Butterfly/issues/753))
* Add documentation button to collapsed app bar
* Move eraser tool to property view
* Improve scaling rotated elements ([#518](https://github.com/LinwoodDev/Butterfly/issues/518) partially, offset needs to be fixed)
* Improve performance on large pages ([#667](https://github.com/LinwoodDev/Butterfly/issues/667) partially)
* Improve property view
* Fix changing page don't showing content ([#755](https://github.com/LinwoodDev/Butterfly/issues/755))
* Fix label cursor style if not editing element
* Remove cusor visibility on eraser, path eraser and label tool
* Remove label tool can be changed tool to allow context menu

Read more here: https://linwood.dev/butterfly/2.2.2-rc.1

## 2.2.2-rc.0 (2024-10-28)

* Add layer merging
* Add option to open context menus with right click on desktop or long press on mobile
* Add safe area to add dialog
* Add fade transition for property view
* Remove asking for name on layer creation
* Fix layer rendering
* Fix pin icon in property view
* Fix toolbar position
* Fix directory deletion in native file system
* Fix property view logic
* Fix property view ui padding
* Fix archive importing
* Fix collaboration dialog
* Fix navigator page large constraints
* Fix root directory bug on web
* Upgrade networking stack for collaboration experiment
* Update flutter and agp

Read more here: https://linwood.dev/butterfly/2.2.2-rc.0

## 2.2.1 (2024-10-17)

This is a stable release, it includes all the changes from the 2.2.1 nightly releases.
Read more here: https://linwood.dev/butterfly/2.2.1

## 2.2.1-rc.1 (2024-10-14)

* Add bit mapping of buttons in pointer test
* Add autofocus to add dialog search bar
* Add transition when opening add dialog
* Add size transition to toolbar
* Improve search and settings dialog transition
* Change color toolbar to not have the full width
* Fix pasting with label tool replaces text instead of appending
* Fix unstable sort algorithm if layer is the same
* Fix switching data directory not working
* Fix input button mapping not working on multiple button presses ([#748](https://github.com/LinwoodDev/Butterfly/issues/748))
* Fix app link in android

Read more here: https://linwood.dev/butterfly/2.2.1-rc.1

## 2.2.1-rc.0 (2024-09-30)

* Add convert to layer to collection dialog
* Readd option to select custom collection
* Update button in name dialog to context specific action
* Use live icon in add dialog (for example on undo, redo and full screen tools)
* Improve layout of collection dialog
* Improve copy to clipboard snackbar to show color
* Change sensitivity settings to percent
* Change min sensitivity of inputs to 10%
* Rename context menu item name to rename in area context menu
* Use search bar in areas navigator instead of normal text field
* Fix select sensitivity slider in input settings changes scroll sensitivity
* Fix current collection not being shown in collection dialog
* Fix duplicating not working correctly
* Fix layer rendering
* Fix convert to layer not working before reopening the app
* Fix file name only supports latin characters ([#743](https://github.com/LinwoodDev/Butterfly/issues/743))
* Fix selection not updated when elements changed

Read more here: https://linwood.dev/butterfly/2.2.1-rc.0

## 2.2.0 (2024-09-28)

* Fix importing keeps id

This is a stable release, it includes all the changes from the 2.2 nightly release.
Read more here: https://linwood.dev/butterfly/2.2

<details>
 <summary>2.2 Nightly Changelog</summary>

## 2.2.0-rc.3 (2024-09-26)

* Rebuild baking system to support multiple layers
* Add convert to layer to collection dialog
* Add convert to layer to general area context menu
* Fix layer ordering being reversed
* Fix current layer not being changed
* Fix lock collection mode not working
* Fix elements being modifyable in different layers
* Fix invisible layers setting being ignored

Read more here: https://linwood.dev/butterfly/2.2.0-rc.2

## 2.2.0-rc.1 (2024-09-23)

* Add icons to position personalization settings
* Update baking image rendering
* Change default sorting to modified descending
* Change floating action button in toolbar to be small to improve rounded corners
* Change bottom icon in toolbar items to toolbar position
* Improve size of add dialog
* Improve lock and tools buttons in vertical toolbar
* Fix size of vertical toolbar position
* Fix wrong settings page of inputs and behaviors routes
* Fix file system refreshing on cancelling moving a file
* Fix file not saved in certain cases
* Fix add button can be moved in the toolbar

Read more here: https://linwood.dev/butterfly/2.2.0-rc.1

## 2.2.0-rc.0 (2024-09-16)

* Refactor layer tool ([#728](https://github.com/LinwoodDev/Butterfly/issues/728))
  * Renamed to collection tool
  * Changed to action tool
  * It now opens a menu with all collections and actions
* Upgrade file version to 10 ([#728](https://github.com/LinwoodDev/Butterfly/issues/728))
  * Refactor to new layer system
  * Rename current layer implementation to collections
* Change layer navigator page to new layer system ([#728](https://github.com/LinwoodDev/Butterfly/issues/728))
* Improve action tool visualization in edit toolbar
* Add eye dropper docs
* Improve multi select in file view ([#713](https://github.com/LinwoodDev/Butterfly/issues/713))
  * Add invert selection
  * Add move
* Add tolerance to area move in navigator page to fix duplicated areas
* Add startup behavior settings to open last note or new note on startup
* Update selection incorrect when transforming multiple elements
* Refactor sensitivity settings to be more user friendly and more descriptive and remove unused settings
* Move inputs from behaviors settings to own page
* Make packs dialog responsive
* Fix select all shortcut
* Fix temporary tool is not the right size in the edit toolbar
* Fix memory leaks
* Fix regression bug introduced in 2.2 that caused weird behavior in webdav file system
* Fix action tools gets selected when added
* Fix data directory does not update when selecting one
* Fix export pin icon in dialog
* Fix export tool not recognized as action tool
* Update pdfjs on web
* Update to flutter 3.24.3

Read more here: https://linwood.dev/butterfly/2.2.0-rc.0

## 2.2.0-beta.3 (2024-09-09)

* Add full selection mode ([#684](https://github.com/LinwoodDev/Butterfly/issues/684))
* Save utilities states after restart
* Ignore invalid files with invalid syntax
* Fix elements not being selected after moving
* Fix file gets duplicated on save (again)
* Fix image background wrong offset when moving on canvas
* Fix packs dialog showing templates
* Fix web showing no templates on first start
* Fix templates and packs gets overriden on creation with same name

Read more here: https://linwood.dev/butterfly/2.2.0-beta.3

## 2.2.0-beta.2 (2024-08-27)

* Add wasm support for chromium based browsers
* Use date for default file name
* Fix unnamed files gets duplicated on save
* Upgrade to flutter 3.24
* Update internal component library
* Remove FLUTTER_VERSION file, use pubspec instead

Read more here: https://linwood.dev/butterfly/2.2.0-beta.2

## 2.2.0-beta.1 (2024-08-05)

* Add navigator position to position it to the right (useful for left handed users)
* Add option to change layer in select and area context menu
* Start adding multi file selection ([#713](https://github.com/LinwoodDev/Butterfly/issues/713))
* Improve renaming in files view
* Improve grid view item
* Improve navigator rail
* Refactor file system to include it as library
* Fix pinned properties view gets closed when switching tools

Read more here: https://linwood.dev/butterfly/2.2.0-beta.1

## 2.2.0-beta.0 (2024-06-25)

* Add erase elements property to eraser and patheraser ([#680](https://github.com/LinwoodDev/Butterfly/issues/680))
* Add shape element to normal eraser([#683](https://github.com/LinwoodDev/Butterfly/issues/683))
* Add lock layer ([#688](https://github.com/LinwoodDev/Butterfly/issues/688))
* Add export button to templates dialog
* Improve packs dialog
* Fix spacer has no help page
* Fix utilities state on undo/redo ([#721](https://github.com/LinwoodDev/Butterfly/issues/721))
* Fix select and eye dropper temporary tool already gets removed before doing the action
* Fix asset select dialog overflows on too many assets
* Fix full screen button in top left corner menu doesn't work
* Upgrade AGB to 8.5.0 in android

Read more here: https://linwood.dev/butterfly/2.2.0-beta.0

</details>

## 2.1.1 (2024-06-10)

Nothing changed from the nightly build to the stable release.

See all changes since the last stable here: https://linwood.dev/butterfly/2.1.1

## 2.1.1-rc.2 (2024-06-03)

* Show no elements message when document search is empty
* Fix file changing in webdav on root folder ([#714](https://github.com/LinwoodDev/Butterfly/pull/714))
* Fix layer not set on automatic shapes ([#717](https://github.com/LinwoodDev/Butterfly/pull/717))
* Fix x icon button in navigator page on mobile
* Fix page not saved after creating a new page

Read more here: https://linwood.dev/butterfly/2.1.1-rc.2

## 2.1.1-rc.1 (2024-05-21)

* Add hide cursor while drawing
* Improve pdf import performance ([#702](https://github.com/LinwoodDev/Butterfly/pull/702))
* Reimplement quality in pdf import ([#702](https://github.com/LinwoodDev/Butterfly/pull/702))
* Center grid items in home page
* Modernize home page header gradient to use secondary and primary color
* Improve webdav requests ([#703](https://github.com/LinwoodDev/Butterfly/pull/703))
* Improve image quality ([#704](https://github.com/LinwoodDev/Butterfly/issues/704))
* Improve baked image quality
* Improve responsiveness
* Improve path eraser performance
* Use a blue/gray for secondary color in classic theme
* Fix launching url does nothing
* Fix settings on mobile fill full height
* Fix grid switch on file view will be shown in navigator
* Fix missing scrollbar in home page
* Fix scale proportional not working
* Fix bfly file import and export on android ([#709](https://github.com/LinwoodDev/Butterfly/issues/709))
* Fix old baked image not being disposed
* Fix toolbar not showing on desktop in toolbar position inline
* Fix removing elements hides all elements for a moment
* Fix label could not be edited ([#712](https://github.com/LinwoodDev/Butterfly/issues/712))
* Upgrade to flutter 3.22
* Fix linux screenshot appdata

Read more here: https://linwood.dev/butterfly/2.1.1-rc.1
Visit the new docs here: https://butterfly.linwood.dev

## 2.1.1-rc.0 (2024-05-14)

* Make dav requests more performant ([#689](https://github.com/LinwoodDev/Butterfly/pull/689))
* Add icons to platform theme setting
* Enhance mobile home page
* Change lasso select icon to a real lasso
* Fix visible layers are not working correctly ([#692](https://github.com/LinwoodDev/Butterfly/issues/692))
* Fix remote button if external storage is default
* Fix linux metainfo
* Fix image operations
* Fix no element on fetch in dav requests ([#695](https://github.com/LinwoodDev/Butterfly/pull/695))
* Fix context buttons in template dialog closes the dialog

Read more here: https://linwood.dev/butterfly/2.1.1-rc.0

## 2.1.0 (2024-05-10)

Nothing changed from the nightly build to the stable release.

See all changes since the last stable here: https://linwood.dev/butterfly/2.1

<details>
 <summary>2.1 Nightly Changelog</summary>

## 2.1.0-rc.3 (2024-05-07)

* Add button to check for updates instead of automatically checking on opening the settings ([#691](https://github.com/LinwoodDev/Butterfly/issues/691))
* Update android build files

Read more here: https://linwood.dev/butterfly/2.1.0-rc.3

## 2.1.0-rc.2 (2024-05-06)

* Reenable changing data directory on android ([#569](https://github.com/LinwoodDev/Butterfly/issues/569))
* Fix unknown import type shows euler number
* Fix unknown import type on images ([#679](https://github.com/LinwoodDev/Butterfly/issues/679))
* Fix changing background removes all elements from the canvas ([#681](https://github.com/LinwoodDev/Butterfly/issues/681))
* Fix unnessesary rerender dialogs and views

Read more here: https://linwood.dev/butterfly/2.1.0-rc.2

## 2.1.0-rc.1 (2024-04-30)

* Fix triangle rendering
* Fix temporary tool won't be removed when using not configured input
* Fix select all
* Fix import error when using open with on android

Read more here: https://linwood.dev/butterfly/2.1.0-rc.1

## 2.1.0-rc.0 (2024-04-22)

This is the 100th release 🎉

* Add image background svg support
* Add triangle to shape tool and add dialog ([#664](https://github.com/LinwoodDev/Butterfly/pull/664))
* Add name field to create template dialog
* Add button to invert selection in templates dialog
* Add option to override tools for selected templates ([#613](https://github.com/LinwoodDev/Butterfly/issues/613))
* Add intents to open zip, pdf and images with this app on android
* Redesign templates dialog
* Fix linux metainfo again
* Fix label is not being created when unfocussing
* Fix area preview rendering
* Fix recent history not removed when deleting the document
* Fix editable input not being updated
* Fix baking when using smooth navigation
* Fix locale displayed as system language if there is no translation for this
* Fix missing translations for locales
* Fix render background gets ignored ([#670](https://github.com/LinwoodDev/Butterfly/issues/670))
* Remove old unused code

Read more here: https://linwood.dev/butterfly/2.1.0-rc.0

## 2.1.0-beta.5 (2024-04-08)

* Add native clipboard ([#605](https://github.com/LinwoodDev/Butterfly/issues/605))
* Add option to import zip archive
* Allow using these tools as temporary tool ([#656](https://github.com/LinwoodDev/Butterfly/issues/656))
  * Select
  * Area
  * Laser
* Add small, tiny and compact toolbar size option
* Add maximize and desktop density personalization setting
* Allow pasting packs inside documents
* Remove navigating to canvas view if no document was imported
* Use correct remote for importing
* Rename toolbar columns to rows
* Change size of quickstart to be smaller
* Change size of recent files card
* Improve home page header to be more responsive
* Improve size of add button
* Force top instead of inline if multiple rows in toolbar
* Fix linux metainfo again
* Fix template infinite loading on initial load
* Fix size of temporary tool and lock and tools button if toolbar columns count is bigger than 1
* Fix snackbar will be shown twice when copying to clipboard in settings
* Fix null check in area handler
* Fix pen renderer doesn't use the real pressure value ([#650](https://github.com/LinwoodDev/Butterfly/issues/650))
* Don't allow importing templates when document is opened

* Use nightly flavor for nightly builds to allow installing both stable and nightly builds on the same device
* Add architecture specific apk builds ([#657](https://github.com/LinwoodDev/Butterfly/issues/657))
* Upgrade path rendering api

Read more here: https://linwood.dev/butterfly/2.1.0-beta.5

## 2.1.0-beta.4 (2024-04-01)

* Add auto create areas functionality in areas navigator page
* Add top toolbar setting that isn't integrated with the appbar
* Add option to have multiple toolbar columns
* Add multi columns for toolbar ([#589](https://github.com/LinwoodDev/Butterfly/issues/589))
* Add pointer test to behavior settings
* Change area enter and exit to the left of the area name in areas navigator page
* Change current area on area click in areas navigator page if the current area is not the clicked area
* Improve friction
* Use percents for zoom in document properties
* Readd drawing outside of window ([#521](https://github.com/LinwoodDev/Butterfly/pull/521))
* Fix baking when animating smooth navigation
* Fix eraser
* Fix crash and size when loading pdf or big butterfly files ([#645](https://github.com/LinwoodDev/Butterfly/pull/645))
* Fix toolbar size setting saving
* Fix template dialog loading failed
* Fix grid x position negation
* Update linux appdata

Read more here: https://linwood.dev/butterfly/2.1.0-beta.4

## 2.1.0-beta.3 (2024-03-25)

* Add support for renaming the current page
* Add advance button in quickstart
* Add setting for toolbar size ([#589](https://github.com/LinwoodDev/Butterfly/issues/589))
* Add "Add all" to area export dialog ([#633](https://github.com/LinwoodDev/Butterfly/issues/633))
* Add move left and right to area export dialog
* Add page name to export pdf dialog details
* Add support for multiple document pages in pdf export dialog
* Add "Only current page" filter option to area selection dialog for pdf export dialog
* Add tools to search results
* Add shortcut (ctrl + k) to open search
* Advance shape detection and add support for rectangle, triangle and circle ([#632](https://github.com/LinwoodDev/Butterfly/pull/632))
* Add smooth scrolling behind a feature flag ([#86](https://github.com/LinwoodDev/Butterfly/issues/86))
* Allow multiple selections in templates dialog
* Improve pdf export dialog sizing of cards
* Change identifier for elements from index to a key based id ([#528](https://github.com/LinwoodDev/Butterfly/issues/528))
* Save document on undo/redo
* Run events synchronously instead of asynchronously ([#528](https://github.com/LinwoodDev/Butterfly/issues/528))
* Fix folder fetching in web
* Fix problems when changing to the same page
* Fix missing scrolling in export pdf select dialogs ([#633](https://github.com/LinwoodDev/Butterfly/issues/633))
* Fix position on search results
* Fix page icon in search results
* Fix search to search document wide instead of only the current page
* Upgrading major versions of many dependencies
* Update android build configuration

Read more here: https://linwood.dev/butterfly/2.1.0-beta.3

## 2.1.0-beta.2 (2024-03-11)

* Add icons to sort dropdown items
* Improve window buttons on custom title bar
* Improve svg path export ([#620](https://github.com/LinwoodDev/Butterfly/issues/620))
* Fix svg export preview shows nothing
* Fix exporting on web
* Fix file creation if the file path already exists

Read more here: https://linwood.dev/butterfly/2.1.0-beta.2

## 2.1.0-beta.1 (2024-03-04)

* Add setting for adding background to pdf import ([#606](https://github.com/LinwoodDev/Butterfly/issues/606))
* Add setting for inverting to pdf import ([#606](https://github.com/LinwoodDev/Butterfly/issues/606))
* Add image operations
  * Invert
  * Background
* Add ability to reorder waypoints
* Change waypoint identifier to the name instead of index
* Fix transformation pushed to reference handle ([#615](https://github.com/LinwoodDev/Butterfly/issues/615))
* Disable showing transform controls while transforming

Read more here: https://linwood.dev/butterfly/2.1.0-beta.1

## 2.1.0-beta.0 (2024-02-26)

* Add shape detection for lines ([#578](https://github.com/LinwoodDev/Butterfly/issues/578))
* Add area navigator page ([#574](https://github.com/LinwoodDev/Butterfly/issues/574))
* Add resize and move controls to area tool ([#542](https://github.com/LinwoodDev/Butterfly/issues/542))
* Add reorder controls to area tool
* Add option to export whole page ([#594](https://github.com/LinwoodDev/Butterfly/issues/594))
* Add export tool ([#590](https://github.com/LinwoodDev/Butterfly/issues/590))
* Move rotation controls to the top ([#607](https://github.com/LinwoodDev/Butterfly/issues/607))
* Improve area tool creation rect selection
* Make selection system of select tool modular
* Upgrade to flutter 3.19
* Improve pdf import ([#612](https://github.com/LinwoodDev/Butterfly/issues/612))
* Rename release assets ([#568](https://github.com/LinwoodDev/Butterfly/discussions/568))
* Generalize svg and png dialog
* Fix thumbnail shoot position
* Fix png export

Read more here: https://linwood.dev/butterfly/2.1.0-beta.0

</details>

## 2.0.3 (2024-02-19)

* Fix png export

See all changes since the last stable here: https://linwood.dev/butterfly/2.0.3

## 2.0.3-rc.1 (2024-02-12)

* Add initial ios support (currently nightly only) ([#244](https://github.com/LinwoodDev/Butterfly/issues/244))
* Add option to disable autosave ([#591](https://github.com/LinwoodDev/Butterfly/issues/591))
* Convert aspect ratio menu to material 3
* Invert current inverted position to be normal
* Fix file sharing on android ([#585](https://github.com/LinwoodDev/Butterfly/issues/585))
* Fix laser movement is not locked
* Fix color of icon dropdown in property view
* Disable camera on android sdk version < 21

Read more here: https://linwood.dev/butterfly/2.0.3-rc.1

## 2.0.3-rc.0 (2024-02-05)

* Fix export pdf print instead of export as file
* Fix scroll in pdf export dialog
* Fix pdf.js on web
* Fix exporting on web
* Fix notch area not being used in full screen ([#368](https://github.com/LinwoodDev/Butterfly/issues/368))
* Fix performance of the eraser tool ([#461](https://github.com/LinwoodDev/Butterfly/issues/461))
* Fix performance of the path eraser tool (partially [#528](https://github.com/LinwoodDev/Butterfly/issues/528))

Read more here: https://linwood.dev/butterfly/2.0.3-rc.0

## 2.0.2 (2024-01-29)

Nothing changed from the nightly build to the stable release.

See all changes since the last stable here: https://linwood.dev/butterfly/2.0.2

## 2.0.2-rc.0 (2024-01-22)

* Use thicker lines for label selection rect
* Restrict input to area bounds when inside area ([#573](https://github.com/LinwoodDev/Butterfly/issues/573))
* Fix template import opens blank document
* Fix zoom view not appearing
* Fix markdown property view not opening
* Fix creating component origin being page origin instead of selection origin

Read more here: https://linwood.dev/butterfly/2.0.2-rc.0

## 2.0.1 (2024-01-15)

Nothing changed from the nightly build to the stable release.

See all changes since the last stable here: https://linwood.dev/butterfly/2.0.1

## 2.0.1-rc.1 (2024-01-08)

* Add refresh button to quickstart
* Add refresh button to file view
* Add link to experiment
* Add extra icon for label markdown mode
* Add validation in collaboration start dialog
* Add help pages for navigator pages
* Remember grid view setting
* Improve spacing in add dialog
* Set default port as initial value in collaboration start dialog
* Fix markdown label editing
* Fix not working new line
* Fix asset card missing ripple effect
* Fix rename saved function will be triggered multiple times
* Fix pen property view
* Fix label editing when selecting different text input
* Fix subSpan editing in label editing
* Fix svg exporting error
* Fix presentation preview on initial selection
* Fix exporting on mobile devices

## 2.0.1-rc.0 (2024-01-01)

* Add high contrast mode ([#564](https://github.com/LinwoodDev/Butterfly/issues/564))
* Add support for multi character input languages ([#539](https://github.com/LinwoodDev/Butterfly/issues/539))
* Add scale to label toolbar
* Add scale to label selection view
* Add markdown element selection view
* Fix moving data directory ([#562](https://github.com/LinwoodDev/Butterfly/issues/562))
* Fix various issues with the label tool
* Fix display icon
* Fix spread pages settings not being saved
* Fix app link on android

## 2.0.0 (2023-12-24)

Nothing changed from the nightly build to the stable release.

See all changes since the last stable here: https://linwood.dev/butterfly/2.0.0-rc.3

<details>
 <summary>2.0 Nightly Changelog</summary>

### 2.0.0-rc.3 (2023-12-22)

* Change duplicate icon to have a difference to copy icon ([#552](https://github.com/LinwoodDev/Butterfly/issues/552))
* Change default scale of label tool to 2
* Change dropdown to modal bottom sheet for density personalisation setting
* Improve responsiveness of dialogs on mobile devices ([#550](https://github.com/LinwoodDev/Butterfly/issues/550))
* Improve add dialog trailing icon ([#550](https://github.com/LinwoodDev/Butterfly/issues/550))
* Replace file picker package
* Fix back button closes app on mobile ([#551](https://github.com/LinwoodDev/Butterfly/issues/551))
* Fix default color when adding tools
* Fix elements selection will be cleared after unfocusing
* Remove appbar on native title bar in home page

View all changes in the blog: https://linwood.dev/butterfly/2.0.0-rc.3

### 2.0.0-rc.2 (2023-12-15)

* Improve button of display icons ([#549](https://github.com/LinwoodDev/Butterfly/issues/549))
* Improve performance when saving ([#547](https://github.com/LinwoodDev/Butterfly/issues/547))
* Improve mobile add dialog
* Improve selected icons in settings
* Improve consistency of close button ([#550](https://github.com/LinwoodDev/Butterfly/issues/550))
* Rename default locale to system locale
* Fix asset plus button ([#550](https://github.com/LinwoodDev/Butterfly/issues/550))
* Fix calling onScale to tools on moving on touch devices ([#546](https://github.com/LinwoodDev/Butterfly/issues/546))
* Fix exporting documents as png or svg

View all changes in the blog: https://linwood.dev/butterfly/2.0.0-rc.2

### 2.0.0-rc.1 (2023-12-08)

* Add right click as alternative to long press
* Change default scale of label to 5
* Improve documentation of shortcuts ([#534](https://github.com/LinwoodDev/Butterfly/issues/534))
* Fix closing of settings on click on mobile ([#537](https://github.com/LinwoodDev/Butterfly/issues/537))
* Fix zoom usable if hidden ([#538](https://github.com/LinwoodDev/Butterfly/issues/538))
* Fix full screen menu item ([#535](https://github.com/LinwoodDev/Butterfly/issues/535))
* Fix selecting small areas ([#543](https://github.com/LinwoodDev/Butterfly/issues/543))
* Fix areas not refreshing after deleting ([#541](https://github.com/LinwoodDev/Butterfly/issues/541))
* Fix tool not selected when added

View all changes in the blog: https://linwood.dev/butterfly/2.0.0-rc.1

### 2.0.0-rc.0 (2023-12-01)

* Add files action to file navigator
* Add function to disable certain directory in local storage
* Add name to local storage
* Add extra properties for models to implement further import/export features
* Add option to connect to a self-signed server ([#531](https://github.com/LinwoodDev/Butterfly/issues/531))
* Improve web loading experience
* Fix changing current tool when adding in collaboration mode
* Fix remote connection requests

View all changes in the blog: https://linwood.dev/butterfly/2.0.0-rc.0

### 2.0.0-beta.16 (2023-11-24)

* Add experiments settings in nightly version
* Add collaboration support (experimental) using websockets ([#401](https://github.com/LinwoodDev/Butterfly/issues/401))
* Add spread to pages in pdf importer
* Add importer for xopp documents ([#314](https://github.com/LinwoodDev/Butterfly/issues/314))
* Add select tool to document defaults
* Use menu in files navigator view
* Improve performance of canvas
* Remove restriction of bfly files on import in files view
* Restructure settings
* Fix android mimetype
* Fix global importing
* Fix plus button in palette dialog
* Fix note importer
* Fix creating defaults on native
* Remove pointer on cancel

View all changes in the blog: https://linwood.dev/butterfly/2.0.0-beta.16

### 2.0.0-beta.15 (2023-11-17)

* Add templates to data settings
* Add advanced note importer ([#511](https://github.com/LinwoodDev/Butterfly/issues/511))
* Add progress indicator for pdf import
* Add create button on missing span or paragraph style
* Add copy to clipboard to color edit dialog
* Fix icon button if no display icon available
* Fix pointer list on window exit ([#521](https://github.com/LinwoodDev/Butterfly/issues/521))
* Fix saving when changing path
* Fix document importer
* Fix updating ui in presentation toolbar
* Fix moving in presentation state
* Fix toolbar in presentation state
* Fix animation duplicates on rename
* Fix string to color converting
* Remove sync button on local storage
* Remove sync button on files in local storage
* Upgrade to flutter 3.16.0 stable

View all changes in the blog: https://linwood.dev/butterfly/2.0.0-beta.15

### 2.0.0-beta.14 (2023-11-04)

* Add cursor to path eraser
* Add scrollbar to recent files
* Add recent colors to color picker
* Add version to web
* Add eye dropper
* Add copy on click for versions in settings dialog ([#519](https://github.com/LinwoodDev/Butterfly/issues/519))
* Add scaling to markdown and text renderers ([#520](https://github.com/LinwoodDev/Butterfly/issues/520))
* Show remote on hover in recent files
* Improve action buttons in add dialog
* Improve color picker dialog
* Fix invalidation of selection when transforming ([#517](https://github.com/LinwoodDev/Butterfly/issues/517))
* Fix folder creation ([#513](https://github.com/LinwoodDev/Butterfly/issues/513))
* Fix locale spacing
* Fix pack updating
* Fix pdf operations on web
* Fix exporting whole directory ([#523](https://github.com/LinwoodDev/Butterfly/issues/523))
* Set full screen tool to action tool
* Fix saving files in local external directory
* Fixing missing saving of pdf quality and platform theme settings

View all changes in the blog: https://linwood.dev/butterfly/2.0.0-beta.14

### 2.0.0-beta.13 (2023-10-29)

* Allow moving tools when selected
* Readd recent files ([#512](https://github.com/LinwoodDev/Butterfly/issues/512))
* Improve responsiveness in home page
* Improve performance of saving files
* Fix tool indicator alignment if toolbar is in column mode
* Fix moving issues when painting
* Fix painting issues when using gestures

View all changes in the blog: https://linwood.dev/butterfly/2.0.0-beta.13

### 2.0.0-beta.12 (2023-10-27)

* Add local directory connection
* Add zoom shortcuts ([#507](https://github.com/LinwoodDev/Butterfly/issues/507))
* Add moving using trackpad ([#507](https://github.com/LinwoodDev/Butterfly/issues/507))
* Add name to hand tool selection
* Add default template file creation in home page
* Change remote button dropdown to material 3
* Allow more valid file names
* Improve command line argument parsing
* Fix home page header ([#510](https://github.com/LinwoodDev/Butterfly/issues/510))
* Fix offset in scaling multiple elements ([#506](https://github.com/LinwoodDev/Butterfly/issues/506))
* Fix opening animation in zoom view
* Fix broken legacy file migrator
* Fix default template on multiple connections
* Fix expansion panel in add connection dialog

View all changes in the blog: https://linwood.dev/butterfly/2.0.0-beta.12

### 2.0.0-beta.11 (2023-10-20)

* Add print as export option
* Add selected animation to color toolbar
* Use current view as default for pdf export option
* Improve performance of file fetching
* Improve home page header
* Improve slide transition
* Change user data directory for portable apps
* Fix leading icon on exact slider on larger screens
* Remove add connection button on web

View all changes in the blog: https://linwood.dev/butterfly/2.0.0-beta.11

### 2.0.0-beta.10 (2023-10-13)

* Add tooltips to icon buttons
* Improve delete popover in home page
* Change file name when changing document name in the title bar
* Change dropdown in text and paragraph style view to disable if no elements are to be added
* Change the zoom slider to operate in realtime in style view
* Change reload button icon in remote button
* Change name of document when creating create file in files view
* Rename document directory to data directory
* Fix adding template instead of document when clicking create file in files view
* Fix unnessesary baking of canvas on every change ([#503](https://github.com/LinwoodDev/Butterfly/issues/503))
* Fix performance of pen tool
* Fix tool reordering
* Fix pattern background rendering
* Fix baking transform problems if it was changed when baking
* Improve default pattern templates values
* Improve documentation
* Improve file name validator to support -, (, ), comma and space
* Improve open animation in property view
* Switch back to flutter beta

View all changes in the blog: https://linwood.dev/butterfly/2.0.0-beta.10

### 2.0.0-beta.9 (2023-10-06)

* Add classic theme to theme selection
* Add indication for opened menu on top left corner menu
* Change secondary color of classic theme to red
* Use elements changed event for transformation
* Use center tab alignment
* Make spacer tool realtime
* Fix markdown newlines ([#501](https://github.com/LinwoodDev/Butterfly/issues/501))
* Fix home page header on low density
* Update to flutter master (Fix windows issues)
* Unify tabs
* Remove content copy on page creation

View all changes in the blog: https://linwood.dev/butterfly/2.0.0-beta.9

### 2.0.0-beta.8 (2023-09-28)

* Bump file version to 10
  * Move box background properties to own Texture.pattern class
  * Rename box background to pattern background
  * Change page.background to page.backgrounds and allow a list of backgrounds
  * Rename painters to tools
  * Rename hand painter to select tool
  * Rename move painter to hand tool
  * Rename tool to utilities
* Recode event system to include collaboration in the future
* Redesign document properties
* Redesign color operation bottom sheet
* Add texture tool ([#406](https://github.com/LinwoodDev/Butterfly/issues/406))
* Add search to add dialog
* Add mobile context menu ([#410](https://github.com/LinwoodDev/Butterfly/issues/410))
* Add setting to set default pdf quality
* Add texture element ([#406](https://github.com/LinwoodDev/Butterfly/issues/406))
* Add add to pack for selection
* Add svg export for text elements ([#488](https://github.com/LinwoodDev/Butterfly/issues/488))
* Add thumbnail to templates dialog
* Add markdown importing
* Add export functionality to markdown elements
* Add animation to search dialog
* Add scale property to label tool
* Add alpha slider to shape element
* Add delete buttons in pack dialog
* Add size transition to property view
* Add animation for tool change
* Add selected state to utilities button
* Add lasso selection mode to select tool ([#409](https://github.com/LinwoodDev/Butterfly/issues/409))
* Add share to label context menu
* Add animation when changing homepage header
* Add hide ui ([#458](https://github.com/LinwoodDev/Butterfly/issues/458))
* Add ability to teleport to area in search
* Add setting to configure visual density
* Add export to elements context menu
* Add full screen f11 shortcut
* Add play button to add dialog for action tools
* Add tool status to add dialog
* Fallback to first stylesheet if no stylesheet is selected
* Move export button from selection view to context menu
* Replace most dropdown buttons (material 2) with dropdown menus (material 3)
* Improve performance on home page ([#459](https://github.com/LinwoodDev/Butterfly/issues/459))
* Improve clipboard system to include image and svg source as data uri
* Improve export system
* Improve version info in setting if not connected to the internet
* Improve spacing in background dialog
* Improve icon buttons to match material 3
* Improve export menu in area context menu
* Prevent window of closing when there are unsaved changes ([#403](https://github.com/LinwoodDev/Butterfly/issues/403))
* Change file search to not case sensitive
* Change expansion panels in background dialog to tabs
* Change selected icons to fill variant
* Change image and svg export dialog position and size to row
* Fix expansion panel list in corner radius shape, texture property, shapes and constraints view
* Fix bfly mimetype
* Fix property view playing open animation when opening navigator
* Fix colors in svg export
* Fix grid not updating when changing values
* Fix pack dialog version text field
* Fix changing styles of label in selection
* Fix open with for bfly documents on android
* Fix insert first and last tooltip in pages navigator view
* Fix background not changed after page change
* Fix missing localization for switch view
* Fix transforming shape element
* Fix duplication position issues
* Fix template creation message text
* Fix page ordering
* Fix page index when renaming
* Fix packs dialog closes after action
* Fix layer remove button not working
* Fix line shape transforming
* Fix hit calculation on rotation in shape element
* Fix importing of assets
* Fix teleport position of text element in search
* Disable gestures on mouse input
* Remove view options from undo
* Remove reload after clicking on star
* Upgrade to agp 8
* Upgrade to flutter 3.15

* Add macos zip and dmg release builds
* Add linux rpm release build

Please make a backup of your documents before opening them with this version.
This version is not compatible with older versions of Butterfly.

View all changes in the blog: https://linwood.dev/butterfly/2.0.0-beta.8

### 2.0.0-beta.7 (2023-08-18)

* Add pen painter icon customisation ([#467](https://github.com/LinwoodDev/Butterfly/issues/467))
* Add locking for transformation ([#455](https://github.com/LinwoodDev/Butterfly/issues/455))
* Add data directory setting for android ([#482](https://github.com/LinwoodDev/Butterfly/issues/482))
* Add image scale setting ([#454](https://github.com/LinwoodDev/Butterfly/issues/454))
* Add double click to rename ([#452](https://github.com/LinwoodDev/Butterfly/issues/452))
* Add ability to rename waypoint
* Add ability to rename layers from navigator
* Add thumbnail for components ([#474](https://github.com/LinwoodDev/Butterfly/issues/474))
* Add toolbar for stamp painter ([#474](https://github.com/LinwoodDev/Butterfly/issues/474))
* Add components navigator page ([#474](https://github.com/LinwoodDev/Butterfly/issues/474))
* Add scaling functionality for stamp painter ([#474](https://github.com/LinwoodDev/Butterfly/issues/474))
* Add ctrl+a shortcut on all painters to open the hand painter and select all ([#450](https://github.com/LinwoodDev/Butterfly/issues/450))
* Rename Export > Data to Export > Document
* Fix portable linux build
  * Fix script.sh
  * Set executable permission on script.sh and butterfly binary
* Fix deleting pages
* Fix duplicated name on sync mode bottom sheet
* Upgrade to flutter 3.13

View all changes in the blog: https://linwood.dev/butterfly/2.0.0-beta.7

### 2.0.0-beta.6 (2023-08-04)

* Add sort order ([#469](https://github.com/LinwoodDev/Butterfly/issues/469))
* Add move painter ([#473](https://github.com/LinwoodDev/Butterfly/issues/473))
* Save sort state ([#469](https://github.com/LinwoodDev/Butterfly/issues/469))
* Save deleted images in cache
  * Fix pasting images not working ([#465](https://github.com/LinwoodDev/Butterfly/issues/465))
* Add to selected after transformed ([#478](https://github.com/LinwoodDev/Butterfly/issues/478))
* Recode shape painter
  * Add center, 1:1 features ([#476](https://github.com/LinwoodDev/Butterfly/issues/476))
* Improve save state icons
* Improve import painter position
* Improve hit calculation on single point pen elements
* Improve performance of quick start view in home page ([#459](https://github.com/LinwoodDev/Butterfly/issues/459))
* Improve context menu position ([#468](https://github.com/LinwoodDev/Butterfly/issues/468))
* Align source and sort by in home page
* Set position to clicked when pasting ([#468](https://github.com/LinwoodDev/Butterfly/issues/468))
* Fix selection not updated if deleted
* Fix native title bar error on mobile devices
* Fix internet problems on android ([#457](https://github.com/LinwoodDev/Butterfly/issues/457))
* Fix position when pasting elements ([#468](https://github.com/LinwoodDev/Butterfly/issues/468))
* Fix corner hit detection on hand tool when zoomed
* Fix rotation when selecting multiple elements ([#472](https://github.com/LinwoodDev/Butterfly/issues/472))
* Fix ruler moving speed when zoomed ([#480](https://github.com/LinwoodDev/Butterfly/issues/480))
* Fix path selection rect when rotated ([#475](https://github.com/LinwoodDev/Butterfly/issues/475))

View all changes in the blog: https://linwood.dev/butterfly/2.0

### 2.0.0-beta.5 (2023-07-21)

* Add navigation rail to large ui ([#444](https://github.com/LinwoodDev/Butterfly/issues/444))
* Add specific navigator pages to menu in mobile ui ([#442](https://github.com/LinwoodDev/Butterfly/issues/442))
* Add keyboard shortcuts
  * Add ctrl + a to select all to hand painter ([#436](https://github.com/LinwoodDev/Butterfly/issues/436))
  * Add del to delete selected to hand painter ([#435](https://github.com/LinwoodDev/Butterfly/issues/435))
* Add svg icon to asset file type svg
* Add asset painter ([#431](https://github.com/LinwoodDev/Butterfly/issues/431))
* Add clipboard (cut, copy, paste) ([#422](https://github.com/LinwoodDev/Butterfly/issues/422))
* Add transformation functions for markdown renderer
* Fix move transformation on image renderer
* Fix mobile ui
* Fix hand tool corner selection not working on mobile
* Fix waypoints not updating in navigator
* Fix background won't be loaded
* Fix position when scaling elements
* Fix window when native title bar is enabled
* Fix full screen and maximize window ([#449](https://github.com/LinwoodDev/Butterfly/issues/449))
* Fix add asset dialog not working
* Fix baking not working on presentation mode
* Fix painters not updated in selection property view

### 2.0.0-beta.4 (2023-07-14)

* Add custom mouse cursors for painters ([#426](https://github.com/LinwoodDev/Butterfly/issues/426))
* Add spacer painter ([#424](https://github.com/LinwoodDev/Butterfly/issues/424))
* Add full screen painter ([#432](https://github.com/LinwoodDev/Butterfly/issues/432))
* Add move by dragging selection, add rotate button ([#410](https://github.com/LinwoodDev/Butterfly/issues/410))
* Add floating toolbar ([#445](https://github.com/LinwoodDev/Butterfly/issues/445))
* Add settings animation and blur
* Add responsive main view ui
* Recode hand tool to allow realtime transformation
* Improve window title bar
* Fix window does not open with start in fullscreen mode enabled ([#430](https://github.com/LinwoodDev/Butterfly/issues/430))
* Fix resizing with multiple elements ([#434](https://github.com/LinwoodDev/Butterfly/issues/434))
* Fix resizing with rotated elements
* Fix not waiting for creating default templates on native platforms
* Fix native title bar setting not saved
* Fix home page not refreshing
* Fix save indicator on web

### 2.0.0-beta.3 (2023-07-07)

* Add image background ([#419](https://github.com/LinwoodDev/Butterfly/issues/419))
* Add ability to customize position of the toolbar ([#408](https://github.com/LinwoodDev/Butterfly/issues/408))
* Add option to rename page
* Add changing of page after adding a new page
* Add pages button to the toolbar ([#411](https://github.com/LinwoodDev/Butterfly/issues/411))
* Add real fullscreen mode ([#421](https://github.com/LinwoodDev/Butterfly/issues/421))
* Don't ask for name when adding a page (single click) ([#411](https://github.com/LinwoodDev/Butterfly/issues/411))
* Fix many properties (background, animations, ...) missing when opening a document
* Fix name check not allowing spaces, - and _
* Fix zoom enable setting will be ignored
* Fix setting navigation clears page history
* Fix elements can't be moved on import ([#423](https://github.com/LinwoodDev/Butterfly/issues/423))
* Reduce size of title text field
* Reduce size of window buttons
* Remove delete painter. Use the delete button in the properties instead or move the painter to the right of the add button

### 2.0.0-beta.2 (2023-06-30)

* Add label context menu
* Improve document load performance
* Fix export button when loading absolute document
* Fix label toolbar if text is empty
* Fix updating of tool selection
* Fix line breaks in markdown
* Fix core pack styling
* Fix pack exporting
* Fix importing assets from home page
* Fix importing of documents in web
* Fix changing elements multiple times in property view
* Fix missing title in locale bottom sheet
* Fix wrong title in design bottom sheet
* Fix loading non documents with open with ([#417](https://github.com/LinwoodDev/Butterfly/issues/417))

### 2.0.0-beta.1 (2023-06-23)

* Add grid view
* Add editing of label elements
* Add move elements in the z axis ([#396](https://github.com/LinwoodDev/Butterfly/issues/396))
* Add saving indicator ([#402](https://github.com/LinwoodDev/Butterfly/issues/402))
* Add pack remote directory ([#389](https://github.com/LinwoodDev/Butterfly/issues/389))
* Add folder structure to pages ([#398](https://github.com/LinwoodDev/Butterfly/issues/398))
* Add stacktrace to error page
* Use delay on reorder item for painters
* Use delay on files in home page
* Validate file name on creation
* Migrate selection context menu to new menu button widget
* Improve performance
* Fix loading files with file args
* Fix not working spacebar in label
* Fix layer view not updating when layer visibility changes
* Fix page won't be saved if autosave is disabled on page change
* Fix importing of assets
* Fix showing selected settings page in mobile
* Fix flashing navigation bar if not enabled

### 2.0.0-beta.0 (2023-06-12)

* Rebuild area painter handler
  * Areas can now intersect
* Add version to pack metadata
* Add navigator ([#391](https://github.com/LinwoodDev/Butterfly/issues/391))
  * Waypoints view
  * Layers view
  * Pages view
  * Files view
* Add pages
* Add alpha to grid
* Add alpha to label
* Add dynamic height to toolbar
* Add shortcut indication to painters
* Add layers ui
* Add quality to image export dialog
* Add asset service to manage disposing of images
* Add more space for edit toolbar
* Add settings menu item button in top left corner
* Bump file version
  * Painters, export presets and tool are now global instead of page specific and was moved to a info.json file
  * Remove waypoint painter in favor of the navigator
* Migrate more components to material 3
* Rename native window title bar to native title bar
* Fix clearing history after navigating in behavior settings
* Fix moving of elements
* Fix migrating old documents
* Fix exporting documents on android
* Fix offset when selecting painters
* Fix alpha in color toolbar
* Fix creating default templates if directory doesn't exist
* Fix temporary handler
* Fix moving shapes
* Fix default template
* Fix changing color palette in color toolbar
* Fix duplicating core pack because of case sensitivity
* Fix opening of non butterfly files
* Fix position when moving of imported elements
* Fix snapping in grid when zoomed
* Fix label created empty text elements
* Fix backwards compatibility with stamp painter

### 2.0.0-alpha.4 (2023-05-21)

* Add markdown element
* Add modes for label painter
* Add foreground property for painter, markdown and text element
* Add extra file icon ([#374](https://github.com/LinwoodDev/Butterfly/issues/374))
* Include font in assets
* Fix connection title bar
* Fix zoom view showing above the property view
* Fix setting position in property view
* Fix name and description not updating in property view
* Show only window if title bar was set ([#385](https://github.com/LinwoodDev/Butterfly/issues/385))
* Remove tab shortcut to reset the document

### 2.0.0-alpha.3 (2023-05-15)

* Add archive format
* Add thumbnails on documents
* Add ability to open other files than notes from home page
* Add missing painter help pages
* Add popup menu when long pressing on window title bar
* Improve text update in zoom view
* Improve sorting at home page
* Move change document path to appbar
* Fix appearing zoom view and disappearing on focus
* Fix importing of documents
* Disallow saving in json format
* Remove save and load dialog (including load and saving from clipboard)
* Upgrade to flutter 3.10

### 2.0.0-alpha.2 (2023-05-05)

* Add option to change visibility of banner ([#372](https://github.com/LinwoodDev/Butterfly/issues/372))
* Add pt language
* Add nightly text to appbar if nightly version is installed
* Publish butterfly in the snap store
* Use text field in zoom view to change zoom level
* Use the best painter color based on the background color
* Use background on window buttons
* Make laser and text painter zoom dependent
* Fix installation path on windows to 64-bit ([#371](https://github.com/LinwoodDev/Butterfly/issues/371))
* Fix timeline colors
* Fix reload after resizing the window
* Fix reset does not replace templates
* Fix text span creation
* Fix select while zooming
* Fix overflow in settings dialog
* Fixing text replacing problems
* Remove file extension on file move dialog
* Remove settings button in main view

### 2.0.0-alpha.1 (2023-04-14)

* Add button to reset templates if quickstart is empty
* Add option to change shape in add dialog
* Add zoom enabled in personalization settings
* Add delete icon for painters
* Add system to change position of cursor on text by clicking on it
* Add box to text editing
* Add vertical arrow selection in text
* Add option to add core pack to update the current one
* Play at the beginning if the current frame is the last one
* Show path without leading slash in appbar
* Fix home page on smaller screens
* Fix rich text editor in label painter
* Fix DragToMoveArea on native title bar on desktop
* Fix infinite loop if action painter is first painter
* Fix selection system after removing current painter
* Fix file import on mobile devices
* Fix setting horizontal alignment of text
* Fix problems with presentation painter if paused

### 2.0.0-alpha.0 (2023-04-09)

* Add rich text
* Pack changes
  * Add styles to pack
  * Add color palette to pack
    * Improve color toolbar to reflect that color palettes are now saved in the pack
  * Add core pack
* Painter changes
  * Remove eraser element to improve performance (Breaking change)
  * Add waypoint painter
  * Rebuild add dialog
    * Add inserts of assets in add dialog
  * Remove right click menu from hand dialog
  * Rebuild pen renderer
  * Add new properties to pen painter
    * Thinning
    * Smoothing
    * Streamline
  * Move transparency property out of color into an extra slider
  * Rich text
    * Add label toolbar to support rich text
    * Add text cursor
  * Add presentation mode
    * Add animations
    * Add presentation toolbar with timeline
    * Add new mode for running a presentation
  * Replace pixel property in image element with source url as base64 data url
* Tool changes
  * Add check if ruler size is greater than 0
  * Move project settings in tools
* Template changes
  * Templates have now thumbnails
  * Templates will be created in the selected connection
* UI Improvements
  * Add home page
  * Remove open dialog in flavor of the home page
  * Rebuild top corner menu
  * Remove classic, yaru and adwaita theme
  * Use device accent color for default theme
  * Add zoom slider to the main draw page
  * Rename remote translations to connection
  * Replace listtiles in context menus to menuitembuttons
  * Add search at the top to search for text elements, areas and waypoints
  * Title is now smaller aligned in the top left corner to look better
  * Improve title bar to look more material 3 like
* Middle mouse behavior is now move as default
* Rebuild file format and add note for breaking changes
* Remove date format setting, documents have no name by default
* Add new butterfly logo
* Improve web file system
* Improve pdf export
* Restructure basic classes in api project
* Downloads
  * Add start scripts ([#304](https://github.com/LinwoodDev/Butterfly/issues/304))
* Bug fixes
  * Fix unicode characters in file path, fixes ([#336](https://github.com/LinwoodDev/Butterfly/issues/336))
  * Fix after Undo, Hand tool will be selected
  * Fix blank page after entering or exiting area mode
  * Fix global shortcuts

Things that need to be improved:
* Text tool
* Presentation tool
* Packs in general
* File format (there will be an automatic migration)

</details>

## 1.6.1 (2023-01-27)

* Fix new button
* Fix ruler gestures
* Upgrade to flutter 3.7

## 1.6.0 (2022-12-24)

Read the whole 1.6 changelog [here](https://go.linwood.dev/butterfly/1-6).

<details>
 <summary>1.6 Nightly Changelog</summary>

## 1.6.0-rc.1 (2022-12-19)

* Fix precision of offset property view
* Fix permission error in windows setup
* Internal: Use map instead of this is

## 1.6.0-rc.0 (2022-12-16)

* Add themed color for ruler color and areas
* Area painter will now use the grid
* Shape painter will now use the grid
* Laser painter will now use the ruler
* Enable changing rotation of ruler with gesture
* Fix grid to be local to the screen
* Disable text for ruler for now

## 1.6.0-beta.0 (2022-12-09)

* Add tool window
* Add grid
    * The grid can be turned on and off
    * When moving elements, it will snap to the grid
* Add ruler

## 1.6.0-alpha.1 (2022-11-25)

* Add packs to storage and document
* Add packs dialog to top left corner menu
* Add stamp painter
* Add "Add to pack" button to area context menu
* Add action painter indicator
* Update text and icon for generic painter property view
* Fix remove of selection

## 1.6.0-alpha.0 (2022-11-05)

* Add laser painter selection view
* Add data path argument to the command line
* Add new folder button to move dialog
* Add dialog close on text field submit
* Show error if loading document fails
* Improve windows setup
    * Add dialog to decide if the program should be installed for all users or just the current user ([#306](https://github.com/LinwoodDev/Butterfly/issues/306))
    * Add icon for the uninstall window in the windows control panel ([#305](https://github.com/LinwoodDev/Butterfly/issues/305))
* Fix start in full screen on desktop ([#307](https://github.com/LinwoodDev/Butterfly/issues/307))

</details>

## 1.5.0 (2022-10-21)

Read the whole 1.5 changelog at https://go.linwood.dev/butterfly/1-5

<details>
 <summary>1.5 Nightly Changelog</summary>

### 1.5.0-rc.1 (2022-10-19)

* Add painters to default document
* Enable label editing when long pressing on a label
* Fix rect shape hit calculation

### 1.5.0-rc.0 (2022-10-15)

* Add delete button to color view
* Update hit calculator to reflect element exactly (path and shape)
* Update performance of path eraser
* Fix reset button in input controls customization
* Fix line shape transform
* Fix context menu handling on selection in hand painter
* Fix image export

### 1.5.0-beta.2 (2022-10-07)

* Add disabled colors to redo and undo painter
* Update color view
* Move property view to the top right corner
* Fix issues when trying to add undo/redo painters
* Fix opening of exported pdfs and zips
* Fix shortcuts
* Hide move handler
* Remove unused permissions on android

### 1.5.0-beta.1 (2022-09-30)

* Open url externally
* Fix temporary move handler
* Fix import on open dialog

### 1.5.0-beta.0 (2022-09-23)

* Add resize feature to selection
* Use move if painter index is zero
* Fix image open
* Fix empty background
* Remove hit calculator, use function insteads
* Remove temporary painter on creation

### 1.5.0-alpha.2 (2022-09-09)

* Separate behavior settings for each input type
* Add option to change painter using control and number
* Add move functionality if no painter is selected
* Fix start in full screen settings
* Fix grid view in file system dialogs
* Fix missing save of sync mode in settings

### 1.5.0-alpha.1 (2022-09-02)

* Add temporary painter
* Add new painters
  * Hand
  * Undo
  * Redo
* Remove hand, undo, redo buttons from general gui
* Improve UI and UX problems ([#280](https://github.com/LinwoodDev/Butterfly/issues/280))
  * Reset pointer on app hide
  * Add default behavior to not ask for area name
* Add option to load images, pdfs and svgs from open dialog
* Add option to start the app in full screen mode
* Fix gesture issues on area and shape painter
* Fix area change problem
* Fix divider on top right in native title bar mode

### 1.5.0-alpha.0 (2022-08-26)

* Add macos support (Thanks to batuhand)
* Add pdf export support
    * Add export presets
* Add mutli selection option
* Add property view
* Add native file opener for pdf, image and notes
* Add export button to data settings
* Add option to import files from file on pwa
* Improve context menu (add modal background, add new scale animation)
* Fix image import bug
* Use json converters to load/save json (fixes missing type and version info)

</details>

## 1.4.4 (2022-09-16)

* Fix line generation in shape painter
* Fix position and size issues when moving elements
* Fix gesture issues on area and shape painter and area change problem
* Fix sync mode won't be saved
* Reset pointer on app hide, see #280

## 1.4.3 (2022-08-20)

* Move directory on document path change and disable document change on android ([#254](https://github.com/LinwoodDev/Butterfly/issues/254) and [#255](https://github.com/LinwoodDev/Butterfly/issues/255))
* Fix reappearing strokes after delete ([#265](https://github.com/LinwoodDev/Butterfly/issues/265))
* Fix laggy moving ([#266](https://github.com/LinwoodDev/Butterfly/issues/266))
* Fix eraser cursor glitches ([#264](https://github.com/LinwoodDev/Butterfly/issues/264))
* Fix app bar title

## 1.4.2 (2022-08-12)

* Add sync modes
* Add cursor for eraser
* Add oval feature for circle shape
* Improve creation of shape and area when going in negative
* Fix area painter
    * Add name validation
    * Fix size validationa
* Fix undo/redo
* Change text fields to filled in remote create dialog
* Remove duplicated label element in plus popup menu

## 1.4.1 (2022-08-05)

* Add option to change data directory location on android
* Add turkish translation (thanks to ilker besken)
* Add constraint and export option to svg element context menu
* Add support for setting locale in embed mode
* Fix missing svg move indicator
* Fix exporting of image elements
* Fix svg renderer rect
* Fix native window title bar issues
* Fix performance on large documents when trying to open a context menu of an element
* Fix render time on large documents
* Fix slider do not update after changing outside of the slider
* Fix unintential behavior when deleting all elements in a layer
* Fix save button in embed mode

## 1.4.0 (2022-07-26)

Read the whole 1.4 changelog at https://go.linwood.dev/butterfly/1-4

<details>
 <summary>1.4 Nightly Changelog</summary>

### 1.4.0-rc.3 (2022-07-25)

* Add option to change data directory location on android
* Add turkish translation (thanks to ilker besken)
* Add constraint and export option to svg element context menu
* Add support for setting locale in embed mode
* Fix missing svg move indicator
* Fix exporting of image elements
* Fix svg renderer rect
* Fix native window title bar issues
* Fix performance on large documents when trying to open a context menu of an element
* Fix render time on large documents
* Fix slider do not update after changing outside of the slider
* Fix unintential behavior when deleting all elements in a layer
* Fix save button in embed mode

### 1.4.0-rc.3 (2022-07-25)

* Add native window title bar support
* Fix supported locales

### 1.4.0-rc.2 (2022-07-23)

* Add portuguese (Brazil) localization
* Disable updater on web
* Fix file import on remote
* Fix classic light theme
* Fix embedding mode
* Fix error when opening same file

### 1.4.0-rc.1 (2022-07-20)

* Fix save indicator
* Fix error when fetching version
* Fix save button
* Fix drag to move area
* Fix invalid parse of remote path
* Fix bake issues

### 1.4.0-rc.0 (2022-07-17)

* Add stylus button input
* Add hex input to color dialog
* Add constraints to shape painter
* Move save state in current index cubit to allow undo/redo
* Fix bake issues
* Fix wrong properties when resetting back to hand painter
* Fix ignored properties in area painter

### 1.4.0-beta.1 (2022-07-15)

* Add matrix invite link
* Rework multi input system
    * Add input gesture support (move with two fingers [#206](https://github.com/LinwoodDev/Butterfly/issues/206))
* Rework bake system
    * Fix undo/redo lag
    * Fix that you need to click multiple times to undo something
    * Disable buttons if you cannot undo/redo
* Add italian localizatiion
* Fix lag when opening/closing the color view
* Improve default theme to match with the documentation
* Change color of eraser to background color
* Add check to prevent adding duplicated locations to paths
* Remove unused color property in eraser painter

### 1.4.0-beta.0 (2022-07-08)

* Add offline sync
    * Add remote page to control all cached paths
    * Add sync button and dialog to file system dialog to see the status
    * Add sync button controller to all remote assets in file system dialog
    * Add sync background service 
* Switch license to AGPL
* Fixing shape editing dialog for elements
* Fix opening nested context menus

### 1.4.0-alpha.3 (2022-07-01)

* Add updater
* Add shape painter
    * Add rectangle shape
    * Add circle shape
    * Add line shape
* Add yaru and adwaita theme
* Show better display name for themes
* Change area icon
* Disable restart of the app after changing the personalization settings
* Add file extension registry on linux
* Add option to change color in pen context menu
* Add svg element
* Fix icon size in remote button
* Fix error if icon is invalid when adding remote
* Fix export in image element context menu
* Add check to prevent duplicated remote entries
* Change scale to slider in constraints dialog

### 1.4.0-alpha.2 (2022-06-24)

* Add remote storage ([#88](https://github.com/LinwoodDev/Butterfly/issues/88))
    * Add remote settings
    * Add storage option to template and open dialog
    * Specify remote in title
* Add loading indicator to file open dialog
* Exporting on web now downloads the file
* Remove cdns on the web
* Redesign settings with cards
* Fix settings rounded corners

### 1.4.0-alpha.1 (2022-06-20)

* Fix invalid namespace on android

### 1.4.0-alpha.0 (2022-06-17)

* Add laser painter to paint strokes temporarily
* Add duplicate to change document path
* Add color view to label, pen and laser painter
* Add spanish translation
* Add quality slider to pdf ([#184](https://github.com/LinwoodDev/Butterfly/issues/184))
* Add copy to change document path ([#180](https://github.com/LinwoodDev/Butterfly/issues/180))

</details>

## 1.3.2 (2022-06-10)

* Add quality slider to pdf
* Add material palette to default templates
* Fixing area issues
    * Fix bug when area has negative values
    * Fix bug when area is not visible when changing the painter
    * Fix app bar title does not change after exiting the area
* Improve spacing of selection rect based on the zoom
* Move android storage to external
* Center image on moving ([#185](https://github.com/LinwoodDev/Butterfly/issues/185))
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
* Fixing a lot of bugs ([#158](https://github.com/LinwoodDev/Butterfly/issues/158), Thanks to vi)
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

* Add baking of the viewport ([#89](https://github.com/LinwoodDev/Butterfly/issues/89))
* Add templates dialogs and presets
* Add change document path option ([#96](https://github.com/LinwoodDev/Butterfly/issues/96))
* Add insert dialog to add simplification of the user interface
  * Add image insert
  * Add camera insert
* Add sensitive settings ([#91](https://github.com/LinwoodDev/Butterfly/issues/91))
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

* Fix image loading ([#83](https://github.com/LinwoodDev/Butterfly/issues/83))
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
* Add zoom-dependent stroke width ([#31](https://github.com/LinwoodDev/Butterfly/issues/31))
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

* Add file system with files and folders native and indexeddb in web ([#53](https://github.com/LinwoodDev/butterfly/pull/53))
  * Custom save location
  * Added file names
* Add behavior options for multi gestures ([#45](https://github.com/LinwoodDev/butterfly/issues/45))
* Add version to information dialog ([#50](https://github.com/LinwoodDev/butterfly/issues/50))
* Fixing dialogs will open multiple times ([#47](https://github.com/LinwoodDev/butterfly/issues/47))
* Improve performance for images ([#35](https://github.com/LinwoodDev/butterfly/issues/35))

### 1.0.0-rc.3 (2021-11-14)

* Add shortcuts
* Add default name for documents
* Reimplement fill feature
* Fixing zooming
* Fixing version on windows installer

### 1.0.0-rc.2 (2021-11-07)

* Change home page to drawing page ([#17](https://github.com/LinwoodDev/butterfly/issues/17))
* Fixing zoom issues ([#20](https://github.com/LinwoodDev/butterfly/issues/20))
* Simplify selection ([#23](https://github.com/LinwoodDev/butterfly/issues/23))
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
* Fixing empty names in document name ([#14](https://github.com/LinwoodDev/butterfly/issues/14))
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
