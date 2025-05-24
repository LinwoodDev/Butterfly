import 'dart:async';

import 'package:butterfly/api/close.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart';

CloseSubscription onPreventClose(
  BuildContext context,
  OnCloseCallback onClose,
) {
  return WebCloseSubscription(onClose);
}

class WebCloseSubscription extends CloseSubscription {
  final StreamSubscription _subscription;

  WebCloseSubscription(OnCloseCallback onClose)
    : _subscription =
          const EventStreamProvider<BeforeUnloadEvent>(
            'onbeforeunload',
          ).forTarget(window).listen((event) {
            final message = onClose();
            if (message == null) return;
            event.returnValue = message;
          });

  @override
  void dispose() {
    _subscription.cancel();
  }
}
