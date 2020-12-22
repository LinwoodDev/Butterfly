import 'package:flutter/foundation.dart';

abstract class ProjectItem {
  final String name;
  final String description;

  const ProjectItem({@required this.name, this.description = ""});

  Map<String, dynamic> toJson() => {'name': name, 'description': description};
  ProjectItem.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'];
}
