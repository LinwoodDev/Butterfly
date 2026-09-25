# Butterfly App

Read more [here](../README.md)

## Technology

This app was build using flutter.
Read more about [here](https://flutter.dev).
For generating the \*.g.dart and \*.freezed.dart files use the `flutter pub run build_runner build` command.

## Structure

The code for this app is stored in the `lib` directory.

```markdown
lib
- actions
- api
- bloc
- cubits
- dialogs
- embed
- handlers
- helpers
- l10n
- models
- selections
- services
- settings
- views
- visualizer
- widgets
- main.dart
- setup_web.dart
- setup.dart
- theme.dart
- view_painter.dart
```

* The `actions` directory has all shortcuts that can be used in the app.
* The `api` directory stores useful functions for the app. Some functions are separated between html (web) and io (native platforms).
* The `bloc` directory stores the save system of the app. In the `document_bloc.dart` file, you can see all handlers to the events that are defined in the `api/protocol/event.dart` file. The `document_state.dart` file stores all states that the app can have.
* The `cubits` directory stores small state systems that are not necessarily associated with the document. Here you also find the position and settings states.
* The `dialogs` directory stores all ui for the dialogs that can be opened in the app. For example the file system dialog or the open dialog.
* The `embed` directory handles all events required for the embedding mode.
* The `handlers` directory stores all gesture handlers for the tools. Here it is defined that for example the `PenTool` creates a `PenElement` when the user starts drawing.
* The `helpers` directory stores all helper functions (extensions) that simplify the usage of base classes, like the `Rect` class.
* The `l10n` directory stores all the strings and translations that are used in the app. Please only edit the `app_en.arb` file, the other files gets updated by Crowdin.
* The `models` directory stores all app specific models that are not general to be added in the `api` directory.
* The `selections` directory defines the ui for all elements and tools if they are selected.
* The `services` directory defines all services that runs in the background while using the app.
* The `settings` directory stores all the settings pages ui that are used in the app.
* The `views` directory stores all the ui views that are used in the document page. For example the appbar, the toolbar or the main view.
* The `visualizer` directory are helper methods that stores all converters between the models and the ui.
* The `widgets` directory stores all general widget that can be reused inside the app. For example the context menu.
* The `main.dart` file is the entry point of the app. Here the app is started and starts all other files. Here the routes are defined and the app is initialized.
* The `setup_web.dart` file is used to define the web specific settings. Here the context menu gets disabled.
* The `setup.dart` file is used to define the general settings. Here the licenses is defined.
* The `theme.dart` file is used to define the general theme of the app. Here the colors and the text styles are defined of the classic theme and all themes gets fetched from here.

## Home screen widgets

On Android, add **Butterfly note preview** or **Butterfly recent files** from
the launcher widget picker. Adding the preview opens Butterfly's file browser
to select the document shown in that widget. On Android 12 and newer, the
recent-files widget starts without setup and shows a scrollable list that uses
the widget's available height. Tapping a preview or recent file opens it in
Butterfly. The `+` shortcut creates a document with Butterfly's default
template. Long-press the widget and choose **Reconfigure** to select another
template or return to the default.

To add a standalone **New note** launcher shortcut, choose Butterfly from the
launcher's shortcut picker and select a template. Tapping that icon creates a
document with the selected template. It is a launcher shortcut, not a widget.

The widgets refresh from Butterfly's recent history and saved document
thumbnails when the app opens or its history changes. They do not add controls
to the app's home page.

## File manager previews

Windows Explorer can show `.bfly` and `.tbfly` thumbnails and Preview Pane
images after installation with the setup program or MSIX package. Debian and
RPM packages install a freedesktop thumbnailer for file managers that support
that specification. Both integrations extract the PNG already saved in the note,
including when a `.bfly` ZIP entry is compressed. Notes without a saved
thumbnail, encrypted notes, and unreadable files retain their normal file icon.
The native thumbnail helper uses Butterfly's existing Dart `archive` and `image`
packages; no additional ZIP library is bundled.

## Rebuilding assets

To rebuild the splash screen use:

```bash
flutter pub run flutter_native_splash:create --path flutter_native_splash-production.yaml
```
