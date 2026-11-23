import 'package:butterfly/services/font.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FontStyleField extends StatefulWidget {
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

  @override
  State<FontStyleField> createState() => _FontStyleFieldState();
}

class _FontStyleFieldState extends State<FontStyleField> {
  List<AvailableFontFamily>? _loadedFonts;
  Widget? _controls;
  Key _menuKey = UniqueKey();

  String get fontFamily => widget.fontFamily;
  List<String> get fontFamilyFallback => widget.fontFamilyFallback;
  bool get compact => widget.compact;

  @override
  void didUpdateWidget(covariant FontStyleField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (fontFamily != oldWidget.fontFamily ||
        !listEquals(fontFamilyFallback, oldWidget.fontFamilyFallback) ||
        compact != oldWidget.compact) {
      _menuKey = UniqueKey();
      _controls = null;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controls = null;
  }

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
    widget.onFontFamilyChanged(font);
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
    key: _menuKey,
    width: compact ? 260 : null,
    initialSelection: fontFamily,
    enableFilter: true,
    requestFocusOnTap: true,
    expandedInsets: compact ? null : .zero,
    label: Text(AppLocalizations.of(context).fontFamily),
    leadingIcon: const PhosphorIcon(
      PhosphorIconsLight.textAa,
      textDirection: .ltr,
    ),
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
    widget.onFontFamilyFallbackChanged(fallback);
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
      builder: (_, snapshot) {
        if (_loadedFonts != snapshot.data) {
          _loadedFonts = snapshot.data;
          _controls = null;
        }
        return _controls ??= _buildControls(
          _availableFonts(_loadedFonts ?? const []),
        );
      },
    );
  }

  Widget _buildControls(List<AvailableFontFamily> fonts) {
    final menu = _buildFontMenu(context, fonts);
    final fallback = _buildFallbackMenu(fonts);
    return compact
        ? Row(mainAxisSize: .min, children: [menu, fallback])
        : Column(
            crossAxisAlignment: .stretch,
            children: [menu, const SizedBox(height: 8), fallback],
          );
  }
}
