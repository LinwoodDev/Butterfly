part of 'handler.dart';

class RedoHandler extends Handler<RedoTool> {
  RedoHandler(super.data);

  @override
  SelectState onSelected(BuildContext context, [bool wasAdded = true]) {
    final bloc = context.read<DocumentBloc>();
    bloc.sendRedo();
    bloc.reload();
    return SelectState.none;
  }

  @override
  ToolStatus getStatus(DocumentBloc bloc) {
    return bloc.canRedo ? ToolStatus.normal : ToolStatus.disabled;
  }
}
