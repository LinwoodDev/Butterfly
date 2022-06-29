import 'package:butterfly/models/document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FileSystemFileRichText extends StatelessWidget {
  final AppDocumentFile file;
  const FileSystemFileRichText({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (file.createdAt != null)
            Text(AppLocalizations.of(context)!.createdAt(file.createdAt!)),
          if (file.updatedAt != null)
            Text(AppLocalizations.of(context)!.updatedAt(file.updatedAt!)),
        ]);
  }
}
