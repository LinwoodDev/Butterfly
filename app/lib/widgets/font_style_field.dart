import 'package:butterfly/services/font.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FontStyleField extends StatelessWidget {
  final String fontFamily;
  final List<String> fontFamilyFallback;
  final ValueChanged<String> onFontFamilyChanged;
  final ValueChanged<List<String>> onFontFamilyFallbackChanged;
  final bool compact;

  const FontStyleField({
    super.key,
    required this.fontFamily,
    required this.fontFamilyFallback,
    required this.onFontFamilyChanged,
    required this.onFontFamilyFallbackChanged,
    this.compact = false,
  });

  List<AvailableFontFamily> _availableFonts(
    List<AvailableFontFamily> loadedFonts,
  ) {
    final fonts = {for (final font in loadedFonts) font.name: font};
    for (final name in [fontFamily, ...fontFamilyFallback]) {
      fonts.putIfAbsent(
        name,
        () => AvailableFontFamily(name: name, bundled: false, system: false),
      );
    }
    return fonts.values.toList()..sort((a, b) => a.name.compareTo(b.name));
  }

  void _selectFont(String? font) {
    if (font == null) return;
    onFontFamilyChanged(font);
  }

  Widget? _sourceIcon(AvailableFontFamily font) {
    final icon = switch ((font.bundled, font.system)) {
      (true, true) => PhosphorIconsLight.intersect,
      (true, false) => PhosphorIconsLight.package,
      (false, true) => PhosphorIconsLight.monitor,
      (false, false) => null,
    };
    return icon == null ? null : PhosphorIcon(icon);
  }

  Widget _buildFontMenu(
    BuildContext context,
    List<AvailableFontFamily> fonts,
  ) => DropdownMenu<String>(
    key: ValueKey(('font', fontFamily, fontFamilyFallback, fonts)),
    width: compact ? 260 : null,
    initialSelection: fontFamily,
    enableFilter: true,
    requestFocusOnTap: true,
    expandedInsets: compact ? null : EdgeInsets.zero,
    label: Text(AppLocalizations.of(context).fontFamily),
    leadingIcon: const PhosphorIcon(PhosphorIconsLight.textAa),
    dropdownMenuEntries: fonts.map((availableFont) {
      final font = availableFont.name;
      final fallbackIndex = fontFamilyFallback.indexOf(font);
      final isPrimary = font == fontFamily;
      return DropdownMenuEntry(
        value: font,
        leadingIcon: _sourceIcon(availableFont),
        label: isPrimary
            ? [fontFamily, ...fontFamilyFallback].join(', ')
            : fallbackIndex < 0
            ? font
            : '$font (fallback ${fallbackIndex + 1})',
        trailingIcon: fallbackIndex < 0
            ? null
            : const PhosphorIcon(PhosphorIconsLight.arrowRight),
      );
    }).toList(),
    onSelected: _selectFont,
  );

  void _toggleFallback(String font, bool selected) {
    final fallback = fontFamilyFallback.where((item) => item != font).toList();
    if (selected) fallback.add(font);
    onFontFamilyFallbackChanged(fallback);
  }

  Widget _buildFallbackMenu(List<AvailableFontFamily> fonts) => MenuAnchor(
    menuChildren: fonts
        .map(
          (availableFont) => CheckboxMenuButton(
            value: fontFamilyFallback.contains(availableFont.name),
            onChanged: availableFont.name == fontFamily
                ? null
                : (selected) =>
                      _toggleFallback(availableFont.name, selected ?? false),
            child: Text(availableFont.name),
          ),
        )
        .toList(),
    builder: (context, controller, child) {
      void toggle() =>
          controller.isOpen ? controller.close() : controller.open();
      final icon = Badge(
        isLabelVisible: fontFamilyFallback.isNotEmpty,
        label: Text('${fontFamilyFallback.length}'),
        child: const PhosphorIcon(PhosphorIconsLight.listPlus),
      );
      if (compact) {
        return IconButton(
          onPressed: toggle,
          tooltip: 'Fallback fonts',
          icon: icon,
        );
      }
      final label = fontFamilyFallback.isEmpty
          ? 'Fallback fonts'
          : 'Fallback fonts: ${fontFamilyFallback.join(', ')}';
      return Align(
        alignment: Alignment.centerLeft,
        child: OutlinedButton.icon(
          onPressed: toggle,
          icon: icon,
          label: Text(label),
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AvailableFontFamily>>(
      future: context.read<FontService>().getFonts(),
      builder: (context, snapshot) {
        final fonts = _availableFonts(snapshot.data ?? const []);
        if (compact) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFontMenu(context, fonts),
              _buildFallbackMenu(fonts),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFontMenu(context, fonts),
            const SizedBox(height: 8),
            _buildFallbackMenu(fonts),
          ],
        );
      },
    );
  }
}
