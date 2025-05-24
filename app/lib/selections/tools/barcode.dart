part of '../selection.dart';

class BarcodeToolSelection extends ToolSelection<BarcodeTool> {
  BarcodeToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return [
      ...super.buildProperties(context),
      ListTile(
        title: Text(loc.barcodeType),
        trailing: DropdownMenu<BarcodeType>(
          initialSelection: selected.first.barcodeType,
          dropdownMenuEntries: BarcodeType.values
              .map(
                (e) => DropdownMenuEntry(
                  label: e.getLocalizedName(context),
                  leadingIcon: Icon(e.icon(PhosphorIconsStyle.light)),
                  value: e,
                ),
              )
              .toList(),
          onSelected: (value) {
            if (value != null) {
              update(
                context,
                selected.map((e) => e.copyWith(barcodeType: value)).toList(),
              );
            }
          },
        ),
      ),
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
