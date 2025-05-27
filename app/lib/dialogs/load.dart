import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

class LoadingDialogHandler {
  final GlobalKey<_LoadingDialogState> _key;

  const LoadingDialogHandler._(this._key);

  void setProgress(double progress) => _key.currentState?.setProgress(progress);
  void close() => _key.currentState?.close();
}

LoadingDialogHandler? showLoadingDialog(BuildContext context) {
  final key = GlobalKey<_LoadingDialogState>();
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => LoadingDialog(key: key),
  );
  return LoadingDialogHandler._(key);
}

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({super.key});

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  double _progress = 0.0;

  void setProgress(double progress) => setState(() {
    _progress = progress;
  });

  void close() => Navigator.of(context).pop();

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
