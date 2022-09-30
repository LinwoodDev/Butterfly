part of 'handler.dart';

class UndoHandler extends Handler<UndoPainter> {
  UndoHandler(super.data);

  @override
  bool onSelected(DocumentBloc bloc, CurrentIndexCubit currentIndexCubit) {
    bloc.undo();
    bloc.load().then((value) => bloc.bake());
    return false;
  }

  @override
  PainterStatus getStatus(DocumentBloc bloc) {
    return bloc.canUndo ? PainterStatus.normal : PainterStatus.disabled;
  }
}
