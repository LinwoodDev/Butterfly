part of 'handler.dart';

class WaypointHandler extends Handler<WaypointPainter> {
  WaypointHandler(super.data);

  @override
  bool onSelected(
      DocumentBloc bloc, CurrentIndexCubit currentIndexCubit, bool justAdded) {
    if (justAdded) return false;
    return false;
  }
}
