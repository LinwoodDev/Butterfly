import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OpenDialog extends StatefulWidget {
  const OpenDialog({Key? key}) : super(key: key);

  @override
  _OpenDialogState createState() => _OpenDialogState();
}

class _OpenDialogState extends State<OpenDialog> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var isMobile = Platform.isAndroid || Platform.isIOS;
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: const Icon(PhosphorIcons.folderOpenLight),
            title: Text(AppLocalizations.of(context)!.open),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Expanded(
                    child: TextField(
                  controller: _textController,
                  maxLines: null,
                )),
                const Divider(),
                Row(children: [
                  OutlinedButton(
                      onPressed: () => Clipboard.getData("text/plain").then(
                          (value) => _textController.text = value?.text ?? _textController.text),
                      child: Text(AppLocalizations.of(context)!.clipboard)),
                  OutlinedButton(
                      onPressed: () {
                        FilePicker.platform
                            .pickFiles(
                                type: isMobile ? FileType.any : FileType.custom,
                                allowedExtensions: isMobile ? null : ["json"])
                            .then((files) {
                          if (files?.files.isEmpty ?? true) return;
                          var e = files!.files.first;
                          var content = String.fromCharCodes(e.bytes ?? Uint8List(0));
                          if (!kIsWeb) content = File(e.path ?? "").readAsStringSync();
                          _textController.text = content;
                        });
                      },
                      child: Text(AppLocalizations.of(context)!.file)),
                  Expanded(child: Container()),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(AppLocalizations.of(context)!.cancel)),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(_textController.text),
                      child: Text(AppLocalizations.of(context)!.open))
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
