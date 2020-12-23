import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mdi/mdi.dart';

import 'type.dart';

abstract class ProjectItem {
  String name;
  String description = '';

  ProjectItem({@required this.name, this.description});

  Map<String, dynamic> toJson() => {'name': name, 'description': description};
  static ProjectItem fromJson(Map<String, dynamic> json) => ProjectItemType.values
      .firstWhere((element) => element.toString() == json['type'])
      .fromJson(json);

  IconData get icon => Mdi.helpCircleOutline;
}
