import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/views/toolbar/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ComponentsToolbarView extends StatefulWidget
    implements PreferredSizeWidget {
  final NamedItem<ButterflyComponent>? component;
  final ValueChanged<NamedItem<ButterflyComponent>?> onChanged;

  const ComponentsToolbarView({
    super.key,
    required this.component,
    required this.onChanged,
  });

  @override
  State<ComponentsToolbarView> createState() => _ComponentsToolbarViewState();

  @override
  Size get preferredSize => kToolbarLarge;
}

class _ComponentsToolbarViewState extends State<ComponentsToolbarView> {
  late final PackFileSystem _packSystem;
  final ScrollController _scrollController = ScrollController();
  String? currentPack;
  Future<List<PackItem<ButterflyComponent>>>? _componentsFuture;

  @override
  void initState() {
    super.initState();
    _packSystem = context.read<PackFileSystem>();
    _componentsFuture = _getComponents();
  }

  Future<List<PackItem<ButterflyComponent>>> _getComponents() async {
    final files = await _packSystem.getFiles();
    final packComponents = <PackItem<ButterflyComponent>>[];
    for (final file in files) {
      final pack = file.data!;
      final components = pack
          .getNamedComponents()
          .map((e) => e.toPack(pack, file.pathWithoutLeadingSlash))
          .nonNulls
          .toList();
      packComponents.addAll(components);
    }
    return packComponents;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PackItem<ButterflyComponent>>>(
      future: _componentsFuture,
      builder: (context, snapshot) {
        final allComponents = snapshot.data ?? [];
        final packs = allComponents.map((e) => e.namespace).toSet().toList()
          ..sort((a, b) => a.compareTo(b));
        var pack = currentPack ?? allComponents.firstOrNull?.namespace;
        final components = allComponents
            .where((e) => e.namespace == pack)
            .toList();
        final value = widget.component;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (value != null) ...[
              _ComponentsButton(
                onChanged: () {},
                value: value.item,
                name: value.name,
              ),
              const VerticalDivider(),
            ],
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                child: ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...List.generate(components.length, (index) {
                      final current = components[index];
                      final named = current.toNamed();
                      return _ComponentsButton(
                        value: current.item,
                        name: current.key,
                        selected: value == named,
                        onChanged: () {
                          widget.onChanged(named);
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MenuAnchor(
                builder: defaultMenuButton(
                  tooltip: AppLocalizations.of(context).pack,
                ),
                menuChildren: packs
                    .map(
                      (e) => RadioMenuButton(
                        value: e,
                        groupValue: currentPack,
                        onChanged: (value) =>
                            setState(() => currentPack = value ?? e),
                        child: Text(e),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ComponentsButton extends StatelessWidget {
  final ButterflyComponent value;
  final String? name;
  final bool selected;
  final VoidCallback onChanged;

  const _ComponentsButton({
    required this.value,
    required this.onChanged,
    this.name,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    const fallbackWidget = AspectRatio(
      aspectRatio: 1,
      child: PhosphorIcon(PhosphorIconsLight.selection),
    );
    final thumbnail = value.thumbnail;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onChanged,
        child: Tooltip(
          message: name,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected
                    ? ColorScheme.of(context).primary
                    : Colors.transparent,
                width: 4,
              ),
            ),
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
        ),
      ),
    );
  }
}
