import 'package:butterfly/api/open_image.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/elements/general.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/element.dart';
import '../../renderers/renderer.dart';
import '../constraints.dart';

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
  late DocumentBloc bloc;

  @override
  void initState() {
    super.initState();
    element = widget.renderer.element;
    newElement = element;
    bloc = context.read<DocumentBloc>();
  }

  void _changeElement() {
    bloc.add(ElementChanged(element, newElement));
    element = newElement;
  }

  @override
  Widget build(BuildContext context) {
    String constraints;
    if (element.constraints is ScaledElementConstraints) {
      constraints = AppLocalizations.of(context)!.scaledConstraints;
    } else if (element.constraints is FixedElementConstraints) {
      constraints = AppLocalizations.of(context)!.fixedConstraints;
    } else if (element.constraints is DynamicElementConstraints) {
      constraints = AppLocalizations.of(context)!.dynamicConstraints;
    } else {
      constraints = AppLocalizations.of(context)!.none;
    }
    return GeneralElementDialog(
      close: widget.close,
      renderer: widget.renderer,
      position: widget.position,
      children: [
        ListTile(
          title: Text(AppLocalizations.of(context)!.constraints),
          leading: const Icon(PhosphorIcons.selectionLight),
          subtitle: Text(constraints),
          onTap: () {
            widget.close();
            showContextMenu(
                context: context,
                position: widget.position,
                builder: (context, close) => ConstraintsContextMenu(
                    position: widget.position,
                    enableScaled: true,
                    initialConstraints: element.constraints,
                    close: close,
                    onChanged: (constraints) {
                      close();
                      newElement = element.copyWith(constraints: constraints);
                      _changeElement();
                    }));
          },
        ),
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
