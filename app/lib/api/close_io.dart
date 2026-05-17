import 'dart:async';
import 'dart:io';
import 'package:butterfly/api/close.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:window_manager/window_manager.dart';

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
    final message = await _onClose();
    if (message == null) {
      await _closeWindow();
      return;
    }
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).sureClose),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          ),
        ],
      ),
    );
    if (result != true) {
      _isClosing = false;
      return;
    }
    await _closeWindow();
  }

  Future<void> _closeWindow() async {
    dispose();
    await windowManager.destroy();
    exit(0);
  }
}
