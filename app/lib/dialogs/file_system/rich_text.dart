import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';

class FileSystemFileRichText extends StatelessWidget {
  final FileSystemFile<NoteData> file;
  const FileSystemFileRichText({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    final metadata = file.data?.getMetadata();
    if (metadata == null) {
      return Container();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (metadata.createdAt != null)
          Text(AppLocalizations.of(context).createdAt(metadata.createdAt!)),
        if (metadata.updatedAt != null)
          Text(AppLocalizations.of(context).updatedAt(metadata.updatedAt!)),
      ],
    );
  }
}
