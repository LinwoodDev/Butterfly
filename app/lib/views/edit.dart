import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/models/painter.dart';
import 'package:butterfly/visualizer/painter.dart';
import 'package:butterfly/widgets/option_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../handlers/handler.dart';

class EditToolbar extends StatefulWidget {
  final bool isMobile;

  const EditToolbar({super.key, required this.isMobile});

  @override
  State<EditToolbar> createState() => _EditToolbarState();
}

enum _MouseState { normal, multi }

class _EditToolbarState extends State<EditToolbar> {
  final ScrollController _scrollController = ScrollController();

  _MouseState _mouseState = _MouseState.normal;

  @override
  void initState() {
    super.initState();

    RawKeyboard.instance.addListener(_handleKey);
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_handleKey);
    super.dispose();
  }

  void _handleKey(RawKeyEvent event) {
    if (event.data.isControlPressed) {
      _mouseState = _MouseState.multi;
    } else {
      _mouseState = _MouseState.normal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        controller: _scrollController,
        child: SizedBox(
          height: 50,
          child: BlocBuilder<DocumentBloc, DocumentState>(
            buildWhen: (previous, current) =>
                previous is! DocumentLoadSuccess ||
                current is! DocumentLoadSuccess ||
                previous.painter != current.painter ||
                previous.document.painters != current.document.painters,
            builder: (context, state) {
              if (state is! DocumentLoadSuccess) return Container();
              var painters = state.document.painters;

              return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
                builder: (context, currentIndex) {
                  final temp = currentIndex.temporaryHandler;
                  final tempData = temp?.data;
                  IconData icon = PhosphorIcons.cubeLight;
                  IconData iconFilled = PhosphorIcons.cubeFill;
                  var tooltip = tempData?.name.trim();
                  if (tooltip?.isEmpty ?? false) {
                    if (tempData is Painter) {
                      tooltip = tempData.getLocalizedName(context);
                      icon = tempData.getIcon();
                      iconFilled = tempData.getIcon(filled: true);
                    }
                  }
                  tooltip ??= '';

                  return Material(
                    color: Colors.transparent,
                    child: Align(
                      alignment: widget.isMobile
                          ? Alignment.center
                          : Alignment.centerRight,
                      child: ListView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            if (state.embedding?.editable ?? true) ...[
                              if (temp != null) ...[
                                OptionButton(
                                  tooltip: tooltip,
                                  selected: true,
                                  highlighted: currentIndex.selection?.selected
                                          .contains(tempData) ??
                                      false,
                                  icon: Icon(icon),
                                  selectedIcon: Icon(iconFilled),
                                  onLongPressed: () => context
                                      .read<CurrentIndexCubit>()
                                      .changeSelection(tempData),
                                  onPressed: () {
                                    if (_mouseState == _MouseState.multi) {
                                      context
                                          .read<CurrentIndexCubit>()
                                          .insertSelection(tempData, true);
                                    } else {
                                      context
                                          .read<CurrentIndexCubit>()
                                          .changeSelection(tempData, true);
                                    }
                                  },
                                ),
                                const VerticalDivider(),
                              ],
                              ReorderableListView.builder(
                                  shrinkWrap: true,
                                  buildDefaultDragHandles: false,
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: painters.length,
                                  itemBuilder: (context, i) {
                                    var e = painters[i];
                                    final selected = i == currentIndex.index;
                                    final highlighted = currentIndex
                                            .selection?.selected
                                            .any((element) =>
                                                element.hashCode ==
                                                e.hashCode) ??
                                        false;
                                    String tooltip = e.name.trim();
                                    if (tooltip.isEmpty) {
                                      tooltip = e.getLocalizedName(context);
                                    }

                                    final handler = Handler.fromPainter(e);

                                    final color = handler.getStatus(
                                                context.read<DocumentBloc>()) ==
                                            PainterStatus.disabled
                                        ? Theme.of(context).disabledColor
                                        : null;

                                    Widget toolWidget = Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: OptionButton(
                                            tooltip: tooltip,
                                            onLongPressed: () => context
                                                .read<CurrentIndexCubit>()
                                                .insertSelection(e, true),
                                            selected: selected,
                                            highlighted: highlighted,
                                            selectedIcon: Icon(
                                              e.getIcon(filled: true),
                                              color: color,
                                            ),
                                            icon: Icon(
                                              e.getIcon(filled: false),
                                              color: color,
                                            ),
                                            onPressed: () {
                                              if (_mouseState ==
                                                  _MouseState.multi) {
                                                context
                                                    .read<CurrentIndexCubit>()
                                                    .insertSelection(e, true);
                                              } else if (!selected ||
                                                  temp != null) {
                                                context
                                                    .read<CurrentIndexCubit>()
                                                    .resetSelection();
                                                context
                                                    .read<CurrentIndexCubit>()
                                                    .changePainter(
                                                        context.read<
                                                            DocumentBloc>(),
                                                        i,
                                                        handler);
                                              } else {
                                                context
                                                    .read<CurrentIndexCubit>()
                                                    .changeSelection(e, true);
                                              }
                                            }));
                                    return ReorderableDragStartListener(
                                        key: ObjectKey(i),
                                        index: i,
                                        child: toolWidget);
                                  },
                                  onReorder: (oldIndex, newIndex) => context
                                      .read<DocumentBloc>()
                                    ..add(
                                        PainterReordered(oldIndex, newIndex))),
                              const VerticalDivider(),
                              PopupMenuButton<Painter>(
                                  tooltip: AppLocalizations.of(context)!.more,
                                  onSelected: (value) {
                                    context
                                        .read<DocumentBloc>()
                                        .add(PainterCreated(value));
                                  },
                                  icon: const Icon(PhosphorIcons.listLight),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  itemBuilder: (context) => [
                                        ...[
                                          Painter.hand,
                                          Painter.undo,
                                          Painter.redo,
                                          null,
                                          Painter.pen,
                                          Painter.shape,
                                          Painter.pathEraser,
                                          Painter.label,
                                          Painter.eraser,
                                          Painter.layer,
                                          Painter.area
                                        ].map((e) {
                                          if (e == null) {
                                            return const PopupMenuDivider();
                                          }
                                          final painter = e();
                                          return PopupMenuItem<Painter>(
                                            value: painter,
                                            child: ListTile(
                                              mouseCursor: MouseCursor.defer,
                                              title: Text(painter
                                                  .getLocalizedName(context)),
                                              leading: Icon(painter.getIcon()),
                                            ),
                                          );
                                        })
                                      ])
                            ]
                          ]),
                    ),
                  );
                },
              );
            },
          ),
        ));
  }
}
