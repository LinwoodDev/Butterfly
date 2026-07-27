part of '../home.dart';

final _viewSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).view,
  icon: PhosphorIconsLight.eye,
  appBarBuilder: _butterflyAppBar,
  sections: {
    'interface': SettingsLeapSection(
      settings: [
        SettingsLeapAdvancedSwitchSetting<ButterflySettings, ZoomPosition>(
          id: 'zoomControl',
          displayName: (context) => AppLocalizations.of(context).zoomControl,
          icon: PhosphorIconsLight.magnifyingGlass,
          options: [
            for (final value in ZoomPosition.values)
              SettingsLeapOption(
                id: value.name,
                value: value,
                displayName: (context) => value.getLocalizedName(context),
              ),
          ],
          readEnabled: (state) => state.zoomEnabled,
          writeEnabled: (context, value) =>
              context.read<SettingsCubit>().changeZoomEnabled(value),
          read: (state) => state.zoomPosition,
          write: (context, value) =>
              context.read<SettingsCubit>().changeZoomPosition(value),
        ),
        SettingsLeapEnumSetting(
          displayName: (context) => AppLocalizations.of(context).properties,
          hintBuilder: (context) =>
              AppLocalizations.of(context).propertiesDescription,
          icon: PhosphorIconsLight.sliders,
          values: ZoomPosition.values,
          read: (state) => state.propertyPosition,
          write: (context, value) =>
              context.read<SettingsCubit>().changePropertyPosition(value),
          valueLabel: (context, value) => value.getLocalizedName(context),
        ),
        SettingsLeapEnumSetting(
          displayName: (context) =>
              AppLocalizations.of(context).toolbarPosition,
          icon: PhosphorIconsLight.toolbox,
          values: ToolbarPosition.values,
          read: (state) => state.toolbarPosition,
          write: (context, value) =>
              context.read<SettingsCubit>().changeToolbarPosition(value),
          valueLabel: (context, value) => value.getLocalizedName(context),
        ),
        SettingsLeapEnumSetting(
          displayName: (context) => AppLocalizations.of(context).toolbarSize,
          icon: PhosphorIconsLight.toolbox,
          values: ToolbarSize.values,
          read: (state) => state.toolbarSize,
          write: (context, value) =>
              context.read<SettingsCubit>().changeToolbarSize(value),
          valueLabel: (context, value) => value.getLocalizedName(context),
        ),
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).toolbarRows,
          builder: _toolbarRowsSetting,
        ),
        SettingsLeapAdvancedSwitchSetting<ButterflySettings, NavigatorPosition>(
          id: 'navigationRail',
          displayName: (context) => AppLocalizations.of(context).navigationRail,
          hintBuilder: (context) =>
              AppLocalizations.of(context).navigationRailDescription,
          icon: PhosphorIconsLight.sidebar,
          options: [
            for (final value in NavigatorPosition.values)
              SettingsLeapOption(
                id: value.name,
                value: value,
                displayName: (context) =>
                    _navigatorPositionName(context, value),
              ),
          ],
          readEnabled: (state) => state.navigationRail,
          writeEnabled: (context, value) =>
              context.read<SettingsCubit>().changeNavigationRail(value),
          read: (state) => state.navigatorPosition,
          write: (context, value) =>
              context.read<SettingsCubit>().changeNavigatorPosition(value),
        ),
        SettingsLeapEnumSetting(
          displayName: (context) =>
              AppLocalizations.of(context).optionsPanelPosition,
          hintBuilder: (context) =>
              AppLocalizations.of(context).optionsPanelPositionDescription,
          icon: PhosphorIconsLight.archive,
          values: OptionsPanelPosition.values,
          read: (state) => state.optionsPanelPosition,
          write: (context, value) =>
              context.read<SettingsCubit>().changeOptionsPanelPosition(value),
          valueLabel: (context, value) => value.getLocalizedName(context),
        ),
        SettingsLeapEnumSetting(
          displayName: (context) =>
              AppLocalizations.of(context).simpleToolbarVisibility,
          hintBuilder: (context) =>
              AppLocalizations.of(context).simpleToolbarVisibilityDescription,
          icon: PhosphorIconsLight.cursorText,
          values: SimpleToolbarVisibility.values,
          read: (state) => state.simpleToolbarVisibility,
          write: (context, value) => context
              .read<SettingsCubit>()
              .changeSimpleToolbarVisibility(value),
          valueLabel: (context, value) => value.getLocalizedName(context),
        ),
        SettingsLeapBoolSetting(
          displayName: (context) =>
              AppLocalizations.of(context).showNavigatorPreviews,
          hintBuilder: (context) =>
              AppLocalizations.of(context).showNavigatorPreviewsDescription,
          icon: PhosphorIconsLight.imageSquare,
          read: (state) => state.showNavigatorPreviews,
          write: (context, value) =>
              context.read<SettingsCubit>().changeShowNavigatorPreviews(value),
        ),
      ],
    ),
    'home': SettingsLeapSection(
      displayName: (context) => AppLocalizations.of(context).home,
      settings: [
        SettingsLeapBoolSetting(
          displayName: (context) => AppLocalizations.of(context).showThumbnails,
          icon: PhosphorIconsLight.image,
          read: (state) => state.showThumbnails,
          write: (context, value) =>
              context.read<SettingsCubit>().changeShowThumbnails(value),
        ),
        SettingsLeapBoolSetting(
          displayName: (context) =>
              AppLocalizations.of(context).hideFileExtension,
          icon: PhosphorIconsLight.fileText,
          read: (state) => state.hideExtension,
          write: (context, value) =>
              context.read<SettingsCubit>().changeHideExtension(value),
        ),
      ],
    ),
  },
);

Widget _imageScaleSetting(BuildContext context, ButterflySettings state) {
  return ExactSlider(
    header: Text(AppLocalizations.of(context).imageScale),
    leading: const PhosphorIcon(PhosphorIconsLight.frameCorners),
    value: state.imageScale * 100,
    min: 0,
    max: 100,
    defaultValue: 50,
    fractionDigits: 0,
    onChangeEnd: (value) =>
        context.read<SettingsCubit>().changeImageScale(value / 100),
  );
}

void _openPersistenceSettings(BuildContext context) =>
    context.push('/settings/behaviors/persistence');

Widget _toolbarRowsSetting(BuildContext context, ButterflySettings state) {
  return ExactSlider(
    header: Text(AppLocalizations.of(context).toolbarRows),
    value: state.toolbarRows.toDouble(),
    leading: const PhosphorIcon(PhosphorIconsLight.rows),
    defaultValue: 1,
    min: 1,
    max: 4,
    fractionDigits: 0,
    headerWidth: 250,
    divide: true,
    onChangeEnd: (value) =>
        context.read<SettingsCubit>().changeToolbarRows(value.round()),
  );
}

String _navigatorPositionName(BuildContext context, NavigatorPosition value) =>
    switch (value) {
      NavigatorPosition.left => AppLocalizations.of(context).left,
      NavigatorPosition.right => AppLocalizations.of(context).right,
    };
