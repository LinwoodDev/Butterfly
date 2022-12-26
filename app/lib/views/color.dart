import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubits/settings.dart';
import '../dialogs/color_pick.dart';
import '../models/palette.dart';

class ColorView extends StatefulWidget {
  const ColorView({super.key});

  @override
  State<ColorView> createState() => _ColorViewState();
}

class _ColorViewState extends State<ColorView> {
  String? currentPalette;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _animatedKey = GlobalKey();
  double _height = 50;

  void _setOpened(bool opened) {
    if (opened && _height == 0) {
      _height = 50;
    }
    if (!opened && _height != 0) {
      _height = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<SettingsCubit, ButterflySettings>(
          buildWhen: (previous, current) =>
              previous.colorEnabled != current.colorEnabled,
          builder: (context, settings) {
            return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
              builder: (context, currentIndex) =>
                  BlocBuilder<DocumentBloc, DocumentState>(
                      builder: (context, state) {
                Widget? child;
                if (!settings.colorEnabled) {
                  _setOpened(false);
                } else if (state is! DocumentLoadSuccess) {
                  _setOpened(false);
                } else {
                  final handler =
                      currentIndex.temporaryHandler ?? currentIndex.handler;
                  final bloc = context.read<DocumentBloc>();
                  final color = handler.getColor(bloc);
                  if (color == null) {
                    _setOpened(false);
                  } else {
                    currentPalette ??=
                        state.document.palettes.firstOrNull?.name;
                    final palette = currentPalette == null
                        ? null
                        : state.document.getPalette(currentPalette!);
                    _setOpened(true);
                    child = Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (!(palette?.colors.contains(color) ?? false)) ...[
                          _ColorButton(
                            current: color,
                            color: color,
                            bloc: bloc,
                            onChanged: (value) {
                              handler.setColor(bloc, value);
                            },
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
                                ...List.generate(palette?.colors.length ?? 0,
                                    (index) {
                                  final current = palette!.colors[index];
                                  return _ColorButton(
                                    bloc: bloc,
                                    color: color,
                                    current: current,
                                    handler: handler,
                                    onChanged: (value) {
                                      if (color == current) {
                                        final newPainter =
                                            handler.setColor(bloc, value);
                                        if (newPainter == null) return;
                                        context.read<DocumentBloc>().add(
                                            PaintersChanged(
                                                {handler.data: newPainter}));
                                      }
                                      var newPalettes = List<ColorPalette>.from(
                                              state.document.palettes)
                                          .map((e) {
                                        if (e.name == currentPalette) {
                                          return e.copyWith(
                                            colors: List<int>.from(e.colors)
                                              ..[index] = value,
                                          );
                                        }
                                        return e;
                                      }).toList();
                                      bloc.add(
                                          DocumentPaletteChanged(newPalettes));
                                    },
                                    onDeleted: () {
                                      var newPalettes = List<ColorPalette>.from(
                                              state.document.palettes)
                                          .map((e) {
                                        if (e.name == currentPalette) {
                                          return e.copyWith(
                                            colors: List<int>.from(e.colors)
                                              ..removeAt(index),
                                          );
                                        }
                                        return e;
                                      }).toList();
                                      bloc.add(
                                          DocumentPaletteChanged(newPalettes));
                                    },
                                  );
                                }),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      final response =
                                          await showDialog<ColorPickerResponse>(
                                        context: context,
                                        builder: (context) => CustomColorPicker(
                                          defaultColor: Color(color),
                                          pinOption: palette != null,
                                        ),
                                      );
                                      if (response != null) {
                                        final newPainter = handler.setColor(
                                            bloc, response.color);
                                        if (newPainter == null) return;
                                        bloc.add(PaintersChanged(
                                            {handler.data: newPainter}));
                                        if (response.pin) {
                                          var newPalettes =
                                              List<ColorPalette>.from(
                                                      state.document.palettes)
                                                  .map((e) {
                                            if (e.name == currentPalette) {
                                              return e.copyWith(colors: [
                                                ...e.colors,
                                                response.color
                                              ]);
                                            }
                                            return e;
                                          }).toList();
                                          bloc.add(DocumentPaletteChanged(
                                              newPalettes));
                                        }
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(12),
                                    child: const AspectRatio(
                                      aspectRatio: 1,
                                      child: Icon(PhosphorIcons.plusLight),
                                    ),
                                  ),
                                ),
                              ]),
                        )),
                        PopupMenuButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          itemBuilder: (context) {
                            final palettes = state.document.palettes;
                            return <PopupMenuEntry>[
                              for (final palette in palettes)
                                PopupMenuItem(
                                  padding: EdgeInsets.zero,
                                  value: palette.name,
                                  child: ListTile(
                                    mouseCursor: MouseCursor.defer,
                                    title: Text(palette.name),
                                    selected: palette.name == currentPalette,
                                    onTap: () {
                                      setState(() {
                                        currentPalette = palette.name;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              if (palettes.isNotEmpty) const PopupMenuDivider(),
                              PopupMenuItem(
                                padding: EdgeInsets.zero,
                                child: ListTile(
                                  mouseCursor: MouseCursor.defer,
                                  leading: const Icon(PhosphorIcons.plusLight),
                                  title:
                                      Text(AppLocalizations.of(context)!.add),
                                  onTap: _newPalette,
                                ),
                              ),
                              if (palettes.isNotEmpty) ...[
                                PopupMenuItem(
                                  padding: EdgeInsets.zero,
                                  child: ListTile(
                                    mouseCursor: MouseCursor.defer,
                                    title: const Text('Rename'),
                                    leading: Icon(PhosphorIcons.pencilLight,
                                        color:
                                            Theme.of(context).iconTheme.color),
                                    onTap: _renamePalette,
                                  ),
                                ),
                                PopupMenuItem(
                                  padding: EdgeInsets.zero,
                                  child: ListTile(
                                    mouseCursor: MouseCursor.defer,
                                    title: const Text('Delete'),
                                    leading: Icon(PhosphorIcons.trashLight,
                                        color:
                                            Theme.of(context).iconTheme.color),
                                    onTap: () {
                                      final newPalettes =
                                          List<ColorPalette>.from(
                                                  state.document.palettes)
                                              .where((e) =>
                                                  e.name != currentPalette)
                                              .toList();
                                      context.read<DocumentBloc>().add(
                                          DocumentPaletteChanged(newPalettes));
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            ];
                          },
                        ),
                      ],
                    );
                  }
                }
                return AnimatedContainer(
                  height: _height,
                  key: _animatedKey,
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 200),
                  child: child,
                );
              }),
            );
          }),
    );
  }

  Future<void> _newPalette() async {
    Navigator.of(context).pop();
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final nameController = TextEditingController();
    final success = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(AppLocalizations.of(context)!.cancel)),
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(AppLocalizations.of(context)!.ok)),
                    ],
                    title: Text(AppLocalizations.of(context)!.enterName),
                    content: TextField(
                        decoration: InputDecoration(
                            filled: true,
                            hintText: AppLocalizations.of(context)!.name),
                        autofocus: true,
                        onSubmitted: (value) => Navigator.of(context).pop(true),
                        controller: nameController))) ??
        false;
    if (!success) return;
    final name = nameController.text;
    if (state.document.palettes.any((element) => element.name == name)) return;
    final newPalettes = List<ColorPalette>.from(state.document.palettes)
      ..add(ColorPalette(name: name, colors: []));
    bloc.add(DocumentPaletteChanged(newPalettes));
    setState(() => currentPalette = name);
  }

  Future<void> _renamePalette() async {
    Navigator.of(context).pop();
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return;
    final nameController = TextEditingController(text: currentPalette);
    return showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(AppLocalizations.of(context)!.cancel)),
                  ElevatedButton(
                      onPressed: () {
                        final name = nameController.text;
                        if (state.document.palettes
                            .any((element) => element.name == name)) return;
                        final newPalettes =
                            List<ColorPalette>.from(state.document.palettes)
                                .map((e) {
                          if (e.name == currentPalette) {
                            return e.copyWith(name: name);
                          }
                          return e;
                        }).toList();
                        if (newPalettes.isEmpty) {
                          newPalettes.add(ColorPalette(name: name, colors: []));
                        }
                        context
                            .read<DocumentBloc>()
                            .add(DocumentPaletteChanged(newPalettes));
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.ok)),
                ],
                title: Text(AppLocalizations.of(context)!.enterName),
                content: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        hintText: AppLocalizations.of(context)!.name),
                    autofocus: true,
                    controller: nameController)));
  }
}

class _ColorButton extends StatelessWidget {
  final Handler? handler;
  final int current, color;
  final DocumentBloc bloc;
  final ValueChanged<int> onChanged;
  final VoidCallback? onDeleted;
  const _ColorButton({
    this.handler,
    required this.current,
    required this.color,
    required this.bloc,
    required this.onChanged,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          final newPainter = handler?.setColor(bloc, current);
          if (newPainter == null) return;
          context
              .read<DocumentBloc>()
              .add(PaintersChanged({handler?.data: newPainter}));
        },
        onLongPress: () async {
          final newColor = await showDialog<ColorPickerResponse>(
            context: context,
            builder: (context) => CustomColorPicker(
              defaultColor: Color(current),
              deleteOption: onDeleted != null,
            ),
          );
          if (newColor == null) return;
          if (newColor.delete) {
            onDeleted?.call();
          } else {
            onChanged(newColor.color);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Color(current),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: color == current
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                width: 4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
