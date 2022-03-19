import 'package:butterfly/api/open_image.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/selection.dart';
import 'package:butterfly/dialogs/elements/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/elements/element.dart';
import '../../widgets/exact_slider.dart';

class ImageElementDialog extends StatefulWidget {
  final int index;
  final VoidCallback close;
  final Offset position;

  const ImageElementDialog(
      {Key? key,
      required this.index,
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
    var bloc = context.read<DocumentBloc>();
    element = (bloc.state as DocumentLoadSuccess).document.content[widget.index]
        as ImageElement;
  }

  void _changeElement() {
    context.read<DocumentBloc>().add(ElementChanged(widget.index, element));
    context.read<SelectionCubit>().change(element);
  }

  @override
  Widget build(BuildContext context) {
    return GeneralElementDialog(
      close: widget.close,
      index: widget.index,
      position: widget.position,
      children: [
        ExactSlider(
          header: Text(AppLocalizations.of(context)!.scale),
          value: element.scale,
          min: 0.1,
          max: 5,
          defaultValue: 1,
          onChanged: (value) {
            setState(() => element = element.copyWith(scale: value));
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
