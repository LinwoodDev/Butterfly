import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/element.dart';
import '../models/painter.dart';

part 'elements/element.dart';
part 'painters/painter.dart';

abstract class Selection<T> {
  final List<T> selected;

  Selection(this.selected);

  List<Widget> buildProperties(BuildContext context);

  @mustCallSuper
  void update(BuildContext context, List<T> selected) {
    this.selected.clear();
    this.selected.addAll(selected);
  }

  bool get showDeleteButton => false;
  void onDelete(BuildContext context) {}
}
