part of 'handler.dart';

class FullScreenHandler extends Handler<FullScreenTool> {
  FullScreenHandler(super.data);

  @override
  SelectState onSelected(BuildContext context, [bool wasAdded = true]) {
    unawaited(
      toggleFullScreen(
        context.read<EditorController>(),
        context.read<WindowCubit>(),
      ),
    );
    return SelectState.none;
  }

  @override
  PhosphorIconData getIcon(DocumentBloc bloc) =>
      (bloc.editorController.saveCubit.state.embedding != null
          ? bloc.editorController.saveCubit.state.fullScreen
          : bloc.state.windowCubit.state.fullScreen)
      ? PhosphorIconsLight.arrowsIn
      : PhosphorIconsLight.arrowsOut;
}
