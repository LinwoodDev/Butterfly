import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/dialogs/color_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditToolbar extends StatefulWidget {
  final DocumentBloc bloc;
  const EditToolbar({Key? key, required this.bloc}) : super(key: key);

  @override
  _EditToolbarState createState() => _EditToolbarState();
}

class _EditToolbarState extends State<EditToolbar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) {
        if (state is! DocumentLoadSuccess) return Container();
        return Row(children: [
          ...state.document.painters.map((e) {
            IconData icon, activeIcon;
            var type = e.toJson()['type'];
            switch (type) {
              case "eraser":
                icon = PhosphorIcons.eraserLight;
                activeIcon = PhosphorIcons.eraserFill;
                break;
              case "path-eraser":
                icon = PhosphorIcons.pathLight;
                activeIcon = PhosphorIcons.pathFill;
                break;
              case "text":
                icon = PhosphorIcons.textTLight;
                activeIcon = PhosphorIcons.textTFill;
                break;
              default:
                icon = PhosphorIcons.penLight;
                activeIcon = PhosphorIcons.penFill;
                break;
            }
            var selected = type == state.currentPainter.toJson()['type'];
            return IconButton(
                icon: Icon(selected ? activeIcon : icon),
                onPressed: () {
                  if (!selected) widget.bloc.add(PainterChanged(e));
                });
          }),
          IconButton(icon: const Icon(PhosphorIcons.penLight), tooltip: "Pencil", onPressed: () {}),
          IconButton(
              icon: const Icon(PhosphorIcons.markerCircleLight),
              tooltip: "Marker",
              onPressed: () {}),
          IconButton(
              icon: const Icon(PhosphorIcons.eraserLight),
              tooltip: "Eraser",
              color: state.editOption.eraser ? Theme.of(context).colorScheme.primary : null,
              onPressed: () {
                widget.bloc.add(
                    EditOptionChanged(state.editOption.copyWith(eraser: !state.editOption.eraser)));
              }),
          IconButton(
              icon: const Icon(PhosphorIcons.paletteLight),
              tooltip: "Color",
              color: state.editOption.color,
              onPressed: () async {
                var color = await showDialog(
                    context: context, builder: (context) => const ColorPickerDialog());
                if (color != null) {
                  widget.bloc.add(EditOptionChanged(state.editOption.copyWith(color: color)));
                }
              })
        ]);
      },
    );
  }
}
