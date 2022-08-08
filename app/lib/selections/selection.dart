import 'package:flutter/material.dart';

import '../models/element.dart';
import '../models/painter.dart';

part 'elements/element.dart';
part 'painters/painter.dart';

abstract class Selection<T> {
  final List<T> selected;

  Selection(this.selected);

  List<Widget> buildProperties(BuildContext context);
  bool get showDeleteButton => false;
  void onDelete(BuildContext context);
}
