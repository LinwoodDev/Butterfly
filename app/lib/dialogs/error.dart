import 'package:flutter/material.dart';

class ErrorDialog extends StatefulWidget {
  final dynamic error;
  final StackTrace stackTrace;
  const ErrorDialog({Key? key, required this.error, required this.stackTrace})
      : super(key: key);

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.error.toString()),
      content: Text(widget.stackTrace.toString()),
      actions: [
        TextButton(
          child: Text(MaterialLocalizations.of(context).okButtonLabel),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
