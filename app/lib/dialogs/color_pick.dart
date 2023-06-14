import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'delete.dart';
import 'packs/select.dart';

class ColorPalettePickerDialog extends StatefulWidget {
  final bool viewMode;
  final Color value;
  final ColorPalette? palette;
  final ValueChanged<ColorPalette>? onChanged;
  final DocumentBloc? bloc;

  const ColorPalettePickerDialog({
    super.key,
    this.value = Colors.white,
    this.viewMode = false,
    this.bloc,
    this.palette,
    this.onChanged,
  });

  @override
  _ColorPalettePickerDialogState createState() =>
      _ColorPalettePickerDialogState();
}

class _ColorPalettePickerDialogState extends State<ColorPalettePickerDialog> {
  PackAssetLocation? _selected;
  ColorPalette? _palette;

  @override
  void initState() {
    super.initState();
    _palette = widget.palette;
    if (widget.bloc != null) {
      final state = widget.bloc!.state;
      if (state is DocumentLoaded) {
        final packName = state.data.getPacks().firstOrNull;
        final pack = packName == null ? null : state.data.getPack(packName);
        final palette = pack?.getPalettes().firstOrNull;
        if (palette != null) {
          _selected = PackAssetLocation(pack: packName!, name: palette);
        }
      }
    }
  }

  ColorPalette? _getPalette() {
    if (_palette != null) return _palette;
    if (_selected == null) return null;
    final state = widget.bloc?.state;
    if (state is! DocumentLoaded) return null;
    return state.data.getPack(_selected!.pack)?.getPalette(_selected!.name);
  }

  void _changePalette(ColorPalette palette) {
    if (widget.onChanged != null) {
      widget.onChanged!(palette);
      setState(() {
        _palette = palette;
      });
    } else {
      final state = widget.bloc?.state;
      if (state is! DocumentLoaded) return;
      final pack =
          _selected == null ? null : state.data.getPack(_selected!.name);
      if (pack == null) return;
      pack.setPalette(palette);
      widget.bloc?.add(PackUpdated(pack.name!, pack));
    }
  }

  void _showColorOperation(int index) {
    showModalBottomSheet(
        context: context,
        constraints: const BoxConstraints(maxWidth: 640),
        builder: (ctx) {
          final palette = _getPalette();
          if (palette == null) return Container();
          if ((palette.colors.length) <= index) return Container();
          final color = palette.colors[index];
          return SizedBox(
              height: 300,
              child: Column(children: [
                SizedBox(
                  height: 125,
                  child: Center(
                      child: Container(
                          color: Color(color), height: 75, width: 75)),
                ),
                const Divider(thickness: 1),
                Expanded(
                    child: ListView(children: [
                  ListTile(
                      leading: const PhosphorIcon(PhosphorIconsLight.pen),
                      title: Text(AppLocalizations.of(context).edit),
                      onTap: () async {
                        final value = await showDialog<ColorPickerResponse>(
                            context: context,
                            builder: (context) =>
                                ColorPicker(value: Color(color)));
                        if (value != null) {
                          _changePalette(palette.copyWith(
                              colors: List.from(palette.colors)
                                ..[index] = value.color));
                        }
                      }),
                  ListTile(
                    leading: const PhosphorIcon(PhosphorIconsLight.trash),
                    title: Text(AppLocalizations.of(context).delete),
                    onTap: () async {
                      final result = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => const DeleteDialog());
                      if (result != true) return;
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        _changePalette(palette.copyWith(
                            colors: List.from(palette.colors)
                              ..removeAt(index)));
                      }
                    },
                  )
                ]))
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    final palette = _getPalette();
    return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Material(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LayoutBuilder(builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth: constraints.maxWidth),
                                child: Row(
                                  children: [
                                    if (widget.palette == null) ...[
                                      IconButton(
                                        onPressed: () async {
                                          final state = widget.bloc?.state;
                                          if (state is! DocumentLoaded) {
                                            return;
                                          }
                                          final result = await showDialog<
                                              PackAssetLocation?>(
                                            context: context,
                                            builder: (context) =>
                                                BlocProvider.value(
                                              value: widget.bloc!,
                                              child: SelectPackAssetDialog(
                                                selected: _selected,
                                                type: PackAssetType.palette,
                                              ),
                                            ),
                                          );
                                          if (result == null) return;
                                          setState(() {
                                            _selected = result;
                                          });
                                        },
                                        icon: const PhosphorIcon(
                                            PhosphorIconsLight.package),
                                      )
                                    ] else
                                      Expanded(
                                        child: TextFormField(
                                          initialValue: _palette?.name,
                                          decoration: InputDecoration(
                                            labelText:
                                                AppLocalizations.of(context)
                                                    .name,
                                            filled: true,
                                          ),
                                          onChanged: (value) {
                                            _changePalette(_palette!
                                                .copyWith(name: value));
                                          },
                                        ),
                                      ),
                                  ],
                                )),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Wrap(alignment: WrapAlignment.start, children: [
                        ...(List.generate(
                            palette?.colors.length ?? 0,
                            (index) => InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(32)),
                                onLongPress: () => _showColorOperation(index),
                                onTap: () => Navigator.of(context)
                                    .pop(palette.colors[index]),
                                child: Container(
                                  width: 75,
                                  height: 75,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Color(palette!.colors[index]),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(32))),
                                )))).toList(),
                        if (palette != null)
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Material(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.5),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32))),
                              child: InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(32)),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(1322))),
                                  width: 75,
                                  height: 75,
                                  child: const Center(
                                      child: PhosphorIcon(
                                          PhosphorIconsLight.plus,
                                          size: 42)),
                                ),
                                onTap: () async {
                                  var value =
                                      await showDialog<ColorPickerResponse>(
                                          context: context,
                                          builder: (context) =>
                                              ColorPicker(value: widget.value));
                                  if (value != null) {
                                    _changePalette(palette.copyWith(
                                        colors: List<int>.from(palette.colors)
                                          ..add(value.color)));
                                  }
                                },
                              ),
                            ),
                          )
                      ]),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                if (!widget.viewMode)
                  ElevatedButton(
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        var value = await showDialog<ColorPickerResponse>(
                            context: context,
                            builder: (context) =>
                                ColorPicker(value: widget.value));
                        if (value != null) navigator.pop(value.color);
                      },
                      child: Text(AppLocalizations.of(context).custom)),
              ],
            ),
          ),
        ));
  }
}
