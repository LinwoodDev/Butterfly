import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/dialogs/hand.dart';
import 'package:butterfly/dialogs/painters/eraser.dart';
import 'package:butterfly/dialogs/painters/label.dart';
import 'package:butterfly/dialogs/painters/laser.dart';
import 'package:butterfly/dialogs/painters/layer.dart';
import 'package:butterfly/dialogs/painters/path_eraser.dart';
import 'package:butterfly/dialogs/painters/pen.dart';
import 'package:butterfly/models/painter.dart';
import 'package:butterfly/visualizer/painter.dart';
import 'package:butterfly/widgets/option_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../dialogs/painters/area.dart';
import '../dialogs/painters/shape.dart';

class EditToolbar extends StatelessWidget {
  final bool isMobile;
  final ScrollController _scrollController = ScrollController();

  EditToolbar({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        controller: _scrollController,
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
                        position: Tween<Offset>(
                                begin: const Offset(0, -1), end: Offset.zero)
                            .animate(a1),
                        child: widget,
                      );
                    },
                    barrierDismissible: true,
                    barrierLabel: AppLocalizations.of(context)!.close,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        BlocProvider.value(
                            value: bloc, child: const HandDialog()));
              }

              return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
                builder: (context, currentIndex) => Material(
                  color: Colors.transparent,
                  child: Align(
                    alignment:
                        isMobile ? Alignment.center : Alignment.centerRight,
                    child: ListView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          OptionButton(
                            tooltip: AppLocalizations.of(context)!.hand,
                            selected:
                                context.read<CurrentIndexCubit>().getIndex() <
                                    0,
                            icon: const Icon(PhosphorIcons.handLight),
                            selectedIcon: const Icon(PhosphorIcons.handFill),
                            onLongPressed: openHandDialog,
                            onPressed: () {
                              if (context
                                      .read<CurrentIndexCubit>()
                                      .getPainter(state.document) ==
                                  null) {
                                openHandDialog();
                              } else {
                                context.read<CurrentIndexCubit>().reset();
                              }
                            },
                          ),
                          if (state.embedding?.editable ?? true) ...[
                            const VerticalDivider(),
                            ReorderableListView.builder(
                                shrinkWrap: true,
                                buildDefaultDragHandles: false,
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: painters.length,
                                itemBuilder: (context, i) {
                                  var e = painters[i];
                                  final type = e.toJson()['type'];
                                  final selected = i ==
                                      context
                                          .read<CurrentIndexCubit>()
                                          .getIndex();
                                  String tooltip = e.name.trim();
                                  if (tooltip.isEmpty) {
                                    tooltip = e.getLocalizedName(context);
                                  }
                                  void openDialog() {
                                    var bloc = context.read<DocumentBloc>();
                                    showGeneralDialog(
                                        context: context,
                                        transitionBuilder:
                                            (context, a1, a2, widget) {
                                          // Slide transition
                                          return SlideTransition(
                                            position: Tween<Offset>(
                                                    begin: const Offset(0, -1),
                                                    end: Offset.zero)
                                                .animate(a1),
                                            child: widget,
                                          );
                                        },
                                        barrierDismissible: true,
                                        barrierLabel:
                                            AppLocalizations.of(context)!.close,
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            BlocProvider.value(
                                                value: bloc,
                                                child:
                                                    Builder(builder: (context) {
                                                  switch (type) {
                                                    case 'pen':
                                                      return PenPainterDialog(
                                                          painterIndex: i);
                                                    case 'shape':
                                                      return ShapePainterDialog(
                                                          painterIndex: i);
                                                    case 'eraser':
                                                      return EraserPainterDialog(
                                                          painterIndex: i);
                                                    case 'pathEraser':
                                                      return PathEraserPainterDialog(
                                                          painterIndex: i);
                                                    case 'label':
                                                      return LabelPainterDialog(
                                                          painterIndex: i);
                                                    case 'layer':
                                                      return LayerPainterDialog(
                                                          painterIndex: i);
                                                    case 'area':
                                                      return AreaPainterDialog(
                                                          painterIndex: i);
                                                    case 'laser':
                                                      return LaserPainterDialog(
                                                          painterIndex: i);
                                                    default:
                                                      return Container();
                                                  }
                                                })));
                                  }

                                  Widget toolWidget = Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: OptionButton(
                                          tooltip: tooltip,
                                          onLongPressed: openDialog,
                                          selected: selected,
                                          selectedIcon:
                                              Icon(e.getIcon(filled: true)),
                                          icon: Icon(e.getIcon(filled: false)),
                                          onPressed: () {
                                            if (!selected) {
                                              context
                                                  .read<CurrentIndexCubit>()
                                                  .changePainter(state.document,
                                                      state.currentArea, i);
                                            } else {
                                              openDialog();
                                            }
                                          }));
                                  return ReorderableDragStartListener(
                                      key: ObjectKey(e),
                                      index: i,
                                      child: toolWidget);
                                },
                                onReorder: (oldIndex, newIndex) => context
                                    .read<DocumentBloc>()
                                  ..add(PainterReordered(oldIndex, newIndex))),
                            const VerticalDivider(),
                            PopupMenuButton<Painter>(
                                tooltip: AppLocalizations.of(context)!.create,
                                onSelected: (value) => context
                                    .read<DocumentBloc>()
                                    .add(PainterCreated(value)),
                                icon: const Icon(PhosphorIcons.plusLight),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                itemBuilder: (context) => [
                                      ...[
                                        Painter.pen,
                                        Painter.shape,
                                        Painter.pathEraser,
                                        Painter.label,
                                        Painter.eraser,
                                        Painter.layer,
                                        Painter.area,
                                        Painter.label
                                      ].map((e) {
                                        final painter = e();
                                        return PopupMenuItem<Painter>(
                                            value: painter,
                                            child: ListTile(
                                              mouseCursor: MouseCursor.defer,
                                              title: Text(painter
                                                  .getLocalizedName(context)),
                                              leading: Icon(painter.getIcon()),
                                            ));
                                      })
                                    ])
                          ]
                        ]),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
