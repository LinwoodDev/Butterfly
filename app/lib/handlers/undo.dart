part of 'handler.dart';

class UndoHandler extends Handler<UndoTool> {
  UndoHandler(super.data);

  @override
  bool onSelected(
      DocumentBloc bloc, CurrentIndexCubit currentIndexCubit, bool justAdded) {
    if (justAdded) return false;
    bloc.undo();
    bloc.load().then((value) => bloc.bake());
    return false;
  }

  @override
  ToolStatus getStatus(DocumentBloc bloc) {
    return bloc.canUndo ? ToolStatus.normal : ToolStatus.disabled;
  }
}
