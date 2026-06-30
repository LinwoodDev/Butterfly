part of 'editor_runtime.dart';

@freezed
sealed class EditorInputState with _$EditorInputState {
  const factory EditorInputState({
    Offset? lastPosition,
    @Default([]) List<int> pointers,
    int? buttons,
    @Default(false) bool penDetected,
    @Default(false) bool sessionPenOnlyInput,
    @Default(HideState.visible) HideState hideUi,
  }) = _EditorInputState;
}

class EditorInputCubit extends Cubit<EditorInputState> {
  EditorInputCubit(
    this.settingsCubit, [
    super.initial = const EditorInputState(),
  ]);

  final SettingsCubit settingsCubit;
  ToolCubit? _toolCubit;

  void bindToolCubit(ToolCubit toolCubit) {
    _toolCubit = toolCubit;
  }

  @override
  void onChange(Change<EditorInputState> change) {
    super.onChange(change);
    if (change.nextState.lastPosition != change.currentState.lastPosition) {
      _toolCubit?.scheduleNetworkingState();
    }
  }

  void replace(EditorInputState state) => emit(state);

  void setPenDetected(bool detected, {bool enableSessionPenOnly = false}) {
    if (state.penDetected == detected &&
        (!enableSessionPenOnly || state.sessionPenOnlyInput)) {
      return;
    }
    emit(
      state.copyWith(
        penDetected: detected,
        sessionPenOnlyInput: enableSessionPenOnly
            ? true
            : state.sessionPenOnlyInput,
      ),
    );
  }

  bool get effectivePenOnlyInput {
    final setting = settingsCubit.state.penOnlyInput;
    if (setting != null) return setting;
    return state.sessionPenOnlyInput;
  }

  bool get moveEnabled =>
      (settingsCubit.state.inputGestures && state.pointers.length > 1) &&
      settingsCubit.state.moveOnGesture;

  void detectPen(bool detected) {
    if (state.penDetected == detected) return;
    setPenDetected(
      detected,
      enableSessionPenOnly:
          detected &&
          settingsCubit.state.penOnlyInput == null &&
          !state.sessionPenOnlyInput,
    );
  }

  void setSessionPenOnlyInput(bool value) {
    if (state.sessionPenOnlyInput != value) {
      emit(state.copyWith(sessionPenOnlyInput: value));
    }
  }

  void updateLastPosition(Offset position) {
    final lastPos = state.lastPosition;
    if (lastPos != null) {
      final dx = (position.dx - lastPos.dx).abs();
      final dy = (position.dy - lastPos.dy).abs();
      if (dx < 1 && dy < 1) return;
    }
    emit(state.copyWith(lastPosition: position));
  }

  void addPointer(int pointer) {
    if (!state.pointers.contains(pointer)) {
      emit(state.copyWith(pointers: [...state.pointers, pointer]));
    }
  }

  void removePointer(int pointer) {
    if (state.pointers.contains(pointer)) {
      emit(
        state.copyWith(
          pointers: state.pointers.where((p) => p != pointer).toList(),
        ),
      );
    }
  }

  void setButtons(int buttons) => emit(state.copyWith(buttons: buttons));

  void removeButtons() => emit(state.copyWith(buttons: null));

  void resetInputState() => emit(state.copyWith(buttons: null, pointers: []));

  void toggleKeyboardHideUI() => emit(
    state.copyWith(
      hideUi: state.hideUi == HideState.visible
          ? HideState.keyboard
          : HideState.visible,
    ),
  );

  void enterTouchHideUI() => emit(state.copyWith(hideUi: HideState.touch));

  void exitHideUI() => emit(state.copyWith(hideUi: HideState.visible));

  @override
  Future<void> close() {
    _toolCubit = null;
    return super.close();
  }
}
