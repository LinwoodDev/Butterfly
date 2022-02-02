import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/hand.dart';
import 'package:butterfly/dialogs/painters/eraser.dart';
import 'package:butterfly/dialogs/painters/image.dart';
import 'package:butterfly/dialogs/painters/label.dart';
import 'package:butterfly/dialogs/painters/layer.dart';
import 'package:butterfly/dialogs/painters/path_eraser.dart';
import 'package:butterfly/dialogs/painters/pen.dart';
import 'package:butterfly/models/painters/eraser.dart';
import 'package:butterfly/models/painters/image.dart';
import 'package:butterfly/models/painters/label.dart';
import 'package:butterfly/models/painters/layer.dart';
import 'package:butterfly/models/painters/painter.dart';
import 'package:butterfly/models/painters/path_eraser.dart';
import 'package:butterfly/models/painters/pen.dart';
import 'package:butterfly/widgets/option_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditToolbar extends StatelessWidget {
  const EditToolbar({Key? key}) : super(key: key);

  IconData getPainterIcon(String type) {
    switch (type) {
      case 'eraser':
        return PhosphorIcons.eraserLight;
      case 'path-eraser':
        return PhosphorIcons.pathLight;
      case 'label':
        return PhosphorIcons.textTLight;
      case 'image':
        return PhosphorIcons.imageLight;
      case 'layer':
        return PhosphorIcons.squaresFourLight;
      default:
        return PhosphorIcons.penLight;
    }
  }

  IconData getPainterActiveIcon(String type) {
    switch (type) {
      case 'eraser':
        return PhosphorIcons.eraserFill;
      case 'path-eraser':
        return PhosphorIcons.pathFill;
      case 'label':
        return PhosphorIcons.textTFill;
      case 'image':
        return PhosphorIcons.imageFill;
      case 'layer':
        return PhosphorIcons.squaresFourFill;
      default:
        return PhosphorIcons.penFill;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
            height: 50,
            child: BlocBuilder<DocumentBloc, DocumentState>(
              builder: (context, state) {
                if (state is! DocumentLoadSuccess) return Container();
                var painters = state.document.painters;
                void openHandDialog() {
                  var bloc = context.read<DocumentBloc>();
                  showGeneralDialog(
                      context: context,
                      transitionBuilder: (context, a1, a2, widget) {
                        // Slide transition
                        return SlideTransition(
                          position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
                              .animate(a1),
                          child: widget,
                        );
                      },
                      barrierDismissible: true,
                      barrierLabel: AppLocalizations.of(context)!.close,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          BlocProvider.value(value: bloc, child: const HandDialog()));
                }

                return Material(
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    OptionButton(
                      tooltip: AppLocalizations.of(context)!.hand,
                      isSelected: state.currentPainter == null,
                      icon: const Icon(PhosphorIcons.handLight),
                      selectedIcon: const Icon(PhosphorIcons.handFill),
                      onLongPressed: openHandDialog,
                      onPressed: () {
                        var bloc = context.read<DocumentBloc>();
                        if (state.currentPainter == null) {
                          openHandDialog();
                        } else {
                          bloc.add(const CurrentPainterChanged(null));
                        }
                      },
                    ),
                    const VerticalDivider(),
                    ReorderableListView.builder(
                        shrinkWrap: true,
                        buildDefaultDragHandles: false,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: painters.length,
                        itemBuilder: (context, i) {
                          var e = painters[i];
                          var type = e.toJson()['type'];
                          var selected = i ==
                              state.currentPainterIndex
                                  ?.clamp(0, state.document.painters.length - 1);
                          String tooltip = e.name.trim();
                          void openDialog() {
                            var bloc = context.read<DocumentBloc>();
                            showGeneralDialog(
                                context: context,
                                transitionBuilder: (context, a1, a2, widget) {
                                  // Slide transition
                                  return SlideTransition(
                                    position:
                                        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
                                            .animate(a1),
                                    child: widget,
                                  );
                                },
                                barrierDismissible: true,
                                barrierLabel: AppLocalizations.of(context)!.close,
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  switch (type) {
                                    case 'pen':
                                      return PenPainterDialog(bloc: bloc, painterIndex: i);
                                    case 'eraser':
                                      return EraserPainterDialog(bloc: bloc, painterIndex: i);
                                    case 'path-eraser':
                                      return PathEraserPainterDialog(bloc: bloc, painterIndex: i);
                                    case 'label':
                                      return LabelPainterDialog(bloc: bloc, painterIndex: i);
                                    case 'image':
                                      return ImagePainterDialog(bloc: bloc, painterIndex: i);
                                    case 'layer':
                                      return LayerPainterDialog(bloc: bloc, painterIndex: i);
                                    default:
                                      return Container();
                                  }
                                });
                          }

                          Widget toolWidget = Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: OptionButton(
                                  tooltip: tooltip,
                                  onLongPressed: openDialog,
                                  isSelected: selected,
                                  selectedIcon: Icon(getPainterActiveIcon(type)),
                                  icon: Icon(getPainterIcon(type)),
                                  onPressed: () {
                                    var bloc = context.read<DocumentBloc>();
                                    if (!selected) {
                                      bloc.add(CurrentPainterChanged(i));
                                    } else {
                                      openDialog();
                                    }
                                  }));
                          return ReorderableDragStartListener(
                              key: ObjectKey(e), index: i, child: toolWidget);
                        },
                        onReorder: (oldIndex, newIndex) =>
                            context.read<DocumentBloc>().add(PainterReordered(oldIndex, newIndex))),
                    const VerticalDivider(),
                    PopupMenuButton<Painter>(
                        tooltip: AppLocalizations.of(context)!.create,
                        onSelected: (value) =>
                            context.read<DocumentBloc>().add(PainterCreated(value)),
                        icon: const Icon(PhosphorIcons.plusLight),
                        itemBuilder: (context) => [
                              ...['pen', 'eraser', 'path-eraser', 'label', 'layer', 'image']
                                  .map((e) {
                                final Painter painter;
                                String name;
                                switch (e) {
                                  case 'eraser':
                                    // ignore: prefer_const_constructors
                                    painter = EraserPainter();
                                    name = AppLocalizations.of(context)!.eraser;
                                    break;
                                  case 'path-eraser':
                                    // ignore: prefer_const_constructors
                                    painter = PathEraserPainter();
                                    name = AppLocalizations.of(context)!.pathEraser;
                                    break;
                                  case 'label':
                                    // ignore: prefer_const_constructors
                                    painter = LabelPainter();
                                    name = AppLocalizations.of(context)!.label;
                                    break;
                                  case 'image':
                                    // ignore: prefer_const_constructors
                                    painter = ImagePainter();
                                    name = AppLocalizations.of(context)!.image;
                                    break;
                                  case 'layer':
                                    // ignore: prefer_const_constructors
                                    painter = LayerPainter();
                                    name = AppLocalizations.of(context)!.layer;
                                    break;
                                  default:
                                    // ignore: prefer_const_constructors
                                    painter = PenPainter();
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
                  ]),
                );
              },
            )));
  }
}
