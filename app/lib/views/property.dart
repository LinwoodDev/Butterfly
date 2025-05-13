import 'dart:math';

import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/widgets/editable_list_tile.dart';
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

const minSize = 480.0;

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
                    child: _PropertyCard(
                      isMobile: isMobile,
                      selection: showing,
                      size: _size,
                      onSizeDeltaChanged: (delta) =>
                          setState(() => _size = max(_size - delta, minSize)),
                      closeView: _closeView,
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

class _PropertyCard extends StatefulWidget {
  final bool isMobile;
  final Selection<dynamic> selection;
  final double size;
  final ValueChanged<double> onSizeDeltaChanged;
  final VoidCallback closeView;

  const _PropertyCard({
    required this.isMobile,
    required this.selection,
    required this.size,
    required this.onSizeDeltaChanged,
    required this.closeView,
  });

  @override
  State<_PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<_PropertyCard> {
  final MenuController _menuController = MenuController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _menuController.close();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selection = widget.selection;
    final caption = selection.getLocalizedCaption(context);
    final help = selection.help;
    final multi = selection.selected.length != 1;
    final selected = selection.selected.first;
    final icon = selection.icon(
      multi ? PhosphorIconsStyle.fill : PhosphorIconsStyle.light,
    );
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
                        _menuController.close();
                      },
              ),
            )
            .toList();
    final name = selection.getLocalizedName(context);
    if (_nameController.text != name) {
      _nameController.text = name;
    }
    final textStyle = TextTheme.of(context).headlineSmall;
    final leading = SizedBox.square(
      dimension: 60,
      child: menuChildren.length <= 1
          ? PhosphorIcon(
              icon,
              color: Theme.of(
                context,
              ).iconTheme.color,
            )
          : Center(
              child: MenuAnchor(
                controller: _menuController,
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
                            ? PhosphorIconsLight.caretUp
                            : PhosphorIconsLight.caretDown,
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
            ),
    );
    final titleEditable = selection.isNameEditable(context);
    final title = titleEditable
        ? EditableListTile(
            controller: _nameController,
            textStyle: textStyle,
            contentPadding: EdgeInsets.only(left: 4),
            subtitle: caption.isEmpty ? SizedBox() : Text(caption),
            onSaved: (value) => selection.setName(context, value),
            textFormatter: (value) => selection.nameFormatter(context, value),
            showEditIcon: false,
          )
        : SizedBox(
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(name, style: textStyle),
                ),
                if (caption.isNotEmpty)
                  Text(
                    caption,
                    style: TextTheme.of(context).labelLarge,
                  ),
              ],
            ),
          );
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 6,
        ),
        child: AnimatedSize(
          alignment: Alignment.topCenter,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 200),
          child: Row(
            children: [
              if (!widget.isMobile)
                MouseRegion(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  child: GestureDetector(
                    child: const PhosphorIcon(
                      PhosphorIconsLight.dotsSixVertical,
                    ),
                    onPanUpdate: (details) {
                      final delta = details.delta.dx;
                      widget.onSizeDeltaChanged(delta);
                    },
                  ),
                ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        leading,
                        const SizedBox(width: 8),
                        Expanded(child: title),
                        const SizedBox(width: 4),
                        if (selection.showDeleteButton)
                          IconButton(
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.trash,
                            ),
                            tooltip: AppLocalizations.of(
                              context,
                            ).delete,
                            onPressed: () {
                              selection.onDelete(context);
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
                          height: 42,
                          child: VerticalDivider(),
                        ),
                        if (!widget.isMobile)
                          BlocBuilder<CurrentIndexCubit, CurrentIndex>(
                            buildWhen: (previous, current) =>
                                previous.pinned != current.pinned,
                            builder: (context, state) => IconButton(
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
                              onPressed: () =>
                                  context.read<CurrentIndexCubit>().togglePin(),
                            ),
                          ),
                        const SizedBox(width: 8),
                        IconButton.outlined(
                          tooltip: MaterialLocalizations.of(context)
                              .closeButtonTooltip,
                          icon: const PhosphorIcon(
                            PhosphorIconsLight.x,
                          ),
                          onPressed: widget.closeView,
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
                          children: selection.buildProperties(
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
    );
  }
}
