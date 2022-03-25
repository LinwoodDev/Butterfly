part of 'handler.dart';

class EraserHandler extends Handler {
  final EraserPainter painter;

  EraserHandler(this.painter, DocumentBloc bloc) : super(bloc);

  @override
  void onTapDown(TapDownDetails details) {}
}
