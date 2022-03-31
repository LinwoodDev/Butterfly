import 'package:butterfly/api/open_image.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/elements/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/element.dart';
import '../../renderers/renderer.dart';
import '../../widgets/exact_slider.dart';

class ImageElementDialog extends StatefulWidget {
  final ImageRenderer renderer;
  final VoidCallback close;
  final Offset position;

  const ImageElementDialog(
      {Key? key,
      required this.renderer,
      required this.close,
      required this.position})
      : super(key: key);

  @override
  State<ImageElementDialog> createState() => _ImageElementDialogState();
}

class _ImageElementDialogState extends State<ImageElementDialog> {
  late ImageElement element;

  @override
  void initState() {
    super.initState();
    element = widget.renderer.element;
  }

  void _changeElement() {
    context.read<DocumentBloc>()
      ..add(ElementChanged(widget.renderer.element, element))
      ..add(const IndexRefreshed());
  }

  @override
  Widget build(BuildContext context) {
    return GeneralElementDialog(
      close: widget.close,
      renderer: widget.renderer,
      position: widget.position,
      children: [
        ExactSlider(
          header: Text(AppLocalizations.of(context)!.scale),
          value: element.scale.toDouble(),
          min: 0.1,
          max: 5,
          defaultValue: 1,
          onChanged: (value) {
            setState(() => element = element.copyWith(scale: value.toInt()));
          },
          onChangeEnd: (value) => _changeElement(),
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
