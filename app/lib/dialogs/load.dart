import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

mixin LoadingDialogHandler {
  void setProgress(double progress) {}
  void close() {}
}

_LoadingDialogState? showLoadingDialog(BuildContext context) {
  final key = GlobalKey<_LoadingDialogState>();
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return LoadingDialog(key: key);
    },
  );
  return key.currentState;
}

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({super.key});

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog>
    with LoadingDialogHandler {
  double _progress = 0.0;

  @override
  void setProgress(double progress) => setState(() {
        _progress = progress;
      });

  @override
  void close() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(value: _progress),
                const SizedBox(height: 16),
                Text(AppLocalizations.of(context).loading),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
