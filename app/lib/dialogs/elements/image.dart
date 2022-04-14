import 'package:butterfly/api/open_image.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/elements/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/element.dart';
import '../../renderers/renderer.dart';

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
  late ImageElement element, newElement;

  @override
  void initState() {
    super.initState();
    element = widget.renderer.element;
    newElement = element;
  }

  void _changeElement() {
    context.read<DocumentBloc>().add(ElementChanged(element, newElement));
    element = newElement;
  }

  @override
  Widget build(BuildContext context) {
    return GeneralElementDialog(
      close: widget.close,
      renderer: widget.renderer,
      position: widget.position,
      children: [
        // TODO: Add option to change constraints
        ListTile(
          title: Text(AppLocalizations.of(context)!.export),
          leading: const Icon(PhosphorIcons.exportLight),
          onTap: () {
            openImage(newElement.pixels);
          },
        ),
      ],
    );
  }
}
