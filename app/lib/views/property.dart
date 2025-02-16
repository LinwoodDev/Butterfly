import 'dart:math';

import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

import '../selections/selection.dart';
import '../visualizer/icon.dart';

class PropertyView extends StatefulWidget {
  const PropertyView({super.key});

  @override
  State<PropertyView> createState() => _PropertyViewState();
}

const minSize = 450.0;

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
  late final Animation<double> _fadeAnimation = Tween<double>(
    begin: 1.0,
    end: 0.0,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));
  final _scrollController = ScrollController();
  Selection? _lastSelection;

  double _size = 500;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
      buildWhen: (previous, current) =>
          previous.selection?.selected != current.selection?.selected ||
          previous.pinned != current.pinned,
      builder: (context, state) {
        var selection = state.selection;
        if (selection == null) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        final showing = selection ?? _lastSelection;
        _lastSelection = selection;
        if (showing == null) {
          return Container();
        }
        final help = showing.help;
        final multi = showing.selected.length != 1;
        final selected = showing.selected.first;
        final controller = MenuController();
        final menuChildren = multi
            ? <Widget>[]
            : DisplayIcons.recommended(selected)
                .map(
                  (e) => IconButton(
                    icon: PhosphorIcon(e.icon(PhosphorIconsStyle.light)),
                    iconSize: 26,
                    onPressed: selected is! Tool
                        ? null
                        : () {
                            final bloc = context.read<DocumentBloc>();
                            final state = bloc.state;
                            if (state is! DocumentLoadSuccess) {
                              return;
                            }
                            final painters = state.info.tools;
                            bloc.add(
                              ToolsChanged({
                                painters.indexOf(selected):
                                    selected.copyWith(displayIcon: e.name),
                              }),
                            );
                            controller.close();
                          },
                  ),
                )
                .toList();
        final icon = showing.icon(
          multi ? PhosphorIconsStyle.fill : PhosphorIconsStyle.light,
        );
        return LayoutBuilder(
          builder: (context, constraints) {
            final isMobile =
                constraints.maxWidth < minSize || constraints.maxHeight < 400;
            return Container(
              constraints: BoxConstraints(maxWidth: _size, maxHeight: 500),
              child: RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _offsetAnimation,
                  builder: (context, child) {
                    final offset = _offsetAnimation.value * _size;
                    return Transform.translate(offset: offset, child: child);
                  },
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Card(
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: AnimatedSize(
                          alignment: Alignment.topCenter,
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 200),
                          child: Row(
                            children: [
                              if (!isMobile)
                                MouseRegion(
                                  cursor: SystemMouseCursors.resizeLeftRight,
                                  child: GestureDetector(
                                    child: const PhosphorIcon(
                                      PhosphorIconsLight.dotsSixVertical,
                                    ),
                                    onPanUpdate: (details) {
                                      final delta = details.delta.dx;
                                      setState(() {
                                        _size -= delta;
                                        _size = max(_size, minSize);
                                      });
                                    },
                                  ),
                                ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Header(
                                      centerTitle: false,
                                      leadingWidth: 60,
                                      title: Text(
                                        showing.getLocalizedName(context),
                                      ),
                                      leading: menuChildren.length <= 1
                                          ? PhosphorIcon(
                                              icon,
                                              color: Theme.of(
                                                context,
                                              ).iconTheme.color,
                                            )
                                          : MenuAnchor(
                                              controller: controller,
                                              builder: defaultFilledMenuButton(
                                                iconBuilder: (
                                                  context,
                                                  controller,
                                                  child,
                                                ) =>
                                                    Row(
                                                  children: [
                                                    PhosphorIcon(
                                                      icon,
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.onPrimary,
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    PhosphorIcon(
                                                      controller.isOpen
                                                          ? PhosphorIconsLight
                                                              .caretUp
                                                          : PhosphorIconsLight
                                                              .caretDown,
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.onPrimary,
                                                      size: 12,
                                                    ),
                                                  ],
                                                ),
                                                tooltip: AppLocalizations.of(
                                                  context,
                                                ).icon,
                                              ),
                                              menuChildren: menuChildren,
                                            ),
                                      actions: [
                                        if (showing.showDeleteButton)
                                          IconButton(
                                            icon: const PhosphorIcon(
                                              PhosphorIconsLight.trash,
                                            ),
                                            tooltip: AppLocalizations.of(
                                              context,
                                            ).delete,
                                            onPressed: () {
                                              selection?.onDelete(context);
                                              context
                                                  .read<CurrentIndexCubit>()
                                                  .resetSelection(force: true);
                                            },
                                          ),
                                        if (help.isNotEmpty)
                                          IconButton(
                                            tooltip: AppLocalizations.of(
                                              context,
                                            ).help,
                                            icon: const PhosphorIcon(
                                              PhosphorIconsLight.sealQuestion,
                                            ),
                                            onPressed: () => openHelp(help),
                                          ),
                                        const SizedBox(
                                          height: 16,
                                          child: VerticalDivider(),
                                        ),
                                        if (!isMobile)
                                          IconButton(
                                            tooltip: state.pinned
                                                ? AppLocalizations.of(
                                                    context,
                                                  ).unpin
                                                : AppLocalizations.of(
                                                    context,
                                                  ).pin,
                                            icon: state.pinned
                                                ? const PhosphorIcon(
                                                    PhosphorIconsFill.pushPin,
                                                  )
                                                : const PhosphorIcon(
                                                    PhosphorIconsLight.pushPin,
                                                  ),
                                            onPressed: () => context
                                                .read<CurrentIndexCubit>()
                                                .togglePin(),
                                          ),
                                        const SizedBox(width: 8),
                                        IconButton.outlined(
                                          tooltip: MaterialLocalizations.of(
                                            context,
                                          ).closeButtonLabel,
                                          icon: const PhosphorIcon(
                                            PhosphorIconsLight.x,
                                          ),
                                          onPressed: _closeView,
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 16,
                                        ),
                                        child: ListView(
                                          shrinkWrap: true,
                                          primary: true,
                                          children: showing.buildProperties(
                                            context,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _closeView() {
    context.read<CurrentIndexCubit>().resetSelection(force: true);
  }
}
