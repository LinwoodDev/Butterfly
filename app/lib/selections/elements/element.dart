part of '../selection.dart';

class ElementSelection<T extends PadElement> extends Selection<T> {
  ElementSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [];
  }

  @override
  void update(BuildContext context, List<T> selected) {
    final updatedElements = Map<T, T>.fromIterables(this.selected, selected);
    context.read<DocumentBloc>().add(ElementsChanged(updatedElements));
    super.update(context, selected);
  }

  @override
  bool get showDeleteButton => true;

  @override
  void onDelete(BuildContext context) {
    context.read<DocumentBloc>().add(ElementsRemoved(selected));
  }
}
