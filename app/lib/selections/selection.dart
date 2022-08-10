import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/models/property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../models/element.dart';
import '../models/painter.dart';
import '../renderers/renderer.dart';
import '../widgets/color_field.dart';
import '../widgets/exact_slider.dart';

part 'elements/element.dart';

part 'painters/painter.dart';
part 'painters/pen.dart';
part 'painters/label.dart';

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
}
