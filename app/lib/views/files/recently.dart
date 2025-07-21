import 'dart:typed_data';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/files/card.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_file_system/lw_file_system.dart';

class RecentFilesView extends StatefulWidget {
  final bool replace, asGrid;
  final void Function(FileSystemEntity<NoteFile> entity)? onFileTap;

  const RecentFilesView({
    super.key,
    required this.replace,
    this.asGrid = false,
    this.onFileTap,
  });

  @override
  State<RecentFilesView> createState() => RecentFilesViewState();
}

class RecentFilesViewState extends State<RecentFilesView> {
  late Stream<List<FileSystemEntity<NoteFile>>> _stream;
  late final ButterflyFileSystem _fileSystem;
  final ScrollController _recentScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fileSystem = context.read<ButterflyFileSystem>();
    _setStream(context.read<SettingsCubit>().state);
  }

  @override
  void dispose() {
    _recentScrollController.dispose();
    super.dispose();
  }

  void _setStream(ButterflySettings settings) =>
      _stream = GeneralDirectoryFileSystem.fetchAssetsGlobalSync(
        settings.history,
        _fileSystem.buildAllDocumentSystems(),
      );

  Widget _getItem(FileSystemEntity<NoteFile> entity) {
    FileMetadata? metadata;
    Uint8List? thumbnail;
    if (entity is FileSystemFile<NoteFile>) {
      final data = entity.data?.load();
      metadata = data?.getMetadata();
      thumbnail = data?.getThumbnail();
    }
    return AssetCard(
      metadata: metadata,
      thumbnail: thumbnail,
      name: entity.location.identifier,
      height: double.infinity,
      onTap: () => widget.onFileTap == null
          ? openFile(context, widget.replace, entity.location)
          : widget.onFileTap!(entity),
    );
  }

  void reload([ButterflySettings? settings]) => setState(
    () => _setStream(settings ?? context.read<SettingsCubit>().state),
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, ButterflySettings>(
      listenWhen: (previous, current) => previous.history != current.history,
      listener: (_, state) => reload(state),
      child: StreamBuilder<List<FileSystemEntity<NoteFile>>>(
        stream: _stream,
        builder: (context, snapshot) {
          final files = snapshot.data ?? [];
          if (files.isEmpty) {
            return Container();
          }
          return widget.asGrid
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: kThumbnailRatio,
                    crossAxisCount: 2,
                  ),
                  itemCount: files.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => _getItem(files[index]),
                )
              : SizedBox(
                  height: 128,
                  child: Scrollbar(
                    controller: _recentScrollController,
                    child: ListView.builder(
                      controller: _recentScrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: files.length,
                      itemBuilder: (context, index) => _getItem(files[index]),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
