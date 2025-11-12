part of 'handler.dart';

class UndoHandler extends Handler<UndoTool> {
  UndoHandler(super.data);

  @override
  Future<SelectState> onSelected(
    BuildContext context, [
    bool wasAdded = true,
  ]) async {
    final bloc = context.read<DocumentBloc>();
    bloc.sendUndo();
    await bloc.reload();
    return SelectState.none;
  }

  @override
  ToolStatus getStatus(DocumentBloc bloc) =>
      bloc.canUndo ? ToolStatus.normal : ToolStatus.disabled;
}
