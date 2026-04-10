import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BehaviorsSettingsPage extends StatelessWidget {
  final bool inView;

  const BehaviorsSettingsPage({super.key, this.inView = false});

  String _getStartupBehaviorName(BuildContext context, StartupBehavior value) =>
      switch (value) {
        StartupBehavior.openHomeScreen => AppLocalizations.of(
          context,
        ).homeScreen,
        StartupBehavior.openLastNote => AppLocalizations.of(context).lastNote,
        StartupBehavior.openNewNote => AppLocalizations.of(context).newNote,
      };

  String _getRenderResolutionName(
    BuildContext context,
    RenderResolution value,
  ) => switch (value) {
    RenderResolution.performance => AppLocalizations.of(context).performance,
    RenderResolution.normal => AppLocalizations.of(context).normal,
    RenderResolution.high => AppLocalizations.of(context).high,
  };

  String _getRenderResolutionDescription(
    BuildContext context,
    RenderResolution value,
  ) => switch (value) {
    RenderResolution.performance => AppLocalizations.of(
      context,
    ).performanceDescription,
    RenderResolution.normal => AppLocalizations.of(context).normalDescription,
    RenderResolution.high => AppLocalizations.of(context).highDescription,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: inView ? Colors.transparent : null,
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        title: Text(AppLocalizations.of(context).behaviors),
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
                      ListTile(
                        title: Text(AppLocalizations.of(context).autosave),
                        leading: const PhosphorIcon(
                          PhosphorIconsLight.floppyDisk,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).autosaveDescription,
                        ),
                        trailing: Text(
                          state.autosave
                              ? state.delayedAutosave
                                    ? AppLocalizations.of(context).delay
                                    : state.showSaveButton
                                    ? AppLocalizations.of(
                                        context,
                                      ).yesButShowButtons
                                    : AppLocalizations.of(context).yes
                              : AppLocalizations.of(context).no,
                        ),
                        onTap: () => _openAutosaveModal(context),
                      ),
                      if (state.autosave && state.delayedAutosave)
                        ExactSlider(
                          leading: const PhosphorIcon(PhosphorIconsLight.clock),
                          header: Text(
                            AppLocalizations.of(context).autosaveDelay,
                          ),
                          subtitle: Text(
                            AppLocalizations.of(context).autosaveDelayDescription,
                          ),
                          value: state.autosaveDelaySeconds.toDouble(),
                          min: 1,
                          max: 10,
                          defaultValue: 5,
                          fractionDigits: 0,
                          onChangeEnd: (value) => context
                              .read<SettingsCubit>()
                              .changeAutosaveDelaySeconds(value.toInt()),
                        ),
                      ListTile(
                        title: Text(AppLocalizations.of(context).onStartup),
                        subtitle: Text(
                          AppLocalizations.of(context).onStartupDescription,
                        ),
                        trailing: Text(
                          _getStartupBehaviorName(context, state.onStartup),
                        ),
                        onTap: () => _openStartupModal(context),
                        leading: const Icon(PhosphorIconsLight.arrowFatLineUp),
                      ),
                      SwitchListTile(
                        value: state.startInFullScreen,
                        onChanged: (value) => context
                            .read<SettingsCubit>()
                            .changeStartInFullScreen(value),
                        title: Text(
                          AppLocalizations.of(context).startInFullScreen,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).startInFullScreenDescription,
                        ),
                        secondary: const PhosphorIcon(
                          PhosphorIconsLight.arrowsOut,
                        ),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(
                          PhosphorIconsLight.appWindow,
                        ),
                        title: Text(
                          AppLocalizations.of(context).contentViewport,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).contentViewportDescription,
                        ),
                        trailing: Text(
                          state.limitViewportMultiplier == null
                              ? AppLocalizations.of(context).off
                              : '${state.limitViewportMultiplier}x',
                        ),
                        onTap: () => _openContentViewportModal(context),
                      ),
                      SwitchListTile(
                        value: state.limitViewportPositive,
                        onChanged: (value) => context
                            .read<SettingsCubit>()
                            .changeLimitViewportPositive(value),
                        title: Text(
                          AppLocalizations.of(
                            context,
                          ).limitViewportToPositiveCoordinates,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(
                            context,
                          ).limitViewportToPositiveCoordinatesDescription,
                        ),
                        secondary: const PhosphorIcon(
                          PhosphorIconsLight.plusSquare,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).renderResolution,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).renderResolutionDescription,
                        ),
                        trailing: Text(
                          _getRenderResolutionName(
                            context,
                            state.renderResolution,
                          ),
                        ),
                        onTap: () => _openRenderResolutionModal(context),
                        leading: const Icon(PhosphorIconsLight.sparkle),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: settingsCardMargin,
                child: Padding(
                  padding: settingsCardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: settingsCardTitlePadding,
                        child: Text(
                          AppLocalizations.of(context).import,
                          style: TextTheme.of(context).headlineSmall,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        value: state.spreadPages,
                        secondary: const PhosphorIcon(
                          PhosphorIconsLight.arrowsOutSimple,
                        ),
                        title: Text(AppLocalizations.of(context).spreadToPages),
                        subtitle: Text(
                          AppLocalizations.of(context).spreadToPagesDescription,
                        ),
                        onChanged: (value) => context
                            .read<SettingsCubit>()
                            .changeSpreadPages(value),
                      ),
                      ExactSlider(
                        header: Text(AppLocalizations.of(context).imageScale),
                        subtitle: Text(
                          AppLocalizations.of(context).imageScaleDescription,
                        ),
                        leading: const PhosphorIcon(
                          PhosphorIconsLight.frameCorners,
                        ),
                        value: state.imageScale * 100,
                        min: 0,
                        max: 100,
                        defaultValue: 50,
                        fractionDigits: 0,
                        onChangeEnd: (value) => context
                            .read<SettingsCubit>()
                            .changeImageScale(value / 100),
                      ),
                      ExactSlider(
                        leading: const PhosphorIcon(
                          PhosphorIconsLight.flowerLotus,
                        ),
                        header: Text(AppLocalizations.of(context).pdfQuality),
                        subtitle: Text(
                          AppLocalizations.of(context).pdfQualityDescription,
                        ),
                        value: state.pdfQuality,
                        min: 0.5,
                        max: 10,
                        defaultValue: 2,
                        onChangeEnd: (value) => context
                            .read<SettingsCubit>()
                            .changePdfQuality(value),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: settingsCardMargin,
                child: Padding(
                  padding: settingsCardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: settingsCardTitlePadding,
                        child: Text(
                          AppLocalizations.of(context).home,
                          style: TextTheme.of(context).headlineSmall,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        secondary: const PhosphorIcon(PhosphorIconsLight.image),
                        title: Text(
                          AppLocalizations.of(context).showThumbnails,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).showThumbnailsDescription,
                        ),
                        value: state.showThumbnails,
                        onChanged: (value) => context
                            .read<SettingsCubit>()
                            .changeShowThumbnails(value),
                      ),
                      SwitchListTile(
                        value: state.hideExtension,
                        onChanged: (value) => context
                            .read<SettingsCubit>()
                            .changeHideExtension(value),
                        title: Text(
                          AppLocalizations.of(context).hideFileExtension,
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context).hideFileExtensionDescription,
                        ),
                        secondary: const PhosphorIcon(
                          PhosphorIconsLight.fileText,
                        ),
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

  void _openContentViewportModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    var currentMultiplier = cubit.state.limitViewportMultiplier;
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

  void _openStartupModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final currentStartup = cubit.state.onStartup;

    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) => Text(AppLocalizations.of(context).onStartup),
      childrenBuilder: (context) {
        void changeStartup(StartupBehavior behavior) {
          cubit.changeStartupBehavior(behavior);
          Navigator.of(context).pop();
        }

        return StartupBehavior.values
            .map(
              (e) => ListTile(
                title: Text(_getStartupBehaviorName(context, e)),
                leading: Icon(switch (e) {
                  StartupBehavior.openHomeScreen => PhosphorIconsLight.house,
                  StartupBehavior.openLastNote =>
                    PhosphorIconsLight.arrowCounterClockwise,
                  StartupBehavior.openNewNote => PhosphorIconsLight.file,
                }, textDirection: TextDirection.ltr),
                selected: currentStartup == e,
                onTap: () => changeStartup(e),
              ),
            )
            .toList();
      },
    );
  }

  void _openRenderResolutionModal(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final currentResolution = cubit.state.renderResolution;

    showLeapBottomSheet(
      context: context,
      titleBuilder: (context) =>
          Text(AppLocalizations.of(context).renderResolution),
      childrenBuilder: (context) {
        void changeResolution(RenderResolution resolution) {
          cubit.changeRenderResolution(resolution);
          Navigator.of(context).pop();
        }

        return RenderResolution.values
            .map(
              (e) => ListTile(
                title: Text(_getRenderResolutionName(context, e)),
                subtitle: Text(_getRenderResolutionDescription(context, e)),
                selected: currentResolution == e,
                onTap: () => changeResolution(e),
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
            leading: Icon(PhosphorIconsLight.check),
            selected: autosave && !showSaveButton && !delayed,
            onTap: () => changeAutosave(true),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).delay),
            leading: Icon(PhosphorIconsLight.clock),
            selected: autosave && delayed,
            onTap: () => changeAutosave(null, delayed: true),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).yesButShowButtons),
            leading: Icon(PhosphorIconsLight.question),
            selected: autosave && showSaveButton && !delayed,
            onTap: () => changeAutosave(null),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).no),
            leading: Icon(PhosphorIconsLight.x),
            selected: !autosave,
            onTap: () => changeAutosave(false),
          ),
        ];
      },
    );
  }
}
