import 'package:butterfly/api/file_system.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
    return ListView(
      children: [
        const SizedBox(height: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: value
              .getComponents()
              .map(
                (e) => Dismissible(
                  key: ValueKey(e),
                  onDismissed: (direction) {
                    onChanged(value.removeComponent(e));
                  },
                  child: ListTile(
                    title: Text(e),
                    trailing: IconButton(
                      icon: const PhosphorIcon(PhosphorIconsLight.trash),
                      onPressed: () async {
                        onChanged(value.removeComponent(e));
                      },
                      tooltip: AppLocalizations.of(context).delete,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
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
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 150,
          width: 150,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
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
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            fallbackWidget,
                      ),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: TextTheme.of(context).titleMedium,
                textAlign: TextAlign.center,
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
