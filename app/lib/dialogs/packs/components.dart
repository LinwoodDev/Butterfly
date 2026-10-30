import 'package:butterfly/api/file_system.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'widgets.dart';

class ComponentsPackView extends StatelessWidget {
  final NoteData value;
  final ValueChanged<NoteData> onChanged;

  const ComponentsPackView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final names = value.getComponents().toList();
    return PackAssetList(
      icon: PhosphorIconsLight.puzzlePiece,
      children: names.map((name) {
        final thumbnail = value.getComponent(name)?.thumbnail;
        return Dismissible(
          key: ValueKey(name),
          onDismissed: (_) => onChanged(value.removeComponent(name)),
          child: ListTile(
            leading: thumbnail == null
                ? const PhosphorIcon(PhosphorIconsLight.puzzlePiece)
                : SizedBox.square(
                    dimension: 48,
                    child: Image.memory(
                      thumbnail,
                      fit: .contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const PhosphorIcon(PhosphorIconsLight.puzzlePiece),
                    ),
                  ),
            title: Text(name),
            onTap: () async {
              final component = value.getComponent(name);
              if (component == null) return;
              final result = await showDialog<String>(
                context: context,
                builder: (ctx) => NameDialog(
                  value: name,
                  validator: defaultFileNameValidator(
                    context,
                    names.where((other) => other != name).toList(),
                  ),
                ),
              );
              if (result == null || result.isEmpty || result == name) return;
              onChanged(
                value.removeComponent(name).setComponent(result, component),
              );
            },
            trailing: IconButton(
              icon: const PhosphorIcon(PhosphorIconsLight.trash),
              tooltip: AppLocalizations.of(context).delete,
              onPressed: () => onChanged(value.removeComponent(name)),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class ComponentCard extends StatelessWidget {
  final ButterflyComponent component;
  final bool selected;
  final String name;
  final VoidCallback onTap;

  const ComponentCard({
    required this.component,
    required this.selected,
    required this.onTap,
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const fallbackWidget = AspectRatio(
      aspectRatio: 1,
      child: PhosphorIcon(PhosphorIconsLight.selection),
    );
    final thumbnail = component.thumbnail;
    return Card(
      clipBehavior: .antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 150,
          width: 150,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              color: selected
                  ? ColorScheme.of(context).primary
                  : Colors.transparent,
              width: 4,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: thumbnail == null
                    ? fallbackWidget
                    : Image.memory(
                        thumbnail,
                        width: 48,
                        height: 48,
                        fit: .contain,
                        errorBuilder: (context, error, stackTrace) =>
                            fallbackWidget,
                      ),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: TextTheme.of(context).titleMedium,
                textAlign: .center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectComponentDialog extends StatefulWidget {
  const SelectComponentDialog({super.key});

  @override
  State<SelectComponentDialog> createState() => _SelectComponentDialogState();
}

class _SelectComponentDialogState extends State<SelectComponentDialog> {
  late final PackFileSystem _packSystem;
  Future<List<(String, ButterflyComponent)>>? _componentsFuture;

  @override
  void initState() {
    super.initState();
    _packSystem = context.read<ButterflyFileSystem>().buildDefaultPackSystem();
    _componentsFuture = _getComponents();
  }

  Future<List<(String, ButterflyComponent)>> _getComponents() async {
    final files = await _packSystem.getFiles();
    final packComponents = <(String, ButterflyComponent)>[];
    for (final file in files) {
      final pack = file.data!;
      final components = pack
          .getComponents()
          .map((e) {
            final component = pack.getComponent(e);
            if (component == null) return null;
            return (e, component);
          })
          .nonNulls
          .toList();
      packComponents.addAll(components);
    }
    return packComponents;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).selectComponent),
      content: FutureBuilder<List<(String, ButterflyComponent)>>(
        future: _componentsFuture,
        builder: (context, snapshot) {
          final allComponents =
              snapshot.data ?? <(String, ButterflyComponent)>[];
          return ListView(
            shrinkWrap: true,
            children: allComponents
                .map(
                  (e) => ComponentCard(
                    component: e.$2,
                    name: e.$1,
                    selected: false,
                    onTap: () {
                      Navigator.of(context).pop(e.$2);
                    },
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
