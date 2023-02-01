import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FileSystemFileRichText extends StatelessWidget {
  final AppDocumentFile file;
  const FileSystemFileRichText({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    final info = file.getDocumentInfo();
    if (info == null) {
      return Container();
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (info.createdAt != null)
            Text(AppLocalizations.of(context).createdAt(info.createdAt!)),
          if (info.updatedAt != null)
            Text(AppLocalizations.of(context).updatedAt(info.updatedAt!)),
        ]);
  }
}
