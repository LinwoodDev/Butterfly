import 'dart:async';

import 'package:flutter/material.dart';

import 'close.dart';

typedef OnCloseCallback = FutureOr<String?> Function();

CloseSubscription onPreventClose(
  BuildContext context,
  OnCloseCallback onClose,
) => StubCloseSubscription();

class StubCloseSubscription extends CloseSubscription {
  @override
  void dispose() {}
}
