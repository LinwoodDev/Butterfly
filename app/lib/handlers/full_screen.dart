part of 'handler.dart';

class FullScreenHandler extends Handler<FullScreenPainter> {
  FullScreenHandler(super.data);

  @override
  bool onSelected(
      DocumentBloc bloc, CurrentIndexCubit currentIndexCubit, bool justAdded) {
    if (justAdded) return false;
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
