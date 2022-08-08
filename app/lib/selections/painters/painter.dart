part of '../selection.dart';

abstract class PainterSelection<T extends Painter> extends Selection<T> {
  PainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [];
  }
}
