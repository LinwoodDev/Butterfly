import 'package:butterfly/actions/shortcuts.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

List<(String?, String)> getInputShortcutOptions(BuildContext context) {
  final projectShortcuts = [
    searchShortcut,
    undoShortcut,
    redoShortcut,
    backgroundShortcut,
    saveShortcut,
    changePathShortcut,
    zoomInShortcut,
    zoomOutShortcut,
    fullScreenShortcut,
    hideUIShortcut,
    selectAllShortcut,
    pasteShortcut,
    ...changeToolShortcuts,
  ];

  return [
    (null, AppLocalizations.of(context).none),
    ('long_press', AppLocalizations.of(context).longPress),
    ...projectShortcuts.map((e) => (e.id, e.getLocalizedName(context))),
  ];
}

void showInputShortcutPicker(
  BuildContext context,
  String title,
  List<(String?, String)> availableShortcuts,
  String? currentValue,
  ValueChanged<String?> onChanged,
) {
  showLeapBottomSheet(
    context: context,
    titleBuilder: (ctx) => Text(title),
    childrenBuilder: (ctx) => [
      RadioGroup<String?>(
        groupValue: currentValue,
        onChanged: (val) {
          onChanged(val);
          Navigator.of(context).pop();
        },
        child: Column(
          children: availableShortcuts
              .map(
                (e) => RadioListTile<String?>(value: e.$1, title: Text(e.$2)),
              )
              .toList(),
        ),
      ),
    ],
  );
}

class InputShortcutListTile extends StatelessWidget {
  final String inputName;
  final String? currentValue;
  final List<(String?, String)> availableShortcuts;
  final Widget? icon;
  final ValueChanged<String?> onChanged;

  const InputShortcutListTile({
    super.key,
    required this.inputName,
    required this.currentValue,
    required this.availableShortcuts,
    required this.onChanged,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon ?? const PhosphorIcon(PhosphorIconsLight.keyboard),
      title: Text(inputName),
      subtitle: Text(
        availableShortcuts.firstWhereOrNull((e) => e.$1 == currentValue)?.$2 ??
            AppLocalizations.of(context).none,
      ),
      onTap: () => showInputShortcutPicker(
        context,
        inputName,
        availableShortcuts,
        currentValue,
        onChanged,
      ),
    );
  }
}
