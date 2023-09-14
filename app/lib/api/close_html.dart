import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:butterfly/api/close.dart';
import 'package:flutter/material.dart';

CloseSubscription onPreventClose(
    BuildContext context, OnCloseCallback onClose) {
  return WebCloseSubscription(onClose);
}

class WebCloseSubscription extends CloseSubscription {
  final StreamSubscription _subscription;

  WebCloseSubscription(OnCloseCallback onClose)
      : _subscription = window.onBeforeUnload.listen((event) {
          if (event is! BeforeUnloadEvent) return;
          final message = onClose();
          if (message == null) return;
          event.returnValue = message;
        });

  @override
  void dispose() {
    _subscription.cancel();
  }
}
