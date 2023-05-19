import 'package:butterfly/api/file_system/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/file_system/move.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/settings.dart';

class ChangePathIntent extends Intent {
  final BuildContext context;

  const ChangePathIntent(this.context);
}

class ChangePathAction extends Action<ChangePathIntent> {
  ChangePathAction();

  @override
  Future<void> invoke(ChangePathIntent intent) async {
    final context = intent.context;
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess || state.location.path == '') return;
    final location = state.location;
    final settings = context.read<SettingsCubit>().state;
    final fileSystem = DocumentFileSystem.fromPlatform(
        remote: settings.getRemote(location.remote));
    var asset = await fileSystem.getAsset(location.path);
    if (asset == null) return;
    if (context.mounted) {
      var newPath = await showDialog<String?>(
          context: context,
          builder: (context) => FileSystemAssetMoveDialog(
                asset: asset,
                fileSystem: fileSystem,
              ));
      if (newPath == null) return;
      bloc.add(DocumentPathChanged(newPath));
    }
  }
}
