import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/dialogs/add.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/visualizer/painter.dart';
import 'package:butterfly/widgets/option_button.dart';
import 'package:butterfly_api/butterfly_api.dart';
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
          height: 60,
          child: BlocBuilder<DocumentBloc, DocumentState>(
            buildWhen: (previous, current) =>
                previous is! DocumentLoadSuccess ||
                current is! DocumentLoadSuccess ||
                previous.painter != current.painter ||
                previous.page.painters != current.page.painters,
            builder: (context, state) {
              if (state is! DocumentLoadSuccess) return Container();
              var painters = state.page.painters;

              Widget buildIcon(PhosphorIconData data, bool action,
                      [Color? color]) =>
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 8),
                      PhosphorIcon(
                        data,
                        color: color,
                      ),
                      SizedBox(
                        width: 8,
                        child: action
                            ? PhosphorIcon(
                                PhosphorIconsLight.playCircle,
                                size: 16,
                                color: color,
                              )
                            : null,
                      ),
                    ],
                  );

              return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
                builder: (context, currentIndex) {
                  final temp = currentIndex.temporaryHandler;
                  final tempData = temp?.data;
                  PhosphorIconData icon = PhosphorIconsLight.cube;
                  PhosphorIconData iconFilled = PhosphorIconsFill.cube;
                  var tooltip = tempData?.name.trim();
                  if (tooltip?.isEmpty ?? false) {
                    if (tempData is Painter) {
                      tooltip = tempData.getLocalizedName(context);
                      icon = tempData.icon(PhosphorIconsStyle.light);
                      iconFilled = tempData.icon(PhosphorIconsStyle.fill);
                    }
                  }
                  tooltip ??= '';

                  return Material(
                    color: Colors.transparent,
                    child: Align(
                      alignment: widget.isMobile
                          ? Alignment.center
                          : Alignment.centerRight,
                      child: Card(
                        elevation: 10,
                        child: ListView(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
                              if (state.embedding?.editable ?? true) ...[
                                if (temp != null && tempData != null) ...[
                                  OptionButton(
                                    tooltip: tooltip,
                                    selected: true,
                                    highlighted: currentIndex
                                            .selection?.selected
                                            .contains(tempData) ??
                                        false,
                                    icon: PhosphorIcon(icon),
                                    selectedIcon: PhosphorIcon(iconFilled),
                                    onLongPressed: () => context
                                        .read<CurrentIndexCubit>()
                                        .changeSelection(tempData),
                                    onPressed: () {
                                      if (tempData == null) return;
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
                                  itemCount: painters.length + 1,
                                  itemBuilder: (context, i) {
                                    if (painters.length <= i) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        key: const ValueKey('add'),
                                        children: [
                                          const VerticalDivider(),
                                          const SizedBox(width: 8),
                                          IconButton(
                                            tooltip:
                                                AppLocalizations.of(context)
                                                    .delete,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            icon: const PhosphorIcon(
                                                PhosphorIconsLight.trash),
                                            onPressed: () async {
                                              final painter =
                                                  currentIndex.handler.data;
                                              if (painter is! Painter) return;
                                              context.read<DocumentBloc>().add(
                                                  PaintersRemoved([painter]));
                                            },
                                          ),
                                        ],
                                      );
                                    }
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
                                            selectedIcon: buildIcon(
                                                e.icon(PhosphorIconsStyle.fill),
                                                e.isAction(),
                                                color),
                                            icon: buildIcon(
                                                e.icon(
                                                    PhosphorIconsStyle.light),
                                                e.isAction(),
                                                color),
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
                                                      context
                                                          .read<DocumentBloc>(),
                                                      i,
                                                      handler,
                                                    );
                                              } else {
                                                context
                                                    .read<CurrentIndexCubit>()
                                                    .changeSelection(e, true);
                                              }
                                            }));
                                    return ReorderableDragStartListener(
                                      key: ObjectKey(i),
                                      index: i,
                                      child: toolWidget,
                                    );
                                  },
                                  onReorder: (oldIndex, newIndex) {
                                    final bloc = context.read<DocumentBloc>();
                                    final delete = newIndex > painters.length;
                                    if (delete) {
                                      bloc.add(PaintersRemoved(
                                          [painters[oldIndex]]));
                                      return;
                                    }
                                    bloc.add(
                                        PainterReordered(oldIndex, newIndex));
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: FloatingActionButton.small(
                                      tooltip: AppLocalizations.of(context).add,
                                      heroTag: null,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => MultiBlocProvider(
                                            providers: [
                                              BlocProvider.value(
                                                value: context
                                                    .read<DocumentBloc>(),
                                              ),
                                              BlocProvider.value(
                                                value: context
                                                    .read<CurrentIndexCubit>(),
                                              ),
                                            ],
                                            child: RepositoryProvider.value(
                                              value:
                                                  context.read<ImportService>(),
                                              child: const AddDialog(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: const PhosphorIcon(
                                          PhosphorIconsLight.plus),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(),
                                IconButton(
                                  icon: const PhosphorIcon(
                                      PhosphorIconsLight.wrench),
                                  onPressed: () {
                                    final cubit =
                                        context.read<CurrentIndexCubit>();
                                    final state = cubit
                                        .state.cameraViewport.tool?.element;
                                    if (state != null) {
                                      cubit.changeSelection(state);
                                    }
                                  },
                                ),
                              ],
                            ]),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ));
  }
}
