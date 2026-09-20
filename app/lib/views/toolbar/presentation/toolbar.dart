import 'dart:math';

import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/presentation.dart';
import 'package:butterfly/dialogs/presentation/keyframe.dart';
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
  bool _advanced = false;

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
      (_animation?.keys.entries ?? const <MapEntry<int, AnimationKey>>[])
          .where((entry) => entry.value.breakpoint)
          .map((entry) => entry.key)
          .sorted((a, b) => a.compareTo(b));

  AnimationKey _cameraKey(CameraTransform transform) => AnimationKey(
    cameraPosition: transform.position.toPoint(),
    cameraZoom: transform.size,
    cameraRotation: transform.rotation,
    breakpoint: true,
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
    final spacing = max(1, animation.fps * 2).toInt();
    final frame = frames.isEmpty ? 0 : frames.last + spacing;
    final updated = animation.copyWith(
      duration: max(animation.duration, frame).toInt(),
      keys: Map.of(animation.keys)..[frame] = _cameraKey(transform),
    );
    _bloc.add(AnimationUpdated(animation.name, updated));
    setState(() => _animation = updated);
    _setFrame(frame);
  }

  void _updateSlide(CameraTransform transform) {
    final animation = _animation;
    if (animation == null || !(animation.keys[_frame]?.breakpoint ?? false)) {
      return;
    }
    _setKey(_cameraKey(transform));
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
    final colorScheme = ColorScheme.of(context);
    final defaultKey = _key ?? const AnimationKey();
    final keyframeEnabled =
        defaultKey.cameraPosition != null &&
        defaultKey.cameraZoom != null &&
        defaultKey.cameraRotation != null &&
        defaultKey.breakpoint;
    final cameraEnabled =
        defaultKey.cameraPosition != null &&
        defaultKey.cameraZoom != null &&
        defaultKey.cameraRotation != null;

    final animations = _bloc.state.page?.animations ?? [];
    final slideFrames = _slideFrames;
    final slideIndex = slideFrames.indexOf(_frame);

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
                        SegmentedButton<bool>(
                          showSelectedIcon: false,
                          segments: [
                            ButtonSegment(
                              value: false,
                              label: Text(AppLocalizations.of(context).simple),
                            ),
                            ButtonSegment(
                              value: true,
                              label: Text(
                                AppLocalizations.of(context).advanced,
                              ),
                            ),
                          ],
                          selected: {_advanced},
                          onSelectionChanged: (selection) =>
                              setState(() => _advanced = selection.first),
                        ),
                        const SizedBox(width: 8),
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
                        if (!_advanced)
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
                              ? AppLocalizations.of(context).play
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
                        if (!_advanced)
                          IconButton(
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.caretRight,
                            ),
                            tooltip: AppLocalizations.of(context).nextSlide,
                            onPressed: slideFrames.isEmpty
                                ? null
                                : () => _jumpSlide(1),
                          ),
                        if (!_advanced && _animation == null)
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
                        if (!_advanced && _animation != null)
                          FilledButton.tonalIcon(
                            onPressed: () => _addSlide(transform),
                            icon: const PhosphorIcon(PhosphorIconsLight.plus),
                            label: Text(AppLocalizations.of(context).addSlide),
                          ),
                        if (!_advanced && _animation != null)
                          IconButton(
                            onPressed: _key?.breakpoint ?? false
                                ? () => _updateSlide(transform)
                                : null,
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.floppyDisk,
                            ),
                            tooltip: AppLocalizations.of(context).updateSlide,
                          ),
                        if (!_advanced && _animation != null)
                          IconButton(
                            onPressed: () => _configureKeyframe(transform),
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.sliders,
                            ),
                            tooltip: AppLocalizations.of(context)
                                .configureKeyframe,
                          ),
                        if (_advanced)
                          IconButton(
                            icon: const PhosphorIcon(PhosphorIconsLight.stop),
                            tooltip: AppLocalizations.of(context).stop,
                            onPressed: _animation == null
                                ? null
                                : () {
                                    _setFrame(0);
                                    widget.onRunningStateChanged?.call(
                                      PresentationRunningState.paused,
                                    );
                                  },
                          ),
                        if (_advanced && _animation != null)
                          MenuAnchor(
                            builder: defaultMenuButton(
                              icon: const PhosphorIcon(
                                PhosphorIconsLight.record,
                              ),
                              tooltip: AppLocalizations.of(context).keyframe,
                            ),
                            menuChildren: [
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
                              const Divider(),
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.record,
                                ),
                                child: Text(
                                  AppLocalizations.of(context).keyframe,
                                  style: TextStyle(
                                    color: keyframeEnabled
                                        ? colorScheme.primary
                                        : null,
                                  ),
                                ),
                                onPressed: () => _setKey(
                                  keyframeEnabled
                                      ? defaultKey.copyWith(
                                          cameraPosition: null,
                                          cameraZoom: null,
                                          cameraRotation: null,
                                          breakpoint: false,
                                        )
                                      : defaultKey.copyWith(
                                          cameraPosition: transform.position
                                              .toPoint(),
                                          cameraZoom: transform.size,
                                          cameraRotation: transform.rotation,
                                          breakpoint: true,
                                        ),
                                ),
                              ),
                              const Divider(),
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.flowArrow,
                                ),
                                child: Text(
                                  AppLocalizations.of(context).camera,
                                  style: TextStyle(
                                    color: cameraEnabled
                                        ? colorScheme.primary
                                        : null,
                                  ),
                                ),
                                onPressed: () => _setKey(
                                  cameraEnabled
                                      ? defaultKey.copyWith(
                                          cameraPosition: null,
                                          cameraZoom: null,
                                          cameraRotation: null,
                                        )
                                      : defaultKey.copyWith(
                                          cameraPosition: transform.position
                                              .toPoint(),
                                          cameraZoom: transform.size,
                                          cameraRotation: transform.rotation,
                                        ),
                                ),
                              ),
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.camera,
                                ),
                                child: Text(
                                  AppLocalizations.of(context).breakpoint,
                                  style: TextStyle(
                                    color: defaultKey.breakpoint
                                        ? colorScheme.primary
                                        : null,
                                  ),
                                ),
                                onPressed: () => _setKey(
                                  defaultKey.copyWith(
                                    breakpoint: !defaultKey.breakpoint,
                                  ),
                                ),
                              ),
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.arrowClockwise,
                                ),
                                child: Text(
                                  AppLocalizations.of(context).rotation,
                                  style: TextStyle(
                                    color: defaultKey.cameraRotation != null
                                        ? colorScheme.primary
                                        : null,
                                  ),
                                ),
                                onPressed: () => _setKey(
                                  defaultKey.copyWith(
                                    cameraRotation: transform.rotation,
                                  ),
                                ),
                              ),
                              const Divider(),
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.arrowsOutCardinal,
                                ),
                                child: Text(
                                  AppLocalizations.of(context).position,
                                  style: TextStyle(
                                    color: defaultKey.cameraPosition != null
                                        ? colorScheme.primary
                                        : null,
                                  ),
                                ),
                                onPressed: () => _setKey(
                                  defaultKey.copyWith(
                                    cameraPosition: transform.position
                                        .toPoint(),
                                  ),
                                ),
                              ),
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.magnifyingGlass,
                                ),
                                child: Text(
                                  AppLocalizations.of(context).zoom,
                                  style: TextStyle(
                                    color: defaultKey.cameraZoom != null
                                        ? colorScheme.primary
                                        : null,
                                  ),
                                ),
                                onPressed: () => _setKey(
                                  defaultKey.copyWith(
                                    cameraZoom: transform.size,
                                  ),
                                ),
                              ),
                              const Divider(),
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.trash,
                                ),
                                onPressed: _key == null
                                    ? null
                                    : () {
                                        final bloc = context
                                            .read<DocumentBloc>();
                                        final updated = _animation!.copyWith(
                                          keys: Map.from(_animation!.keys)
                                            ..remove(_frame),
                                        );
                                        bloc.add(
                                          AnimationUpdated(
                                            _animation!.name,
                                            updated,
                                          ),
                                        );
                                        setState(() {
                                          _animation = updated;
                                          _key = null;
                                        });
                                      },
                                child: Text(
                                  AppLocalizations.of(context).delete,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    if (_animation != null)
                      Row(
                        mainAxisSize: .min,
                        children: [
                          if (!_advanced)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppLocalizations.of(context).slideOf(
                                      slideIndex < 0 ? 0 : slideIndex + 1,
                                      slideFrames.length,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge,
                                  ),
                                  const SizedBox(width: 8),
                                  ...slideFrames.indexed.map(
                                    (entry) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 2,
                                      ),
                                      child: Tooltip(
                                        message: AppLocalizations.of(context)
                                            .slideOf(
                                              entry.$1 + 1,
                                              slideFrames.length,
                                            ),
                                        child: ChoiceChip(
                                          label: Text('${entry.$1 + 1}'),
                                          selected: entry.$2 == _frame,
                                          onSelected: (_) =>
                                              _setFrame(entry.$2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (_advanced)
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
                                                context
                                                    .read<DocumentBloc>()
                                                    .add(
                                                      AnimationUpdated(
                                                        _animation!.name,
                                                        updated,
                                                      ),
                                                    );
                                                setState(
                                                  () => _animation = updated,
                                                );
                                              } else {
                                                _fpsController.text =
                                                    _animation!.fps.toString();
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
                                                    .copyWith(
                                                      duration: duration,
                                                    );
                                                context
                                                    .read<DocumentBloc>()
                                                    .add(
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
                          if (_advanced) const SizedBox(width: 8),
                          if (_advanced)
                            SizedBox(
                              width: max(150, constraints.maxWidth * 0.4),
                              child: PresentationTimelineView(
                                animationKeys: _animation!.keys.keys.toList(),
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
                              tooltip: AppLocalizations.of(context).export,
                            ),
                            menuChildren: [
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.playCircle,
                                ),
                                child: Text(AppLocalizations.of(context).play),
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
