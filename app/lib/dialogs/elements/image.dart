import 'package:butterfly/api/open_image.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/selection.dart';
import 'package:butterfly/dialogs/elements/general.dart';
import 'package:butterfly/models/elements/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageElementDialog extends StatefulWidget {
  final int index;
  final VoidCallback close;

  const ImageElementDialog({Key? key, required this.index, required this.close})
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
    var bloc = context.read<DocumentBloc>();
    element = (bloc.state as DocumentLoadSuccess).document.content[widget.index]
        as ImageElement;
    _scaleController.text = (element.scale * 100).toStringAsFixed(2);
  }

  void _changeElement() {
    context.read<DocumentBloc>().add(LayerChanged(widget.index, element));
    context.read<SelectionCubit>().change(element);
  }

  @override
  Widget build(BuildContext context) {
    return GeneralElementDialog(
      close: widget.close,
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
