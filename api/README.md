# Butterfly API

Read more [here](../README.md)

This library is meant to be used to interact with the Butterfly app or its files. It is written in Dart and can be used in any Dart project.

## Project structure

The code for this library is stored in the `lib` directory.

```markdown
lib/src
- converter
- helpers
- models
- protocol

lib
- butterfly_api.dart
- butterfly_helpers.dart
- butterfly_models.dart
- butterfly_protocol.dart
- butterfly_text.dart
```

* The `converter` directory stores all converters that converts file formats like xopp and older versions of Butterfly files to the new Butterfly file format.
* The `helpers` directory stores all helper functions (extensions) that simplify the usage of base classes, like strings and points.
* The `models` directory is the main part of this library. It stores all models that are used in the app. The base class of all Butterfly files is the `NoteData` class inside the `data.dart` file.
* The `protocol` directory stores all events and messages that are used in the app. The `event.dart` file stores all events that can be sent to the app. This can be used to interact with the collaboration feature of Butterfly.

For all directories, there is a specific file that exports all files in the directory. For example, the `butterfly_models.dart` file exports all files in the `models` directory. The special `butterfly_text.dart` file only exports the text models.
The `butterfly_api.dart` file exports all files in the `src` directory.
