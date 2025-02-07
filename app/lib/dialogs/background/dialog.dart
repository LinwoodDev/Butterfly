import 'dart:ui' as ui;

import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/texture.dart';
import 'package:butterfly/visualizer/preset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

part 'general.dart';
part 'properties/texture.dart';
part 'properties/image.dart';
part 'properties/svg.dart';

class BackgroundDialog extends StatefulWidget {
  const BackgroundDialog({super.key});

  @override
  State<BackgroundDialog> createState() => _BackgroundDialogState();
}

class _BackgroundDialogState extends State<BackgroundDialog> {
  final List<Background> _backgrounds = [];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoaded) return;
    _backgrounds.addAll(state.page.backgrounds);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final background = _backgrounds.elementAtOrNull(_index);
    final content = switch (background) {
      TextureBackground() => _TextureBackgroundPropertiesView(
          value: background,
          onChanged: (value) => setState(() => _backgrounds[_index] = value)),
      ImageBackground() => _ImageBackgroundPropertiesView(
          value: background,
          onChanged: (value) => setState(() => _backgrounds[_index] = value)),
      SvgBackground() => _SvgBackgroundPropertiesView(
          value: background,
          onChanged: (value) => setState(() => _backgrounds[_index] = value)),
      Null() => _GeneralBackgroundPropertiesView(
          onChanged: (value) => setState(() {
            _index = _backgrounds.length;
            _backgrounds.add(value);
          }),
        ),
    };
    return ResponsiveAlertDialog(
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
      title: Text(AppLocalizations.of(context).background),
      leading: const PhosphorIcon(PhosphorIconsLight.image),
      headerActions: [
        IconButton(
          tooltip: AppLocalizations.of(context).help,
          icon: const PhosphorIcon(PhosphorIconsLight.sealQuestion),
          onPressed: () => openHelp(['background']),
        ),
      ],
      content: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DefaultTabController(
                  length: _backgrounds.length + 1,
                  initialIndex: _index,
                  child: TabBar(
                    tabAlignment: TabAlignment.startOffset,
                    isScrollable: true,
                    onTap: (i) => setState(() => _index = i),
                    tabs: [
                      ..._backgrounds.map((e) => HorizontalTab(
                          label: Text(switch (e) {
                            TextureBackground() => loc.texture,
                            ImageBackground() => loc.image,
                            SvgBackground() => loc.svg,
                          }),
                          icon: Icon(switch (e) {
                            TextureBackground() => PhosphorIconsLight.gridFour,
                            ImageBackground() => PhosphorIconsLight.image,
                            SvgBackground() => PhosphorIconsLight.fileSvg,
                          }))),
                      HorizontalTab(
                        label: Text(AppLocalizations.of(context).add),
                        icon: Icon(PhosphorIconsLight.plus),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              IconButton(
                icon: Icon(PhosphorIconsLight.trash),
                onPressed: _index >= 0 && _index < _backgrounds.length
                    ? () => setState(() {
                          _backgrounds.removeAt(_index);
                          _index--;
                        })
                    : null,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(child: content),
        ],
      ),
      actions: [
        TextButton(
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text(AppLocalizations.of(context).save),
          onPressed: () {
            context
                .read<DocumentBloc>()
                .add(DocumentBackgroundsChanged(_backgrounds));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
