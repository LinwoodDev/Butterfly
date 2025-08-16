import 'dart:ui' as ui;

import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/widgets/color_field.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

@immutable
class PageDialogCallback {
  final List<int> pages;
  final bool spreadToPages, createAreas, invert;
  final SRGBColor background;

  const PageDialogCallback(
    this.pages,
    this.spreadToPages,
    this.createAreas,
    this.background,
    this.invert,
  );
}

class PagesDialog extends StatefulWidget {
  final List<ui.Image> pages;
  const PagesDialog({super.key, required this.pages});

  @override
  State<PagesDialog> createState() => _PagesDialogState();
}

class _PagesDialogState extends State<PagesDialog> {
  List<int> _selected = const [];
  bool _spreadToPages = false, _createAreas = true, _invert = false;
  SRGBColor _background = BasicColors.whiteTransparent;

  @override
  void initState() {
    super.initState();
    _selected = List.generate(widget.pages.length, (i) => i);
    final settings = context.read<SettingsCubit>().state;
    _spreadToPages = settings.spreadPages;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Header(
              title: Text(
                AppLocalizations.of(context).countPages(_selected.length),
              ),
              actions: [
                IconButton(
                  tooltip: AppLocalizations.of(context).invertSelection,
                  icon: const PhosphorIcon(PhosphorIconsLight.selectionInverse),
                  onPressed: () {
                    setState(() {
                      // Remove all selected pages and add all other pages.
                      _selected = List.generate(
                        widget.pages.length,
                        (i) => i,
                      ).toSet().difference(_selected.toSet()).toList();
                    });
                  },
                ),
              ],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.pages.length,
                    itemBuilder: (context, index) {
                      // Show border for selected pages
                      final border = _selected.contains(index)
                          ? Border.all(
                              width: 4,
                              color: Theme.of(context).primaryColor,
                            )
                          : null;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selected = _selected.contains(index)
                                ? _selected.where((e) => e != index).toList()
                                : [..._selected, index];
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: border,
                            color: _background.toColor(),
                          ),
                          child: RawImage(
                            image: widget.pages[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SwitchListTile(
              value: _createAreas,
              onChanged: (value) => setState(() => _createAreas = value),
              title: Text(AppLocalizations.of(context).createAreas),
            ),
            SwitchListTile(
              value: _spreadToPages,
              onChanged: (value) => setState(() => _spreadToPages = value),
              title: Text(AppLocalizations.of(context).spreadToPages),
            ),
            ColorField(
              value: _background.withValues(a: 255),
              custom: true,
              onChanged: (value) => setState(() {
                _background = value.withValues(a: _background.a);
              }),
              title: Text(AppLocalizations.of(context).background),
            ),
            ExactSlider(
              value: _background.a.toDouble(),
              header: Text(AppLocalizations.of(context).alpha),
              fractionDigits: 0,
              max: 255,
              min: 0,
              defaultValue: 255,
              onChangeEnd: (value) => setState(() {
                _background = _background.withValues(a: value.toInt());
              }),
            ),
            SwitchListTile(
              value: _invert,
              onChanged: (value) => setState(() => _invert = value),
              title: Text(AppLocalizations.of(context).invert),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      MaterialLocalizations.of(context).cancelButtonLabel,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  ElevatedButton(
                    child: Text(
                      MaterialLocalizations.of(context).okButtonLabel,
                    ),
                    onPressed: () => Navigator.of(context).pop(
                      PageDialogCallback(
                        _selected,
                        _spreadToPages,
                        _createAreas,
                        _background,
                        _invert,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
