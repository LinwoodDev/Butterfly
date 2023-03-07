part of 'handler.dart';

class PresentationHandler extends Handler<PresentationPainter> {
  int _currentFrame = 0;
  String? _currentAnimation;

  PresentationHandler(super.data);

  @override
  Widget? getToolbar(BuildContext context) => PresentationToolbarView(
        animation: _currentAnimation,
        frame: _currentFrame,
        onAnimationChanged: (animation) {
          _currentAnimation = animation;
          _applyAnimationFromContext(context);
        },
        onFrameChanged: (frame) {
          _currentFrame = frame;
          _applyAnimationFromContext(context);
        },
      );

  AnimationTrack? _getAnimation(DocumentBloc bloc) {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess || _currentAnimation == null) return null;
    final animation = state.document.getAnimation(_currentAnimation!);
    return animation;
  }

  void _applyAnimationFromContext(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final cubit = context.read<CurrentIndexCubit>();
    final transformCubit = context.read<TransformCubit>();
    _applyAnimation(bloc, cubit, transformCubit);
  }

  void _applyAnimation(DocumentBloc bloc, CurrentIndexCubit cubit,
      TransformCubit transformCubit) {
    final animation = _getAnimation(bloc);
    if (animation == null) return;
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final position = animation.interpolateCameraPosition(_currentFrame);
    final zoom = animation.interpolateCameraZoom(_currentFrame);
    if (position == null && zoom == null) return;
    if (position != null) transformCubit.setPosition(position.toOffset());
    if (zoom != null) transformCubit.zoom(zoom);
    cubit.bake(state.document);
  }
}

enum PresentationRunningState { running, reversed, paused }

class PresentationStateHandler extends Handler<AnimationTrack> {
  DocumentBloc bloc;
  Timer? _timer;
  PresentationRunningState _state = PresentationRunningState.paused;

  PresentationStateHandler(super.data, this.bloc) {
    setup();
  }

  void setup() {
    final fps = data.fps;
    final milliseconds = 1000 ~/ fps;
    _timer = Timer.periodic(Duration(milliseconds: milliseconds), _tick);
  }

  @override
  void dispose(DocumentBloc bloc) {
    super.dispose(bloc);
    _timer?.cancel();
  }

  void _tick(Timer timer) {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    int tick = 0;
    switch (_state) {
      case PresentationRunningState.running:
        tick = 1;
        break;
      case PresentationRunningState.reversed:
        tick = -1;
        break;
      case PresentationRunningState.paused:
        return;
    }
    bloc.add(PresentationTick(tick));
  }

  @override
  void onScaleEnd(ScaleEndDetails details, EventContext context) {
    _checkSlideChange(details, context);
    _checkStateChange(details, context);
  }

  void _checkSlideChange(ScaleEndDetails details, EventContext context) {
    final dx = details.velocity.pixelsPerSecond.dx;
    if (dx.abs() < 50) return;
    if (dx < 0) {
      _nextSlide(context);
    } else {
      _previousSlide(context);
    }
  }

  void _nextSlide(EventContext context) {
    _state = PresentationRunningState.running;
  }

  void _previousSlide(EventContext context) {
    _state = PresentationRunningState.reversed;
  }

  void _checkStateChange(ScaleEndDetails details, EventContext context) {
    final dy = details.velocity.pixelsPerSecond.dy;
    if (dy.abs() < 50) return;
    if (dy < 0) {
      _exitPresentation(context);
    }
  }

  void _exitPresentation(EventContext context) {
    context.getDocumentBloc().add(const PresentationModeExited());
  }
}
