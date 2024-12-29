part of 'handler.dart';

class RedoHandler extends Handler<RedoTool> {
  RedoHandler(super.data);

  @override
  SelectState onSelected(BuildContext context, [bool wasAdded = true]) {
    final bloc = context.read<DocumentBloc>();
    bloc.redo();
    bloc.load().then((value) => bloc.bake().then((value) => bloc.save()));
    return SelectState.none;
  }

  @override
  ToolStatus getStatus(DocumentBloc bloc) {
    return bloc.canRedo ? ToolStatus.normal : ToolStatus.disabled;
  }
}
