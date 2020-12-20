import 'package:flutter/foundation.dart';

abstract class ProjectItem {
  String _name;
  String description;
  static const validFilename = r"^[\w\-. ]+$";

  String get name => _name;
  set name(String value) {
    if (RegExp(validFilename).hasMatch(value)) _name = value;
  }

  ProjectItem({@required String name}) {
    this.name = name;
  }
}
