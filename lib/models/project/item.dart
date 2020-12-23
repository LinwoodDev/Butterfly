import 'package:flutter/foundation.dart';

import 'type.dart';

abstract class ProjectItem {
  final String name;
  final String description;

  const ProjectItem({@required this.name, this.description = ""});

  Map<String, dynamic> toJson() => {'name': name, 'description': description};
  static ProjectItem fromJson(Map<String, dynamic> json) => ProjectItemType.values
      .firstWhere((element) => element.toString() == json['type'])
      .fromJson(json);
}
