part of '../selection.dart';

class EraserPropertySelection extends PathPropertySelection<EraserProperty> {
  EraserPropertySelection();

  @override
  List<Widget> build(
    BuildContext context,
    EraserProperty property,
    ValueChanged<EraserProperty> onChanged,
  ) =>
      [
        ...super.build(context, property, onChanged),
      ];
}
