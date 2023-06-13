import 'dart:io';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/dialogs/constraints.dart';
import 'package:butterfly/helpers/element_helper.dart';
import 'package:butterfly/helpers/num_helper.dart';
import 'package:butterfly/helpers/offset_helper.dart';
import 'package:butterfly/helpers/point_helper.dart';
import 'package:butterfly/visualizer/painter.dart';
import 'package:butterfly/visualizer/preset.dart';
import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../actions/background.dart';
import '../actions/packs.dart';
import '../api/open.dart';
import '../cubits/transform.dart';
import '../dialogs/layer.dart';
import '../renderers/renderer.dart';
import '../widgets/color_field.dart';

part 'elements/element.dart';
part 'elements/image.dart';
part 'elements/text.dart';
part 'elements/pen.dart';
part 'elements/shape.dart';
part 'elements/svg.dart';

part 'painters/painter.dart';
part 'painters/hand.dart';
part 'painters/area.dart';
part 'painters/eraser.dart';
part 'painters/label.dart';
part 'painters/laser.dart';
part 'painters/layer.dart';
part 'painters/path_eraser.dart';
part 'painters/pen.dart';
part 'painters/shape.dart';
part 'painters/stamp.dart';

part 'properties/property.dart';
part 'properties/path.dart';
part 'properties/pen.dart';

part 'area.dart';
part 'tool.dart';

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
    if (selected is Area) {
      return AreaSelection([selected]) as Selection<T>;
    }
    if (selected is ToolState) {
      return ToolSelection([selected]) as Selection<T>;
    }
    throw UnsupportedError('Unsupported selection type: $T');
  }

  String getLocalizedName(BuildContext context);

  IconGetter get icon;

  List<Widget> buildProperties(BuildContext context) => [];

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

  Selection? remove(T selected) {
    final selections = List.from(this.selected);
    var success = selections.remove(selected);
    if (!success) return this;
    if (selections.isEmpty) return null;
    var selection = Selection.from(selections.first);
    for (int i = 1; i < selections.length; i++) {
      selection = selection.insert(selections[i]);
    }
    return selection;
  }
}
