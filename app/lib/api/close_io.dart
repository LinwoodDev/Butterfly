import 'dart:async';

import 'package:butterfly/api/close.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:window_manager/window_manager.dart';

enum _CloseDialogResult { save, discard }

CloseSubscription onPreventClose(
  BuildContext context,
  OnCloseCallback onClose,
) {
  return IOCloseSubscription(context, onClose);
}

class IOCloseSubscription extends CloseSubscription {
  static final List<IOCloseSubscription> _activeSubscriptions = [];

  final OnCloseCallback _onClose;
  final BuildContext context;
  Window? _window;
  ListenerId? _listener;
  bool _isClosing = false;
  bool _isDisposed = false;

  IOCloseSubscription(this.context, this._onClose, {Window? window}) {
    if (kIsWeb || !isWindow) return;
    _window = window ?? WindowManager.instance.getCurrent();
    if (_window == null) return;
    _activeSubscriptions.add(this);
    _listener = _window!.addListener(_onWindowEvent);
  }

  @override
  void dispose() {
    _isDisposed = true;
    if (kIsWeb || !isWindow) return;
    _activeSubscriptions.remove(this);
    final listener = _listener;
    if (listener != null) _window?.removeListener(listener);
    _listener = null;
    _window?.dispose();
    _window = null;
  }

  Future<void> _onWindowEvent(WindowEvent event) async {
    if (event is! WindowCloseRequestedEvent || _isDisposed) return;
    if (_activeSubscriptions.isEmpty ||
        !identical(_activeSubscriptions.last, this)) {
      return;
    }
    if (_isClosing) {
      event.request.cancel();
      return;
    }
    _isClosing = true;
    try {
      // Native close requests remain pending until this callback completes.
      if (!await _confirmClose()) event.request.cancel();
    } catch (_) {
      event.request.cancel();
      rethrow;
    } finally {
      _isClosing = false;
    }
  }

  Future<bool> _confirmClose() async {
    final request = await _onClose();
    if (_isDisposed || !context.mounted) return false;
    if (request == null) return true;
    final result = await showDialog<_CloseDialogResult>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).sureClose),
        content: Text(request.message),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(_CloseDialogResult.save),
            child: Text(MaterialLocalizations.of(context).saveButtonLabel),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(_CloseDialogResult.discard),
            child: const Text('Discard'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
        ],
      ),
    );
    if (_isDisposed) return false;
    if (result == _CloseDialogResult.save) {
      final saved = await _save(request);
      return saved && !_isDisposed;
    } else if (result == _CloseDialogResult.discard) {
      return true;
    }
    return false;
  }

  Future<bool> _save(CloseRequest request) async {
    try {
      return await request.onSave?.call() ?? true;
    } catch (_) {
      return false;
    }
  }
}
