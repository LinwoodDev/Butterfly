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
        value: Color(selected.first.foreground),
        onChanged: (value) => update(context,
            selected.map((e) => e.copyWith(foreground: value.value)).toList()),
        title: Text(AppLocalizations.of(context).foreground),
      ),
      CheckboxListTile(
          title: Text(AppLocalizations.of(context).dynamicContent),
          value: null,
          onChanged: null),
      ExactSlider(
        header: Text(AppLocalizations.of(context).alpha),
        value: Color(selected.first.foreground).alpha.toDouble(),
        defaultValue: 255,
        min: 0,
        max: 255,
        fractionDigits: 0,
        onChangeEnd: (value) => update(
            context,
            selected
                .map((e) => e.copyWith(
                    foreground:
                        Color(e.foreground).withAlpha(value.toInt()).value))
                .toList()),
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