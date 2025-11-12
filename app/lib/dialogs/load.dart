import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

class LoadingDialogHandler {
  final GlobalKey<_LoadingDialogState> _key;
  final OverlayEntry entry;

  LoadingDialogHandler._(this._key, this.entry);

  void setProgress(double progress) => _key.currentState?.setProgress(progress);

  bool _wasClosed = false;

  void close() {
    if (_wasClosed) return;
    _wasClosed = true;
    entry.remove();
    entry.dispose();
  }
}

LoadingDialogHandler? showLoadingDialog(BuildContext context) {
  final key = GlobalKey<_LoadingDialogState>();

  final overlay = Overlay.maybeOf(context, rootOverlay: true);
  if (overlay == null) return null;

  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (ctx) => Stack(
      children: [
        const ModalBarrier(dismissible: false),
        LoadingDialog(key: key),
      ],
    ),
  );

  overlay.insert(entry);
  return LoadingDialogHandler._(key, entry);
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
