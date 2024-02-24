part of 'handler.dart';

class ExportHandler extends Handler<ExportTool> {
  ExportHandler(super.data);

  @override
  bool onSelected(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    showDialog(
        context: context,
        builder: (context) => BlocProvider.value(
              value: bloc,
              child: GeneralExportDialog(
                options: data.options,
              ),
            ));
    return false;
  }
}
