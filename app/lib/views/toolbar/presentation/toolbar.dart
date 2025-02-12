import 'dart:math';

import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/presentation.dart';
import 'package:butterfly/views/toolbar/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    this.runningState = PresentationRunningState.paused,
    this.onRunningStateChanged,
  });

  @override
  State<PresentationToolbarView> createState() =>
      _PresentationToolbarViewState();

  @override
  Size get preferredSize => kToolbarLarge;
}

class _PresentationToolbarViewState extends State<PresentationToolbarView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _frameController = TextEditingController(),
      _durationController = TextEditingController(),
      _fpsController = TextEditingController();
  late final DocumentBloc _bloc;
  String? _selected;
  AnimationTrack? _animation;
  AnimationKey? _key;
  int _frame = 0;

  @override
  void initState() {
    super.initState();
    _frame = widget.frame;
    _bloc = context.read<DocumentBloc>();
    _selected =
        widget.animation ?? _bloc.state.page?.animations.firstOrNull?.name;
    _animation =
        _selected == null ? null : _bloc.state.page?.getAnimation(_selected!);
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
      setState(() => _frame = widget.frame);
    } else if (oldWidget.animation != widget.animation) {
      setState(() => _selected = widget.animation);
    } else if (oldWidget.runningState != widget.runningState) {
      setState(() {});
    }
  }

  void _updateControllers() {
    if (_animation != null) {
      _durationController.text = _animation!.duration.toString();
      _fpsController.text = _animation!.fps.toString();
    }
    _frameController.text = _frame.toString();
  }

  void _setAnimation(String? value) {
    final animation =
        _selected == null ? null : _bloc.state.page?.getAnimation(_selected!);
    setState(() {
      _selected = value;
      _animation = animation;
      _key = animation?.keys[_frame];
    });
    _updateControllers();
    widget.onAnimationChanged?.call(value);
  }

  void _setFrame(int value) {
    setState(() => _frame = value);
    _frameController.text = _frame.toString();
    _key = _animation?.keys[_frame];
    widget.onFrameChanged?.call(value);
  }

  void _resetSelection() {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return;
    _setAnimation(state.page.animations.firstOrNull?.name);
  }

  void _setKey(AnimationKey key) {
    final updated = _animation!.copyWith(
      keys: Map.of(_animation!.keys)..[_frame] = key,
    );
    _bloc.add(
      AnimationUpdated(
        _animation!.name,
        updated,
      ),
    );
    setState(() {
      _animation = updated;
      _key = key;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final defaultKey = _key ?? const AnimationKey();
    final keyframeEnabled = defaultKey.cameraPosition != null &&
        defaultKey.cameraZoom != null &&
        defaultKey.breakpoint;
    final cameraEnabled =
        defaultKey.cameraPosition != null && defaultKey.cameraZoom != null;

    final animations = _bloc.state.page?.animations ?? [];

    return BlocBuilder<TransformCubit, CameraTransform>(
      builder: (context, transform) => Padding(
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
                          dropdownMenuEntries: animations
                              .map((e) => DropdownMenuEntry(
                                    value: e.name,
                                    label: e.name,
                                  ))
                              .toList(),
                          onSelected: _setAnimation,
                          initialSelection: _selected,
                        ),
                        MenuAnchor(
                          builder: defaultMenuButton(
                            tooltip: AppLocalizations.of(context).presentation,
                          ),
                          menuChildren: [
                            MenuItemButton(
                              leadingIcon:
                                  const PhosphorIcon(PhosphorIconsLight.plus),
                              onPressed: () async {
                                final bloc = context.read<DocumentBloc>();
                                final name = await showDialog<String>(
                                  context: context,
                                  builder: (context) => NameDialog(),
                                );
                                if (name == null) return;
                                final track = AnimationTrack(
                                  name: name,
                                );
                                bloc.add(
                                  AnimationAdded(track),
                                );
                                setState(() {
                                  _animation = track;
                                  _updateControllers();
                                });
                              },
                              child: Text(LeapLocalizations.of(context).create),
                            ),
                            MenuItemButton(
                              leadingIcon:
                                  const PhosphorIcon(PhosphorIconsLight.copy),
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
                                                  .toList()),
                                          button: AppLocalizations.of(context)
                                              .duplicate,
                                        ),
                                      );
                                      if (name == null) return;
                                      bloc.add(
                                        AnimationAdded(
                                            _animation!.copyWith(name: name)),
                                      );
                                      _setAnimation(name);
                                      _setFrame(0);
                                    },
                              child:
                                  Text(AppLocalizations.of(context).duplicate),
                            ),
                            MenuItemButton(
                              leadingIcon:
                                  const PhosphorIcon(PhosphorIconsLight.pencil),
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
                                                  .toList()),
                                          button: AppLocalizations.of(context)
                                              .rename,
                                        ),
                                      );
                                      if (name == null) return;
                                      bloc.add(
                                        AnimationUpdated(
                                            _animation!.name,
                                            _animation!.copyWith(
                                              name: name,
                                            )),
                                      );
                                      _setAnimation(name);
                                    },
                              child: Text(AppLocalizations.of(context).rename),
                            ),
                            MenuItemButton(
                              leadingIcon:
                                  const PhosphorIcon(PhosphorIconsLight.trash),
                              onPressed: _animation == null
                                  ? null
                                  : () {
                                      final bloc = context.read<DocumentBloc>();
                                      bloc.add(
                                        AnimationRemoved(_animation!.name),
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
                          icon: widget.runningState !=
                                  PresentationRunningState.running
                              ? const PhosphorIcon(PhosphorIconsLight.play)
                              : const PhosphorIcon(PhosphorIconsLight.pause),
                          tooltip: widget.runningState !=
                                  PresentationRunningState.running
                              ? AppLocalizations.of(context).play
                              : AppLocalizations.of(context).pause,
                          onPressed: _animation == null
                              ? null
                              : () {
                                  if (widget.runningState ==
                                      PresentationRunningState.running) {
                                    widget.onRunningStateChanged
                                        ?.call(PresentationRunningState.paused);
                                  } else {
                                    if (_animation!.duration <= _frame) {
                                      _setFrame(0);
                                    }
                                    widget.onRunningStateChanged?.call(
                                        PresentationRunningState.running);
                                  }
                                },
                        ),
                        IconButton(
                          icon: const PhosphorIcon(PhosphorIconsLight.stop),
                          tooltip: AppLocalizations.of(context).stop,
                          onPressed: _animation == null
                              ? null
                              : () {
                                  _setFrame(0);
                                  widget.onRunningStateChanged
                                      ?.call(PresentationRunningState.paused);
                                },
                        ),
                        MenuAnchor(
                          builder: defaultMenuButton(
                            icon: const PhosphorIcon(PhosphorIconsLight.record),
                            tooltip: AppLocalizations.of(context).keyframe,
                          ),
                          menuChildren: [
                            MenuItemButton(
                              leadingIcon:
                                  const PhosphorIcon(PhosphorIconsLight.record),
                              child: Text(
                                AppLocalizations.of(context).keyframe,
                                style: TextStyle(
                                  color: keyframeEnabled
                                      ? colorScheme.primary
                                      : null,
                                ),
                              ),
                              onPressed: () => _setKey(keyframeEnabled
                                  ? defaultKey.copyWith(
                                      cameraPosition: null,
                                      cameraZoom: null,
                                      breakpoint: false,
                                    )
                                  : defaultKey.copyWith(
                                      cameraPosition:
                                          transform.position.toPoint(),
                                      cameraZoom: transform.size,
                                      breakpoint: true,
                                    )),
                            ),
                            const Divider(),
                            MenuItemButton(
                              leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.flowArrow),
                              child: Text(
                                AppLocalizations.of(context).camera,
                                style: TextStyle(
                                  color: cameraEnabled
                                      ? colorScheme.primary
                                      : null,
                                ),
                              ),
                              onPressed: () => _setKey(cameraEnabled
                                  ? defaultKey.copyWith(
                                      cameraPosition: null,
                                      cameraZoom: null,
                                    )
                                  : defaultKey.copyWith(
                                      cameraPosition:
                                          transform.position.toPoint(),
                                      cameraZoom: transform.size,
                                    )),
                            ),
                            MenuItemButton(
                              leadingIcon:
                                  const PhosphorIcon(PhosphorIconsLight.camera),
                              child: Text(
                                AppLocalizations.of(context).breakpoint,
                                style: TextStyle(
                                  color: defaultKey.breakpoint
                                      ? colorScheme.primary
                                      : null,
                                ),
                              ),
                              onPressed: () => _setKey(defaultKey.copyWith(
                                breakpoint: !defaultKey.breakpoint,
                              )),
                            ),
                            const Divider(),
                            MenuItemButton(
                              leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.arrowsOutCardinal),
                              child: Text(
                                AppLocalizations.of(context).position,
                                style: TextStyle(
                                  color: defaultKey.cameraPosition != null
                                      ? colorScheme.primary
                                      : null,
                                ),
                              ),
                              onPressed: () => _setKey(defaultKey.copyWith(
                                cameraPosition: transform.position.toPoint(),
                              )),
                            ),
                            MenuItemButton(
                              leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.magnifyingGlass),
                              child: Text(
                                AppLocalizations.of(context).zoom,
                                style: TextStyle(
                                  color: defaultKey.cameraZoom != null
                                      ? colorScheme.primary
                                      : null,
                                ),
                              ),
                              onPressed: () => _setKey(defaultKey.copyWith(
                                cameraZoom: transform.size,
                              )),
                            ),
                            const Divider(),
                            MenuItemButton(
                              leadingIcon:
                                  const PhosphorIcon(PhosphorIconsLight.trash),
                              onPressed: _key == null
                                  ? null
                                  : () {
                                      final bloc = context.read<DocumentBloc>();
                                      bloc.add(AnimationUpdated(
                                          _animation!.name,
                                          _animation!.copyWith(
                                            keys: Map.from(_animation!.keys)
                                              ..remove(_frame),
                                          )));
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                labelText: AppLocalizations.of(context).frame,
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                              ),
                              controller: _frameController,
                              textAlign: TextAlign.center,
                              onFieldSubmitted: (value) {
                                final frame = int.tryParse(value.trim());
                                if (frame != null) {
                                  _setFrame(frame);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: max(200, constraints.maxWidth * 0.25),
                            child: PresentationTimelineView(
                              animationKeys: _animation!.keys.keys.toList(),
                              currentFrame: _frame,
                              duration: _animation!.duration,
                              onFrameChanged: _setFrame,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 100,
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                labelText:
                                    AppLocalizations.of(context).duration,
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                              ),
                              controller: _durationController,
                              textAlign: TextAlign.center,
                              onFieldSubmitted: (value) {
                                final duration = int.tryParse(value.trim());
                                if (duration != null && duration > 0) {
                                  final updated =
                                      _animation!.copyWith(duration: duration);
                                  context.read<DocumentBloc>().add(
                                        AnimationUpdated(
                                          _animation!.name,
                                          updated,
                                        ),
                                      );
                                  setState(() {
                                    _animation = updated;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          MenuAnchor(
                            builder: defaultMenuButton(
                              icon: const PhosphorIcon(
                                  PhosphorIconsLight.presentation),
                              tooltip: AppLocalizations.of(context).export,
                            ),
                            menuChildren: [
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                    PhosphorIconsLight.playCircle),
                                child: Text(AppLocalizations.of(context).play),
                                onPressed: () async {
                                  final bloc = context.read<DocumentBloc>();
                                  final fullScreen = await isFullScreen();
                                  if (context.mounted) {
                                    final result = await showDialog<bool>(
                                      context: context,
                                      builder: (context) =>
                                          const PresentationControlsDialog(),
                                    );
                                    if (result != true) return;
                                    bloc.add(PresentationModeEntered(
                                        _animation!, fullScreen));
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
                                leadingIcon:
                                    const PhosphorIcon(PhosphorIconsLight.file),
                                child: Text(AppLocalizations.of(context).pdf),
                                onPressed: () {
                                  final size = MediaQuery.of(context).size;
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => BlocProvider.value(
                                      value: context.read<DocumentBloc>(),
                                      child: PdfExportDialog(
                                        areas: {
                                          0,
                                          ..._animation!.keys.entries
                                              .where((element) =>
                                                  element.value.breakpoint)
                                              .map((e) => e.key)
                                              .sorted((a, b) => a.compareTo(b))
                                        }.map(
                                          (e) {
                                            final zoom = _animation!
                                                    .interpolateCameraZoom(e) ??
                                                transform.size;
                                            final position = _animation!
                                                    .interpolateCameraPosition(
                                                        e) ??
                                                transform.position.toPoint();
                                            return AreaPreset(
                                              name: e.toString(),
                                              area: Area(
                                                position: -position,
                                                height: size.height / zoom,
                                                width: size.width / zoom,
                                              ),
                                              quality: zoom,
                                            );
                                          },
                                        ).toList(),
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
