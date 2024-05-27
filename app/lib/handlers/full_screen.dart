part of 'handler.dart';

class FullScreenHandler extends Handler<FullScreenTool> {
  FullScreenHandler(super.data);

  @override
  bool onSelected(BuildContext context) {
    context.read<WindowCubit>().toggleFullScreen();
    return false;
  }

  @override
  PhosphorIconData getIcon(DocumentBloc bloc) {
    return bloc.state.windowCubit.state.fullScreen
        ? PhosphorIconsLight.arrowsIn
        : PhosphorIconsLight.arrowsOut;
  }
}
