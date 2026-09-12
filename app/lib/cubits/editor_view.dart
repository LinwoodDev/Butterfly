part of 'editor_runtime.dart';

@freezed
class const EditorViewState({
  final PersistentLockState locks = const .new(),
  final bool areaNavigatorCreate = true,
  final bool areaNavigatorExact = true,
  final bool areaNavigatorAsk = false,
  final bool navigatorEnabled = false,
  final NavigatorPage navigatorPage = .waypoints,
  final String userName = '',
}) with _$EditorViewState {}

class EditorViewCubit({
  final EditorSessionCubit? editorSessionCubit,
  EditorViewState? initial,
}) extends Cubit<EditorViewState> {
  this : super(initial ?? const EditorViewState());
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
