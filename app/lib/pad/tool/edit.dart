import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/dialogs/painters/eraser.dart';
import 'package:butterfly/pad/dialogs/painters/path_eraser.dart';
import 'package:butterfly/pad/dialogs/painters/pen.dart';
import 'package:butterfly/painter/eraser.dart';
import 'package:butterfly/painter/painter.dart';
import 'package:butterfly/painter/path_eraser.dart';
import 'package:butterfly/painter/pen.dart';
import 'package:butterfly/painter/text.dart';
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
  IconData getPainterIcon(String type) {
    switch (type) {
      case "eraser":
        return PhosphorIcons.eraserLight;
      case "path-eraser":
        return PhosphorIcons.pathLight;
      case "label":
        return PhosphorIcons.textTLight;
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
                return ReorderableDragStartListener(
                  index: i,
                  key: ObjectKey(e),
                  child: IconButton(
                      tooltip: tooltip,
                      color: selected ? Theme.of(context).colorScheme.primary : null,
                      icon: Icon(selected ? getPainterActiveIcon(type) : getPainterIcon(type),
                          size: 24),
                      onPressed: () {
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
                                    return EraserPainterDialog(bloc: widget.bloc, painterIndex: i);
                                  case 'path-eraser':
                                    return PathEraserPainterDialog(
                                        bloc: widget.bloc, painterIndex: i);
                                  default:
                                    return Container();
                                }
                              });
                        }
                      }),
                );
              },
              onReorder: (oldIndex, newIndex) =>
                  widget.bloc.add(PainterReordered(oldIndex, newIndex))),
          const VerticalDivider(),
          PopupMenuButton<Painter>(
              onSelected: (value) => widget.bloc.add(PainterCreated(value)),
              icon: const Icon(PhosphorIcons.plusLight),
              itemBuilder: (context) => [
                    ...["pen", "eraser", "path-eraser", "label"].map((e) {
                      Painter painter;
                      switch (e) {
                        case "eraser":
                          painter = const EraserPainter();
                          break;
                        case "path-eraser":
                          painter = const PathEraserPainter();
                          break;
                        case "label":
                          painter = const LabelPainter();
                          break;
                        default:
                          painter = const PenPainter();
                      }
                      return PopupMenuItem<Painter>(
                          value: painter,
                          child: ListTile(
                            mouseCursor: MouseCursor.defer,
                            title: Text(e),
                            leading: Icon(getPainterIcon(e)),
                          ));
                    })
                  ])
        ]);
      },
    );
  }
}
