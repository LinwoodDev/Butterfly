part of 'handler.dart';

class RedoHandler extends Handler<RedoTool> {
  RedoHandler(super.data);

  @override
  bool onSelected(
      DocumentBloc bloc, CurrentIndexCubit currentIndexCubit, bool justAdded) {
    if (justAdded) return false;
    bloc.redo();
    bloc.load().then((value) => bloc.bake());
    return false;
  }

  @override
  ToolStatus getStatus(DocumentBloc bloc) {
    return bloc.canRedo ? ToolStatus.normal : ToolStatus.disabled;
  }
}
