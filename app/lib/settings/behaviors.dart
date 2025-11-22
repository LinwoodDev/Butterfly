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
                          _getStartupBehaviorName(context, state.onStartup),
                        ),
                        onTap: () => _openStartupModal(context),
                        leading: const Icon(PhosphorIconsLight.arrowFatLineUp),
                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).renderResolution,
                        ),
                        subtitle: Text(
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
                        onChanged: (value) => context
                            .read<SettingsCubit>()
                            .changeSpreadPages(value),
                      ),
                      ExactSlider(
                        header: Text(AppLocalizations.of(context).imageScale),
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
            ],
          );
        },
      ),
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
