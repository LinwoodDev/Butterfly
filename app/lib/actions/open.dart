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
    AssetLocation? lastLocation;
    final context = intent.context;
    final state = bloc.state;
    if (state is DocumentLoadSuccess) lastLocation = state.location;
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
          final location = document.location;
          // Ignore if the document is already opened.
          if (lastLocation == location) return;
          if (location.remote != '') {
            final uri = Uri(pathSegments: [
              '',
              'remote',
              Uri.encodeComponent(location.remote),
              ...location.pathWithoutLeadingSlash
                  .split('/')
                  .map((e) => Uri.encodeComponent(e)),
            ]).toString();

            GoRouter.of(context).push(uri);
            return;
          }
          GoRouter.of(context).push(Uri(
            pathSegments: [
              '',
              'local',
              ...location.pathWithoutLeadingSlash
                  .split('/')
                  .map((e) => Uri.encodeComponent(e)),
            ],
          ).toString());
        });
      }
    });
  }
}
