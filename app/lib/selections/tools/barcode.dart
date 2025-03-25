part of '../selection.dart';

class BarcodeToolSelection extends ToolSelection<BarcodeTool> {
  BarcodeToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [
      ...super.buildProperties(context),
      ColorField(
        value: selected.first.color,
        onChanged: (value) => update(
          context,
          selected.map((e) => e.copyWith(color: value)).toList(),
        ),
        title: Text(LeapLocalizations.of(context).color),
      ),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is BarcodeTool) {
      return BarcodeToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
