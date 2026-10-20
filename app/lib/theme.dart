import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:material_ui/material_ui.dart';

import 'main.dart';

const kClassicFirstColor = Color(0xFFc4840d);
const kClassicSecondColor = Color(0xFF7b8f96);
const kClassicThemePrimary = isNightly
    ? kClassicSecondColor
    : kClassicFirstColor;
const kClassicThemeSecondary = isNightly
    ? kClassicFirstColor
    : kClassicSecondColor;
const kClassicTheme = FlexSchemeColor(
  primary: kClassicThemePrimary,
  secondary: kClassicThemeSecondary,
);
const kClassicThemeData = FlexSchemeData(
  name: '',
  description: '',
  light: kClassicTheme,
  dark: kClassicTheme,
);

const EdgeInsets settingsCardMargin = .all(8);
const EdgeInsets settingsCardPadding = .all(16);
const EdgeInsets settingsCardTitlePadding = .only(left: 12, top: 8, right: 12);

/// Shared shape tokens so every surface of the app uses the same rounding.
const double kRadiusSmall = 8;
const double kRadiusMedium = 12;
const double kRadiusLarge = 20;
const double kRadiusPill = 999;

/// Inner height of every island in the editor's top bar (logo, title and the
/// inline toolbar), so they line up as one row.
const double kTopBarIslandContentHeight = 44;

/// The brand font is kept for headlines, the interface itself uses a neutral
/// sans serif to stay calm and readable.
const _kDisplayFont = 'Comfortaa';
const _kInterfaceFont = 'Roboto';
const _kFontFallback = ['Noto Sans Arabic', 'Roboto'];

const _kSubThemes = FlexSubThemesData(
  scaffoldBackgroundBaseColor: FlexScaffoldBaseColor.surface,
  interactionEffects: true,
  tintedDisabledControls: true,
  blendOnLevel: 6,
  defaultRadius: kRadiusMedium,
  thinBorderWidth: 1,
  thickBorderWidth: 1.5,
  textButtonRadius: kRadiusPill,
  filledButtonRadius: kRadiusPill,
  elevatedButtonRadius: kRadiusPill,
  outlinedButtonRadius: kRadiusPill,
  segmentedButtonRadius: kRadiusPill,
  toggleButtonsRadius: kRadiusMedium,
  inputDecoratorIsFilled: true,
  inputDecoratorBorderType: FlexInputBorderType.outline,
  inputDecoratorRadius: kRadiusMedium,
  inputDecoratorUnfocusedHasBorder: false,
  inputDecoratorFocusedBorderWidth: 1.5,
  inputDecoratorBackgroundAlpha: 0x14,
  fabUseShape: true,
  fabRadius: 16,
  chipRadius: kRadiusSmall,
  cardRadius: kRadiusLarge,
  cardElevation: 0,
  popupMenuRadius: kRadiusMedium,
  popupMenuElevation: 6,
  menuRadius: kRadiusMedium,
  menuElevation: 6,
  menuPadding: EdgeInsets.all(6),
  menuIndicatorRadius: kRadiusSmall,
  tooltipRadius: kRadiusSmall,
  tooltipWaitDuration: Duration(milliseconds: 400),
  dialogRadius: 24,
  dialogElevation: 6,
  snackBarRadius: kRadiusMedium,
  searchBarElevation: 0,
  searchViewElevation: 6,
  appBarScrolledUnderElevation: 0,
  navigationRailUseIndicator: true,
  navigationRailIndicatorRadius: kRadiusMedium,
  navigationRailMutedUnselectedLabel: true,
  navigationRailMutedUnselectedIcon: true,
  navigationBarIndicatorRadius: kRadiusMedium,
  drawerRadius: kRadiusLarge,
  bottomSheetRadius: 24,
  sliderTrackHeight: 4,
);

TextTheme _buildTextTheme(TextTheme base) {
  TextStyle? display(TextStyle? style, [double spacing = 0]) => style?.copyWith(
    fontFamily: _kDisplayFont,
    fontFamilyFallback: _kFontFallback,
    fontWeight: FontWeight.w700,
    letterSpacing: spacing,
  );
  TextStyle? ui(TextStyle? style, [FontWeight weight = FontWeight.w400]) =>
      style?.copyWith(fontWeight: weight);
  return base.copyWith(
    displayLarge: display(base.displayLarge, -1),
    displayMedium: display(base.displayMedium, -0.5),
    displaySmall: display(base.displaySmall),
    headlineLarge: display(base.headlineLarge),
    headlineMedium: display(base.headlineMedium),
    headlineSmall: display(base.headlineSmall)?.copyWith(fontSize: 20),
    titleLarge: ui(base.titleLarge, FontWeight.w600),
    titleMedium: ui(base.titleMedium, FontWeight.w600),
    titleSmall: ui(base.titleSmall, FontWeight.w600),
    labelLarge: ui(base.labelLarge, FontWeight.w500),
    labelMedium: ui(base.labelMedium, FontWeight.w500),
    labelSmall: ui(base.labelSmall, FontWeight.w500),
  );
}

ThemeData getThemeData(
  String name,
  bool dark, [
  VisualDensity? density,
  ColorScheme? overridden,
  bool highContrast = false,
]) {
  final color = getFlexThemeColor(name, dark);
  final override = overridden != null && name.isEmpty;
  ThemeData theme;
  if (dark) {
    theme = FlexThemeData.dark(
      colors: override ? null : color,
      colorScheme: override ? overridden : null,
      useMaterial3: true,
      surfaceMode: FlexSurfaceMode.level,
      blendLevel: 4,
      appBarElevation: 0,
      subThemesData: _kSubThemes,
      fontFamily: _kInterfaceFont,
      visualDensity: density,
      darkIsTrueBlack: highContrast,
      fontFamilyFallback: _kFontFallback,
    );
  } else {
    theme = FlexThemeData.light(
      colors: override ? null : color,
      colorScheme: override ? overridden : null,
      useMaterial3: true,
      surfaceMode: FlexSurfaceMode.level,
      blendLevel: 2,
      appBarElevation: 0,
      subThemesData: _kSubThemes,
      fontFamily: _kInterfaceFont,
      visualDensity: density,
      lightIsWhite: highContrast,
      fontFamilyFallback: _kFontFallback,
    );
  }
  return theme.copyWith(
    textTheme: _buildTextTheme(theme.textTheme),
    tabBarTheme: const TabBarThemeData(tabAlignment: TabAlignment.center),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: defaultDropdownInputDecorationTheme(),
    ),
    // Rounded list rows so selections in panels and dialogs read as soft
    // pills instead of hard edged bars.
    listTileTheme: theme.listTileTheme.copyWith(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(kRadiusMedium)),
      ),
    ),
    dividerTheme: theme.dividerTheme.copyWith(
      color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
      space: 1,
      thickness: 1,
    ),
    sliderTheme: theme.sliderTheme.copyWith(year2023: false),
    progressIndicatorTheme: theme.progressIndicatorTheme.copyWith(
      year2023: false,
    ),
  );
}

InputDecorationTheme defaultDropdownInputDecorationTheme() {
  return const InputDecorationTheme(
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(kRadiusMedium)),
    ),
  );
}

/// Decoration for the floating panels ("islands") that sit on top of the
/// canvas. They share one look so the editor reads as a single calm surface.
BoxDecoration islandDecoration(BuildContext context, {double? radius}) {
  final colorScheme = ColorScheme.of(context);
  return BoxDecoration(
    color: colorScheme.surfaceContainerLow,
    borderRadius: BorderRadius.all(Radius.circular(radius ?? kRadiusLarge)),
    border: Border.all(
      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
    ),
    boxShadow: [
      BoxShadow(
        color: colorScheme.shadow.withValues(alpha: 0.08),
        blurRadius: 24,
        offset: const Offset(0, 8),
      ),
      BoxShadow(
        color: colorScheme.shadow.withValues(alpha: 0.06),
        blurRadius: 4,
        offset: const Offset(0, 1),
      ),
    ],
  );
}

/// A floating panel on top of the canvas, see [islandDecoration].
class Island extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double? radius;

  const Island({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(4),
    this.margin = const EdgeInsets.all(4),
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.all(
      Radius.circular(radius ?? kRadiusLarge),
    );
    return Container(
      margin: margin,
      decoration: islandDecoration(context, radius: radius),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

FlexSchemeColor getFlexThemeColor(String name, bool dark) {
  final color = FlexColor.schemesList.firstWhere(
    (scheme) => scheme.name == name,
    orElse: () => kClassicThemeData,
  );
  if (dark) return color.dark;
  return color.light;
}

List<String> getThemes() {
  return ['Classic', ...FlexColor.schemesList.map((e) => e.name)];
}
