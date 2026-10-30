import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:material_ui/material_ui.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../widgets.dart';
import 'style.dart';

class StylesPackView extends StatelessWidget {
  final NoteData value;
  final ValueChanged<NoteData> onChanged;

  const StylesPackView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PackAssetList(
      icon: PhosphorIconsLight.pencilCircle,
      action: ElevatedButton.icon(
        onPressed: () async {
          final name = await showDialog<String>(
            context: context,
            builder: (ctx) => NameDialog(
              validator: defaultFileNameValidator(
                context,
                value.getStyles().toList(),
              ),
            ),
          );
          if (name == null) return;
          onChanged(value.setStyle(name, const text.TextStyleSheet()));
        },
        icon: const PhosphorIcon(PhosphorIconsLight.plus),
        label: Text(LeapLocalizations.of(context).create),
      ),
      children: value
          .getNamedStyles()
          .map(
            (style) => Dismissible(
              key: ValueKey(style.name),
              onDismissed: (_) => onChanged(value.removeStyle(style.name)),
              child: ListTile(
                leading: const PhosphorIcon(PhosphorIconsLight.pencilCircle),
                title: Text(style.name),
                onTap: () async {
                  var name = style.name;
                  var sheet = style.item;
                  final result = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => StyleDialog(
                      value: style.item,
                      onChanged: (value) => sheet = value,
                      name: name,
                      onNameChanged: (value) => name = value,
                    ),
                  );
                  if (result != true) return;
                  onChanged(
                    value.removeStyle(style.name).setStyle(name, sheet),
                  );
                },
                trailing: IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.trash),
                  tooltip: AppLocalizations.of(context).delete,
                  onPressed: () => onChanged(value.removeStyle(style.name)),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
