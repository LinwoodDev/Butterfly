import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/dialogs/painters/eraser.dart';
import 'package:butterfly/pad/dialogs/painters/image.dart';
import 'package:butterfly/pad/dialogs/painters/label.dart';
import 'package:butterfly/pad/dialogs/painters/path_eraser.dart';
import 'package:butterfly/pad/dialogs/painters/pen.dart';
import 'package:butterfly/painter/eraser.dart';
import 'package:butterfly/painter/image.dart';
import 'package:butterfly/painter/painter.dart';
import 'package:butterfly/painter/path_eraser.dart';
import 'package:butterfly/painter/pen.dart';
import 'package:butterfly/painter/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditToolbar extends StatefulWidget {
  final DocumentBloc bloc;
  const EditToolbar({Key? key, required this.bloc}) : super(key: key);

  @override
  _EditToolbarState createState() => _EditToolbarState();
}

class _EditToolbarState extends State<EditToolbar> {
  IconData getPainterIcon(String type) {
    switch (type) {
      case "eraser":
        return PhosphorIcons.eraserLight;
      case "path-eraser":
        return PhosphorIcons.pathLight;
      case "label":
        return PhosphorIcons.textTLight;
      case "image":
        return PhosphorIcons.imageLight;
      default:
        return PhosphorIcons.penLight;
    }
  }

  IconData getPainterActiveIcon(String type) {
    switch (type) {
      case "eraser":
        return PhosphorIcons.eraserFill;
      case "path-eraser":
        return PhosphorIcons.pathFill;
      case "label":
        return PhosphorIcons.textTFill;
      case "image":
        return PhosphorIcons.imageFill;
      default:
        return PhosphorIcons.penFill;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      builder: (context, state) {
        if (state is! DocumentLoadSuccess) return Container();
        var painters = state.document.painters;

        return Row(children: [
          ReorderableListView.builder(
              shrinkWrap: true,
              buildDefaultDragHandles: false,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: painters.length,
              itemBuilder: (context, i) {
                var e = painters[i];
                var type = e.toJson()['type'];
                var selected =
                    i == state.currentPainterIndex.clamp(0, state.document.painters.length - 1);
                String? tooltip = e.name.trim();
                if (tooltip == "") tooltip = null;
                Widget toolWidget = Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(32)),
                        child: Column(children: [
                          Icon(selected ? getPainterActiveIcon(type) : getPainterIcon(type),
                              color: selected ? Theme.of(context).colorScheme.primary : null,
                              size: 32),
                          if (selected) const Icon(PhosphorIcons.caretDownLight, size: 12)
                        ]),
                        onTap: () {
                          if (!selected) {
                            widget.bloc.add(CurrentPainterChanged(i));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  switch (type) {
                                    case 'pen':
                                      return PenPainterDialog(bloc: widget.bloc, painterIndex: i);
                                    case 'eraser':
                                      return EraserPainterDialog(
                                          bloc: widget.bloc, painterIndex: i);
                                    case 'path-eraser':
                                      return PathEraserPainterDialog(
                                          bloc: widget.bloc, painterIndex: i);
                                    case 'label':
                                      return LabelPainterDialog(bloc: widget.bloc, painterIndex: i);
                                    case 'image':
                                      return ImagePainterDialog(bloc: widget.bloc, painterIndex: i);
                                    default:
                                      return Container();
                                  }
                                });
                          }
                        }));
                if (tooltip != null) toolWidget = Tooltip(message: tooltip, child: toolWidget);
                return ReorderableDragStartListener(index: i, key: ObjectKey(e), child: toolWidget);
              },
              onReorder: (oldIndex, newIndex) =>
                  widget.bloc.add(PainterReordered(oldIndex, newIndex))),
          const VerticalDivider(),
          PopupMenuButton<Painter>(
              tooltip: AppLocalizations.of(context)!.create,
              onSelected: (value) => widget.bloc.add(PainterCreated(value)),
              icon: const Icon(PhosphorIcons.plusLight),
              itemBuilder: (context) => [
                    ...["pen", "eraser", "path-eraser", "label", "image"].map((e) {
                      Painter painter;
                      String name;
                      switch (e) {
                        case "eraser":
                          painter = const EraserPainter();
                          name = AppLocalizations.of(context)!.eraser;
                          break;
                        case "path-eraser":
                          painter = const PathEraserPainter();
                          name = AppLocalizations.of(context)!.pathEraser;
                          break;
                        case "label":
                          painter = const LabelPainter();
                          name = AppLocalizations.of(context)!.label;
                          break;
                        case "image":
                          painter = const ImagePainter();
                          name = AppLocalizations.of(context)!.image;
                          break;
                        default:
                          painter = const PenPainter();
                          name = AppLocalizations.of(context)!.pen;
                      }
                      return PopupMenuItem<Painter>(
                          value: painter,
                          child: ListTile(
                            mouseCursor: MouseCursor.defer,
                            title: Text(name),
                            leading: Icon(getPainterIcon(e)),
                          ));
                    })
                  ])
        ]);
      },
    );
  }
}
