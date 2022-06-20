import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/settings.dart';
import '../dialogs/file_system/dialog.dart';

class OpenIntent extends Intent {
  final BuildContext context;

  const OpenIntent(this.context);
}

class OpenAction extends Action<OpenIntent> {
  OpenAction();

  @override
  void invoke(OpenIntent intent) {
    final bloc = intent.context.read<DocumentBloc>();
    final settings = intent.context.read<SettingsCubit>().state;
    showDialog<AssetLocation>(
        context: intent.context,
        builder: (context) => FileSystemDialog(bloc: bloc)).then((value) {
      if (value != null) {
        return DocumentFileSystem.fromPlatform(
                remote: settings.getRemote(value.remote))
            .getAsset(value.path)
            .then((document) async {
          if (document is! AppDocumentFile) return;
          GoRouter.of(intent.context).push(Uri(
            pathSegments: [
              '',
              'local',
              ...document.path.split('/').sublist(1),
            ],
          ).toString());
        });
      }
    });
  }
}
