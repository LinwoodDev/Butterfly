import 'package:butterfly/api/open_image.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/selection.dart';
import 'package:butterfly/models/elements/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ImageElementDialog extends StatefulWidget {
  final int index;
  final DocumentBloc bloc;
  final SelectionCubit selectionCubit;

  const ImageElementDialog(
      {Key? key,
      required this.index,
      required this.bloc,
      required this.selectionCubit})
      : super(key: key);

  @override
  State<ImageElementDialog> createState() => _ImageElementDialogState();
}

class _ImageElementDialogState extends State<ImageElementDialog> {
  final TextEditingController _scaleController = TextEditingController();
  ImageElement? element;

  void _changeElement() {
    widget.bloc.add(LayerChanged(widget.index, element!));
    widget.selectionCubit.change(element!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          if (state is! DocumentLoadSuccess) return Container();
          if (state.document.content.length <= widget.index) return Container();
          element ??= state.document.content[widget.index] as ImageElement;
          if (double.tryParse(_scaleController.text) != element!.scale) {
            _scaleController.text = element!.scale.toStringAsFixed(2);
          }
          return SizedBox(
            height: 300,
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                  child:
                      Center(child: Icon(PhosphorIcons.imageLight, size: 36)),
                ),
                const Divider(thickness: 1),
                Expanded(
                    child: ListView(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 100),
                        child: TextField(
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.scale),
                            controller: _scaleController,
                            onEditingComplete: () => _changeElement(),
                            onChanged: (value) => setState(() => element =
                                element?.copyWith(
                                    scale: double.tryParse(value)))),
                      ),
                      Expanded(
                          child: Slider(
                        value: element!.scale.clamp(0.1, 5),
                        min: 0.1,
                        max: 5,
                        onChangeEnd: (value) => _changeElement(),
                        onChanged: (value) => setState(
                            () => element = element?.copyWith(scale: value)),
                      ))
                    ]),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.export),
                    leading: const Icon(PhosphorIcons.exportLight),
                    onTap: () {
                      openImage(element!.pixels);
                    },
                  ),
                  ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                    title: Text(AppLocalizations.of(context)!
                                        .areYouSure),
                                    content: Text(AppLocalizations.of(context)!
                                        .reallyDelete),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                            AppLocalizations.of(context)!.no),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                            AppLocalizations.of(context)!.yes),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          widget.bloc
                                              .add(LayersRemoved([element!]));
                                        },
                                      ),
                                    ]));
                      },
                      title: Text(AppLocalizations.of(context)!.delete),
                      leading: const Icon(PhosphorIcons.trashLight))
                ])),
              ],
            ),
          );
        },
      ),
    );
  }
}
