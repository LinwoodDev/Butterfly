import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ViewSettingsPage extends StatelessWidget {
  final bool inView;

  const ViewSettingsPage({super.key, this.inView = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: inView ? Colors.transparent : null,
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        title: Text(AppLocalizations.of(context).view),
        backgroundColor: inView ? Colors.transparent : null,
        inView: inView,
      ),
      body: BlocBuilder<SettingsCubit, ButterflySettings>(
        builder: (context, state) {
          return ListView(
            children: [
              Card(
                margin: settingsCardMargin,
                child: Padding(
                  padding: settingsCardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SwitchListTile(
                        secondary: const PhosphorIcon(
                          PhosphorIconsLight.magnifyingGlass,
                        ),
                        title: Text(AppLocalizations.of(context).zoomControl),
                        value: state.zoomEnabled,
                        onChanged: (value) => context
                            .read<SettingsCubit>()
                            .changeZoomEnabled(value),
                      ),
                      SwitchListTile(
                        value: state.startInFullScreen,
                        onChanged: (value) => context
                            .read<SettingsCubit>()
                            .changeStartInFullScreen(value),
                        title: Text(
                          AppLocalizations.of(context).startInFullScreen,
                        ),
                        secondary: const PhosphorIcon(
                          PhosphorIconsLight.arrowsOut,
                        ),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.toolbox),
                        title: Text(
                          AppLocalizations.of(context).toolbarPosition,
                        ),
                        subtitle: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              state.toolbarPosition.getLocalizedName(context),
                            ),
                            Text(
                              AppLocalizations.of(
                                context,
                              ).onlyAvailableLargerScreen,
                              style: TextTheme.of(context).labelSmall,
                            ),
                          ],
                        ),
                        onTap: () => _openToolbarPositionModal(context),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.toolbox),
                        title: Text(AppLocalizations.of(context).toolbarSize),
                        subtitle: Text(
                          state.toolbarSize.getLocalizedName(context),
                        ),
                        onTap: () => _openToolbarSizeModal(context),
                      ),
                      ExactSlider(
                        header: Text(AppLocalizations.of(context).toolbarRows),
                        value: state.toolbarRows.toDouble(),
                        leading: const PhosphorIcon(PhosphorIconsLight.rows),
                        defaultValue: 1,
                        min: 1,
                        max: 4,
                        fractionDigits: 0,
                        headerWidth: 250,
                        divide: true,
                        onChangeEnd: (value) => context
                            .read<SettingsCubit>()
                            .changeToolbarRows(value.round()),
                      ),
                      AdvancedSwitchListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.sidebar),
                        title: Text(
                          AppLocalizations.of(context).navigationRail,
                        ),
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
                              AppLocalizations.of(
                                context,
                              ).onlyAvailableLargerScreen,
                              style: TextTheme.of(context).labelSmall,
                            ),
                          ],
                        ),
                        onTap: () async {
                          final position = await showLeapBottomSheet(
                            context: context,
                            titleBuilder: (context) =>
                                Text(AppLocalizations.of(context).position),
                            childrenBuilder: (context) => [
                              ListTile(
                                title: Text(AppLocalizations.of(context).left),
                                selected:
                                    state.navigatorPosition ==
                                    NavigatorPosition.left,
                                leading: const PhosphorIcon(
                                  PhosphorIconsLight.arrowLineLeft,
                                  textDirection: TextDirection.ltr,
                                ),
                                onTap: () => Navigator.of(
                                  context,
                                ).pop(NavigatorPosition.left),
                              ),
                              ListTile(
                                title: Text(AppLocalizations.of(context).right),
                                selected:
                                    state.navigatorPosition ==
                                    NavigatorPosition.right,
                                leading: const PhosphorIcon(
                                  PhosphorIconsLight.arrowLineRight,
                                  textDirection: TextDirection.ltr,
                                ),
                                onTap: () => Navigator.of(
                                  context,
                                ).pop(NavigatorPosition.right),
                              ),
                            ],
                          );
                          if (position != null) {
                            context
                                .read<SettingsCubit>()
                                .changeNavigatorPosition(position);
                          }
                        },
                        value: state.navigationRail,
                        onChanged: (value) => context
                            .read<SettingsCubit>()
                            .changeNavigationRail(value),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.archive),
                        title: Text(
                          AppLocalizations.of(context).optionsPanelPosition,
                        ),
                        subtitle: Text(
                          state.optionsPanelPosition.getLocalizedName(context),
                        ),
                        onTap: () => _openOptionsPanelPositionModal(context),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(
                          PhosphorIconsLight.cursorText,
                        ),
                        title: Text(
                          AppLocalizations.of(context).simpleToolbarVisibility,
                        ),
                        subtitle: Text(
                          state.simpleToolbarVisibility.getLocalizedName(
                            context,
                          ),
                        ),
                        onTap: () => _openSimpleToolbarVisibilityModal(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openToolbarPositionModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    var currentPos = cubit.state.toolbarPosition;
    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) =>
          Text(AppLocalizations.of(context).toolbarPosition),
      childrenBuilder: (context) => ToolbarPosition.values
          .map(
            (e) => ListTile(
              title: Text(e.getLocalizedName(context)),
              selected: currentPos == e,
              leading: Icon(switch (e) {
                ToolbarPosition.inline => PhosphorIconsLight.appWindow,
                ToolbarPosition.top => PhosphorIconsLight.arrowLineUp,
                ToolbarPosition.bottom => PhosphorIconsLight.arrowLineDown,
                ToolbarPosition.left => PhosphorIconsLight.arrowLineLeft,
                ToolbarPosition.right => PhosphorIconsLight.arrowLineRight,
              }),
              onTap: () {
                cubit.changeToolbarPosition(e);
                Navigator.of(context).pop();
              },
            ),
          )
          .toList(),
    );
  }

  void _openOptionsPanelPositionModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    var currentPos = cubit.state.optionsPanelPosition;
    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) =>
          Text(AppLocalizations.of(context).optionsPanelPosition),
      childrenBuilder: (context) => OptionsPanelPosition.values
          .map(
            (e) => ListTile(
              title: Text(e.getLocalizedName(context)),
              selected: currentPos == e,
              leading: Icon(switch (e) {
                OptionsPanelPosition.top => PhosphorIconsLight.arrowLineUp,
                OptionsPanelPosition.bottom => PhosphorIconsLight.arrowLineDown,
              }),
              onTap: () {
                cubit.changeOptionsPanelPosition(e);
                Navigator.of(context).pop();
              },
            ),
          )
          .toList(),
    );
  }

  void _openToolbarSizeModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    var currentSize = cubit.state.toolbarSize;
    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) => Text(AppLocalizations.of(context).toolbarSize),
      childrenBuilder: (context) => ToolbarSize.values
          .map(
            (e) => ListTile(
              title: Text(e.getLocalizedName(context)),
              selected: currentSize == e,
              onTap: () {
                cubit.changeToolbarSize(e);
                Navigator.of(context).pop();
              },
            ),
          )
          .toList(),
    );
  }

  void _openSimpleToolbarVisibilityModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    var currentPos = cubit.state.simpleToolbarVisibility;
    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) =>
          Text(AppLocalizations.of(context).simpleToolbarVisibility),
      childrenBuilder: (context) => SimpleToolbarVisibility.values
          .map(
            (e) => ListTile(
              title: Text(e.getLocalizedName(context)),
              selected: currentPos == e,
              leading: Icon(switch (e) {
                SimpleToolbarVisibility.show => PhosphorIconsLight.eye,
                SimpleToolbarVisibility.hide => PhosphorIconsLight.eyeSlash,
                SimpleToolbarVisibility.temporary => PhosphorIconsLight.clock,
              }),
              onTap: () {
                cubit.changeSimpleToolbarVisibility(e);
                Navigator.of(context).pop();
              },
            ),
          )
          .toList(),
    );
  }
}
