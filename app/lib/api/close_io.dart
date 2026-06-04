import 'dart:async';
import 'dart:io';
import 'package:butterfly/api/close.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

class IOCloseSubscription extends CloseSubscription with WindowListener {
  static final List<IOCloseSubscription> _activeSubscriptions = [];

  final OnCloseCallback _onClose;
  final BuildContext context;
  bool _isClosing = false;
  bool _isDisposed = false;

  IOCloseSubscription(this.context, this._onClose) {
    if (kIsWeb || !isWindow) return;
    _activeSubscriptions.add(this);
    windowManager.setPreventClose(true);
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    _isDisposed = true;
    if (kIsWeb || !isWindow) return;
    _activeSubscriptions.remove(this);
    windowManager.setPreventClose(_activeSubscriptions.isNotEmpty);
    WindowManager.instance.removeListener(this);
  }

  @override
  void onWindowClose() async {
    if (_isClosing || _isDisposed) return;
    if (_activeSubscriptions.isEmpty ||
        !identical(_activeSubscriptions.last, this)) {
      return;
    }
    _isClosing = true;
    final request = await _onClose();
    if (request == null) {
      await _closeWindow();
      return;
    }
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
    if (result == _CloseDialogResult.save) {
      final saved = await _save(request);
      if (saved) {
        await _closeWindow();
        return;
      }
    } else if (result == _CloseDialogResult.discard) {
      await _closeWindow();
      return;
    }
    if (!_isDisposed) {
      _isClosing = false;
    }
  }

  Future<bool> _save(CloseRequest request) async {
    try {
      return await request.onSave?.call() ?? true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _closeWindow() async {
    dispose();
    await windowManager.destroy();
    exit(0);
  }
}
