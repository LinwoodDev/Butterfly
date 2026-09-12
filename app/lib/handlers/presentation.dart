part of 'handler.dart';

mixin GeneralPresentationHandler {
  Timer? _timer;
  PresentationRunningState _state = .paused;

  int get currentFrame;

  AnimationTrack? getAnimation(DocumentBloc bloc);

  void _createTimer(DocumentBloc bloc) {
    final animation = getAnimation(bloc);
    if (animation == null) return;
    final milliseconds = 1000 ~/ animation.fps;
    _timer ??= Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      if (_state != .paused) {
        onTick(bloc, animation);
      }
    });
  }

  void _onStateChange(DocumentBloc bloc) {}

  void next(DocumentBloc bloc, BuildContext context) {
    final animation = getAnimation(bloc);
    if (animation == null) return;
    if (currentFrame >= animation.duration) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).endOfPresentation)),
      );
    } else {
      play(bloc);
    }
  }

  void previous(DocumentBloc bloc, BuildContext context) {
    if (currentFrame <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).startOfPresentation),
        ),
      );
    } else {
      playReverse(bloc);
    }
  }

  void play(DocumentBloc bloc) {
    if (_state == .running) return;
    _state = PresentationRunningState.running;
    _timer?.cancel();
    _timer = null;
    _createTimer(bloc);
    _onStateChange(bloc);
  }

  void playReverse(DocumentBloc bloc) {
    if (_state == .reversed) return;
    _state = PresentationRunningState.reversed;
    _timer?.cancel();
    _timer = null;
    _createTimer(bloc);
    _onStateChange(bloc);
  }

  void toggle(DocumentBloc bloc) {
    switch (_state) {
      case .running:
      case .reversed:
        pause(bloc);
        break;
      case .paused:
        play(bloc);
        break;
    }
  }

  void onTick(DocumentBloc bloc, AnimationTrack animation) {
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    _applyAnimation(
      animation,
      bloc,
      bloc.editorController,
      bloc.transformCubit,
    );

    var frame = currentFrame;
    switch (_state) {
      case .running:
        if (frame < animation.duration) {
          frame++;
        } else {
          pause(bloc);
        }
        break;
      case .reversed:
        if (frame > 0) {
          frame--;
        } else {
          pause(bloc);
        }
        break;
      case .paused:
        return;
    }
    changeFrame(bloc, animation, frame);
    if (animation.keys[frame]?.breakpoint ?? false) {
      pause(bloc);
    }
  }

  void changeFrame(DocumentBloc bloc, AnimationTrack animation, int frame);

  void pause(DocumentBloc bloc) {
    if (_state == .paused) return;
    _state = PresentationRunningState.paused;
    _timer?.cancel();
    _timer = null;
    _onStateChange(bloc);
  }

  void stop(DocumentBloc bloc) {
    _state = PresentationRunningState.paused;
    _timer?.cancel();
    _timer = null;
    _onStateChange(bloc);
  }

  void _applyAnimation(
    AnimationTrack animation,
    DocumentBloc bloc,
    EditorController cubit,
    TransformCubit transformCubit,
  ) {
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    final position = animation.interpolateCameraPosition(currentFrame);
    final zoom = animation.interpolateCameraZoom(currentFrame);
    if (position == null && zoom == null) return;
    if (position != null) transformCubit.teleport(position.toOffset());
    if (zoom != null) transformCubit.size(zoom);
    bloc.delayedBake(testTransform: true);
  }

  void _applyAnimationFromBloc(DocumentBloc bloc) {
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    final animation = getAnimation(bloc);
    if (animation == null) return;
    _applyAnimation(
      animation,
      bloc,
      bloc.editorController,
      bloc.transformCubit,
    );
  }
}

class PresentationHandler extends GeneralHandHandler<PresentationTool>
    with GeneralPresentationHandler {
  int _currentFrame = 0;
  String? _currentAnimation;

  PresentationHandler(super.data);

  @override
  PreferredSizeWidget getToolbar(DocumentBloc bloc) => PresentationToolbarView(
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
        case .running:
          play(bloc);
          break;
        case .reversed:
          playReverse(bloc);
          break;
        case .paused:
          pause(bloc);
          break;
      }
    },
  );

  @override
  void dispose(DocumentBloc bloc) {
    super.dispose(bloc);
    stop(bloc);
  }

  @override
  AnimationTrack? getAnimation(DocumentBloc bloc) {
    final state = bloc.state;
    _currentAnimation ??= state.page?.animations.firstOrNull?.name;
    if (state is! DocumentLoadSuccess || _currentAnimation == null) return null;
    final animation = state.page.getAnimation(_currentAnimation!);
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
    bloc.editorController.toolCubit.refreshToolbar(bloc);
  }
}

enum PresentationRunningState { running, reversed, paused }

class PresentationStateHandler extends Handler<AnimationTrack>
    with GeneralPresentationHandler {
  DocumentBloc bloc;

  PresentationStateHandler(super.data, this.bloc) {
    _applyAnimationFromBloc(bloc);
  }

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) => true;

  @override
  void dispose(DocumentBloc bloc) {
    super.dispose(bloc);
    stop(bloc);
  }

  @override
  void onScaleEnd(ScaleEndDetails details, EventContext context) {
    if (!_checkSlideChange(details, context)) {
      _checkStateChange(details, context);
    }
  }

  @override
  void onTapUp(TapUpDetails details, EventContext context) {
    if (details.kind == .mouse) {
      if (_state == .reversed || _state == .paused) {
        play(bloc);
      } else {
        pause(bloc);
      }
      return;
    }
    toggle(bloc);
  }

  bool _checkSlideChange(ScaleEndDetails details, EventContext context) {
    final dx = details.velocity.pixelsPerSecond.dx;
    if (dx.abs() < 100) return false;
    if (dx < 0) {
      next(bloc, context.buildContext);
    } else {
      previous(bloc, context.buildContext);
    }
    return true;
  }

  void _checkStateChange(ScaleEndDetails details, EventContext context) {
    final dy = details.velocity.pixelsPerSecond.dy;
    if (dy.abs() < 100) return;
    if (dy > 0) {
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
