import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/file_system/move.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePathIntent extends Intent {
  final BuildContext context;

  const ChangePathIntent(this.context);
}

class ChangePathAction extends Action<ChangePathIntent> {
  ChangePathAction();

  @override
  Future<void> invoke(ChangePathIntent intent) async {
    var bloc = intent.context.read<DocumentBloc>();
    var state = bloc.state;
    if (state is! DocumentLoadSuccess || state.path == null) return;
    var fileSystem = DocumentFileSystem.fromPlatform();
    var asset = await fileSystem.getAsset(state.path!);
    if (asset == null) return;
    var newPath = await showDialog(
        context: intent.context,
        builder: (context) => FileSystemAssetMoveDialog(asset: asset));
    if (newPath == null) return;
    bloc.add(DocumentPathChanged(newPath));
  }
}
