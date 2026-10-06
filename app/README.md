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

## Android 16 KB page-size checks

After building an APK or App Bundle, run from the repository root:

```bash
dart pub get -C tools
dart run tools/check_android_page_sizes.dart app/build/app/outputs/flutter-apk/app-production-release.apk
dart run tools/check_android_page_sizes.dart app/build/app/outputs/bundle/productionRelease/app-production-release.aab
```

The Dart checker checks every LOAD segment
in every arm64-v8a and x86_64 shared library, including dependency libraries and
App Bundle feature modules. It also checks the ZIP offsets of uncompressed APK
libraries and the bundle's requested native-library alignment. Compressed legacy
APKs still need compatible ELF segments; 32-bit ABIs are exempt from this check.
CI runs this check on universal and split APKs in both packaging modes and on
the Play App Bundle.

## Offline web builds

Build and generate the offline cache from the repository root:

```bash
dart pub get -C tools
cd app
flutter build web --wasm --release --no-web-resources-cdn
cd ..
dart run tools/build_web_service_worker.dart
```

Run the generator after all build files have been written, then deploy all of
`app/build/web` over HTTPS (localhost also works). The deployment workflow does
this for both stable and nightly. It replaces Flutter's cleanup stub at
`flutter_service_worker.js` with Butterfly's own worker. Custom output directories
can be passed as the generator's first argument; subpath hosting uses Flutter's
`--base-href` as usual.

After one online visit and successful cache installation, the app can reload
offline, including deep links, rendering engines, fonts, and bundled import
libraries. Local notes stay in browser storage; remote sync and network imports
still need a connection. The first download caches the entire build, so leave
the app online until the worker activates (visible in browser developer tools).
New builds wait until all app tabs close before activating, preserving open
editing sessions. Serve the worker with revalidation enabled rather than
immutable caching. The worker only caches bundled files, never API responses.

## Rebuilding assets

To rebuild the splash screen use:

```bash
flutter pub run flutter_native_splash:create --path flutter_native_splash-production.yaml
```
