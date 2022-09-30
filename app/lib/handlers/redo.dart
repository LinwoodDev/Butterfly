part of 'handler.dart';

class RedoHandler extends Handler<RedoPainter> {
  RedoHandler(super.data);

  @override
  bool onSelected(DocumentBloc bloc, CurrentIndexCubit currentIndexCubit) {
    bloc.redo();
    bloc.load().then((value) => bloc.bake());
    return false;
  }

  @override
  PainterStatus getStatus(DocumentBloc bloc) {
    return bloc.canRedo ? PainterStatus.normal : PainterStatus.disabled;
  }
}
