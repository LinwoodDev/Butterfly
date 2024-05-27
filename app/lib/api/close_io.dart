import 'package:butterfly/api/close.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:window_manager/window_manager.dart';

CloseSubscription onPreventClose(
    BuildContext context, OnCloseCallback onClose) {
  return IOCloseSubscription(context, onClose);
}

class IOCloseSubscription extends CloseSubscription with WindowListener {
  final OnCloseCallback _onClose;
  final BuildContext context;

  IOCloseSubscription(this.context, this._onClose) {
    if (kIsWeb || !isWindow) return;
    windowManager.setPreventClose(true);
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    if (kIsWeb || !isWindow) return;
    windowManager.setPreventClose(false);
    WindowManager.instance.removeListener(this);
  }

  @override
  void onWindowClose() async {
    final message = _onClose();
    if (message == null) {
      windowManager.destroy();
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
            child: Text(AppLocalizations.of(context).cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context).close),
          ),
        ],
      ),
    );
    if (result != true) return;
    windowManager.destroy();
  }
}
