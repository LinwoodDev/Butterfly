import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/dialogs/constraints.dart';
import 'package:butterfly/dialogs/texture.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:butterfly/visualizer/tool.dart';
import 'package:butterfly/visualizer/preset.dart';
import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../cubits/transform.dart';
import '../renderers/renderer.dart';
import '../widgets/color_field.dart';

part 'elements/element.dart';
part 'elements/image.dart';
part 'elements/text.dart';
part 'elements/pen.dart';
part 'elements/polygon.dart';
part 'elements/shape.dart';
part 'elements/svg.dart';

part 'tools/barcode.dart';
part 'tools/tool.dart';
part 'tools/hand.dart';
part 'tools/area.dart';
part 'tools/eraser.dart';
part 'tools/grid.dart';
part 'tools/label.dart';
part 'tools/laser.dart';
part 'tools/path_eraser.dart';
part 'tools/pen.dart';
part 'tools/polygon.dart';
part 'tools/ruler.dart';
part 'tools/shape.dart';
part 'tools/stamp.dart';
part 'tools/texture.dart';

part 'properties/property.dart';
part 'properties/pen.dart';
part 'properties/polygon.dart';

part 'area.dart';
part 'document.dart';

abstract class Selection<T> {
  List<T> _selected;

  List<T> get selected => List.unmodifiable(_selected);

  Selection(this._selected);

  factory Selection.from(T selected) {
    if (selected is Renderer<PadElement>) {
      return ElementSelection<PadElement>.from(selected) as Selection<T>;
    }
    if (selected is Tool) {
      return ToolSelection<Tool>.from(selected) as Selection<T>;
    }
    if (selected is Area) {
      return AreaSelection([selected]) as Selection<T>;
    }
    if (selected is CurrentIndexCubit) {
      return DocumentSelection(selected) as Selection<T>;
    }
    throw UnsupportedError('Unsupported selection type: $T');
  }

  static Selection? fromList(List? selected) {
    if (selected == null || selected.isEmpty) {
      return null;
    }
    var current = Selection.from(selected.first);
    for (final element in selected.sublist(1)) {
      current = current.insert(element);
    }
    return current;
  }

  String getLocalizedName(BuildContext context);

  bool isNameEditable(BuildContext context) => false;

  void setName(BuildContext context, String name) {}

  String getLocalizedCaption(BuildContext context) => '';

  IconGetter get icon;

  List<Widget> buildProperties(BuildContext context) => [];

  @mustCallSuper
  void update(BuildContext context, List<T> selected) {
    selected = selected;
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

  Selection? remove(dynamic selected) {
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

  String nameFormatter(BuildContext context, String name) => name;
}
