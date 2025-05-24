part of '../selection.dart';

class LabelToolSelection extends ToolSelection<LabelTool> {
  LabelToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return [];
    return [
      ...super.buildProperties(context),
      ColorField(
        value: selected.first.foreground.withValues(a: 255),
        onChanged: (value) => update(
          context,
          selected
              .map(
                (e) => e.copyWith(
                  foreground: value.withValues(a: selected.first.foreground.a),
                ),
              )
              .toList(),
        ),
        title: Text(AppLocalizations.of(context).foreground),
      ),
      ExactSlider(
        header: Text(AppLocalizations.of(context).alpha),
        value: selected.first.foreground.a.toDouble(),
        defaultValue: 255,
        min: 0,
        max: 255,
        fractionDigits: 0,
        onChangeEnd: (value) => update(
          context,
          selected
              .map(
                (e) => e.copyWith(
                  foreground: e.foreground.withValues(a: value.toInt()),
                ),
              )
              .toList(),
        ),
      ),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is LabelTool) {
      return LabelToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
