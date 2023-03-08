part of 'handler.dart';

abstract class GeneralPresentationHandler {
  Timer? _timer;
  PresentationRunningState _state = PresentationRunningState.paused;

  int get currentFrame;

  AnimationTrack? getAnimation(DocumentBloc bloc);

  void _createTimer(DocumentBloc bloc) {
    final animation = getAnimation(bloc);
    if (animation == null) return;
    _timer ??= Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_state == PresentationRunningState.running) {
        onTick(bloc, animation);
      }
    });
  }

  void _onStateChange(DocumentBloc bloc) {}

  void play(DocumentBloc bloc) {
    _state = PresentationRunningState.running;
    _createTimer(bloc);
    _onStateChange(bloc);
  }

  void playReverse(DocumentBloc bloc) {
    _state = PresentationRunningState.reversed;
    _createTimer(bloc);
    _onStateChange(bloc);
  }

  void toggle(DocumentBloc bloc) {
    switch (_state) {
      case PresentationRunningState.running:
      case PresentationRunningState.reversed:
        pause(bloc);
        break;
      case PresentationRunningState.paused:
        play(bloc);
        break;
    }
  }

  void onTick(DocumentBloc bloc, AnimationTrack animation) {
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    _applyAnimation(
        animation, bloc, state.currentIndexCubit, state.transformCubit);

    var frame = currentFrame;
    switch (_state) {
      case PresentationRunningState.running:
        if (frame < animation.duration) {
          frame++;
        }
        break;
      case PresentationRunningState.reversed:
        if (frame > 0) {
          frame--;
        }
        break;
      case PresentationRunningState.paused:
        return;
    }
    changeFrame(bloc, animation, frame);
    if (animation.keys[frame]?.breakpoint ?? false) {
      pause(bloc);
    }
  }

  void changeFrame(DocumentBloc bloc, AnimationTrack animation, int frame);

  void pause(DocumentBloc bloc) {
    _state = PresentationRunningState.paused;
    _onStateChange(bloc);
  }

  void stop(DocumentBloc bloc) {
    _state = PresentationRunningState.paused;
    _timer?.cancel();
    _onStateChange(bloc);
  }

  void _applyAnimation(AnimationTrack animation, DocumentBloc bloc,
      CurrentIndexCubit cubit, TransformCubit transformCubit) {
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    final position = animation.interpolateCameraPosition(currentFrame);
    final zoom = animation.interpolateCameraZoom(currentFrame);
    if (position == null && zoom == null) return;
    if (position != null) transformCubit.setPosition(position.toOffset());
    if (zoom != null) transformCubit.size(zoom);
    cubit.bake(state.document);
  }

  void _applyAnimationFromBloc(DocumentBloc bloc) {
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    final animation = getAnimation(bloc);
    if (animation == null) return;
    _applyAnimation(
        animation, bloc, state.currentIndexCubit, state.transformCubit);
  }
}

class PresentationHandler extends GeneralMoveHandler<PresentationPainter>
    with GeneralPresentationHandler {
  int _currentFrame = 0;
  String? _currentAnimation;

  PresentationHandler(super.data);

  @override
  Widget? getToolbar(DocumentBloc bloc) => PresentationToolbarView(
        animation: _currentAnimation,
        frame: _currentFrame,
        onAnimationChanged: (animation) {
          _currentAnimation = animation;
          _refreshToolbar(bloc);
          _applyAnimationFromBloc(bloc);
        },
        onFrameChanged: (frame) {
          _currentFrame = frame;
          _refreshToolbar(bloc);
          _applyAnimationFromBloc(bloc);
        },
        runningState: _state,
        onRunningStateChanged: (value) {
          switch (value) {
            case PresentationRunningState.running:
              play(bloc);
              break;
            case PresentationRunningState.reversed:
              playReverse(bloc);
              break;
            case PresentationRunningState.paused:
              pause(bloc);
              break;
          }
        },
      );

  @override
  AnimationTrack? getAnimation(DocumentBloc bloc) {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess || _currentAnimation == null) return null;
    final animation = state.document.getAnimation(_currentAnimation!);
    return animation;
  }

  @override
  int get currentFrame => _currentFrame;

  @override
  void changeFrame(DocumentBloc bloc, AnimationTrack animation, int frame) {
    _currentFrame = frame;
    _refreshToolbar(bloc);
  }

  @override
  void _onStateChange(DocumentBloc bloc) {
    _refreshToolbar(bloc);
  }

  void _refreshToolbar(DocumentBloc bloc) {
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    state.currentIndexCubit.refreshToolbar(bloc);
  }
}

enum PresentationRunningState { running, reversed, paused }

class PresentationStateHandler extends Handler<AnimationTrack>
    with GeneralPresentationHandler {
  DocumentBloc bloc;

  PresentationStateHandler(super.data, this.bloc) {
    play(bloc);
  }

  @override
  void dispose(DocumentBloc bloc) {
    super.dispose(bloc);
    stop(bloc);
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
      play(bloc);
    } else {
      playReverse(bloc);
    }
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

  @override
  int get currentFrame {
    final state = bloc.state;
    if (state is! DocumentPresentationState) return 0;
    return state.frame;
  }

  @override
  AnimationTrack? getAnimation(DocumentBloc bloc) => data;

  @override
  void changeFrame(DocumentBloc bloc, AnimationTrack animation, int frame) {
    bloc.add(PresentationTick(frame));
  }
}
