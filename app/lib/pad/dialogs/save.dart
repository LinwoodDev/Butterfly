import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaveDialog extends StatefulWidget {
  final String data;
  const SaveDialog({Key? key, required this.data}) : super(key: key);

  @override
  _SaveDialogState createState() => _SaveDialogState();
}

class _SaveDialogState extends State<SaveDialog> {
  final TextEditingController _textController = TextEditingController();
  @override
  void initState() {
    _textController.text = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = Platform.isAndroid || Platform.isIOS;
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: const Icon(PhosphorIcons.floppyDiskLight),
            title: Text(AppLocalizations.of(context)!.save),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Expanded(
                    child: TextField(
                  controller: _textController,
                  readOnly: true,
                  maxLines: null,
                )),
                const Divider(),
                Row(children: [
                  OutlinedButton(
                      onPressed: () => Clipboard.setData(ClipboardData(text: widget.data)),
                      child: Text(AppLocalizations.of(context)!.clipboard)),
                  if (!kIsWeb && !isMobile)
                    OutlinedButton(
                        onPressed: () {
                          FilePicker.platform.saveFile(
                              fileName: "butterfly.json",
                              type: FileType.custom,
                              allowedExtensions: ["json"]).then((value) {
                            if (value == null) {
                              return;
                            }
                            var file = File(value);
                            void write() {
                              file.writeAsStringSync(widget.data);
                            }

                            if (!file.existsSync()) {
                              write();
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(AppLocalizations.of(context)!.areYouSure),
                                        content: Text(AppLocalizations.of(context)!.existOverride),
                                        actions: [
                                          TextButton(
                                              child: Text(AppLocalizations.of(context)!.no),
                                              onPressed: () => Navigator.of(context).pop()),
                                          TextButton(
                                              child: Text(AppLocalizations.of(context)!.yes),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                write();
                                              })
                                        ],
                                      ));
                            }
                          });
                        },
                        child: Text(AppLocalizations.of(context)!.file)),
                  Expanded(child: Container()),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(AppLocalizations.of(context)!.ok))
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
