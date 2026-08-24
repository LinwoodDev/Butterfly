import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A toggle button that appears when a pen/stylus is detected,
/// allowing the user to quickly toggle stylus-only input mode.
class StylusOnlyToggle extends StatelessWidget {
  const StylusOnlyToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DocumentBloc, DocumentState, bool>(
      selector: (state) => state is DocumentLoadSuccess,
      builder: (context, loaded) =>
          BlocSelector<
            EditorInputCubit,
            EditorInputState,
            ({
              HideState hideUi,
              bool stylusDetected,
              bool? sessionStylusOnlyInput,
            })
          >(
            selector: (state) => (
              hideUi: state.hideUi,
              stylusDetected: state.stylusDetected,
              sessionStylusOnlyInput: state.sessionStylusOnlyInput,
            ),
            builder: (context, inputState) =>
                BlocSelector<
                  SettingsCubit,
                  ButterflySettings,
                  ({bool? stylusOnlyInput, bool showStylusOnlyToggle})
                >(
                  selector: (state) => (
                    stylusOnlyInput: state.stylusOnlyInput,
                    showStylusOnlyToggle: state.showStylusOnlyToggle,
                  ),
                  builder: (context, settings) {
                    // Don't show if:
                    // - No stylus has been detected
                    // - UI is hidden
                    // - Setting to show toggle is disabled
                    // - Document is not loaded
                    if (!inputState.stylusDetected ||
                        inputState.hideUi != HideState.visible ||
                        !settings.showStylusOnlyToggle ||
                        !loaded) {
                      return const SizedBox.shrink();
                    }

                    // Use effective stylus-only state (considers both setting and session)
                    final stylusOnlyEnabled = context
                        .read<EditorInputCubit>()
                        .effectiveStylusOnlyInput;
                    final isAutoMode = settings.stylusOnlyInput == null;

                    return Tooltip(
                      message: AppLocalizations.of(context).stylusOnlyInput,
                      child: IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: stylusOnlyEnabled
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                          foregroundColor: stylusOnlyEnabled
                              ? Theme.of(context).colorScheme.onPrimaryContainer
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        icon: PhosphorIcon(
                          stylusOnlyEnabled
                              ? PhosphorIconsFill.pen
                              : PhosphorIconsLight.pen,
                        ),
                        onPressed: () {
                          if (isAutoMode) {
                            // In auto mode, toggle the session state
                            context
                                .read<EditorInputCubit>()
                                .setSessionStylusOnlyInput(!stylusOnlyEnabled);
                          } else {
                            // In explicit mode, toggle the persisted setting
                            context.read<SettingsCubit>().changeStylusOnlyInput(
                              !stylusOnlyEnabled,
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
