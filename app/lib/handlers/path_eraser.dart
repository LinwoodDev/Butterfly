part of 'handler.dart';

class PathEraserHandler extends Handler {
  final PathEraserPainter painter;

  PathEraserHandler(this.painter, DocumentBloc bloc) : super(bloc);

  @override
  void onTapDown(TapDownDetails details) {}
}
