part of 'handler.dart';

class RedoHandler extends Handler<RedoTool> {
  RedoHandler(super.data);

  @override
  Future<SelectState> onSelected(
    BuildContext context, [
    bool wasAdded = true,
  ]) async {
    final bloc = context.read<DocumentBloc>();
    bloc.sendRedo();
    await bloc.reload();
    return SelectState.none;
  }

  @override
  ToolStatus getStatus(DocumentBloc bloc) {
    return bloc.canRedo ? ToolStatus.normal : ToolStatus.disabled;
  }
}
