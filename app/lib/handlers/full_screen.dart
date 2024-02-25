part of 'handler.dart';

class FullScreenHandler extends Handler<FullScreenTool> {
  FullScreenHandler(super.data);

  @override
  bool onSelected(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    bloc.state.settingsCubit.toggleFullScreen();
    return false;
  }

  @override
  PhosphorIconData getIcon(DocumentBloc bloc) {
    return bloc.state.settingsCubit.state.fullScreen
        ? PhosphorIconsLight.arrowsIn
        : PhosphorIconsLight.arrowsOut;
  }
}
