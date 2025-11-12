part of '../selection.dart';

class StampToolSelection extends ToolSelection<StampTool> {
  StampToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return [];
    final value = selected.first.component;
    void updateComponent(NamedItem<ButterflyComponent>? component) => update(
      context,
      selected.map((e) => e.copyWith(component: component)).toList(),
    );
    return [
      ...super.buildProperties(context),
      const SizedBox(height: 16),
      ListTile(
        title: Text(AppLocalizations.of(context).component),
        subtitle: value == null
            ? Text(AppLocalizations.of(context).notSet)
            : Text(value.name),
        trailing: IconButton(
          icon: const PhosphorIcon(PhosphorIconsLight.trash),
          onPressed: () => updateComponent(null),
          tooltip: AppLocalizations.of(context).delete,
        ),
      ),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is StampTool) {
      return StampToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
