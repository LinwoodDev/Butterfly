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
