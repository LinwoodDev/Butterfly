part of 'handler.dart';

const kZoomBoxMinFactor = 1.5;
const kZoomBoxMaxFactor = 5.0;
const kZoomBoxDefaultFactor = 3.0;
const kZoomBoxMargin = 16.0;
const kZoomBoxMinWidth = 260.0;
const kZoomBoxMinHeight = 180.0;
const kZoomBoxDefaultHeight = 240.0;
const kZoomBoxHeaderHeight = 44.0;
const kZoomBoxFooterHeight = 56.0;
const kZoomBoxHorizontalPadding = 12.0;
const kZoomBoxSectionSpacing = 8.0;
const kZoomBoxAdvanceFraction = 0.9;
const kZoomBoxLineAdvanceFraction = 0.95;
const kZoomBoxMinAdvanceTriggerFraction = 0.5;
const kZoomBoxMaxAdvanceTriggerFraction = 0.98;
const kZoomBoxMinTargetScale = 0.35;
const kZoomBoxMaxTargetScale = 4.0;
const kZoomBoxAdvanceKnobWidth = 24.0;
const kZoomBoxAdvanceKnobHeight = 28.0;
const kZoomBoxAdvanceKnobTop = 10.0;
const kZoomBoxDefaultAutoAdvancePauseSeconds = 0.22;
const kZoomBoxMaxAutoAdvancePauseSeconds = 10.0;

Rect zoomBoxContentRect(Rect boxRect) => Rect.fromLTWH(
  boxRect.left + kZoomBoxHorizontalPadding,
  boxRect.top + kZoomBoxHeaderHeight + kZoomBoxSectionSpacing,
  max(1, boxRect.width - kZoomBoxHorizontalPadding * 2),
  max(
    1,
    boxRect.height -
        kZoomBoxHeaderHeight -
        kZoomBoxFooterHeight -
        kZoomBoxSectionSpacing * 2,
  ),
);

@immutable
class ZoomBoxOverlayState {
  final Rect? boxRect;
  final Offset? targetOrigin;
  final double lineStartX;
  final double zoomFactor;
  final bool autoAdvance;
  final bool locked;
  final bool docked;
  final double advanceTriggerFraction;
  final double autoAdvancePauseSeconds;
  final double targetWidthScale;
  final double targetHeightScale;
  final int? activePointer;
  final bool writingInside;
  final Offset? lastLocalPosition;
  final bool animateTarget;
  final int animationNonce;

  const ZoomBoxOverlayState({
    this.boxRect,
    this.targetOrigin,
    this.lineStartX = 0,
    this.zoomFactor = kZoomBoxDefaultFactor,
    this.autoAdvance = true,
    this.locked = false,
    this.docked = true,
    this.advanceTriggerFraction = 0.9,
    this.autoAdvancePauseSeconds = kZoomBoxDefaultAutoAdvancePauseSeconds,
    this.targetWidthScale = 1,
    this.targetHeightScale = 1,
    this.activePointer,
    this.writingInside = false,
    this.lastLocalPosition,
    this.animateTarget = false,
    this.animationNonce = 0,
  });

  ZoomBoxOverlayState copyWith({
    Rect? boxRect,
    Offset? targetOrigin,
    double? lineStartX,
    double? zoomFactor,
    bool? autoAdvance,
    bool? locked,
    bool? docked,
    double? advanceTriggerFraction,
    double? autoAdvancePauseSeconds,
    double? targetWidthScale,
    double? targetHeightScale,
    int? activePointer,
    bool clearActivePointer = false,
    bool? writingInside,
    Offset? lastLocalPosition,
    bool clearLastLocalPosition = false,
    bool? animateTarget,
    int? animationNonce,
  }) {
    return ZoomBoxOverlayState(
      boxRect: boxRect ?? this.boxRect,
      targetOrigin: targetOrigin ?? this.targetOrigin,
      lineStartX: lineStartX ?? this.lineStartX,
      zoomFactor: zoomFactor ?? this.zoomFactor,
      autoAdvance: autoAdvance ?? this.autoAdvance,
      locked: locked ?? this.locked,
      docked: docked ?? this.docked,
      advanceTriggerFraction:
          advanceTriggerFraction ?? this.advanceTriggerFraction,
      autoAdvancePauseSeconds:
          autoAdvancePauseSeconds ?? this.autoAdvancePauseSeconds,
      targetWidthScale: targetWidthScale ?? this.targetWidthScale,
      targetHeightScale: targetHeightScale ?? this.targetHeightScale,
      activePointer: clearActivePointer
          ? null
          : activePointer ?? this.activePointer,
      writingInside: writingInside ?? this.writingInside,
      lastLocalPosition: clearLastLocalPosition
          ? null
          : lastLocalPosition ?? this.lastLocalPosition,
      animateTarget: animateTarget ?? this.animateTarget,
      animationNonce: animationNonce ?? this.animationNonce,
    );
  }
}

enum ZoomBoxHitRegion { none, content, controls }

class ZoomBoxHandler extends Handler<ZoomBoxTool>
    with PointerManipulationHandler {
  final ValueNotifier<ZoomBoxOverlayState> _overlayState = ValueNotifier(
    const ZoomBoxOverlayState(),
  );
  ZoomBoxOverlayState? _resolvedState;
  var _seededFromTool = false;
  Timer? _autoAdvanceTimer;
  late double? _defaultTargetLeft = data.targetLeft;
  late double? _defaultTargetTop = data.targetTop;
  late double _defaultTargetWidthScale = data.targetWidthScale;
  late double _defaultTargetHeightScale = data.targetHeightScale;

  ZoomBoxHandler(super.data);

  ValueListenable<ZoomBoxOverlayState> get listenable => _overlayState;

  ZoomBoxOverlayState get overlayState => _overlayState.value;

  @override
  SelectState onSelected(BuildContext context, [bool wasAdded = true]) {
    return SelectState.toggle;
  }

  void _cancelAutoAdvance() {
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = null;
  }

  ZoomBoxHitRegion hitTest(
    Offset localPosition,
    Size viewportSize,
    CameraTransform transform,
    PointerDeviceKind? kind,
  ) {
    final current = ensureState(viewportSize, transform, notify: false);
    final boxRect = current.boxRect;
    final targetOrigin = current.targetOrigin;
    if (boxRect == null || targetOrigin == null) return ZoomBoxHitRegion.none;

    if (boxRect.contains(localPosition)) {
      final contentRect = zoomBoxContentRect(boxRect);
      if (!_isStylusLike(kind) &&
          getAdvanceKnobRect(
            boxRect,
            current,
          ).inflate(6).contains(localPosition)) {
        return ZoomBoxHitRegion.controls;
      }
      if (contentRect.contains(localPosition)) return ZoomBoxHitRegion.content;
      return ZoomBoxHitRegion.controls;
    }

    final targetRect = getTargetRect(viewportSize, transform, current);
    final referenceTopLeft = transform.globalToLocal(targetRect.topLeft);
    final referenceRect = Rect.fromLTWH(
      referenceTopLeft.dx,
      referenceTopLeft.dy,
      targetRect.width * transform.size,
      targetRect.height * transform.size,
    ).inflate(10);
    final referenceHandleRect = Rect.fromLTWH(
      referenceRect.right - 28,
      referenceRect.bottom - 28,
      28,
      28,
    );
    if (referenceHandleRect.contains(localPosition) ||
        referenceRect.contains(localPosition)) {
      return ZoomBoxHitRegion.controls;
    }
    return ZoomBoxHitRegion.none;
  }

  void copyTransientStateFrom(ZoomBoxHandler other) {
    _cancelAutoAdvance();
    _seededFromTool = true;
    final next = other.overlayState.copyWith(
      clearActivePointer: true,
      writingInside: false,
      clearLastLocalPosition: true,
      animateTarget: false,
    );
    _resolvedState = next;
    _overlayState.value = next;
  }

  ZoomBoxOverlayState ensureState(
    Size viewportSize,
    CameraTransform transform, {
    bool notify = true,
  }) {
    final current = _effectiveState;
    final normalized = _normalizeState(current, viewportSize, transform);
    _resolvedState = normalized;
    if (!notify || identical(current, normalized)) {
      return normalized;
    }
    _overlayState.value = normalized;
    return normalized;
  }

  ZoomBoxOverlayState get _effectiveState =>
      _resolvedState ?? _overlayState.value;

  void _setReferenceDefaults({
    double? targetLeft,
    double? targetTop,
    double? targetWidthScale,
    double? targetHeightScale,
  }) {
    _defaultTargetLeft = targetLeft;
    _defaultTargetTop = targetTop;
    _defaultTargetWidthScale = (targetWidthScale ?? 1)
        .clamp(kZoomBoxMinTargetScale, kZoomBoxMaxTargetScale)
        .toDouble();
    _defaultTargetHeightScale = (targetHeightScale ?? 1)
        .clamp(kZoomBoxMinTargetScale, kZoomBoxMaxTargetScale)
        .toDouble();
  }

  Rect getTargetRect(
    Size viewportSize,
    CameraTransform transform, [
    ZoomBoxOverlayState? current,
  ]) {
    current ??= ensureState(viewportSize, transform, notify: false);
    final boxRect = current.boxRect;
    final targetOrigin = current.targetOrigin;
    if (boxRect == null || targetOrigin == null) return Rect.zero;
    return targetOrigin &
        _targetSizeFor(
          zoomBoxContentRect(boxRect).size,
          viewportSize,
          transform,
          current.zoomFactor,
          current.targetWidthScale,
          current.targetHeightScale,
        );
  }

  Rect getAdvanceTriggerRect(Rect boxRect, [ZoomBoxOverlayState? current]) {
    current ??= _effectiveState;
    final contentRect = zoomBoxContentRect(boxRect);
    final triggerX =
        contentRect.left + contentRect.width * current.advanceTriggerFraction;
    return Rect.fromLTRB(
      triggerX,
      contentRect.top,
      contentRect.right,
      contentRect.bottom,
    );
  }

  Rect getAdvanceKnobRect(Rect boxRect, [ZoomBoxOverlayState? current]) {
    current ??= _effectiveState;
    final contentRect = zoomBoxContentRect(boxRect);
    final triggerRect = getAdvanceTriggerRect(boxRect, current);
    return Rect.fromLTWH(
      triggerRect.left - kZoomBoxAdvanceKnobWidth / 2,
      contentRect.top + kZoomBoxAdvanceKnobTop,
      kZoomBoxAdvanceKnobWidth,
      kZoomBoxAdvanceKnobHeight,
    );
  }

  void moveBox(Offset delta, Size viewportSize) {
    final current = _effectiveState;
    if (current.locked) return;
    _cancelAutoAdvance();
    final boxRect = current.boxRect ?? _dockRect(viewportSize, null);
    final nextRect = _clampBoxRect(boxRect.shift(delta), viewportSize);
    final next = current.copyWith(
      boxRect: nextRect,
      docked: false,
      animateTarget: false,
    );
    _resolvedState = next;
    _overlayState.value = next;
  }

  void resizeBoxBy(Offset delta, Size viewportSize, CameraTransform transform) {
    if (_effectiveState.locked) return;
    _cancelAutoAdvance();
    final current = ensureState(viewportSize, transform);
    final boxRect = current.boxRect ?? _dockRect(viewportSize, null);
    final nextRect = current.docked
        ? _dockRect(
            viewportSize,
            Rect.fromLTWH(
              boxRect.left,
              boxRect.top,
              boxRect.width + delta.dx,
              boxRect.height + delta.dy,
            ),
          )
        : _clampBoxRect(
            Rect.fromLTWH(
              boxRect.left,
              boxRect.top,
              boxRect.width + delta.dx,
              boxRect.height + delta.dy,
            ),
            viewportSize,
          );
    final next = _normalizeState(
      current.copyWith(boxRect: nextRect, animateTarget: false),
      viewportSize,
      transform,
    );
    _resolvedState = next;
    _overlayState.value = next;
  }

  void dockBox(
    DocumentBloc bloc,
    Size viewportSize,
    CameraTransform transform,
  ) {
    _cancelAutoAdvance();
    final current = ensureState(viewportSize, transform);
    final next = _normalizeState(
      current.copyWith(
        boxRect: _dockRect(viewportSize, current.boxRect),
        docked: true,
        animateTarget: false,
      ),
      viewportSize,
      transform,
    );
    _resolvedState = next;
    _overlayState.value = next;
    _persistConfig(bloc, viewportSize, next);
  }

  void toggleLocked(DocumentBloc bloc, Size viewportSize) {
    _cancelAutoAdvance();
    final current = _effectiveState;
    final next = current.copyWith(
      locked: !current.locked,
      animateTarget: false,
    );
    _resolvedState = next;
    _overlayState.value = next;
    _persistConfig(bloc, viewportSize, next);
  }

  void toggleAutoAdvance(DocumentBloc bloc, Size viewportSize) {
    _cancelAutoAdvance();
    final current = _effectiveState;
    final next = current.copyWith(
      autoAdvance: !current.autoAdvance,
      animateTarget: false,
    );
    _resolvedState = next;
    _overlayState.value = next;
    _persistConfig(bloc, viewportSize, next);
  }

  void setZoomFactor(
    double value,
    Size viewportSize,
    CameraTransform transform, {
    DocumentBloc? bloc,
    bool persist = false,
  }) {
    if (_effectiveState.locked) return;
    _cancelAutoAdvance();
    final current = ensureState(viewportSize, transform);
    final boxRect = current.boxRect;
    final targetOrigin = current.targetOrigin;
    if (boxRect == null || targetOrigin == null) return;

    final currentRect = getTargetRect(viewportSize, transform, current);
    final nextFactor = value
        .clamp(kZoomBoxMinFactor, kZoomBoxMaxFactor)
        .toDouble();
    final nextSize = _targetSizeFor(
      zoomBoxContentRect(boxRect).size,
      viewportSize,
      transform,
      nextFactor,
      current.targetWidthScale,
      current.targetHeightScale,
    );
    final centeredOrigin =
        currentRect.center - Offset(nextSize.width / 2, nextSize.height / 2);
    final clampedOrigin = _clampTargetOrigin(
      centeredOrigin,
      viewportSize,
      transform,
      nextSize,
    );
    final next = _normalizeState(
      current.copyWith(
        zoomFactor: nextFactor,
        targetOrigin: clampedOrigin,
        animateTarget: false,
      ),
      viewportSize,
      transform,
    );
    _resolvedState = next;
    _overlayState.value = next;
    if (persist && bloc != null) {
      _persistConfig(bloc, viewportSize, next);
    }
  }

  void adjustAdvanceTriggerFraction(
    double deltaFraction, {
    DocumentBloc? bloc,
    Size? viewportSize,
    bool persist = false,
  }) {
    _cancelAutoAdvance();
    final current = _effectiveState;
    final next = current.copyWith(
      advanceTriggerFraction: (current.advanceTriggerFraction + deltaFraction)
          .clamp(
            kZoomBoxMinAdvanceTriggerFraction,
            kZoomBoxMaxAdvanceTriggerFraction,
          )
          .toDouble(),
      animateTarget: false,
    );
    _resolvedState = next;
    _overlayState.value = next;
    if (persist && bloc != null && viewportSize != null) {
      _persistConfig(bloc, viewportSize, next);
    }
  }

  void setAutoAdvancePauseSeconds(
    double value,
    DocumentBloc bloc,
    Size viewportSize,
  ) {
    _cancelAutoAdvance();
    final next = _effectiveState.copyWith(
      autoAdvancePauseSeconds: value
          .clamp(0.0, kZoomBoxMaxAutoAdvancePauseSeconds)
          .toDouble(),
      animateTarget: false,
    );
    _resolvedState = next;
    _overlayState.value = next;
    _persistConfig(bloc, viewportSize, next);
  }

  void previewAutoAdvancePauseSeconds(double value) {
    _cancelAutoAdvance();
    final next = _effectiveState.copyWith(
      autoAdvancePauseSeconds: value
          .clamp(0.0, kZoomBoxMaxAutoAdvancePauseSeconds)
          .toDouble(),
      animateTarget: false,
    );
    _resolvedState = next;
    _overlayState.value = next;
  }

  ZoomBoxTool snapshotTool() => _snapshotToolFromOverlay();

  ZoomBoxTool _snapshotToolFromOverlay() {
    final current = _effectiveState;
    final keepFullDockedWidth = current.docked && data.boxWidth == 0;
    return data.copyWith(
      zoomFactor: current.zoomFactor,
      boxLeft: current.docked ? null : current.boxRect?.left,
      boxTop: current.docked ? null : current.boxRect?.top,
      boxWidth: keepFullDockedWidth
          ? 0
          : current.boxRect?.width ?? data.boxWidth,
      boxHeight: current.boxRect?.height ?? data.boxHeight,
      autoAdvance: current.autoAdvance,
      autoAdvanceTriggerFraction: current.advanceTriggerFraction,
      autoAdvancePauseSeconds: current.autoAdvancePauseSeconds,
      targetLeft: _defaultTargetLeft,
      targetTop: _defaultTargetTop,
      locked: current.locked,
      docked: current.docked,
      targetWidthScale: _defaultTargetWidthScale,
      targetHeightScale: _defaultTargetHeightScale,
    );
  }

  Future<void> persistGlobalState(DocumentBloc bloc) async {
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    final snapshot = _snapshotToolFromOverlay();
    final global = mergeAutomaticGlobalZoomBoxTool(
      snapshot,
      blocState.settingsCubit.state.globalZoomBoxTool,
    );
    await blocState.settingsCubit.changeGlobalZoomBoxTool(global);
  }

  Future<void> persistCurrentState(DocumentBloc bloc) async {
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    final nextTool = _snapshotToolFromOverlay();
    final global = mergeAutomaticGlobalZoomBoxTool(
      nextTool,
      blocState.settingsCubit.state.globalZoomBoxTool,
    );
    await blocState.settingsCubit.changeGlobalZoomBoxTool(global);
  }

  void applyReferenceDefaults(
    DocumentBloc bloc,
    SettingsCubit settingsCubit,
    Size viewportSize, {
    bool reset = false,
  }) {
    final current = _effectiveState;
    _setReferenceDefaults(
      targetLeft: reset ? null : current.targetOrigin?.dx,
      targetTop: reset ? null : current.targetOrigin?.dy,
      targetWidthScale: reset ? 1 : current.targetWidthScale,
      targetHeightScale: reset ? 1 : current.targetHeightScale,
    );
    final next = reset
        ? current.copyWith(
            targetOrigin: null,
            targetWidthScale: 1,
            targetHeightScale: 1,
            animateTarget: false,
          )
        : current.copyWith(animateTarget: false);
    _resolvedState = next;
    _overlayState.value = next;
    final global = (settingsCubit.state.globalZoomBoxTool ?? data).copyWith(
      id: null,
      name: '',
      displayIcon: '',
      targetLeft: _defaultTargetLeft,
      targetTop: _defaultTargetTop,
      targetWidthScale: _defaultTargetWidthScale,
      targetHeightScale: _defaultTargetHeightScale,
    );
    settingsCubit.changeGlobalZoomBoxTool(global);
    _persistConfig(bloc, viewportSize, next);
  }

  void moveReferenceBy(
    Offset localDelta,
    Size viewportSize,
    CameraTransform transform,
  ) {
    if (_effectiveState.locked) return;
    _cancelAutoAdvance();
    final current = ensureState(viewportSize, transform);
    final targetOrigin = current.targetOrigin;
    if (targetOrigin == null) return;
    final targetRect = getTargetRect(viewportSize, transform, current);
    final nextOrigin = _clampTargetOrigin(
      targetOrigin + localDelta / transform.size,
      viewportSize,
      transform,
      targetRect.size,
    );
    final next = current.copyWith(
      targetOrigin: nextOrigin,
      animateTarget: false,
    );
    _resolvedState = next;
    _overlayState.value = next;
  }

  void resizeReferenceBy(
    Offset localDelta,
    Size viewportSize,
    CameraTransform transform, {
    DocumentBloc? bloc,
    bool persist = false,
  }) {
    if (_effectiveState.locked) return;
    _cancelAutoAdvance();
    final current = ensureState(viewportSize, transform);
    final boxRect = current.boxRect;
    final targetOrigin = current.targetOrigin;
    if (boxRect == null || targetOrigin == null) return;

    final currentRect = getTargetRect(viewportSize, transform, current);
    final baseSize = _baseTargetSize(
      zoomBoxContentRect(boxRect).size,
      transform,
      current.zoomFactor,
    );
    final viewportRect = _visibleViewportRect(viewportSize, transform);
    final desiredWidth = max(
      1.0,
      currentRect.width + localDelta.dx / transform.size,
    );
    final desiredHeight = max(
      1.0,
      currentRect.height + localDelta.dy / transform.size,
    );
    final widthScaleCandidate = desiredWidth / max(baseSize.width, 0.001);
    final heightScaleCandidate = desiredHeight / max(baseSize.height, 0.001);
    final maxScale = min(
      kZoomBoxMaxTargetScale,
      min(
        viewportRect.width / max(baseSize.width, 1),
        viewportRect.height / max(baseSize.height, 1),
      ),
    );
    final nextScale =
        ((localDelta.dx.abs() / max(baseSize.width, 1)) >=
                    (localDelta.dy.abs() / max(baseSize.height, 1))
                ? widthScaleCandidate
                : heightScaleCandidate)
            .clamp(kZoomBoxMinTargetScale, maxScale)
            .toDouble();
    final nextSize = _targetSizeFor(
      zoomBoxContentRect(boxRect).size,
      viewportSize,
      transform,
      current.zoomFactor,
      nextScale,
      nextScale,
    );
    final nextOrigin = _clampTargetOrigin(
      targetOrigin,
      viewportSize,
      transform,
      nextSize,
    );
    final next = _normalizeState(
      current.copyWith(
        targetWidthScale: nextScale,
        targetHeightScale: nextScale,
        targetOrigin: nextOrigin,
        animateTarget: false,
      ),
      viewportSize,
      transform,
    );
    _resolvedState = next;
    _overlayState.value = next;
    if (persist && bloc != null) {
      _persistConfig(bloc, viewportSize, next);
    }
  }

  void moveBackward(Size viewportSize, CameraTransform transform) {
    _cancelAutoAdvance();
    final next = _moveHorizontal(
      ensureState(viewportSize, transform),
      viewportSize,
      transform,
      backwards: true,
    );
    _resolvedState = next;
    _overlayState.value = next;
  }

  void moveForward(Size viewportSize, CameraTransform transform) {
    _cancelAutoAdvance();
    final next = _moveHorizontal(
      ensureState(viewportSize, transform),
      viewportSize,
      transform,
    );
    _resolvedState = next;
    _overlayState.value = next;
  }

  void newLine(Size viewportSize, CameraTransform transform) {
    _cancelAutoAdvance();
    final current = ensureState(viewportSize, transform);
    final targetOrigin = current.targetOrigin;
    if (targetOrigin == null) return;
    final targetRect = getTargetRect(viewportSize, transform, current);
    final bounds = _targetBounds(viewportSize, transform, targetRect.size);
    final nextOrigin = _clampTargetOrigin(
      Offset(
        bounds.left,
        targetOrigin.dy + targetRect.height * kZoomBoxLineAdvanceFraction,
      ),
      viewportSize,
      transform,
      targetRect.size,
    );
    final next = current.copyWith(
      targetOrigin: nextOrigin,
      animateTarget: true,
      animationNonce: current.animationNonce + 1,
    );
    _resolvedState = next;
    _overlayState.value = next;
  }

  void persistLayout(DocumentBloc bloc, Size viewportSize) {
    _cancelAutoAdvance();
    final current = _effectiveState;
    _persistConfig(bloc, viewportSize, current);
  }

  @override
  Offset getPointerPosition(
    Offset position,
    Size viewportSize, [
    CameraTransform transform = const CameraTransform(),
  ]) {
    var current = _effectiveState;
    var boxRect = current.boxRect;
    var targetOrigin = current.targetOrigin;
    if (boxRect == null || targetOrigin == null) {
      current = ensureState(viewportSize, transform, notify: false);
      boxRect = current.boxRect;
      targetOrigin = current.targetOrigin;
    }
    if (boxRect == null || targetOrigin == null) return position;

    final contentRect = zoomBoxContentRect(boxRect);
    if (!current.writingInside && !contentRect.contains(position)) {
      return position;
    }

    final targetRect = getTargetRect(viewportSize, transform, current);
    final dx = ((position.dx - contentRect.left) / contentRect.width)
        .clamp(0.0, 1.0)
        .toDouble();
    final dy = ((position.dy - contentRect.top) / contentRect.height)
        .clamp(0.0, 1.0)
        .toDouble();
    final global = Offset(
      targetRect.left + targetRect.width * dx,
      targetRect.top + targetRect.height * dy,
    );
    return transform.globalToLocal(global);
  }

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    _cancelAutoAdvance();
    final current = ensureState(
      context.viewportSize,
      context.getCameraTransform(),
    );
    final boxRect = current.boxRect;
    if (boxRect == null) return;
    final contentRect = zoomBoxContentRect(boxRect);
    if (!contentRect.contains(event.localPosition)) return;
    if (!_isStylusLike(event.kind) &&
        getAdvanceKnobRect(
          boxRect,
          current,
        ).inflate(6).contains(event.localPosition)) {
      return;
    }
    final next = current.copyWith(
      activePointer: event.pointer,
      writingInside: true,
      lastLocalPosition: event.localPosition,
      animateTarget: false,
    );
    _resolvedState = next;
  }

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    final current = _effectiveState;
    if (current.activePointer != event.pointer) return;
    if (current.lastLocalPosition == event.localPosition) return;
    final next = current.copyWith(
      lastLocalPosition: event.localPosition,
      animateTarget: false,
    );
    _resolvedState = next;
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    final current = _effectiveState;
    if (current.activePointer != event.pointer) return;

    var next = current.copyWith(
      clearActivePointer: true,
      writingInside: false,
      lastLocalPosition: event.localPosition,
      animateTarget: false,
    );
    final lastLocalPosition = next.lastLocalPosition;
    final boxRect = next.boxRect;
    if (next.autoAdvance && lastLocalPosition != null && boxRect != null) {
      final triggerRect = getAdvanceTriggerRect(boxRect, next);
      if (lastLocalPosition.dx >= triggerRect.left) {
        final delayMilliseconds = (next.autoAdvancePauseSeconds * 1000)
            .round()
            .clamp(0, (kZoomBoxMaxAutoAdvancePauseSeconds * 1000).round())
            .toInt();
        _autoAdvanceTimer = Timer(
          Duration(milliseconds: delayMilliseconds),
          () {
            final viewportSize = context.viewportSize;
            final transform = context.getCameraTransform();
            final scheduledCurrent = ensureState(
              viewportSize,
              transform,
              notify: false,
            );
            if (scheduledCurrent.activePointer != null ||
                scheduledCurrent.writingInside) {
              return;
            }
            final next = _moveHorizontal(
              scheduledCurrent,
              viewportSize,
              transform,
            );
            _resolvedState = next;
            _overlayState.value = next;
          },
        );
      }
    }
    final cleared = next.copyWith(clearLastLocalPosition: true);
    _resolvedState = cleared;
  }

  ZoomBoxOverlayState _moveHorizontal(
    ZoomBoxOverlayState current,
    Size viewportSize,
    CameraTransform transform, {
    bool backwards = false,
  }) {
    final targetOrigin = current.targetOrigin;
    if (targetOrigin == null) return current;
    final targetRect = getTargetRect(viewportSize, transform, current);
    final bounds = _targetBounds(viewportSize, transform, targetRect.size);
    final step = targetRect.width * kZoomBoxAdvanceFraction;
    final epsilon = 0.5;
    final lineStep = targetRect.height * kZoomBoxLineAdvanceFraction;

    Offset nextOrigin;
    if (backwards) {
      if (targetOrigin.dx <= bounds.left + epsilon) {
        nextOrigin = Offset(bounds.right, targetOrigin.dy - lineStep);
      } else {
        nextOrigin = Offset(
          max(bounds.left, targetOrigin.dx - step),
          targetOrigin.dy,
        );
      }
    } else {
      if (targetOrigin.dx >= bounds.right - epsilon) {
        nextOrigin = Offset(bounds.left, targetOrigin.dy + lineStep);
      } else {
        nextOrigin = Offset(
          min(bounds.right, targetOrigin.dx + step),
          targetOrigin.dy,
        );
      }
    }

    nextOrigin = _clampTargetOrigin(
      nextOrigin,
      viewportSize,
      transform,
      targetRect.size,
    );
    return current.copyWith(
      targetOrigin: nextOrigin,
      animateTarget: true,
      animationNonce: current.animationNonce + 1,
    );
  }

  ZoomBoxOverlayState _normalizeState(
    ZoomBoxOverlayState current,
    Size viewportSize,
    CameraTransform transform,
  ) {
    var next = current;
    var changed = false;

    if (!_seededFromTool) {
      next = next.copyWith(
        boxRect: !data.docked && data.boxLeft != null && data.boxTop != null
            ? Rect.fromLTWH(
                data.boxLeft!,
                data.boxTop!,
                _resolveDockedWidth(viewportSize, data.boxWidth),
                _resolveHeight(viewportSize, data.boxHeight),
              )
            : next.boxRect,
        zoomFactor: data.zoomFactor
            .clamp(kZoomBoxMinFactor, kZoomBoxMaxFactor)
            .toDouble(),
        autoAdvance: data.autoAdvance,
        locked: data.locked,
        docked: data.docked,
        advanceTriggerFraction: data.autoAdvanceTriggerFraction
            .clamp(
              kZoomBoxMinAdvanceTriggerFraction,
              kZoomBoxMaxAdvanceTriggerFraction,
            )
            .toDouble(),
        autoAdvancePauseSeconds: data.autoAdvancePauseSeconds
            .clamp(0.0, kZoomBoxMaxAutoAdvancePauseSeconds)
            .toDouble(),
        targetWidthScale: _defaultTargetWidthScale
            .clamp(kZoomBoxMinTargetScale, kZoomBoxMaxTargetScale)
            .toDouble(),
        targetHeightScale: _defaultTargetHeightScale
            .clamp(kZoomBoxMinTargetScale, kZoomBoxMaxTargetScale)
            .toDouble(),
      );
      _seededFromTool = true;
      changed = true;
    }

    final proportionalScale =
        ((next.targetWidthScale + next.targetHeightScale) / 2)
            .clamp(kZoomBoxMinTargetScale, kZoomBoxMaxTargetScale)
            .toDouble();
    if (next.targetWidthScale != proportionalScale ||
        next.targetHeightScale != proportionalScale) {
      next = next.copyWith(
        targetWidthScale: proportionalScale,
        targetHeightScale: proportionalScale,
      );
      changed = true;
    }

    Rect boxRect;
    if (next.boxRect == null || next.docked) {
      boxRect = _dockRect(viewportSize, next.boxRect);
      if (boxRect != next.boxRect) changed = true;
    } else {
      final clamped = _clampBoxRect(next.boxRect!, viewportSize);
      boxRect = clamped;
      if (clamped != next.boxRect) changed = true;
    }

    final targetSize = _targetSizeFor(
      zoomBoxContentRect(boxRect).size,
      viewportSize,
      transform,
      next.zoomFactor,
      next.targetWidthScale,
      next.targetHeightScale,
    );

    final bounds = _targetBounds(viewportSize, transform, targetSize);
    var targetOrigin = next.targetOrigin;
    if (targetOrigin == null) {
      final viewportRect = _visibleViewportRect(viewportSize, transform);
      targetOrigin = _defaultTargetLeft != null && _defaultTargetTop != null
          ? Offset(_defaultTargetLeft!, _defaultTargetTop!)
          : viewportRect.topLeft +
                Offset(
                  16 / max(transform.size, 0.001),
                  16 / max(transform.size, 0.001),
                );
      targetOrigin = _clampTargetOrigin(
        targetOrigin,
        viewportSize,
        transform,
        targetSize,
      );
      changed = true;
    } else {
      final clampedOrigin = _clampTargetOrigin(
        targetOrigin,
        viewportSize,
        transform,
        targetSize,
      );
      if (clampedOrigin != targetOrigin) changed = true;
      targetOrigin = clampedOrigin;
    }

    final lineStartX = bounds.left;
    if (!changed &&
        boxRect == next.boxRect &&
        targetOrigin == next.targetOrigin &&
        lineStartX == next.lineStartX) {
      return next;
    }
    return next.copyWith(
      boxRect: boxRect,
      targetOrigin: targetOrigin,
      lineStartX: lineStartX,
    );
  }

  Rect _dockRect(Size viewportSize, Rect? current) {
    final width = _resolveDockedWidth(viewportSize, current?.width);
    final height = _resolveHeight(viewportSize, current?.height);
    return Rect.fromLTWH(
      (viewportSize.width - width) / 2,
      max(kZoomBoxMargin, viewportSize.height - height - kZoomBoxMargin),
      width,
      height,
    );
  }

  Rect _clampBoxRect(Rect rect, Size viewportSize) {
    final width = rect.width
        .clamp(kZoomBoxMinWidth, _maxBoxWidth(viewportSize))
        .toDouble();
    final height = rect.height
        .clamp(kZoomBoxMinHeight, _maxBoxHeight(viewportSize))
        .toDouble();
    final maxLeft = max(
      kZoomBoxMargin,
      viewportSize.width - width - kZoomBoxMargin,
    );
    final maxTop = max(
      kZoomBoxMargin,
      viewportSize.height - height - kZoomBoxMargin,
    );
    return Rect.fromLTWH(
      rect.left.clamp(kZoomBoxMargin, maxLeft).toDouble(),
      rect.top.clamp(kZoomBoxMargin, maxTop).toDouble(),
      width,
      height,
    );
  }

  double _resolveDockedWidth(Size viewportSize, double? width) {
    final maxWidth = _maxBoxWidth(viewportSize);
    if ((width ?? data.boxWidth) <= 0) return maxWidth;
    return (width ?? data.boxWidth)
        .clamp(kZoomBoxMinWidth, maxWidth)
        .toDouble();
  }

  double _resolveHeight(Size viewportSize, double? height) {
    final maxHeight = _maxBoxHeight(viewportSize);
    final resolved = (height ?? data.boxHeight);
    if (resolved <= 0) {
      return kZoomBoxDefaultHeight
          .clamp(kZoomBoxMinHeight, maxHeight)
          .toDouble();
    }
    return resolved.clamp(kZoomBoxMinHeight, maxHeight).toDouble();
  }

  double _maxBoxWidth(Size viewportSize) =>
      max(kZoomBoxMinWidth, viewportSize.width - kZoomBoxMargin * 2);

  double _maxBoxHeight(Size viewportSize) =>
      max(kZoomBoxMinHeight, viewportSize.height - kZoomBoxMargin * 2);

  Rect _visibleViewportRect(Size viewportSize, CameraTransform transform) {
    return Rect.fromLTWH(
      transform.position.dx,
      transform.position.dy,
      viewportSize.width / transform.size,
      viewportSize.height / transform.size,
    );
  }

  Size _baseTargetSize(
    Size contentSize,
    CameraTransform transform,
    double zoomFactor,
  ) {
    final divisor = max(transform.size * zoomFactor, 0.001);
    return Size(
      max(1, contentSize.width / divisor),
      max(1, contentSize.height / divisor),
    );
  }

  Size _targetSizeFor(
    Size contentSize,
    Size viewportSize,
    CameraTransform transform,
    double zoomFactor,
    double widthScale,
    double heightScale,
  ) {
    final viewportRect = _visibleViewportRect(viewportSize, transform);
    final baseSize = _baseTargetSize(contentSize, transform, zoomFactor);
    return Size(
      (baseSize.width * widthScale)
          .clamp(1.0, max(1.0, viewportRect.width))
          .toDouble(),
      (baseSize.height * heightScale)
          .clamp(1.0, max(1.0, viewportRect.height))
          .toDouble(),
    );
  }

  Rect _targetBounds(
    Size viewportSize,
    CameraTransform transform,
    Size targetSize,
  ) {
    final viewportRect = _visibleViewportRect(viewportSize, transform);
    final maxX =
        viewportRect.left + max(0.0, viewportRect.width - targetSize.width);
    final maxY =
        viewportRect.top + max(0.0, viewportRect.height - targetSize.height);
    return Rect.fromLTRB(viewportRect.left, viewportRect.top, maxX, maxY);
  }

  Offset _clampTargetOrigin(
    Offset origin,
    Size viewportSize,
    CameraTransform transform,
    Size targetSize,
  ) {
    final bounds = _targetBounds(viewportSize, transform, targetSize);
    return Offset(
      origin.dx.clamp(bounds.left, bounds.right).toDouble(),
      origin.dy.clamp(bounds.top, bounds.bottom).toDouble(),
    );
  }

  void _persistConfig(
    DocumentBloc bloc,
    Size viewportSize,
    ZoomBoxOverlayState current,
  ) {
    final nextTool = _snapshotToolFromOverlay();
    final blocState = bloc.state;
    if (blocState is DocumentLoadSuccess) {
      final global = mergeAutomaticGlobalZoomBoxTool(
        nextTool,
        blocState.settingsCubit.state.globalZoomBoxTool,
      );
      unawaited(blocState.settingsCubit.changeGlobalZoomBoxTool(global));
    }
  }

  @override
  void resetInput(DocumentBloc bloc) {
    _cancelAutoAdvance();
    final current = _effectiveState;
    if (current.activePointer == null &&
        !current.writingInside &&
        current.lastLocalPosition == null) {
      return;
    }
    final next = current.copyWith(
      clearActivePointer: true,
      writingInside: false,
      clearLastLocalPosition: true,
      animateTarget: false,
    );
    _resolvedState = next;
  }

  @override
  void dispose(DocumentBloc bloc) {
    _cancelAutoAdvance();
    _resolvedState = null;
    _overlayState.dispose();
    super.dispose(bloc);
  }
}

bool _isStylusLike(PointerDeviceKind? kind) =>
    kind == PointerDeviceKind.stylus ||
    kind == PointerDeviceKind.invertedStylus;
