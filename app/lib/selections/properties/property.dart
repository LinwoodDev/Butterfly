part of '../selection.dart';

abstract class PropertySelection<T> {
  List<Widget> build(
    BuildContext context,
    T property,
    ValueChanged<T> onChanged,
  );
}
