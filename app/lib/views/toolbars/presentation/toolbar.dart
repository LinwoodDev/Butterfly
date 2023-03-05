import 'dart:math';

import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../bloc/document_bloc.dart';
import 'timeline.dart';

class PresentationToolbarView extends StatefulWidget {
  final ValueChanged<int>? onFrameChanged;
  final ValueChanged<String?>? onAnimationChanged;
  final int frame;
  final String? animation;

  const PresentationToolbarView({
    super.key,
    this.onFrameChanged,
    this.onAnimationChanged,
    this.animation,
    this.frame = 0,
  });

  @override
  State<PresentationToolbarView> createState() =>
      _PresentationToolbarViewState();
}

class _PresentationToolbarViewState extends State<PresentationToolbarView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _frameController = TextEditingController(),
      _durationController = TextEditingController(),
      _fpsController = TextEditingController();
  String? _selected;
  int _frame = 0;
  @override
  void initState() {
    super.initState();
    _frame = widget.frame;
    if (widget.animation != null) {
      _selected = widget.animation;
    } else {
      _resetSelection();
    }
  }

  @override
  void didUpdateWidget(covariant PresentationToolbarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.frame != widget.frame) {
      setState(() => _frameController.text = widget.frame.toString());
    } else if (oldWidget.animation != widget.animation) {
      setState(() => _selected = widget.animation);
    }
  }

  void _setAnimation(String? value) {
    setState(() => _selected = value);
    widget.onAnimationChanged?.call(value);
  }

  void _setFrame(int value) {
    setState(() => _frame = value);
    widget.onFrameChanged?.call(value);
  }

  void _resetSelection() {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return;
    _setAnimation(state.document.animations.firstOrNull?.name);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _frameController.dispose();
    _durationController.dispose();
    _fpsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return const SizedBox();
    final animation =
        _selected == null ? null : state.document.getAnimation(_selected!);
    if (animation != null) {
      _durationController.text = animation.duration.toString();
      _fpsController.text = animation.fps.toString();
      _frameController.text = _frame.toString();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: LayoutBuilder(
        builder: (context, constraints) => Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownMenu<String>(
                        width: 200,
                        key: UniqueKey(),
                        inputDecorationTheme:
                            const InputDecorationTheme(filled: true),
                        dropdownMenuEntries: state.document.animations
                            .map((e) => DropdownMenuEntry(
                                  value: e.name,
                                  label: e.name,
                                ))
                            .toList(),
                        onSelected: _setAnimation,
                        initialSelection: _selected,
                      ),
                      MenuAnchor(
                        builder: (context, controller, child) {
                          return IconButton(
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            icon: const Icon(Icons.more_vert),
                          );
                        },
                        menuChildren: [
                          MenuItemButton(
                            leadingIcon: const Icon(PhosphorIcons.plusLight),
                            onPressed: () async {
                              final bloc = context.read<DocumentBloc>();
                              final name = await showDialog<String>(
                                context: context,
                                builder: (context) => NameDialog(
                                  validator: defaultNameValidator(
                                      context,
                                      null,
                                      state.document.animations
                                          .map((e) => e.name)
                                          .toList()),
                                ),
                              );
                              if (name == null) return;
                              bloc.add(
                                DocumentAnimationAdded(AnimationTrack(
                                  name: name,
                                )),
                              );
                              _setAnimation(name);
                            },
                            child: Text(AppLocalizations.of(context).create),
                          ),
                          MenuItemButton(
                            leadingIcon: const Icon(PhosphorIcons.copyLight),
                            onPressed: animation == null
                                ? null
                                : () async {
                                    final bloc = context.read<DocumentBloc>();
                                    final name = await showDialog<String>(
                                      context: context,
                                      builder: (context) => NameDialog(
                                        validator: defaultNameValidator(
                                            context,
                                            null,
                                            state.document.animations
                                                .map((e) => e.name)
                                                .toList()),
                                      ),
                                    );
                                    if (name == null) return;
                                    bloc.add(
                                      DocumentAnimationAdded(
                                          animation.copyWith(name: name)),
                                    );
                                    _setAnimation(name);
                                    _setFrame(0);
                                  },
                            child: Text(AppLocalizations.of(context).duplicate),
                          ),
                          MenuItemButton(
                            leadingIcon: const Icon(PhosphorIcons.pencilLight),
                            onPressed: animation == null
                                ? null
                                : () async {
                                    final bloc = context.read<DocumentBloc>();
                                    final name = await showDialog<String>(
                                      context: context,
                                      builder: (context) => NameDialog(
                                        validator: defaultNameValidator(
                                            context,
                                            animation.name,
                                            state.document.animations
                                                .map((e) => e.name)
                                                .toList()),
                                      ),
                                    );
                                    if (name == null) return;
                                    bloc.add(
                                      DocumentAnimationAdded(animation.copyWith(
                                        name: name,
                                      )),
                                    );
                                    _setAnimation(name);
                                  },
                            child: Text(AppLocalizations.of(context).rename),
                          ),
                          MenuItemButton(
                            leadingIcon: const Icon(PhosphorIcons.trashLight),
                            onPressed: animation == null
                                ? null
                                : () {
                                    final bloc = context.read<DocumentBloc>();
                                    bloc.add(
                                      DocumentAnimationRemoved(animation.name),
                                    );
                                    setState(() {
                                      _resetSelection();
                                    });
                                  },
                            child: Text(AppLocalizations.of(context).delete),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(PhosphorIcons.playLight),
                        onPressed: animation == null ? null : () {},
                      ),
                      IconButton(
                        icon: const Icon(PhosphorIcons.stopLight),
                        onPressed: animation == null ? null : () {},
                      ),
                      IconButton(
                        icon: const Icon(PhosphorIcons.recordLight),
                        onPressed: animation == null ? null : () {},
                      ),
                    ],
                  ),
                  if (animation != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              labelText: AppLocalizations.of(context).fps,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                            controller: _fpsController,
                            textAlign: TextAlign.center,
                            onEditingComplete: () {},
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              labelText: AppLocalizations.of(context).frame,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                            controller: _frameController,
                            textAlign: TextAlign.center,
                            onEditingComplete: () {},
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: max(200, constraints.maxWidth * 0.25),
                          child: PresentationTimelineView(
                            animationKeys: animation.keys.keys.toList(),
                            currentFrame: _frame,
                            duration: animation.duration,
                            onFrameChanged: _setFrame,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              labelText: AppLocalizations.of(context).duration,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                            controller: _durationController,
                            textAlign: TextAlign.center,
                            onEditingComplete: () {
                              final value =
                                  int.tryParse(_durationController.text.trim());
                              if (value != null && value > 0) {
                                context.read<DocumentBloc>().add(
                                      DocumentAnimationUpdated(
                                        animation.name,
                                        animation.copyWith(duration: value),
                                      ),
                                    );
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        MenuAnchor(
                          builder: (context, controller, child) => IconButton(
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            icon: const Icon(PhosphorIcons.presentationLight),
                          ),
                          menuChildren: [
                            MenuItemButton(
                              leadingIcon:
                                  const Icon(PhosphorIcons.playCircleLight),
                              child: Text(AppLocalizations.of(context).play),
                            ),
                            const Divider(),
                            MenuItemButton(
                              leadingIcon:
                                  const Icon(PhosphorIcons.videoCameraLight),
                              child: Text(AppLocalizations.of(context).video),
                            ),
                            MenuItemButton(
                              leadingIcon:
                                  const Icon(PhosphorIcons.filmStripLight),
                              child: Text(AppLocalizations.of(context).image),
                            ),
                            MenuItemButton(
                              leadingIcon: const Icon(PhosphorIcons.fileLight),
                              child: Text(AppLocalizations.of(context).pdf),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
