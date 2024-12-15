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
        value: Color(selected.first.foreground).withAlpha(255),
        onChanged: (value) => update(
            context,
            selected
                .map((e) => e.copyWith(
                    foreground: convertOldColor(
                        // ignore: deprecated_member_use
                        value.value,
                        selected.first.foreground)))
                .toList()),
        title: Text(AppLocalizations.of(context).foreground),
      ),
      ExactSlider(
        header: Text(AppLocalizations.of(context).alpha),
        // ignore: deprecated_member_use
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
                        // ignore: deprecated_member_use
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
