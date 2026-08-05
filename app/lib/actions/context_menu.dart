import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:keybinder/keybinder.dart';

class ContextMenuIntent extends Intent {
  const ContextMenuIntent();
}

const contextMenuShortcut = ShortcutDefinition(
  id: 'context_menu',
  intent: ContextMenuIntent(),
  defaultActivator: SingleActivator(LogicalKeyboardKey.contextMenu),
);

class ContextMenuAction extends Action<ContextMenuIntent> {
  ContextMenuAction(this.callback);

  final VoidCallback callback;

  @override
  void invoke(ContextMenuIntent intent) => callback();
}
