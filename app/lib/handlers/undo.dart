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
    return SelectState.none;
  }

  @override
  ToolStatus getStatus(DocumentBloc bloc) =>
      bloc.canSendUndo ? ToolStatus.normal : ToolStatus.disabled;
}
