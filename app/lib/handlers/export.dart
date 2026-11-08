part of 'handler.dart';

class ExportHandler extends Handler<ExportTool> {
  ExportHandler(super.data);

  @override
  SelectState onSelected(BuildContext context, [bool wasAdded = true]) {
    showExportDialog(context, options: data.options);
    return SelectState.none;
  }
}
