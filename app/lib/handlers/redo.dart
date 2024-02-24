part of 'handler.dart';

class RedoHandler extends Handler<RedoTool> {
  RedoHandler(super.data);

  @override
  bool onSelected(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    bloc.redo();
    bloc.load().then((value) => bloc.bake());
    return false;
  }

  @override
  ToolStatus getStatus(DocumentBloc bloc) {
    return bloc.canRedo ? ToolStatus.normal : ToolStatus.disabled;
  }
}
