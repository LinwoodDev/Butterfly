part of '../view.dart';

class _ViewportCanvas extends StatefulWidget {
  const _ViewportCanvas({
    super.key,
    required this.rendererState,
    required this.documentState,
    required this.delayBake,
  });

  final RendererRuntimeState rendererState;
  final DocumentLoaded documentState;
  final VoidCallback delayBake;

  @override
  State<_ViewportCanvas> createState() => _ViewportCanvasState();
}

class _ViewportCanvasState extends State<_ViewportCanvas>
    with SingleTickerProviderStateMixin {
  static const _slideCurve = Curves.easeOutCubic;

  late final AnimationController _animationController;
  Animation<Offset>? _positionAnimation;
  Animation<double>? _sizeAnimation;
  int _slideAnimationId = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void settleSlide(TransformCubit transformCubit) {
    final transform = transformCubit.state;
    if (transform.friction == null) return;
    final settled = _visibleTransform(transform);
    transformCubit.teleport(settled.position, settled.size, settled.rotation);
  }

  void _clearSlideAnimation() {
    _slideAnimationId++;
    _animationController.stop();
    _positionAnimation = null;
    _sizeAnimation = null;
  }

  void _handleSlideAnimation(CameraTransform transform) {
    final friction = transform.friction;
    if (friction == null) {
      _clearSlideAnimation();
      return;
    }

    final slideAnimationId = ++_slideAnimationId;
    final curve = CurvedAnimation(
      parent: _animationController,
      curve: _slideCurve,
    );
    _positionAnimation = Tween<Offset>(
      begin: friction.beginOffset - (_positionAnimation?.value ?? Offset.zero),
      end: Offset.zero,
    ).animate(curve);
    _sizeAnimation = Tween<double>(
      begin: friction.beginSize - (_sizeAnimation?.value ?? 0),
      end: 0,
    ).animate(curve);

    final previousDurationMs =
        _animationController.duration?.inMilliseconds ?? 0;
    final remainingDurationMs = _animationController.isAnimating
        ? ((1 - _animationController.value) * previousDurationMs).round()
        : 0;
    final durationMs = remainingDurationMs + (friction.duration * 1000).round();
    if (durationMs <= 0) {
      _clearSlideAnimation();
      return;
    }

    _animationController.duration = Duration(milliseconds: durationMs);
    unawaited(
      _animationController.forward(from: 0).then((_) {
        if (!mounted || slideAnimationId != _slideAnimationId) return;
        widget.delayBake();
      }),
    );
  }

  CameraTransform _visibleTransform(CameraTransform transform) =>
      transform.withFrictionless(
        _positionAnimation?.value ?? Offset.zero,
        _sizeAnimation?.value ?? 0,
      );

  @override
  Widget build(BuildContext context) {
    final state = widget.documentState;
    return BlocListener<TransformCubit, CameraTransform>(
      listenWhen: (previous, current) =>
          previous.friction?.lastUpdate != current.friction?.lastUpdate,
      listener: (_, transform) => _handleSlideAnimation(transform),
      child: BlocBuilder<TransformCubit, CameraTransform>(
        builder: (context, transform) => AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            final visibleTransform = _visibleTransform(transform);
            return Stack(
              children: [
                Container(color: ColorScheme.of(context).surfaceDim),
                RepaintBoundary(
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: ViewPainter(
                      state.data,
                      state.page,
                      state.info,
                      cameraViewport: widget.rendererState.cameraViewport,
                      transform: visibleTransform,
                      invisibleLayers: state.invisibleLayers,
                      currentArea: state.currentArea,
                      colorScheme: ColorScheme.of(context),
                    ),
                    isComplex: true,
                  ),
                ),
                BlocBuilder<ToolCubit, ToolRuntimeState>(
                  buildWhen: (previous, current) =>
                      previous.foregrounds != current.foregrounds ||
                      previous.temporaryForegrounds !=
                          current.temporaryForegrounds ||
                      previous.toggleableForegrounds !=
                          current.toggleableForegrounds ||
                      previous.networkingForegrounds !=
                          current.networkingForegrounds ||
                      previous.selection != current.selection,
                  builder: (context, toolState) => RepaintBoundary(
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: ForegroundPainter(
                        toolState.getAllForegrounds(),
                        state.data,
                        state.page,
                        state.info,
                        ColorScheme.of(context),
                        visibleTransform,
                        toolState.selection,
                        state.settingsCubit.state.navigatorPosition,
                      ),
                      willChange: true,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
