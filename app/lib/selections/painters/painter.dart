part of '../selection.dart';

class PainterSelection<T extends Painter> extends Selection<T> {
  PainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [];
  }

  @override
  void update(BuildContext context, List<T> selected) {
    final updatedElements = Map<T, T>.fromIterables(this.selected, selected);
    context.read<DocumentBloc>().add(PaintersChanged(updatedElements));
    super.update(context, selected);
  }

  @override
  bool get showDeleteButton => true;

  @override
  void onDelete(BuildContext context) {
    context.read<DocumentBloc>().add(PaintersRemoved(selected));
  }
}
