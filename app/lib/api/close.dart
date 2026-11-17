import 'dart:async';

import 'package:butterfly/api/close_stub.dart'
    if (dart.library.io) 'package:butterfly/api/close_io.dart'
    if (dart.library.js) 'package:butterfly/api/close_html.dart'
    as close;
import 'package:material_ui/material_ui.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

typedef OnCloseCallback = FutureOr<CloseRequest?> Function();

class CloseRequest {
  final String message;
  final FutureOr<bool> Function()? onSave;

  const CloseRequest({required this.message, this.onSave});
}

enum _CloseDecision { save, discard }

Future<bool> confirmClose(
  BuildContext context,
  CloseRequest request, {
  ValueChanged<Object?>? onSaveFailed,
}) async {
  final decision = await showDialog<_CloseDecision>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(AppLocalizations.of(context).sureClose),
      content: Text(request.message),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(_CloseDecision.save),
          child: Text(MaterialLocalizations.of(context).saveButtonLabel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_CloseDecision.discard),
          child: const Text('Discard'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
      ],
    ),
  );
  if (decision != .save) {
    return decision == .discard;
  }
  Object? failure;
  try {
    if (await request.onSave?.call() ?? true) return true;
  } catch (error) {
    failure = error;
  }
  onSaveFailed?.call(failure);
  return false;
}

CloseSubscription onPreventClose(
  BuildContext context,
  OnCloseCallback onClose,
) => close.onPreventClose(context, onClose);

abstract class CloseSubscription {
  void dispose();
}
