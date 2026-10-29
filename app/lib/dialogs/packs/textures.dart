import 'package:butterfly/api/open.dart';
import 'package:butterfly/helpers/svg.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'widgets.dart';

class TexturesPackView extends StatelessWidget {
  final NoteData value;
  final ValueChanged<NoteData> onChanged;

  const TexturesPackView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  Future<void> _importTexture(BuildContext context) async {
    final (data, extension, name) = await importFile(context, [
      AssetFileType.image,
      AssetFileType.svg,
    ]);
    if (data == null) return;
    final fileName = value.findUniqueName(
      kTexturesArchiveDirectory,
      extension ?? 'png',
      name ?? 'texture',
    );
    onChanged(value.setTexture(fileName, data));
  }

  @override
  Widget build(BuildContext context) {
    final textures = value.getTextures().toList();
    return PackAssetList(
      icon: PhosphorIconsLight.imageSquare,
      action: ElevatedButton.icon(
        onPressed: () => _importTexture(context),
        icon: const PhosphorIcon(PhosphorIconsLight.uploadSimple),
        label: Text(AppLocalizations.of(context).import),
      ),
      children: textures.map((name) {
        final data = value.getTexture(name);
        return Dismissible(
          key: ValueKey(('texture', name)),
          onDismissed: (_) => onChanged(value.removeTexture(name)),
          child: ListTile(
            leading: SizedBox.square(
              dimension: 48,
              child: data == null
                  ? const PhosphorIcon(PhosphorIconsLight.image)
                  : name.toLowerCase().endsWith('.svg')
                  ? SvgPicture.string(
                      normalizeSvgBytes(data),
                      fit: .cover,
                      placeholderBuilder: (context) =>
                          const PhosphorIcon(PhosphorIconsLight.image),
                    )
                  : Image.memory(
                      data,
                      fit: .cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const PhosphorIcon(PhosphorIconsLight.image),
                    ),
            ),
            title: Text(name),
            onTap: () async {
              if (data == null) return;
              final result = await showDialog<String>(
                context: context,
                builder: (ctx) => NameDialog(
                  value: name,
                  validator: defaultFileNameValidator(
                    context,
                    textures.where((other) => other != name).toList(),
                  ),
                ),
              );
              if (result == null || result.isEmpty || result == name) return;
              onChanged(value.removeTexture(name).setTexture(result, data));
            },
            trailing: IconButton(
              icon: const PhosphorIcon(PhosphorIconsLight.trash),
              onPressed: () => onChanged(value.removeTexture(name)),
              tooltip: AppLocalizations.of(context).delete,
            ),
          ),
        );
      }).toList(),
    );
  }
}
