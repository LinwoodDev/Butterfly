import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/embed/embedding.dart';
import 'package:butterfly/views/files/view.dart';
import 'package:butterfly/views/main.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_file_system/lw_file_system.dart';

class FilesNavigatorPage extends StatefulWidget {
  const FilesNavigatorPage({super.key});

  @override
  State<FilesNavigatorPage> createState() => _FilesNavigatorPageState();
}

class _FilesNavigatorPageState extends State<FilesNavigatorPage> {
  ExternalStorage? _remote;
  (NoteData, AssetLocation)? _opened;

  @override
  void initState() {
    super.initState();
    _remote = context.read<SettingsCubit>().getRemote();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      buildWhen: (previous, current) =>
          (previous is DocumentLoadSuccess &&
              current is! DocumentLoadSuccess) ||
          (previous is! DocumentLoadSuccess &&
              current is DocumentLoadSuccess) ||
          (current is DocumentLoaded &&
              previous is DocumentLoaded &&
              current.location != previous.location),
      builder: (context, state) {
        AssetLocation? location;
        if (state is DocumentLoaded) {
          location = state.location;
          location = AssetLocation(
            remote: location.remote,
            path: '/${location.path}',
          );
        }
        if (_opened != null) {
          return ProjectPage(
            embedding: Embedding(
              editable: false,
              save: false,
              internal: true,
              location: _opened?.$2,
              onOpen: () => openFile(context, true, _opened!.$2, _opened!.$1),
              onExit: () => setState(() {
                _opened = null;
              }),
            ),
            data: _opened?.$1,
          );
        }
        return SingleChildScrollView(
          child: FilesView(
            remote: _remote,
            activeAsset: location,
            initialPath: location?.parent,
            onPreview: (value) {
              final data = value.data!.load();
              if (data == null) return;
              setState(() {
                _opened = (data, value.location);
              });
            },
            onRemoteChanged: (remote) {
              setState(() {
                _remote = remote;
              });
            },
            collapsed: true,
          ),
        );
      },
    );
  }
}
