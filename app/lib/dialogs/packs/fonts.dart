import 'package:butterfly/api/open.dart';
import 'package:butterfly/services/font.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FontsPackView extends StatelessWidget {
  final NoteData value;
  final ValueChanged<NoteData> onChanged;

  const FontsPackView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  Future<void> _importFonts(BuildContext context) async {
    final files = await importFilesWithExtensions(const ['ttf', 'otf']);
    if (!context.mounted || files.isEmpty) return;
    var pack = value;
    var imported = false;
    var failed = false;
    for (final (data, extension, name) in files) {
      final fileName = pack.findUniqueName(
        kFontsArchiveDirectory,
        extension,
        name,
      );
      final family = await context.read<FontService>().loadFont(
        fileName,
        ByteData.sublistView(data),
      );
      if (family == null) {
        failed = true;
        continue;
      }
      pack = pack.setFont(fileName, data);
      imported = true;
    }
    if (failed && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).errorWhileImporting),
        ),
      );
    }
    if (imported) onChanged(pack);
  }

  @override
  Widget build(BuildContext context) {
    final fonts = value.getFonts().toList()..sort();
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.only(bottom: 80),
          children: fonts
              .map(
                (name) => ListTile(
                  leading: const PhosphorIcon(PhosphorIconsLight.textAa),
                  title: Text(name),
                  subtitle: Text(customFontFamily(_baseName(name))),
                  trailing: IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.trash),
                    tooltip: AppLocalizations.of(context).delete,
                    onPressed: () => onChanged(value.removeFont(name)),
                  ),
                ),
              )
              .toList(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            onPressed: () => _importFonts(context),
            icon: const PhosphorIcon(PhosphorIconsLight.uploadSimple),
            label: Text(AppLocalizations.of(context).import),
          ),
        ),
      ],
    );
  }

  String _baseName(String name) {
    final dot = name.lastIndexOf('.');
    return dot > 0 ? name.substring(0, dot) : name;
  }
}
