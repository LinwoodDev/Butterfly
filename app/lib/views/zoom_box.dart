import 'dart:ui' show PointerDeviceKind;

import 'dart:math';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/helpers/pdf_direct.dart';
import 'package:butterfly/helpers/number.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/view_painter.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ZoomBoxOverlay extends StatefulWidget {
  final ZoomBoxHandler handler;
  final int toolIndex;
  final DocumentLoaded documentState;
  final CurrentIndex currentIndex;
  final CameraTransform transform;

  const ZoomBoxOverlay({
    super.key,
    required this.handler,
    required this.toolIndex,
    required this.documentState,
    required this.currentIndex,
    required this.transform,
  });

  @override
  State<ZoomBoxOverlay> createState() => _ZoomBoxOverlayState();
}

enum _ReferenceDefaultsAction { setDefault, resetDefaults }

class _ZoomBoxOverlayState extends State<ZoomBoxOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final TextEditingController _pauseController;
  late final FocusNode _pauseFocusNode;
  RectTween? _targetRectTween;
  Rect? _displayTargetRect;
  int _lastAnimationNonce = 0;
  int? _pendingAnimationNonce;
  bool _advanceHandleCanDrag = false;
  bool _committingPause = false;
  VoidCallback? _commitPauseOnBlur;

  @override
  void initState() {
    super.initState();
    _pauseController = TextEditingController();
    _pauseFocusNode = FocusNode()
      ..addListener(() {
        if (_pauseFocusNode.hasFocus) {
          _pauseController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: _pauseController.text.length,
          );
          return;
        }
        _commitPauseOnBlur?.call();
      });
    _animationController =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 120),
          )
          ..addListener(() => setState(() {}))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed &&
                _targetRectTween != null) {
              _displayTargetRect = _targetRectTween!.end;
              _targetRectTween = null;
            }
          });
  }

  @override
  void didUpdateWidget(covariant ZoomBoxOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.handler != widget.handler) {
      _targetRectTween = null;
      _displayTargetRect = null;
      _lastAnimationNonce = 0;
      _animationController.stop();
      _pauseFocusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _pauseFocusNode.dispose();
    _pauseController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Rect _resolveAnimatedTargetRect(
    Rect targetRect,
    ZoomBoxOverlayState overlayState,
  ) {
    if (_displayTargetRect == null) {
      _displayTargetRect = targetRect;
      _lastAnimationNonce = overlayState.animationNonce;
      return targetRect;
    }

    final shouldAnimate =
        overlayState.animateTarget &&
        overlayState.animationNonce != _lastAnimationNonce &&
        _displayTargetRect != targetRect;
    if (shouldAnimate) {
      _targetRectTween = RectTween(begin: _displayTargetRect, end: targetRect);
      _lastAnimationNonce = overlayState.animationNonce;
      _pendingAnimationNonce = overlayState.animationNonce;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _pendingAnimationNonce != overlayState.animationNonce) {
          return;
        }
        _animationController.forward(from: 0);
      });
    } else if (!_animationController.isAnimating ||
        _targetRectTween?.end != targetRect) {
      _animationController.stop();
      _targetRectTween = null;
      _displayTargetRect = targetRect;
      _lastAnimationNonce = overlayState.animationNonce;
    }

    if (_targetRectTween != null && _animationController.isAnimating) {
      return _targetRectTween!.evaluate(_animationController) ?? targetRect;
    }
    _displayTargetRect = targetRect;
    return targetRect;
  }

  String _formatPauseSecondsInput(double value) {
    final fixed = value.toStringAsFixed(2);
    return fixed
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }

  double? _parsePauseSeconds(String value) {
    final parsed = parseDoubleInput(value);
    if (parsed == null) return null;
    return parsed.clamp(0.0, kZoomBoxMaxAutoAdvancePauseSeconds).toDouble();
  }

  void _syncPauseField(ZoomBoxOverlayState state) {
    if (_pauseFocusNode.hasFocus) return;
    final formatted = _formatPauseSecondsInput(state.autoAdvancePauseSeconds);
    if (_pauseController.text == formatted) return;
    _pauseController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  void _commitPauseField(
    ZoomBoxOverlayState state,
    DocumentBloc bloc,
    Size viewportSize,
  ) {
    if (_committingPause) return;
    _committingPause = true;
    final parsed = _parsePauseSeconds(_pauseController.text);
    final value = parsed ?? state.autoAdvancePauseSeconds;
    final formatted = _formatPauseSecondsInput(value);
    try {
      if (_pauseController.text != formatted) {
        _pauseController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
      if (_pauseFocusNode.hasFocus) {
        _pauseFocusNode.unfocus();
      }
      if (parsed == null || value == state.autoAdvancePauseSeconds) return;
      widget.handler.setAutoAdvancePauseSeconds(value, bloc, viewportSize);
    } finally {
      _committingPause = false;
    }
  }

  Future<void> _showReferenceDefaultsMenu(
    BuildContext context,
    Offset globalPosition,
    DocumentBloc bloc,
    Size viewportSize,
  ) async {
    final overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox?;
    if (overlay == null) return;
    final loc = AppLocalizations.of(context);
    final result = await showMenu<_ReferenceDefaultsAction>(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromCircle(center: globalPosition, radius: 1),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          value: _ReferenceDefaultsAction.setDefault,
          child: Text(loc.setAsDefault),
        ),
        PopupMenuItem(
          value: _ReferenceDefaultsAction.resetDefaults,
          child: Text(loc.resetDefaults),
        ),
      ],
    );
    if (!mounted || result == null) return;
    widget.handler.applyReferenceDefaults(
      bloc,
      widget.documentState.settingsCubit,
      viewportSize,
      reset: result == _ReferenceDefaultsAction.resetDefaults,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewportSize = constraints.biggest;
        widget.handler.setTargetConstraintRect(
          widget.documentState.isDirectPdfSession
              ? widget.documentState.currentArea?.rect
              : null,
        );
        widget.handler.ensureState(
          viewportSize,
          widget.transform,
          notify: false,
        );
        return ValueListenableBuilder<ZoomBoxOverlayState>(
          valueListenable: widget.handler.listenable,
          builder: (context, overlayState, _) {
            final normalized = widget.handler.ensureState(
              viewportSize,
              widget.transform,
              notify: false,
            );
            _syncPauseField(normalized);
            final boxRect = normalized.boxRect;
            final targetOrigin = normalized.targetOrigin;
            if (boxRect == null || targetOrigin == null) {
              return const SizedBox.shrink();
            }

            final theme = Theme.of(context);
            final colorScheme = theme.colorScheme;
            final targetRect = widget.handler.getTargetRect(
              viewportSize,
              widget.transform,
              normalized,
            );
            final animatedTargetRect = _resolveAnimatedTargetRect(
              targetRect,
              normalized,
            );
            final referenceTopLeft = widget.transform.globalToLocal(
              animatedTargetRect.topLeft,
            );
            final referenceRect = Rect.fromLTWH(
              referenceTopLeft.dx,
              referenceTopLeft.dy,
              animatedTargetRect.width * widget.transform.size,
              animatedTargetRect.height * widget.transform.size,
            );
            final contentRect = zoomBoxContentRect(boxRect);
            final localContentRect = contentRect.shift(-boxRect.topLeft);
            final advanceTriggerRect = widget.handler.getAdvanceTriggerRect(
              boxRect,
              normalized,
            );
            final advanceKnobRect = widget.handler.getAdvanceKnobRect(
              boxRect,
              normalized,
            );
            final zoomTransform = CameraTransform(
              widget.transform.pixelRatio,
              animatedTargetRect.topLeft,
              contentRect.width / max(animatedTargetRect.width, 0.001),
            );
            final zoomVisibleRect = animatedTargetRect.inflate(
              max(animatedTargetRect.width, animatedTargetRect.height),
            );
            final zoomVisibleRenderers = widget
                .documentState
                .currentIndexCubit
                .renderers
                .where(
                  (renderer) =>
                      widget.currentIndex.allRendererStates[renderer.id] !=
                          RendererState.hidden &&
                      renderer.isVisible(zoomVisibleRect),
                )
                .toList(growable: false);
            final zoomViewport = widget.currentIndex.cameraViewport.withUnbaked(
              zoomVisibleRenderers,
              visibleElements: zoomVisibleRenderers,
              visibleUnbakedElements: zoomVisibleRenderers,
            );
            final overlayForegrounds = widget.currentIndex
                .getAllForegrounds()
                .where((renderer) => renderer.element is PadElement)
                .toList();
            final loc = AppLocalizations.of(context);
            final bloc = context.read<DocumentBloc>();
            _commitPauseOnBlur = () =>
                _commitPauseField(normalized, bloc, viewportSize);

            return Stack(
              children: [
                Positioned.fromRect(
                  rect: referenceRect.inflate(10),
                  child: IgnorePointer(
                    ignoring: normalized.locked,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onLongPressStart: (details) =>
                                _showReferenceDefaultsMenu(
                                  context,
                                  details.globalPosition,
                                  bloc,
                                  viewportSize,
                                ),
                            onPanUpdate: (details) =>
                                widget.handler.moveReferenceBy(
                                  details.delta,
                                  viewportSize,
                                  widget.transform,
                                ),
                            onPanEnd: (_) => widget.handler.persistLayout(
                              bloc,
                              viewportSize,
                            ),
                            child: Align(
                              child: Container(
                                width: referenceRect.width,
                                height: referenceRect.height,
                                decoration: BoxDecoration(
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: colorScheme.primary,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: IgnorePointer(
                            ignoring: normalized.locked,
                            child: Opacity(
                              opacity: normalized.locked ? 0.45 : 1,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onPanUpdate: (details) =>
                                    widget.handler.resizeReferenceBy(
                                      details.delta,
                                      viewportSize,
                                      widget.transform,
                                    ),
                                onPanEnd: (_) => widget.handler.persistLayout(
                                  bloc,
                                  viewportSize,
                                ),
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const PhosphorIcon(
                                    PhosphorIconsLight.arrowsOutSimple,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fromRect(
                  rect: boxRect,
                  child: Material(
                    elevation: 10,
                    color: colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        Positioned.fromRect(
                          rect: localContentRect,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                border: Border.all(
                                  color: colorScheme.outlineVariant,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: RepaintBoundary(
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: IgnorePointer(
                                        child: CustomPaint(
                                          size: Size.infinite,
                                          foregroundPainter: ForegroundPainter(
                                            overlayForegrounds,
                                            widget.documentState.data,
                                            widget.documentState.page,
                                            widget.documentState.info,
                                            colorScheme,
                                            zoomTransform,
                                            null,
                                            widget
                                                .documentState
                                                .settingsCubit
                                                .state
                                                .navigatorPosition,
                                          ),
                                          painter: ViewPainter(
                                            widget.documentState.data,
                                            widget.documentState.page,
                                            widget.documentState.info,
                                            cameraViewport: zoomViewport,
                                            transform: zoomTransform,
                                            renderBaked: false,
                                            renderBakedLayers: false,
                                            invisibleLayers: widget
                                                .documentState
                                                .invisibleLayers,
                                            currentArea: widget
                                                .documentState
                                                .currentArea,
                                            colorScheme: colorScheme,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned.fromRect(
                                      rect: Rect.fromLTRB(
                                        advanceTriggerRect.left -
                                            contentRect.left,
                                        0,
                                        advanceTriggerRect.right -
                                            contentRect.left,
                                        contentRect.height,
                                      ),
                                      child: IgnorePointer(
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: colorScheme.primary
                                                .withValues(
                                                  alpha: normalized.autoAdvance
                                                      ? 0.10
                                                      : 0.04,
                                                ),
                                            border: Border(
                                              left: BorderSide(
                                                color: normalized.autoAdvance
                                                    ? colorScheme.primary
                                                    : colorScheme
                                                          .outlineVariant,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left:
                                          advanceKnobRect.left -
                                          contentRect.left,
                                      top:
                                          advanceKnobRect.top - contentRect.top,
                                      child: Listener(
                                        onPointerDown: (event) {
                                          _advanceHandleCanDrag =
                                              event.kind !=
                                                  PointerDeviceKind.stylus &&
                                              event.kind !=
                                                  PointerDeviceKind
                                                      .invertedStylus;
                                        },
                                        onPointerUp: (_) =>
                                            _advanceHandleCanDrag = false,
                                        onPointerCancel: (_) =>
                                            _advanceHandleCanDrag = false,
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onPanUpdate: normalized.locked
                                              ? null
                                              : (details) {
                                                  if (!_advanceHandleCanDrag) {
                                                    return;
                                                  }
                                                  widget.handler
                                                      .adjustAdvanceTriggerFraction(
                                                        details.delta.dx /
                                                            max(
                                                              contentRect.width,
                                                              1,
                                                            ),
                                                        persist: false,
                                                      );
                                                },
                                          onPanEnd: normalized.locked
                                              ? null
                                              : (_) {
                                                  _advanceHandleCanDrag = false;
                                                  widget.handler.persistLayout(
                                                    bloc,
                                                    viewportSize,
                                                  );
                                                },
                                          child: Container(
                                            width: advanceKnobRect.width,
                                            height: advanceKnobRect.height,
                                            decoration: BoxDecoration(
                                              color: normalized.autoAdvance
                                                  ? colorScheme.primary
                                                  : colorScheme.outlineVariant,
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                            ),
                                            child: const PhosphorIcon(
                                              PhosphorIconsLight
                                                  .arrowsHorizontal,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          height: kZoomBoxHeaderHeight,
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onPanUpdate: normalized.locked
                                      ? null
                                      : (details) => widget.handler.moveBox(
                                          details.delta,
                                          viewportSize,
                                        ),
                                  onPanEnd: normalized.locked
                                      ? null
                                      : (_) => widget.handler.persistLayout(
                                          bloc,
                                          viewportSize,
                                        ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    child: Row(
                                      children: [
                                        const PhosphorIcon(
                                          PhosphorIconsLight.dotsSixVertical,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          loc.zoomBox,
                                          style: theme.textTheme.titleSmall,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${normalized.zoomFactor.toStringAsFixed(1)}x',
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                tooltip: loc.autoAdvance,
                                isSelected: normalized.autoAdvance,
                                onPressed: () => widget.handler
                                    .toggleAutoAdvance(bloc, viewportSize),
                                icon: const PhosphorIcon(
                                  PhosphorIconsLight.arrowRight,
                                ),
                              ),
                              IconButton(
                                tooltip: loc.lock,
                                isSelected: normalized.locked,
                                onPressed: () => widget.handler.toggleLocked(
                                  bloc,
                                  viewportSize,
                                ),
                                icon: const PhosphorIcon(
                                  PhosphorIconsLight.lockKey,
                                ),
                              ),
                              IconButton(
                                tooltip: loc.dockToBottom,
                                onPressed: () => widget.handler.dockBox(
                                  bloc,
                                  viewportSize,
                                  widget.transform,
                                ),
                                icon: const PhosphorIcon(
                                  PhosphorIconsLight.arrowLineDown,
                                ),
                              ),
                              IconButton(
                                tooltip: MaterialLocalizations.of(
                                  context,
                                ).closeButtonTooltip,
                                onPressed: () => context
                                    .read<CurrentIndexCubit>()
                                    .disableHandler(bloc, widget.toolIndex),
                                icon: const PhosphorIcon(PhosphorIconsLight.x),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          height: kZoomBoxFooterHeight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                IconButton(
                                  tooltip: loc.moveLeft,
                                  onPressed: () => widget.handler.moveBackward(
                                    viewportSize,
                                    widget.transform,
                                  ),
                                  icon: const PhosphorIcon(
                                    PhosphorIconsLight.arrowLeft,
                                  ),
                                ),
                                IconButton(
                                  tooltip: loc.moveRight,
                                  onPressed: () => widget.handler.moveForward(
                                    viewportSize,
                                    widget.transform,
                                  ),
                                  icon: const PhosphorIcon(
                                    PhosphorIconsLight.arrowRight,
                                  ),
                                ),
                                IconButton(
                                  tooltip: loc.newLine,
                                  onPressed: () => widget.handler.newLine(
                                    viewportSize,
                                    widget.transform,
                                  ),
                                  icon: const PhosphorIcon(
                                    PhosphorIconsLight.arrowDown,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Tooltip(
                                  message: '${loc.delay} (s)',
                                  child: SizedBox(
                                    width: 68,
                                    child: TextField(
                                      controller: _pauseController,
                                      focusNode: _pauseFocusNode,
                                      textAlign: TextAlign.center,
                                      textInputAction: TextInputAction.done,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9\.,]'),
                                        ),
                                      ],
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 10,
                                            ),
                                        suffixText: 's',
                                        hintText: _formatPauseSecondsInput(
                                          normalized.autoAdvancePauseSeconds,
                                        ),
                                      ),
                                      onEditingComplete: () =>
                                          _commitPauseField(
                                            normalized,
                                            bloc,
                                            viewportSize,
                                          ),
                                      onSubmitted: (_) => _commitPauseField(
                                        normalized,
                                        bloc,
                                        viewportSize,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Slider(
                                    value: normalized.zoomFactor,
                                    min: kZoomBoxMinFactor,
                                    max: kZoomBoxMaxFactor,
                                    divisions: 14,
                                    label:
                                        '${normalized.zoomFactor.toStringAsFixed(1)}x',
                                    onChanged: (value) =>
                                        widget.handler.setZoomFactor(
                                          value,
                                          viewportSize,
                                          widget.transform,
                                          persist: false,
                                        ),
                                    onChangeEnd: (value) =>
                                        widget.handler.setZoomFactor(
                                          value,
                                          viewportSize,
                                          widget.transform,
                                          bloc: bloc,
                                          persist: true,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: IgnorePointer(
                            ignoring: normalized.locked,
                            child: Opacity(
                              opacity: normalized.locked ? 0.45 : 1,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onPanUpdate: (details) =>
                                    widget.handler.resizeBoxBy(
                                      details.delta,
                                      viewportSize,
                                      widget.transform,
                                    ),
                                onPanEnd: (_) => widget.handler.persistLayout(
                                  bloc,
                                  viewportSize,
                                ),
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: colorScheme.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: colorScheme.outlineVariant,
                                    ),
                                  ),
                                  child: const PhosphorIcon(
                                    PhosphorIconsLight.arrowsOutSimple,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
