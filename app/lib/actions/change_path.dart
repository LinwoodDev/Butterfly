import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/file_system/move.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';
import 'package:lw_file_system/lw_file_system.dart';

import '../cubits/settings.dart';

class ChangePathIntent extends Intent {
  const ChangePathIntent();
}

const changePathShortcut = ShortcutDefinition(
  id: 'change_path',
  intent: ChangePathIntent(),
  defaultActivator: SingleActivator(LogicalKeyboardKey.keyS, alt: true),
);

class ChangePathAction extends Action<ChangePathIntent> {
  final BuildContext context;

  ChangePathAction(this.context);

  @override
  Future<void> invoke(ChangePathIntent intent) async {
    final bloc = context.read<DocumentBloc>();
    final cubit = bloc.editorController;
    final location = cubit.saveCubit.state.location;
    if (location.path == '') return;
    final settings = context.read<SettingsCubit>().state;
    final fileSystem = context.read<ButterflyFileSystem>().buildDocumentSystem(
      settings.getRemote(location.remote),
    );
    var asset = await fileSystem.getAsset(location.path);
    if (asset == null) return;
    if (context.mounted) {
      var newLocations = await showDialog<List<AssetLocation>>(
        context: context,
        builder: (context) => FileSystemAssetMoveDialog(
          assets: [asset.location],
          fileSystem: fileSystem,
        ),
      );
      if (newLocations == null) return;
      cubit.saveCubit.setSaveState(
        location: newLocations.first,
        isCreating: false,
      );
      bloc.save();
    }
  }
}
