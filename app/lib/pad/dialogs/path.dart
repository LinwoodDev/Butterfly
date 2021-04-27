import 'package:flutter/material.dart';

typedef ChangePathCallback<String> = void Function(String path);

class FilePathDialog extends StatefulWidget {
  final String? current;
  final ChangePathCallback? callback;

  const FilePathDialog({Key? key, this.current, this.callback}) : super(key: key);
  @override
  _FilePathDialogState createState() => _FilePathDialogState();
}

class _FilePathDialogState extends State<FilePathDialog> {
  TextEditingController? _pathController;
  @override
  void initState() {
    _pathController = TextEditingController(text: widget.current);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Change path"),
      content:
          TextField(controller: _pathController, decoration: InputDecoration(labelText: "path")),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("CANCEL")),
        TextButton(
            onPressed: () {
              widget.callback!(_pathController!.text);
              Navigator.of(context).pop();
            },
            child: Text("NAVIGATE"))
      ],
    );
  }
}
