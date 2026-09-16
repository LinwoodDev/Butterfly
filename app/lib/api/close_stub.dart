import 'package:material_ui/material_ui.dart';

import 'close.dart';

CloseSubscription onPreventClose(
  BuildContext context,
  OnCloseCallback onClose,
) => StubCloseSubscription();

class StubCloseSubscription extends CloseSubscription {
  @override
  void dispose() {}
}
