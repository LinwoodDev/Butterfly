import 'dart:math';

import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/presentation.dart';
import 'package:butterfly/dialogs/presentation/keyframe.dart';
import 'package:butterfly/dialogs/presentation/transition.dart';
import 'package:butterfly/helpers/presentation.dart';
import 'package:butterfly/views/toolbar/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

import '../../../bloc/document_bloc.dart';
import '../../../dialogs/export/pdf.dart';
import '../../../handlers/handler.dart';
import 'timeline.dart';

class PresentationToolbarView extends StatefulWidget
    implements PreferredSizeWidget {
  final ValueChanged<int>? onFrameChanged;
  final ValueChanged<String?>? onAnimationChanged;
  final int frame;
  final String? animation;
  final PresentationRunningState runningState;
  final ValueChanged<PresentationRunningState>? onRunningStateChanged;

  const PresentationToolbarView({
    super.key,
    this.onFrameChanged,
    this.onAnimationChanged,
    this.animation,
    this.frame = 0,
    this.runningState = .paused,
    this.onRunningStateChanged,
  });

  @override
  State<PresentationToolbarView> createState() =>
      _PresentationToolbarViewState();

  @override
  Size get preferredSize => kToolbarLarge;
}

class _PresentationToolbarViewState extends State<PresentationToolbarView> {
  final ScrollController _scrollController = .new();
  final TextEditingController _frameController = .new(),
      _durationController = TextEditingController(),
      _fpsController = TextEditingController();
  late final DocumentBloc _bloc;
  String? _selected;
  AnimationTrack? _animation;
  AnimationKey? _key;
  int _frame = 0;
  double _newSlideDuration = 1;

  @override
  void initState() {
    super.initState();
    _frame = widget.frame;
    _bloc = context.read<DocumentBloc>();
    _selected = widget.animation;
    _animation = _selected == null
        ? null
        : _bloc.state.page?.getAnimation(_selected!);
    _updateControllers();
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
  void didUpdateWidget(covariant PresentationToolbarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.frame != widget.frame) {
      _frame = _clampFrame(widget.frame);
      _key = _animation?.keys[_frame];
      _updateControllers();
    }
    if (oldWidget.animation != widget.animation) {
      _selected = widget.animation;
      _animation = _selected == null
          ? null
          : _bloc.state.page?.getAnimation(_selected!);
      _frame = _clampFrame(_frame);
      _key = _animation?.keys[_frame];
      _updateControllers();
    } else if (oldWidget.runningState != widget.runningState) {
      setState(() {});
    }
  }

  void _updateControllers() {
    if (_animation != null) {
      _durationController.text = _animation!.duration.toString();
      _fpsController.text = _animation!.fps.toString();
    } else {
      _durationController.clear();
      _fpsController.clear();
    }
    _frameController.text = _frame.toString();
  }

  int _clampFrame(int value) => value.clamp(0, _animation?.duration ?? 0);

  void _setAnimation(String? value) {
    final animation = value == null
        ? null
        : _bloc.state.page?.getAnimation(value);
    _selectAnimation(animation);
  }

  void _selectAnimation(AnimationTrack? animation, {int? frame}) {
    setState(() {
      _selected = animation?.name;
      _animation = animation;
      _frame = _clampFrame(frame ?? _frame);
      _key = animation?.keys[_frame];
      _updateControllers();
    });
    widget.onAnimationChanged?.call(animation?.name);
    widget.onFrameChanged?.call(_frame);
  }

  void _setFrame(int value) {
    final frame = _clampFrame(value);
    setState(() => _frame = frame);
    _frameController.text = _frame.toString();
    _key = _animation?.keys[_frame];
    widget.onFrameChanged?.call(frame);
  }

  void _setKey(AnimationKey key) {
    final updated = _animation!.copyWith(
      keys: Map.of(_animation!.keys)..[_frame] = key,
    );
    _bloc.add(AnimationUpdated(_animation!.name, updated));
    setState(() {
      _animation = updated;
      _key = key;
    });
  }

  List<int> get _slideFrames =>
      _animation == null ? const [] : presentationSlideFrames(_animation!);

  double get _transitionDuration {
    final animation = _animation;
    if (animation == null) return _newSlideDuration;
    final next = _slideFrames.firstWhereOrNull((frame) => frame > _frame);
    if (next == null) return _newSlideDuration;
    return (next - _frame) / max(1, animation.fps);
  }

  bool _cameraMatchesKey(CameraTransform transform, AnimationKey? key) {
    if (key?.cameraPosition == null ||
        key?.cameraZoom == null ||
        key?.cameraRotation == null) {
      return false;
    }
    const epsilon = 0.0001;
    final position = key!.cameraPosition!;
    return (position.x - transform.position.dx).abs() < epsilon &&
        (position.y - transform.position.dy).abs() < epsilon &&
        (key.cameraZoom! - transform.size).abs() < epsilon &&
        (key.cameraRotation! - transform.rotation).abs() < epsilon;
  }

  AnimationKey _cameraKey(
    CameraTransform transform, {
    bool breakpoint = true,
  }) => AnimationKey(
    cameraPosition: transform.position.toPoint(),
    cameraZoom: transform.size,
    cameraRotation: transform.rotation,
    breakpoint: breakpoint,
  );

  void _createQuickPresentation(
    CameraTransform transform,
    List<AnimationTrack> animations,
  ) {
    final baseName = AppLocalizations.of(context).presentation;
    var name = baseName;
    var suffix = 2;
    final names = animations.map((animation) => animation.name).toSet();
    while (names.contains(name)) {
      name = '$baseName $suffix';
      suffix++;
    }
    final track = AnimationTrack(
      name: name,
      keys: {0: _cameraKey(transform)},
      duration: 0,
    );
    _bloc.add(AnimationAdded(track));
    _selectAnimation(track, frame: 0);
  }

  void _addSlide(CameraTransform transform) {
    final animation = _animation;
    if (animation == null) return;
    final frames = _slideFrames;
    if (frames.isEmpty) {
      _setFrame(0);
      _setKey(_cameraKey(transform));
      return;
    }
    final afterFrame = frames.contains(_frame) ? _frame : frames.last;
    final durationFrames = max(
      1,
      (_transitionDuration * animation.fps).round(),
    ).toInt();
    final updated = insertPresentationSlide(
      animation,
      afterFrame: afterFrame,
      durationFrames: durationFrames,
      key: _cameraKey(transform),
    );
    final frame = afterFrame + durationFrames;
    _bloc.add(AnimationUpdated(animation.name, updated));
    setState(() {
      _animation = updated;
      _durationController.text = updated.duration.toString();
    });
    _setFrame(frame);
  }

  void _updateKeyframe(CameraTransform transform) {
    final key = _key;
    if (_animation == null || key == null) return;
    _setKey(_cameraKey(transform, breakpoint: key.breakpoint));
  }

  Future<void> _configureTransition() async {
    final animation = _animation;
    if (animation == null) return;
    final duration = await showDialog<double>(
      context: context,
      builder: (context) =>
          TransitionDurationDialog(duration: _transitionDuration),
    );
    if (duration == null || !mounted) return;
    final next = _slideFrames.firstWhereOrNull((frame) => frame > _frame);
    if (next == null) {
      setState(() => _newSlideDuration = duration);
      return;
    }
    final updated = setPresentationTransitionDuration(
      animation,
      fromFrame: _frame,
      durationFrames: max(1, (duration * animation.fps).round()).toInt(),
    );
    _bloc.add(AnimationUpdated(animation.name, updated));
    setState(() {
      _animation = updated;
      _durationController.text = updated.duration.toString();
    });
  }

  Future<void> _deleteSlide() async {
    final animation = _animation;
    final frames = _slideFrames;
    if (animation == null || !frames.contains(_frame)) return;
    final remove = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).deleteSlide),
        content: Text(AppLocalizations.of(context).removeConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context).delete),
          ),
        ],
      ),
    );
    if (remove != true || !mounted) return;
    final index = frames.indexOf(_frame);
    final target = index <= 0 ? 0 : frames[index - 1];
    final updated = frames.length == 1
        ? animation.copyWith(keys: Map.of(animation.keys)..remove(_frame))
        : removePresentationSlide(animation, _frame);
    _bloc.add(AnimationUpdated(animation.name, updated));
    setState(() {
      _animation = updated;
      _durationController.text = updated.duration.toString();
    });
    _setFrame(target);
  }

  void _deleteKeyframe() {
    final animation = _animation;
    if (animation == null || _key == null) return;
    final updated = animation.copyWith(
      keys: Map.of(animation.keys)..remove(_frame),
    );
    _bloc.add(AnimationUpdated(animation.name, updated));
    setState(() {
      _animation = updated;
      _key = null;
    });
  }

  void _jumpSlide(int direction) {
    final frames = _slideFrames;
    if (frames.isEmpty) return;
    final target = direction < 0
        ? frames.lastWhereOrNull((frame) => frame < _frame) ?? frames.first
        : frames.firstWhereOrNull((frame) => frame > _frame) ?? frames.last;
    _setFrame(target);
  }

  Future<void> _configureKeyframe(CameraTransform transform) async {
    if (_animation == null) return;
    final configured = await showDialog<AnimationKey>(
      context: context,
      builder: (context) => KeyframeConfigurationDialog(
        keyframe: _key ?? const AnimationKey(),
        camera: transform,
      ),
    );
    if (configured != null && mounted) _setKey(configured);
  }

  @override
  Widget build(BuildContext context) {
    final animations = _bloc.state.page?.animations ?? [];
    final slideFrames = _slideFrames;
    final slideIndex = slideFrames.indexOf(_frame);
    final currentIsSlide = slideIndex >= 0;

    return BlocBuilder<TransformCubit, CameraTransform>(
      builder: (context, transform) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: LayoutBuilder(
          builder: (context, constraints) => Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: .horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: Row(
                  mainAxisSize: .min,
                  mainAxisAlignment: .spaceAround,
                  children: [
                    Row(
                      mainAxisSize: .min,
                      children: [
                        DropdownMenu<String>(
                          width: 150,
                          inputDecorationTheme: const InputDecorationTheme(
                            filled: true,
                          ),
                          label: Text(AppLocalizations.of(context).animation),
                          dropdownMenuEntries: animations
                              .map(
                                (e) => DropdownMenuEntry(
                                  value: e.name,
                                  label: e.name,
                                ),
                              )
                              .toList(),
                          onSelected: _setAnimation,
                          initialSelection: _selected,
                        ),
                        MenuAnchor(
                          builder: defaultMenuButton(
                            tooltip: AppLocalizations.of(context).animation,
                          ),
                          menuChildren: [
                            MenuItemButton(
                              leadingIcon: const PhosphorIcon(
                                PhosphorIconsLight.plus,
                              ),
                              onPressed: () async {
                                final bloc = context.read<DocumentBloc>();
                                final name = await showDialog<String>(
                                  context: context,
                                  builder: (context) => NameDialog(
                                    validator: defaultFileNameValidator(
                                      context,
                                      animations.map((e) => e.name).toList(),
                                    ),
                                  ),
                                );
                                if (name == null) return;
                                final track = AnimationTrack(name: name);
                                bloc.add(AnimationAdded(track));
                                _selectAnimation(track, frame: 0);
                              },
                              child: Text(LeapLocalizations.of(context).create),
                            ),
                            MenuItemButton(
                              leadingIcon: const PhosphorIcon(
                                PhosphorIconsLight.copy,
                              ),
                              onPressed: _animation == null
                                  ? null
                                  : () async {
                                      final bloc = context.read<DocumentBloc>();
                                      final name = await showDialog<String>(
                                        context: context,
                                        builder: (context) => NameDialog(
                                          validator: defaultFileNameValidator(
                                            context,
                                            animations
                                                .map((e) => e.name)
                                                .toList(),
                                          ),
                                          button: AppLocalizations.of(context)
                                              .duplicate,
                                        ),
                                      );
                                      if (name == null) return;
                                      final duplicate = _animation!.copyWith(
                                        name: name,
                                      );
                                      bloc.add(AnimationAdded(duplicate));
                                      _selectAnimation(duplicate, frame: 0);
                                    },
                              child: Text(
                                AppLocalizations.of(context).duplicate,
                              ),
                            ),
                            MenuItemButton(
                              leadingIcon: const PhosphorIcon(
                                PhosphorIconsLight.pencil,
                              ),
                              onPressed: _animation == null
                                  ? null
                                  : () async {
                                      final bloc = context.read<DocumentBloc>();
                                      final name = await showDialog<String>(
                                        context: context,
                                        builder: (context) => NameDialog(
                                          value: _animation!.name,
                                          validator: defaultNameValidator(
                                            context,
                                            animations
                                                .map((e) => e.name)
                                                .toList(),
                                          ),
                                          button: AppLocalizations.of(context)
                                              .rename,
                                        ),
                                      );
                                      if (name == null) return;
                                      final previousName = _animation!.name;
                                      final renamed = _animation!.copyWith(
                                        name: name,
                                      );
                                      bloc.add(
                                        AnimationUpdated(previousName, renamed),
                                      );
                                      _selectAnimation(renamed);
                                    },
                              child: Text(AppLocalizations.of(context).rename),
                            ),
                            MenuItemButton(
                              leadingIcon: const PhosphorIcon(
                                PhosphorIconsLight.trash,
                              ),
                              onPressed: _animation == null
                                  ? null
                                  : () async {
                                      final remove = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            AppLocalizations.of(context).delete,
                                          ),
                                          content: Text(
                                            AppLocalizations.of(context)
                                                .removeConfirm,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: Text(
                                                MaterialLocalizations.of(
                                                  context,
                                                ).cancelButtonLabel,
                                              ),
                                            ),
                                            FilledButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                              child: Text(
                                                AppLocalizations.of(context)
                                                    .delete,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                      if (remove != true || !context.mounted) {
                                        return;
                                      }
                                      final bloc = context.read<DocumentBloc>();
                                      final removedName = _animation!.name;
                                      final nextAnimation = animations
                                          .where((e) => e.name != removedName)
                                          .firstOrNull;
                                      bloc.add(AnimationRemoved(removedName));
                                      _selectAnimation(nextAnimation, frame: 0);
                                    },
                              child: Text(AppLocalizations.of(context).delete),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const PhosphorIcon(
                            PhosphorIconsLight.caretLeft,
                          ),
                          tooltip: AppLocalizations.of(context).previousSlide,
                          onPressed: slideFrames.isEmpty
                              ? null
                              : () => _jumpSlide(-1),
                        ),
                        IconButton(
                          icon:
                              widget.runningState !=
                                  PresentationRunningState.running
                              ? const PhosphorIcon(
                                  PhosphorIconsLight.play,
                                  textDirection: .ltr,
                                )
                              : const PhosphorIcon(PhosphorIconsLight.pause),
                          tooltip:
                              widget.runningState !=
                                  PresentationRunningState.running
                              ? AppLocalizations.of(context).preview
                              : AppLocalizations.of(context).pause,
                          onPressed: _animation == null
                              ? null
                              : () {
                                  if (widget.runningState ==
                                      PresentationRunningState.running) {
                                    widget.onRunningStateChanged?.call(
                                      PresentationRunningState.paused,
                                    );
                                  } else {
                                    if (_animation!.duration <= _frame) {
                                      _setFrame(0);
                                    }
                                    widget.onRunningStateChanged?.call(
                                      PresentationRunningState.running,
                                    );
                                  }
                                },
                        ),
                        IconButton(
                          icon: const PhosphorIcon(
                            PhosphorIconsLight.caretRight,
                          ),
                          tooltip: AppLocalizations.of(context).nextSlide,
                          onPressed: slideFrames.isEmpty
                              ? null
                              : () => _jumpSlide(1),
                        ),
                        if (_animation == null)
                          FilledButton.icon(
                            onPressed: () =>
                                _createQuickPresentation(transform, animations),
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.presentation,
                            ),
                            label: Text(
                              AppLocalizations.of(context).createPresentation,
                            ),
                          ),
                        if (_animation != null)
                          FilledButton.tonalIcon(
                            onPressed: () => _addSlide(transform),
                            icon: const PhosphorIcon(PhosphorIconsLight.plus),
                            label: Text(AppLocalizations.of(context).addSlide),
                          ),
                      ],
                    ),
                    if (_animation != null)
                      Row(
                        mainAxisSize: .min,
                        children: [
                          MenuAnchor(
                            builder: (context, controller, child) =>
                                TextButton.icon(
                                  onPressed: controller.isOpen
                                      ? controller.close
                                      : controller.open,
                                  icon: const PhosphorIcon(
                                    PhosphorIconsLight.record,
                                  ),
                                  label: Text(
                                    currentIsSlide
                                        ? AppLocalizations.of(
                                            context,
                                          ).slideAtFrame(slideIndex + 1, _frame)
                                        : _key != null
                                        ? AppLocalizations.of(context)
                                              .keyframeAtFrame(_frame)
                                        : AppLocalizations.of(context)
                                              .frameValue(_frame),
                                  ),
                                ),
                            menuChildren: [
                              if (_key == null)
                                MenuItemButton(
                                  leadingIcon: const PhosphorIcon(
                                    PhosphorIconsLight.plus,
                                  ),
                                  onPressed: () => _setKey(
                                    _cameraKey(transform, breakpoint: false),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context).addKeyframe,
                                  ),
                                ),
                              if (_key != null)
                                MenuItemButton(
                                  leadingIcon: const PhosphorIcon(
                                    PhosphorIconsLight.camera,
                                  ),
                                  onPressed: !_cameraMatchesKey(transform, _key)
                                      ? () => _updateKeyframe(transform)
                                      : null,
                                  child: Text(
                                    AppLocalizations.of(context).updateKeyframe,
                                  ),
                                ),
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.sliders,
                                ),
                                onPressed: () => _configureKeyframe(transform),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .configureKeyframe,
                                ),
                              ),
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.presentation,
                                ),
                                onPressed: () {
                                  final key = _key;
                                  _setKey(
                                    key == null
                                        ? _cameraKey(transform)
                                        : key.copyWith(
                                            breakpoint: !key.breakpoint,
                                          ),
                                  );
                                },
                                child: Text(
                                  currentIsSlide
                                      ? AppLocalizations.of(context)
                                            .removeSlideMarker
                                      : AppLocalizations.of(context)
                                            .markAsSlide,
                                ),
                              ),
                              if (currentIsSlide)
                                MenuItemButton(
                                  leadingIcon: const PhosphorIcon(
                                    PhosphorIconsLight.timer,
                                  ),
                                  onPressed: _configureTransition,
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    ).transitionDurationValue(
                                      _transitionDuration.toStringAsFixed(1),
                                    ),
                                  ),
                                ),
                              const Divider(),
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.trash,
                                ),
                                onPressed: currentIsSlide
                                    ? _deleteSlide
                                    : (_key != null ? _deleteKeyframe : null),
                                child: Text(
                                  currentIsSlide
                                      ? AppLocalizations.of(context).deleteSlide
                                      : AppLocalizations.of(context)
                                            .deleteKeyframe,
                                ),
                              ),
                            ],
                          ),
                          MenuAnchor(
                            builder: defaultMenuButton(
                              icon: const PhosphorIcon(
                                PhosphorIconsLight.faders,
                              ),
                              tooltip: AppLocalizations.of(context).settings,
                            ),
                            menuChildren: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 300,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            filled: true,
                                            labelText: AppLocalizations.of(
                                              context,
                                            ).fps,
                                          ),
                                          controller: _fpsController,
                                          textAlign: .center,
                                          keyboardType: TextInputType.number,
                                          onFieldSubmitted: (value) {
                                            final fps = int.tryParse(
                                              value.trim(),
                                            );
                                            if (fps != null && fps > 0) {
                                              final updated = _animation!
                                                  .copyWith(fps: fps);
                                              context.read<DocumentBloc>().add(
                                                AnimationUpdated(
                                                  _animation!.name,
                                                  updated,
                                                ),
                                              );
                                              setState(
                                                () => _animation = updated,
                                              );
                                            } else {
                                              _fpsController.text = _animation!
                                                  .fps
                                                  .toString();
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            filled: true,
                                            labelText: AppLocalizations.of(
                                              context,
                                            ).frame,
                                          ),
                                          controller: _frameController,
                                          textAlign: .center,
                                          keyboardType: TextInputType.number,
                                          onFieldSubmitted: (value) {
                                            final frame = int.tryParse(
                                              value.trim(),
                                            );
                                            if (frame != null) {
                                              _setFrame(frame);
                                            } else {
                                              _frameController.text = _frame
                                                  .toString();
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            filled: true,
                                            labelText: AppLocalizations.of(
                                              context,
                                            ).duration,
                                          ),
                                          controller: _durationController,
                                          textAlign: .center,
                                          keyboardType: TextInputType.number,
                                          onFieldSubmitted: (value) {
                                            final duration = int.tryParse(
                                              value.trim(),
                                            );
                                            final lastKey = _animation!
                                                .keys
                                                .keys
                                                .fold(0, max);
                                            if (duration != null &&
                                                duration > 0 &&
                                                duration >= lastKey) {
                                              final updated = _animation!
                                                  .copyWith(duration: duration);
                                              context.read<DocumentBloc>().add(
                                                AnimationUpdated(
                                                  _animation!.name,
                                                  updated,
                                                ),
                                              );
                                              setState(
                                                () => _animation = updated,
                                              );
                                              if (_frame > duration) {
                                                _setFrame(duration);
                                              }
                                            } else {
                                              _durationController.text =
                                                  _animation!.duration
                                                      .toString();
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: max(150, constraints.maxWidth * 0.4),
                            child: PresentationTimelineView(
                              animationKeys: _animation!.keys.keys.toList(),
                              slideFrames: slideFrames,
                              currentFrame: _frame,
                              duration: _animation!.duration,
                              onFrameChanged: _setFrame,
                            ),
                          ),
                          const SizedBox(width: 8),
                          MenuAnchor(
                            builder: defaultMenuButton(
                              icon: const PhosphorIcon(
                                PhosphorIconsLight.presentation,
                              ),
                              tooltip: AppLocalizations.of(context)
                                  .presentation,
                            ),
                            menuChildren: [
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.playCircle,
                                ),
                                child: Text(
                                  AppLocalizations.of(context).presentation,
                                ),
                                onPressed: () async {
                                  final bloc = context.read<DocumentBloc>();
                                  final fullScreen = await isFullScreen();
                                  if (context.mounted) {
                                    final requestedFullScreen =
                                        await showDialog<bool>(
                                          context: context,
                                          builder: (context) =>
                                              PresentationControlsDialog(
                                                fullScreen: fullScreen,
                                              ),
                                        );
                                    if (requestedFullScreen == null) return;
                                    if (requestedFullScreen != fullScreen) {
                                      await setFullScreen(requestedFullScreen);
                                    }
                                    bloc.add(
                                      PresentationModeEntered(
                                        _animation!,
                                        fullScreen,
                                      ),
                                    );
                                  }
                                },
                              ),
                              const Divider(),
                              /*
                              MenuItemButton(
                                leadingIcon:
                                    PhosphorIcon(PhosphorIconsLight.videoCamera),
                                child: Text(AppLocalizations.of(context).video),
                              ),
                              MenuItemButton(
                                leadingIcon:
                                    PhosphorIcon(PhosphorIconsLight.filmStrip),
                                child: Text(AppLocalizations.of(context).image),
                              ),*/
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.file,
                                  textDirection: .ltr,
                                ),
                                child: Text(AppLocalizations.of(context).pdf),
                                onPressed: () {
                                  final size = MediaQuery.sizeOf(context);
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => BlocProvider.value(
                                      value: context.read<DocumentBloc>(),
                                      child: PdfExportDialog(
                                        areas:
                                            {
                                              0,
                                              ..._animation!.keys.entries
                                                  .where(
                                                    (element) => element
                                                        .value
                                                        .breakpoint,
                                                  )
                                                  .map((e) => e.key)
                                                  .sorted(
                                                    (a, b) => a.compareTo(b),
                                                  ),
                                            }.map((e) {
                                              final zoom =
                                                  _animation!
                                                      .interpolateCameraZoom(
                                                        e,
                                                      ) ??
                                                  transform.size;
                                              final position =
                                                  _animation!
                                                      .interpolateCameraPosition(
                                                        e,
                                                      ) ??
                                                  transform.position.toPoint();
                                              return AreaPreset(
                                                name: e.toString(),
                                                area: Area(
                                                  position: position,
                                                  height: size.height / zoom,
                                                  width: size.width / zoom,
                                                ),
                                                quality: zoom,
                                              );
                                            }).toList(),
                                      ),
                                    ),
                                  );
                                },
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
      ),
    );
  }
}
