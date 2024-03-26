part of 'handler.dart';

class UndoHandler extends Handler<UndoTool> {
  UndoHandler(super.data);

  @override
  bool onSelected(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    bloc.undo();
    bloc.load().then((value) => bloc.bake().then((value) => bloc.save()));
    return false;
  }

  @override
  ToolStatus getStatus(DocumentBloc bloc) {
    return bloc.canUndo ? ToolStatus.normal : ToolStatus.disabled;
  }
}
