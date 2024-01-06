import 'dart:math';

import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../selections/selection.dart';
import '../visualizer/icon.dart';

class PropertyView extends StatefulWidget {
  const PropertyView({super.key});

  @override
  State<PropertyView> createState() => _PropertyViewState();
}

const minSize = 500.0;

class _PropertyViewState extends State<PropertyView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));
  final _scrollController = ScrollController();

  double _size = minSize;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Selection? lastSelection;
    return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
        buildWhen: (previous, current) =>
            previous.selection?.selected != current.selection?.selected ||
            previous.pinned != current.pinned,
        builder: (context, state) {
          var selection = state.selection;
          if (selection == null) {
            _controller.forward();
          } else if (selection.runtimeType.toString() !=
              lastSelection.runtimeType.toString()) {
            _controller.reset();
            _controller.reverse(from: 1);
          } else {
            lastSelection = selection;
            _controller.reverse();
          }
          selection ??= lastSelection;
          if (selection != null) {
            lastSelection = selection;
          }
          if (selection == null) {
            return Container();
          }
          return LayoutBuilder(builder: (context, constraints) {
            final isMobile =
                constraints.maxWidth < minSize || constraints.maxHeight < 400;
            return StatefulBuilder(builder: (context, setState) {
              return Container(
                padding: const EdgeInsets.all(8),
                constraints: BoxConstraints(maxWidth: _size, maxHeight: 500),
                child: SlideTransition(
                  position: _offsetAnimation,
                  child: Material(
                    elevation: 6,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: AnimatedSize(
                      alignment: Alignment.topCenter,
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 200),
                      child: Row(children: [
                        if (!isMobile)
                          MouseRegion(
                            cursor: SystemMouseCursors.resizeLeftRight,
                            child: GestureDetector(
                              child: const PhosphorIcon(
                                  PhosphorIconsLight.dotsSixVertical),
                              onPanUpdate: (details) {
                                final delta = details.delta.dx;
                                setState(() {
                                  _size -= delta;
                                  _size = max(_size, minSize);
                                });
                              },
                            ),
                          ),
                        Expanded(child: Builder(builder: (context) {
                          final help = selection!.help;
                          final multi = selection.selected.length != 1;
                          final selected = selection.selected.first;
                          final controller = MenuController();
                          final menuChildren = multi
                              ? <Widget>[]
                              : DisplayIcons.recommended(selected)
                                  .map((e) => IconButton(
                                      icon: PhosphorIcon(
                                          e.icon(PhosphorIconsStyle.light)),
                                      iconSize: 26,
                                      onPressed: selected is! Tool
                                          ? null
                                          : () {
                                              final bloc =
                                                  context.read<DocumentBloc>();
                                              final state = bloc.state;
                                              if (state
                                                  is! DocumentLoadSuccess) {
                                                return;
                                              }
                                              final painters = state.info.tools;
                                              bloc.add(ToolsChanged({
                                                painters.indexOf(selected):
                                                    selected.copyWith(
                                                        displayIcon: e.name),
                                              }));
                                              controller.close();
                                            }))
                                  .toList();
                          final icon = PhosphorIcon(
                            selection.icon(multi
                                ? PhosphorIconsStyle.fill
                                : PhosphorIconsStyle.light),
                            color: Theme.of(context).iconTheme.color,
                          );
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Header(
                                title:
                                    Text(selection.getLocalizedName(context)),
                                leading: menuChildren.length <= 1
                                    ? icon
                                    : MenuAnchor(
                                        controller: controller,
                                        builder: defaultFilledMenuButton(
                                          iconBuilder:
                                              (context, controller, child) =>
                                                  Row(
                                            children: [
                                              icon,
                                              const SizedBox(width: 8),
                                              PhosphorIcon(
                                                controller.isOpen
                                                    ? PhosphorIconsLight.caretUp
                                                    : PhosphorIconsLight
                                                        .caretDown,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                          tooltip:
                                              AppLocalizations.of(context).icon,
                                        ),
                                        menuChildren: menuChildren,
                                      ),
                                actions: [
                                  if (selection.showDeleteButton)
                                    IconButton(
                                        icon: const PhosphorIcon(
                                            PhosphorIconsLight.trash),
                                        tooltip:
                                            AppLocalizations.of(context).delete,
                                        onPressed: () {
                                          selection?.onDelete(context);
                                          context
                                              .read<CurrentIndexCubit>()
                                              .resetSelection();
                                        }),
                                  if (help.isNotEmpty)
                                    IconButton(
                                      tooltip:
                                          AppLocalizations.of(context).help,
                                      icon: const PhosphorIcon(
                                          PhosphorIconsLight.sealQuestion),
                                      onPressed: () => openHelp(help),
                                    ),
                                  const SizedBox(
                                      height: 16, child: VerticalDivider()),
                                  if (!isMobile)
                                    IconButton(
                                      tooltip: state.pinned
                                          ? AppLocalizations.of(context).unpin
                                          : AppLocalizations.of(context).pin,
                                      icon: state.pinned
                                          ? const PhosphorIcon(
                                              PhosphorIconsFill.mapPin)
                                          : const PhosphorIcon(
                                              PhosphorIconsLight.mapPin),
                                      onPressed: () => context
                                          .read<CurrentIndexCubit>()
                                          .togglePin(),
                                    ),
                                  const SizedBox(width: 8),
                                  IconButton.outlined(
                                    tooltip: AppLocalizations.of(context).close,
                                    icon: const PhosphorIcon(
                                        PhosphorIconsLight.x),
                                    onPressed: _closeView,
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: ListView(
                                      shrinkWrap: true,
                                      primary: true,
                                      children:
                                          selection.buildProperties(context)),
                                ),
                              ),
                            ],
                          );
                        })),
                      ]),
                    ),
                  ),
                ),
              );
            });
          });
        });
  }

  void _closeView() {
    context.read<CurrentIndexCubit>().resetSelection();
  }
}
