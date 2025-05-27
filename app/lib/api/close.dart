import 'package:butterfly/api/close_stub.dart'
    if (dart.library.io) 'package:butterfly/api/close_io.dart'
    if (dart.library.js) 'package:butterfly/api/close_html.dart'
    as close;
import 'package:flutter/material.dart';

typedef OnCloseCallback = String? Function();

CloseSubscription onPreventClose(
  BuildContext context,
  OnCloseCallback onClose,
) => close.onPreventClose(context, onClose);

abstract class CloseSubscription {
  void dispose();
}
