import 'package:butterfly/api/open_image.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editing.dart';
import 'package:butterfly/cubits/selection.dart';
import 'package:butterfly/dialogs/elements/general.dart';
import 'package:butterfly/models/elements/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ImageElementDialog extends StatefulWidget {
  final int index;
  final VoidCallback onClose;
  final DocumentBloc bloc;
  final SelectionCubit selectionCubit;
  final EditingCubit editingCubit;

  const ImageElementDialog(
      {Key? key,
      required this.index,
      required this.onClose,
      required this.bloc,
      required this.editingCubit,
      required this.selectionCubit})
      : super(key: key);

  @override
  State<ImageElementDialog> createState() => _ImageElementDialogState();
}

class _ImageElementDialogState extends State<ImageElementDialog> {
  final TextEditingController _scaleController = TextEditingController();
  late ImageElement element;

  @override
  void initState() {
    super.initState();
    element = (widget.bloc.state as DocumentLoadSuccess)
        .document
        .content[widget.index] as ImageElement;
    _scaleController.text = (element.scale * 100).toStringAsFixed(2);
  }

  void _changeElement() {
    widget.bloc.add(LayerChanged(widget.index, element));
    widget.selectionCubit.change(element);
  }

  @override
  Widget build(BuildContext context) {
    return GeneralElementDialog(
      bloc: widget.bloc,
      onClose: widget.onClose,
      selectionCubit: widget.selectionCubit,
      editingCubit: widget.editingCubit,
      index: widget.index,
      children: [
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
                      element.copyWith(scale: double.tryParse(value)))),
            ),
            Expanded(
                child: Slider(
              value: element.scale.clamp(0.1, 5),
              min: 0.1,
              max: 5,
              onChangeEnd: (value) => _changeElement(),
              onChanged: (value) {
                _scaleController.text = (value * 100).toStringAsFixed(2);
                setState(() => element = element.copyWith(scale: value));
              },
            ))
          ]),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.export),
          leading: const Icon(PhosphorIcons.exportLight),
          onTap: () {
            openImage(element.pixels);
          },
        ),
      ],
    );
  }
}
