import 'dart:io';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/constraints.dart';
import 'package:butterfly/models/property.dart';
import 'package:butterfly/visualizer/property.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../api/open.dart';
import '../models/area.dart';
import '../models/element.dart';
import '../models/painter.dart';
import '../renderers/renderer.dart';
import '../widgets/color_field.dart';
import '../widgets/exact_slider.dart';

part 'elements/element.dart';
part 'elements/image.dart';
part 'elements/label.dart';
part 'elements/pen.dart';
part 'elements/shape.dart';
part 'elements/svg.dart';

part 'painters/painter.dart';
part 'painters/area.dart';
part 'painters/eraser.dart';
part 'painters/label.dart';
part 'painters/layer.dart';
part 'painters/path_eraser.dart';
part 'painters/pen.dart';
part 'painters/shape.dart';

part 'area.dart';
part 'hand.dart';

abstract class Selection<T> {
  final List<T> selected;

  Selection(this.selected);

  factory Selection.from(T selected) {
    if (selected is Renderer<PadElement>) {
      return ElementSelection<PadElement>.from(selected) as Selection<T>;
    }
    if (selected is Painter) {
      return PainterSelection<Painter>.from(selected) as Selection<T>;
    }
    if (selected is Hand) {
      return HandSelection([selected]) as Selection<T>;
    }
    if (selected is Area) {
      return AreaSelection([selected]) as Selection<T>;
    }
    throw UnsupportedError('Unsupported selection type: $T');
  }

  String getLocalizedName(BuildContext context);
  IconData getIcon({bool filled = false});

  List<Widget> buildProperties(BuildContext context) => [];

  List<Rect> get rects => [];

  @mustCallSuper
  void update(BuildContext context, List<T> selected) {
    this.selected.clear();
    this.selected.addAll(selected);
  }

  bool get showDeleteButton => false;
  void onDelete(BuildContext context) {}
  Selection insert(dynamic element) {
    if (element is T) {
      return Selection.from([...selected, element]);
    }
    return Selection.from(element);
  }

  List<String> get help => <String>[];

  Selection remove(T selected) {
    this.selected.remove(selected);
    return this;
  }
}
