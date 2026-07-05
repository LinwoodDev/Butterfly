part of '../home.dart';

final _viewSettingsPage = SettingsLeapPage<ButterflySettings>(
  id: 'view',
  displayName: (context) => AppLocalizations.of(context).view,
  icon: PhosphorIconsLight.eye,
  appBarBuilder: _butterflyAppBar,
  sections: {
    'interface': SettingsLeapSection(
      settings: [
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).zoomControl,
          builder: _zoomControlSetting,
        ),
        SettingsLeapEnumSetting(
          displayName: (context) => AppLocalizations.of(context).properties,
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
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).navigationRail,
          builder: _navigationRailSetting,
        ),
        SettingsLeapEnumSetting(
          displayName: (context) =>
              AppLocalizations.of(context).optionsPanelPosition,
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
          icon: PhosphorIconsLight.cursorText,
          values: SimpleToolbarVisibility.values,
          read: (state) => state.simpleToolbarVisibility,
          write: (context, value) => context
              .read<SettingsCubit>()
              .changeSimpleToolbarVisibility(value),
          valueLabel: (context, value) => value.getLocalizedName(context),
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

Widget _contentViewportSetting(BuildContext context, ButterflySettings state) {
  return ListTile(
    leading: const PhosphorIcon(PhosphorIconsLight.appWindow),
    title: Text(AppLocalizations.of(context).contentViewport),
    subtitle: Text(
      state.limitViewportMultiplier == null
          ? AppLocalizations.of(context).off
          : '${state.limitViewportMultiplier}x',
    ),
    onTap: () => _openContentViewportModal(context),
  );
}

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

void _openContentViewportModal(BuildContext context) {
  final cubit = context.read<SettingsCubit>();
  final currentMultiplier = cubit.state.limitViewportMultiplier;
  showLeapBottomSheet(
    context: context,
    titleBuilder: (context) =>
        Text(AppLocalizations.of(context).contentViewport),
    childrenBuilder: (context) {
      final options = [
        (null, AppLocalizations.of(context).off),
        (1.0, '1x'),
        (1.5, '1.5x'),
        (2.0, '2x'),
        (3.0, '3x'),
      ];
      return options
          .map(
            (e) => ListTile(
              title: Text(e.$2),
              selected: currentMultiplier == e.$1,
              onTap: () {
                cubit.changeLimitViewportMultiplier(e.$1);
                Navigator.of(context).pop();
              },
            ),
          )
          .toList();
    },
  );
}

void _openAutosaveModal(BuildContext context) {
  final cubit = context.read<SettingsCubit>();
  final autosave = cubit.state.autosave;
  final showSaveButton = cubit.state.showSaveButton;
  final delayed = cubit.state.delayedAutosave;
  showLeapBottomSheet(
    context: context,
    titleBuilder: (context) => Text(AppLocalizations.of(context).autosave),
    childrenBuilder: (context) {
      void changeAutosave(bool? autosave, {bool delayed = false}) {
        cubit.changeAutosave(autosave, delayed: delayed);
        Navigator.of(context).pop();
      }

      return [
        ListTile(
          title: Text(AppLocalizations.of(context).yes),
          leading: const Icon(PhosphorIconsLight.check),
          selected: autosave && !showSaveButton && !delayed,
          onTap: () => changeAutosave(true),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).delay),
          leading: const Icon(PhosphorIconsLight.clock),
          selected: autosave && delayed,
          onTap: () => changeAutosave(null, delayed: true),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).yesButShowButtons),
          leading: const Icon(PhosphorIconsLight.question),
          selected: autosave && showSaveButton && !delayed,
          onTap: () => changeAutosave(null),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).no),
          leading: const Icon(PhosphorIconsLight.x),
          selected: !autosave,
          onTap: () => changeAutosave(false),
        ),
      ];
    },
  );
}

Widget _zoomControlSetting(BuildContext context, ButterflySettings state) {
  return AdvancedSwitchListTile(
    leading: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
    title: Text(AppLocalizations.of(context).zoomControl),
    subtitle: Text(state.zoomPosition.getLocalizedName(context)),
    value: state.zoomEnabled,
    onChanged: (value) =>
        context.read<SettingsCubit>().changeZoomEnabled(value),
    onTap: () => _openZoomPositionModal(context),
  );
}

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

Widget _navigationRailSetting(BuildContext context, ButterflySettings state) {
  return AdvancedSwitchListTile(
    leading: const PhosphorIcon(PhosphorIconsLight.sidebar),
    title: Text(AppLocalizations.of(context).navigationRail),
    height: 76,
    subtitle: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          state.navigatorPosition == NavigatorPosition.left
              ? AppLocalizations.of(context).left
              : AppLocalizations.of(context).right,
        ),
        Text(
          AppLocalizations.of(context).onlyAvailableLargerScreen,
          style: TextTheme.of(context).labelSmall,
        ),
      ],
    ),
    onTap: () async {
      final position = await showLeapBottomSheet<NavigatorPosition>(
        context: context,
        titleBuilder: (context) => Text(AppLocalizations.of(context).position),
        childrenBuilder: (context) => [
          ListTile(
            title: Text(AppLocalizations.of(context).left),
            selected: state.navigatorPosition == NavigatorPosition.left,
            leading: const PhosphorIcon(
              PhosphorIconsLight.arrowLineLeft,
              textDirection: TextDirection.ltr,
            ),
            onTap: () => Navigator.of(context).pop(NavigatorPosition.left),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).right),
            selected: state.navigatorPosition == NavigatorPosition.right,
            leading: const PhosphorIcon(
              PhosphorIconsLight.arrowLineRight,
              textDirection: TextDirection.ltr,
            ),
            onTap: () => Navigator.of(context).pop(NavigatorPosition.right),
          ),
        ],
      );
      if (position != null && context.mounted) {
        context.read<SettingsCubit>().changeNavigatorPosition(position);
      }
    },
    value: state.navigationRail,
    onChanged: (value) =>
        context.read<SettingsCubit>().changeNavigationRail(value),
  );
}

void _openZoomPositionModal(BuildContext context) {
  final cubit = context.read<SettingsCubit>();
  final currentPos = cubit.state.zoomPosition;
  showLeapBottomSheet(
    context: context,
    titleBuilder: (context) => Text(AppLocalizations.of(context).zoomPosition),
    childrenBuilder: (context) => ZoomPosition.values
        .map(
          (e) => ListTile(
            title: Text(e.getLocalizedName(context)),
            selected: currentPos == e,
            leading: Icon(switch (e) {
              ZoomPosition.topRight => PhosphorIconsLight.arrowUpRight,
              ZoomPosition.topLeft => PhosphorIconsLight.arrowUpLeft,
              ZoomPosition.bottomRight => PhosphorIconsLight.arrowDownRight,
              ZoomPosition.bottomLeft => PhosphorIconsLight.arrowDownLeft,
            }, textDirection: TextDirection.ltr),
            onTap: () {
              cubit.changeZoomPosition(e);
              Navigator.of(context).pop();
            },
          ),
        )
        .toList(),
  );
}
