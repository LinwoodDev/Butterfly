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
}
