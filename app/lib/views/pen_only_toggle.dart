import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
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
    return BlocSelector<DocumentBloc, DocumentState, bool>(
      selector: (state) => state is DocumentLoadSuccess,
      builder: (context, loaded) =>
          BlocSelector<
            EditorInputCubit,
            EditorInputState,
            ({HideState hideUi, bool penDetected, bool? sessionPenOnlyInput})
          >(
            selector: (state) => (
              hideUi: state.hideUi,
              penDetected: state.penDetected,
              sessionPenOnlyInput: state.sessionPenOnlyInput,
            ),
            builder: (context, inputState) =>
                BlocSelector<
                  SettingsCubit,
                  ButterflySettings,
                  ({bool? penOnlyInput, bool showPenOnlyToggle})
                >(
                  selector: (state) => (
                    penOnlyInput: state.penOnlyInput,
                    showPenOnlyToggle: state.showPenOnlyToggle,
                  ),
                  builder: (context, settings) {
                    // Don't show if:
                    // - No pen has been detected
                    // - UI is hidden
                    // - Setting to show toggle is disabled
                    // - Document is not loaded
                    if (!inputState.penDetected ||
                        inputState.hideUi != HideState.visible ||
                        !settings.showPenOnlyToggle ||
                        !loaded) {
                      return const SizedBox.shrink();
                    }

                    // Use effective pen-only state (considers both setting and session)
                    final penOnlyEnabled = context
                        .read<EditorInputCubit>()
                        .effectivePenOnlyInput;
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
                                .read<EditorInputCubit>()
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
