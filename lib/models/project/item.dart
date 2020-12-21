import 'package:flutter/foundation.dart';

abstract class ProjectItem {
  final String name;
  final String description;

  const ProjectItem({@required this.name, this.description = ""});
}
