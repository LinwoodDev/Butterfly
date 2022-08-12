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

import '../selections/selection.dart';

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
            builder: (context, state) {
              if (state is! DocumentLoadSuccess) return Container();
              var painters = state.document.painters;

              return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
                builder: (context, currentIndex) => Material(
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
                          OptionButton(
                            tooltip: AppLocalizations.of(context)!.hand,
                            selected:
                                context.read<CurrentIndexCubit>().getIndex() <
                                    0,
                            highlighted: currentIndex.selection?.selected
                                    .contains(kHand) ??
                                false,
                            icon: const Icon(PhosphorIcons.handLight),
                            selectedIcon: const Icon(PhosphorIcons.handFill),
                            onLongPressed: () => context
                                .read<CurrentIndexCubit>()
                                .changeSelection(kHand),
                            onPressed: () {
                              context
                                  .read<CurrentIndexCubit>()
                                  .resetSelection();
                              if (context
                                      .read<CurrentIndexCubit>()
                                      .getPainter(state.document) ==
                                  null) {
                                context
                                    .read<CurrentIndexCubit>()
                                    .changeSelection(kHand);
                              } else {
                                context
                                    .read<CurrentIndexCubit>()
                                    .reset(state.document);
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
                                  final selected = i ==
                                      context
                                          .read<CurrentIndexCubit>()
                                          .getIndex();
                                  final highlighted = currentIndex
                                          .selection?.selected
                                          .any((element) =>
                                              element.hashCode == e.hashCode) ??
                                      false;
                                  String tooltip = e.name.trim();
                                  if (tooltip.isEmpty) {
                                    tooltip = e.getLocalizedName(context);
                                  }

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
                                          selectedIcon:
                                              Icon(e.getIcon(filled: true)),
                                          icon: Icon(e.getIcon(filled: false)),
                                          onPressed: () {
                                            if (_mouseState ==
                                                _MouseState.multi) {
                                              context
                                                  .read<CurrentIndexCubit>()
                                                  .insertSelection(e, true);
                                            } else if (!selected) {
                                              context
                                                  .read<CurrentIndexCubit>()
                                                  .resetSelection();
                                              context
                                                  .read<CurrentIndexCubit>()
                                                  .changePainter(state.document,
                                                      state.currentArea, i);
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
                                        Painter.area
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
