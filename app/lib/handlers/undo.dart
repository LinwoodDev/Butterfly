part of 'handler.dart';

class UndoHandler extends Handler<UndoTool> {
  UndoHandler(super.data);

  @override
  SelectState onSelected(BuildContext context, [bool wasAdded = true]) {
    final bloc = context.read<DocumentBloc>();
    bloc.sendUndo();
    bloc.reload();
    return SelectState.none;
  }

  @override
  ToolStatus getStatus(DocumentBloc bloc) =>
      bloc.canUndo ? ToolStatus.normal : ToolStatus.disabled;
}
