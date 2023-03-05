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
        },
        onFrameChanged: (frame) {
          _currentFrame = frame;
        },
      );
}
