part of 'handler.dart';

class FullScreenHandler extends Handler<FullScreenTool> {
  FullScreenHandler(super.data);

  @override
  SelectState onSelected(BuildContext context, [bool wasAdded = true]) {
    context.read<WindowCubit>().toggleFullScreen();
    return SelectState.none;
  }

  @override
  PhosphorIconData getIcon(DocumentBloc bloc) =>
      bloc.state.windowCubit.state.fullScreen
      ? PhosphorIconsLight.arrowsIn
      : PhosphorIconsLight.arrowsOut;
}
