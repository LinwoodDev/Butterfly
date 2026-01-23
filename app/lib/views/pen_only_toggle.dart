import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A toggle button that appears when a pen/stylus is detected,
/// allowing the user to quickly toggle pen-only input mode.
class PenOnlyToggle extends StatelessWidget {
  const PenOnlyToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, docState) => BlocBuilder<CurrentIndexCubit, CurrentIndex>(
        buildWhen: (previous, current) =>
            previous.penDetected != current.penDetected ||
            previous.hideUi != current.hideUi ||
            previous.sessionPenOnlyInput != current.sessionPenOnlyInput,
        builder: (context, currentIndex) =>
            BlocBuilder<SettingsCubit, ButterflySettings>(
              buildWhen: (previous, current) =>
                  previous.penOnlyInput != current.penOnlyInput ||
                  previous.showPenOnlyToggle != current.showPenOnlyToggle,
              builder: (context, settings) {
                // Don't show if:
                // - No pen has been detected
                // - UI is hidden
                // - Setting to show toggle is disabled
                // - Document is not loaded
                if (!currentIndex.penDetected ||
                    currentIndex.hideUi != HideState.visible ||
                    !settings.showPenOnlyToggle ||
                    docState is! DocumentLoadSuccess) {
                  return const SizedBox.shrink();
                }

                // Use effective pen-only state (considers both setting and session)
                final penOnlyEnabled = currentIndex.effectivePenOnlyInput;
                final isAutoMode = settings.penOnlyInput == null;

                return Tooltip(
                  message: AppLocalizations.of(context).penOnlyInput,
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: penOnlyEnabled
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                      foregroundColor: penOnlyEnabled
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    icon: PhosphorIcon(
                      penOnlyEnabled
                          ? PhosphorIconsFill.pen
                          : PhosphorIconsLight.pen,
                    ),
                    onPressed: () {
                      if (isAutoMode) {
                        // In auto mode, toggle the session state
                        context
                            .read<CurrentIndexCubit>()
                            .setSessionPenOnlyInput(!penOnlyEnabled);
                      } else {
                        // In explicit mode, toggle the persisted setting
                        context.read<SettingsCubit>().changePenOnlyInput(
                          !penOnlyEnabled,
                        );
                      }
                    },
                  ),
                );
              },
            ),
      ),
    );
  }
}
