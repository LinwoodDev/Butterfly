part of 'editor_runtime.dart';

@freezed
sealed class EditorViewState with _$EditorViewState {
  const factory EditorViewState({
    @Default(PersistentLockState()) PersistentLockState locks,
    @Default(true) bool areaNavigatorCreate,
    @Default(true) bool areaNavigatorExact,
    @Default(false) bool areaNavigatorAsk,
    @Default(false) bool navigatorEnabled,
    @Default(NavigatorPage.waypoints) NavigatorPage navigatorPage,
    @Default('') String userName,
  }) = _EditorViewState;
}

class EditorViewCubit extends Cubit<EditorViewState> {
  EditorViewCubit({this.editorSessionCubit, EditorViewState? initial})
    : super(initial ?? const EditorViewState());

  final EditorSessionCubit? editorSessionCubit;
  ToolCubit? _toolCubit;

  void bindToolCubit(ToolCubit toolCubit) {
    _toolCubit = toolCubit;
  }

  @override
  void onChange(Change<EditorViewState> change) {
    super.onChange(change);
    if (change.nextState.userName != change.currentState.userName) {
      _toolCubit?.scheduleNetworkingState();
    }
  }

  void replace(EditorViewState state) => emit(state);

  void updateLocks({PersistentLockState? locks}) {
    emit(state.copyWith(locks: locks ?? state.locks));
    if (locks != null) {
      editorSessionCubit?.updateLocks(locks);
    }
  }

  void setAreaNavigator({bool? create, bool? exact, bool? ask}) {
    emit(
      state.copyWith(
        areaNavigatorCreate: create ?? state.areaNavigatorCreate,
        areaNavigatorExact: exact ?? state.areaNavigatorExact,
        areaNavigatorAsk: ask ?? state.areaNavigatorAsk,
      ),
    );
    editorSessionCubit?.updateAreaNavigator(
      create: create,
      exact: exact,
      ask: ask,
    );
  }

  void setNavigator({bool? enabled, NavigatorPage? page}) {
    emit(
      state.copyWith(
        navigatorEnabled: enabled ?? state.navigatorEnabled,
        navigatorPage: page ?? state.navigatorPage,
      ),
    );
    editorSessionCubit?.updateNavigator(enabled: enabled, page: page);
  }

  void setUserName(String name) => emit(state.copyWith(userName: name));

  @override
  Future<void> close() {
    _toolCubit = null;
    return super.close();
  }
}
