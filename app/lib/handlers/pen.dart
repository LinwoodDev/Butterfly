part of 'handler.dart';

class PenHandler extends Handler {
  final PenPainter painter;

  PenHandler(this.painter, DocumentBloc bloc) : super(bloc);

  @override
  void onTapDown(TapDownDetails details) {}
}
