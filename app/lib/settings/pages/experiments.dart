part of '../home.dart';

final _experimentsSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).experiments,
  icon: PhosphorIconsLight.flask,
  keywordsBuilder: (context) => [
    AppLocalizations.of(context).collaboration,
    AppLocalizations.of(context).smoothNavigation,
    AppLocalizations.of(context).edgePanAreaSwitching,
    AppLocalizations.of(context).infiniteZoom,
  ],
  appBarBuilder: _butterflyAppBar,
  onReset: (context, state) => context.read<SettingsCubit>().resetFlags(),
  sections: {
    'flags': SettingsLeapSection(
      headerBuilder: _experimentsHeader,
      settings: [
        SettingsLeapBoolSetting(
          displayName: (context) => AppLocalizations.of(context).collaboration,
          hintBuilder: (context) =>
              AppLocalizations.of(context).collaborationDescription,
          icon: PhosphorIconsLight.chatTeardrop,
          read: (state) => state.hasFlag('collaboration'),
          write: (context, value) =>
              _changeFlag(context, 'collaboration', value),
        ),
        SettingsLeapBoolSetting(
          displayName: (context) =>
              AppLocalizations.of(context).smoothNavigation,
          hintBuilder: (context) =>
              AppLocalizations.of(context).smoothNavigationDescription,
          icon: PhosphorIconsLight.caretCircleDoubleDown,
          read: (state) => state.hasFlag('smoothNavigation'),
          write: (context, value) =>
              _changeFlag(context, 'smoothNavigation', value),
        ),
        SettingsLeapBoolSetting(
          displayName: (context) =>
              AppLocalizations.of(context).edgePanAreaSwitching,
          hintBuilder: (context) =>
              AppLocalizations.of(context).edgePanAreaSwitchingDescription,
          icon: PhosphorIconsLight.cursor,
          read: (state) => state.hasFlag('edgePanAreaSwitching'),
          write: (context, value) =>
              _changeFlag(context, 'edgePanAreaSwitching', value),
        ),
        SettingsLeapBoolSetting(
          displayName: (context) => AppLocalizations.of(context).infiniteZoom,
          hintBuilder: (context) =>
              AppLocalizations.of(context).infiniteZoomDescription,
          icon: PhosphorIconsLight.infinity,
          read: (state) => state.hasFlag(kInfiniteZoomFlag),
          write: (context, value) =>
              _changeFlag(context, kInfiniteZoomFlag, value),
        ),
      ],
    ),
  },
);

Widget _experimentsHeader(BuildContext context, ButterflySettings state) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    spacing: 16,
    children: [
      const Icon(PhosphorIconsLight.warning),
      Flexible(child: Text(AppLocalizations.of(context).experimentsWarning)),
    ],
  );
}
