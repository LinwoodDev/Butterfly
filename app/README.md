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
- l10n
- models
- settings
- views
- visualizer
- widgets
```

* The `actions` directory has all shortcuts that can be used in the app.
* The `api` directory stores useful functions for the app. Some functions are separated between html (web) and io (native platforms).
* The `bloc` directory stores the save system of the app. In the `document_bloc.dart` file, you can see all handlers to the events that are defined in the `document_event.dart` file. The `document_state.dart` file stores all states that the app can have.
* The `cubits` directory stores small save systems that are not necessarily associated with the document.
* The `dialogs` directory stores all dialogs that can be opened in the app. For example the file system dialog or the open dialog.
* The `embed` directory handles all events required for the embedding mode
* The `handlers` directory stores all gesture handlers for the painters.
* The `l10n` directory stores all the strings and translations that are used in the app.
* The `models` directory stores all the models that are used in the app. For example the `Document` model or the painters.
* The `settings` directory stores all the settings pages that are used in the app.
* The `views` directory stores all the views that are used in the main page. For example the appbar, the toolbar or the main view.
* The `visualizer` directory stores all converters between the models and the ui.
* The `widgets` directory stores all general widget that is not specific to the app. For example the `OptionButton` widget.
