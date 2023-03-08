import 'package:butterfly/dialogs/packs/select.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image/image.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/document_bloc.dart';
import '../../dialogs/color_pick.dart';

class ColorToolbarView extends StatefulWidget {
  final int color;
  final ValueChanged<int> onChanged;

  const ColorToolbarView({
    super.key,
    required this.color,
    required this.onChanged,
  });

  @override
  State<ColorToolbarView> createState() => _ColorToolbarViewState();
}

class _ColorToolbarViewState extends State<ColorToolbarView> {
  final ScrollController _scrollController = ScrollController();
  PackAssetLocation? currentPalette;
  @override
  void initState() {
    super.initState();
    final state = context.read<DocumentBloc>().state;
    if (state is DocumentLoadSuccess) {
      final pack = state.document.packs.firstOrNull; 
      final palette = pack?.palettes.firstOrNull; 
      if(palette  != null ) {
        currentPalette = PackAssetLocation(pack: pack!.name, name: palette.name ) ;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      final bloc = context.read<DocumentBloc>();
      ColorPalette? palette;

      if (state is! DocumentLoadSuccess) return Container();
      if (currentPalette != null) {
        palette = state.document.getPalette(currentPalette!);
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!(palette?.colors.contains(widget.color) ?? false)) ...[
            _ColorButton(
              current: widget.color,
              color: widget.color,
              bloc: bloc,
              onChanged: (value) {
                widget.onChanged(value);
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
                  ...List.generate(palette?.colors.length ?? 0, (index) {
                    final current = palette!.colors[index];
                    return _ColorButton(
                      bloc: bloc,
                      color: widget.color,
                      current: current,
                      onChanged: (value) {
                        widget.onChanged(value);
                      },                 
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        final response = await showDialog<ColorPickerResponse>(
                          context: context,
                          builder: (context) => CustomColorPicker(
                            defaultColor: Color(widget.color),
                            pinOption: palette != null,
                          ),
                        );
                        if (response != null) {
                          widget.onChanged(response.color);
                          if (response.pin) {
                            var newPalettes =
                                List<ColorPalette>.from(state.document.palettes)
                                    .map((e) {
                              if (e.name == currentPalette) {
                                return e.copyWith(
                                    colors: [...e.colors, response.color]);
                              }
                              return e;
                            }).toList();
                            bloc.add(DocumentPaletteChanged(newPalettes));
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
IconButton(onPressed: () async{
  final document = state.document;
   final result = await showDialog<PackAssetLocation>( context: context,  builder: (context) =>
                                              SelectPackAssetDialog(
                                                  type: PackAssetType.palette,
                                                  document: document));

  if (result == null) return; 
  setState(() {
    currentPalette = result; 
  });

}, icon: Icon(PhosphorIcons.packageLight))
        ],
      );
    });
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
                          child: Text(AppLocalizations.of(context).cancel)),
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(AppLocalizations.of(context).ok)),
                    ],
                    title: Text(AppLocalizations.of(context).enterName),
                    content: TextField(
                        decoration: InputDecoration(
                            filled: true,
                            hintText: AppLocalizations.of(context).name),
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
                      child: Text(AppLocalizations.of(context).cancel)),
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
                      child: Text(AppLocalizations.of(context).ok)),
                ],
                title: Text(AppLocalizations.of(context).enterName),
                content: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        hintText: AppLocalizations.of(context).name),
                    autofocus: true,
                    controller: nameController)));
  }
}

class _ColorButton extends StatelessWidget {
  final int current, color;
  final DocumentBloc bloc;
  final ValueChanged<int> onChanged;
  final VoidCallback? onDeleted;
  const _ColorButton({
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
        onTap: () => onChanged(current),
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
