part of 'selection.dart';

class Hand {
  const Hand();
}

const kHand = Hand();

class HandSelection extends Selection<Hand> {
  HandSelection(super.selected);

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.hand;

  @override
  buildProperties(BuildContext context) {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return [];
    final property = state.document.handProperty;
    void updateProperty(HandProperty property) {
      context.read<DocumentBloc>().add(HandPropertyChanged(property));
    }

    return [
      CheckboxListTile(
          value: property.includeEraser,
          title: Text(AppLocalizations.of(context)!.includeEraser),
          onChanged: (value) => updateProperty(property.copyWith(
              includeEraser: value ?? property.includeEraser))),
    ];
  }

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.handFill : PhosphorIcons.handLight;

  @override
  List<String> get help => ['painters', 'hand'];
}
