part of 'handler.dart';

class ImportHandler extends Handler<ImportPainter> {
  ImportHandler(super.data);

  @override
  bool onSelected(
      DocumentBloc bloc, CurrentIndexCubit currentIndexCubit, bool justAdded) {
    if (justAdded) return false;
    return false;
  }
}
