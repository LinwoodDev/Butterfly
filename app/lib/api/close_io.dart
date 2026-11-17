import 'dart:async';
import 'dart:io';

import 'package:butterfly/api/close.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
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
    final request = await _onClose();
    if (request == null || await confirmClose(context, request)) {
      await _closeWindow();
      return;
    }
    if (!_isDisposed) {
      _isClosing = false;
    }
  }

  Future<void> _closeWindow() async {
    dispose();
    await windowManager.destroy();
    exit(0);
  }
}
