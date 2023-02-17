part of 'handler.dart';

class PresentationHandler extends Handler<PresentationPainter> {
  PresentationHandler(super.data);

  @override
  Widget? getToolbar(BuildContext context) => const PresentationToolbarView();
}
