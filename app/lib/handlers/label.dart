part of 'handler.dart';

class LabelHandler extends Handler {
  final LabelPainter painter;

  LabelHandler(this.painter, DocumentBloc bloc) : super(bloc);
}
