part of '../selection.dart';

abstract class ElementSelection<T extends PadElement> extends Selection<T> {
  ElementSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [];
  }
}
