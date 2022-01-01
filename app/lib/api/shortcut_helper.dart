import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ShortcutHelper on BuildContext {
  String getShortcut(String key,
      {bool shiftKey = false, bool altKey = false, bool ctrlKey = true}) {
    if (altKey) {
      key = '${AppLocalizations.of(this)!.altKey} + $key';
    }
    if (shiftKey) {
      key = '${AppLocalizations.of(this)!.shiftKey} + $key';
    }
    if (ctrlKey) {
      key = '${AppLocalizations.of(this)!.ctrlKey} + $key';
    }
    return key;
  }
}
