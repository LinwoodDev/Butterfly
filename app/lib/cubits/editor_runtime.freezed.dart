// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editor_runtime.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RendererRuntimeState implements DiagnosticableTreeMixin {

 CameraViewport get cameraViewport; Map<String, RendererState> get rendererStates; Map<String, RendererState>? get temporaryRendererStates;
/// Create a copy of RendererRuntimeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RendererRuntimeStateCopyWith<RendererRuntimeState> get copyWith => _$RendererRuntimeStateCopyWithImpl<RendererRuntimeState>(this as RendererRuntimeState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RendererRuntimeState'))
    ..add(DiagnosticsProperty('cameraViewport', cameraViewport))..add(DiagnosticsProperty('rendererStates', rendererStates))..add(DiagnosticsProperty('temporaryRendererStates', temporaryRendererStates));
}



@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RendererRuntimeState(cameraViewport: $cameraViewport, rendererStates: $rendererStates, temporaryRendererStates: $temporaryRendererStates)';
}


}

/// @nodoc
abstract mixin class $RendererRuntimeStateCopyWith<$Res>  {
  factory $RendererRuntimeStateCopyWith(RendererRuntimeState value, $Res Function(RendererRuntimeState) _then) = _$RendererRuntimeStateCopyWithImpl;
@useResult
$Res call({
 CameraViewport cameraViewport, Map<String, RendererState> rendererStates, Map<String, RendererState>? temporaryRendererStates
});


$CameraViewportCopyWith<$Res> get cameraViewport;

}
/// @nodoc
class _$RendererRuntimeStateCopyWithImpl<$Res>
    implements $RendererRuntimeStateCopyWith<$Res> {
  _$RendererRuntimeStateCopyWithImpl(this._self, this._then);

  final RendererRuntimeState _self;
  final $Res Function(RendererRuntimeState) _then;

/// Create a copy of RendererRuntimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cameraViewport = null,Object? rendererStates = null,Object? temporaryRendererStates = freezed,}) {
  return _then(_self.copyWith(
cameraViewport: null == cameraViewport ? _self.cameraViewport : cameraViewport // ignore: cast_nullable_to_non_nullable
as CameraViewport,rendererStates: null == rendererStates ? _self.rendererStates : rendererStates // ignore: cast_nullable_to_non_nullable
as Map<String, RendererState>,temporaryRendererStates: freezed == temporaryRendererStates ? _self.temporaryRendererStates : temporaryRendererStates // ignore: cast_nullable_to_non_nullable
as Map<String, RendererState>?,
  ));
}
/// Create a copy of RendererRuntimeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CameraViewportCopyWith<$Res> get cameraViewport {
  
  return $CameraViewportCopyWith<$Res>(_self.cameraViewport, (value) {
    return _then(_self.copyWith(cameraViewport: value));
  });
}
}



/// @nodoc


class _RendererRuntimeState extends RendererRuntimeState with DiagnosticableTreeMixin {
  const _RendererRuntimeState({this.cameraViewport = const CameraViewport.unbaked(), final  Map<String, RendererState> rendererStates = const {}, final  Map<String, RendererState>? temporaryRendererStates = const {}}): _rendererStates = rendererStates,_temporaryRendererStates = temporaryRendererStates,super._();
  

@override@JsonKey() final  CameraViewport cameraViewport;
 final  Map<String, RendererState> _rendererStates;
@override@JsonKey() Map<String, RendererState> get rendererStates {
  if (_rendererStates is EqualUnmodifiableMapView) return _rendererStates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rendererStates);
}

 final  Map<String, RendererState>? _temporaryRendererStates;
@override@JsonKey() Map<String, RendererState>? get temporaryRendererStates {
  final value = _temporaryRendererStates;
  if (value == null) return null;
  if (_temporaryRendererStates is EqualUnmodifiableMapView) return _temporaryRendererStates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of RendererRuntimeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RendererRuntimeStateCopyWith<_RendererRuntimeState> get copyWith => __$RendererRuntimeStateCopyWithImpl<_RendererRuntimeState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RendererRuntimeState'))
    ..add(DiagnosticsProperty('cameraViewport', cameraViewport))..add(DiagnosticsProperty('rendererStates', rendererStates))..add(DiagnosticsProperty('temporaryRendererStates', temporaryRendererStates));
}



@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RendererRuntimeState(cameraViewport: $cameraViewport, rendererStates: $rendererStates, temporaryRendererStates: $temporaryRendererStates)';
}


}

/// @nodoc
abstract mixin class _$RendererRuntimeStateCopyWith<$Res> implements $RendererRuntimeStateCopyWith<$Res> {
  factory _$RendererRuntimeStateCopyWith(_RendererRuntimeState value, $Res Function(_RendererRuntimeState) _then) = __$RendererRuntimeStateCopyWithImpl;
@override @useResult
$Res call({
 CameraViewport cameraViewport, Map<String, RendererState> rendererStates, Map<String, RendererState>? temporaryRendererStates
});


@override $CameraViewportCopyWith<$Res> get cameraViewport;

}
/// @nodoc
class __$RendererRuntimeStateCopyWithImpl<$Res>
    implements _$RendererRuntimeStateCopyWith<$Res> {
  __$RendererRuntimeStateCopyWithImpl(this._self, this._then);

  final _RendererRuntimeState _self;
  final $Res Function(_RendererRuntimeState) _then;

/// Create a copy of RendererRuntimeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cameraViewport = null,Object? rendererStates = null,Object? temporaryRendererStates = freezed,}) {
  return _then(_RendererRuntimeState(
cameraViewport: null == cameraViewport ? _self.cameraViewport : cameraViewport // ignore: cast_nullable_to_non_nullable
as CameraViewport,rendererStates: null == rendererStates ? _self._rendererStates : rendererStates // ignore: cast_nullable_to_non_nullable
as Map<String, RendererState>,temporaryRendererStates: freezed == temporaryRendererStates ? _self._temporaryRendererStates : temporaryRendererStates // ignore: cast_nullable_to_non_nullable
as Map<String, RendererState>?,
  ));
}

/// Create a copy of RendererRuntimeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CameraViewportCopyWith<$Res> get cameraViewport {
  
  return $CameraViewportCopyWith<$Res>(_self.cameraViewport, (value) {
    return _then(_self.copyWith(cameraViewport: value));
  });
}
}

/// @nodoc
mixin _$ToolRuntimeState implements DiagnosticableTreeMixin {

 int? get index; Handler get handler; Handler<Tool>? get temporaryHandler; int? get temporaryIndex; List<Renderer> get foregrounds; Selection? get selection; bool get pinned; List<Renderer>? get temporaryForegrounds; Map<int, Handler<Tool>> get toggleableHandlers; List<Renderer> get networkingForegrounds; Map<int, List<Renderer>> get toggleableForegrounds; MouseCursor get cursor; MouseCursor? get temporaryCursor; TemporaryState get temporaryState; PreferredSizeWidget? get toolbar; PreferredSizeWidget? get temporaryToolbar;
/// Create a copy of ToolRuntimeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolRuntimeStateCopyWith<ToolRuntimeState> get copyWith => _$ToolRuntimeStateCopyWithImpl<ToolRuntimeState>(this as ToolRuntimeState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ToolRuntimeState'))
    ..add(DiagnosticsProperty('index', index))..add(DiagnosticsProperty('handler', handler))..add(DiagnosticsProperty('temporaryHandler', temporaryHandler))..add(DiagnosticsProperty('temporaryIndex', temporaryIndex))..add(DiagnosticsProperty('foregrounds', foregrounds))..add(DiagnosticsProperty('selection', selection))..add(DiagnosticsProperty('pinned', pinned))..add(DiagnosticsProperty('temporaryForegrounds', temporaryForegrounds))..add(DiagnosticsProperty('toggleableHandlers', toggleableHandlers))..add(DiagnosticsProperty('networkingForegrounds', networkingForegrounds))..add(DiagnosticsProperty('toggleableForegrounds', toggleableForegrounds))..add(DiagnosticsProperty('cursor', cursor))..add(DiagnosticsProperty('temporaryCursor', temporaryCursor))..add(DiagnosticsProperty('temporaryState', temporaryState))..add(DiagnosticsProperty('toolbar', toolbar))..add(DiagnosticsProperty('temporaryToolbar', temporaryToolbar));
}



@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ToolRuntimeState(index: $index, handler: $handler, temporaryHandler: $temporaryHandler, temporaryIndex: $temporaryIndex, foregrounds: $foregrounds, selection: $selection, pinned: $pinned, temporaryForegrounds: $temporaryForegrounds, toggleableHandlers: $toggleableHandlers, networkingForegrounds: $networkingForegrounds, toggleableForegrounds: $toggleableForegrounds, cursor: $cursor, temporaryCursor: $temporaryCursor, temporaryState: $temporaryState, toolbar: $toolbar, temporaryToolbar: $temporaryToolbar)';
}


}

/// @nodoc
abstract mixin class $ToolRuntimeStateCopyWith<$Res>  {
  factory $ToolRuntimeStateCopyWith(ToolRuntimeState value, $Res Function(ToolRuntimeState) _then) = _$ToolRuntimeStateCopyWithImpl;
@useResult
$Res call({
 int? index, Handler handler, Handler<Tool>? temporaryHandler, int? temporaryIndex, List<Renderer> foregrounds, Selection? selection, bool pinned, List<Renderer>? temporaryForegrounds, Map<int, Handler<Tool>> toggleableHandlers, List<Renderer> networkingForegrounds, Map<int, List<Renderer>> toggleableForegrounds, MouseCursor cursor, MouseCursor? temporaryCursor, TemporaryState temporaryState, PreferredSizeWidget? toolbar, PreferredSizeWidget? temporaryToolbar
});




}
/// @nodoc
class _$ToolRuntimeStateCopyWithImpl<$Res>
    implements $ToolRuntimeStateCopyWith<$Res> {
  _$ToolRuntimeStateCopyWithImpl(this._self, this._then);

  final ToolRuntimeState _self;
  final $Res Function(ToolRuntimeState) _then;

/// Create a copy of ToolRuntimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = freezed,Object? handler = null,Object? temporaryHandler = freezed,Object? temporaryIndex = freezed,Object? foregrounds = null,Object? selection = freezed,Object? pinned = null,Object? temporaryForegrounds = freezed,Object? toggleableHandlers = null,Object? networkingForegrounds = null,Object? toggleableForegrounds = null,Object? cursor = null,Object? temporaryCursor = freezed,Object? temporaryState = null,Object? toolbar = freezed,Object? temporaryToolbar = freezed,}) {
  return _then(_self.copyWith(
index: freezed == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int?,handler: null == handler ? _self.handler : handler // ignore: cast_nullable_to_non_nullable
as Handler,temporaryHandler: freezed == temporaryHandler ? _self.temporaryHandler : temporaryHandler // ignore: cast_nullable_to_non_nullable
as Handler<Tool>?,temporaryIndex: freezed == temporaryIndex ? _self.temporaryIndex : temporaryIndex // ignore: cast_nullable_to_non_nullable
as int?,foregrounds: null == foregrounds ? _self.foregrounds : foregrounds // ignore: cast_nullable_to_non_nullable
as List<Renderer>,selection: freezed == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as Selection?,pinned: null == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool,temporaryForegrounds: freezed == temporaryForegrounds ? _self.temporaryForegrounds : temporaryForegrounds // ignore: cast_nullable_to_non_nullable
as List<Renderer>?,toggleableHandlers: null == toggleableHandlers ? _self.toggleableHandlers : toggleableHandlers // ignore: cast_nullable_to_non_nullable
as Map<int, Handler<Tool>>,networkingForegrounds: null == networkingForegrounds ? _self.networkingForegrounds : networkingForegrounds // ignore: cast_nullable_to_non_nullable
as List<Renderer>,toggleableForegrounds: null == toggleableForegrounds ? _self.toggleableForegrounds : toggleableForegrounds // ignore: cast_nullable_to_non_nullable
as Map<int, List<Renderer>>,cursor: null == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as MouseCursor,temporaryCursor: freezed == temporaryCursor ? _self.temporaryCursor : temporaryCursor // ignore: cast_nullable_to_non_nullable
as MouseCursor?,temporaryState: null == temporaryState ? _self.temporaryState : temporaryState // ignore: cast_nullable_to_non_nullable
as TemporaryState,toolbar: freezed == toolbar ? _self.toolbar : toolbar // ignore: cast_nullable_to_non_nullable
as PreferredSizeWidget?,temporaryToolbar: freezed == temporaryToolbar ? _self.temporaryToolbar : temporaryToolbar // ignore: cast_nullable_to_non_nullable
as PreferredSizeWidget?,
  ));
}

}



/// @nodoc


class _ToolRuntimeState extends ToolRuntimeState with DiagnosticableTreeMixin {
  const _ToolRuntimeState({this.index, required this.handler, this.temporaryHandler, this.temporaryIndex, final  List<Renderer> foregrounds = const [], this.selection, this.pinned = false, final  List<Renderer>? temporaryForegrounds, final  Map<int, Handler<Tool>> toggleableHandlers = const {}, final  List<Renderer> networkingForegrounds = const [], final  Map<int, List<Renderer>> toggleableForegrounds = const {}, this.cursor = MouseCursor.defer, this.temporaryCursor, this.temporaryState = TemporaryState.allowClick, this.toolbar, this.temporaryToolbar}): _foregrounds = foregrounds,_temporaryForegrounds = temporaryForegrounds,_toggleableHandlers = toggleableHandlers,_networkingForegrounds = networkingForegrounds,_toggleableForegrounds = toggleableForegrounds,super._();
  

@override final  int? index;
@override final  Handler handler;
@override final  Handler<Tool>? temporaryHandler;
@override final  int? temporaryIndex;
 final  List<Renderer> _foregrounds;
@override@JsonKey() List<Renderer> get foregrounds {
  if (_foregrounds is EqualUnmodifiableListView) return _foregrounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_foregrounds);
}

@override final  Selection? selection;
@override@JsonKey() final  bool pinned;
 final  List<Renderer>? _temporaryForegrounds;
@override List<Renderer>? get temporaryForegrounds {
  final value = _temporaryForegrounds;
  if (value == null) return null;
  if (_temporaryForegrounds is EqualUnmodifiableListView) return _temporaryForegrounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<int, Handler<Tool>> _toggleableHandlers;
@override@JsonKey() Map<int, Handler<Tool>> get toggleableHandlers {
  if (_toggleableHandlers is EqualUnmodifiableMapView) return _toggleableHandlers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_toggleableHandlers);
}

 final  List<Renderer> _networkingForegrounds;
@override@JsonKey() List<Renderer> get networkingForegrounds {
  if (_networkingForegrounds is EqualUnmodifiableListView) return _networkingForegrounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_networkingForegrounds);
}

 final  Map<int, List<Renderer>> _toggleableForegrounds;
@override@JsonKey() Map<int, List<Renderer>> get toggleableForegrounds {
  if (_toggleableForegrounds is EqualUnmodifiableMapView) return _toggleableForegrounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_toggleableForegrounds);
}

@override@JsonKey() final  MouseCursor cursor;
@override final  MouseCursor? temporaryCursor;
@override@JsonKey() final  TemporaryState temporaryState;
@override final  PreferredSizeWidget? toolbar;
@override final  PreferredSizeWidget? temporaryToolbar;

/// Create a copy of ToolRuntimeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToolRuntimeStateCopyWith<_ToolRuntimeState> get copyWith => __$ToolRuntimeStateCopyWithImpl<_ToolRuntimeState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ToolRuntimeState'))
    ..add(DiagnosticsProperty('index', index))..add(DiagnosticsProperty('handler', handler))..add(DiagnosticsProperty('temporaryHandler', temporaryHandler))..add(DiagnosticsProperty('temporaryIndex', temporaryIndex))..add(DiagnosticsProperty('foregrounds', foregrounds))..add(DiagnosticsProperty('selection', selection))..add(DiagnosticsProperty('pinned', pinned))..add(DiagnosticsProperty('temporaryForegrounds', temporaryForegrounds))..add(DiagnosticsProperty('toggleableHandlers', toggleableHandlers))..add(DiagnosticsProperty('networkingForegrounds', networkingForegrounds))..add(DiagnosticsProperty('toggleableForegrounds', toggleableForegrounds))..add(DiagnosticsProperty('cursor', cursor))..add(DiagnosticsProperty('temporaryCursor', temporaryCursor))..add(DiagnosticsProperty('temporaryState', temporaryState))..add(DiagnosticsProperty('toolbar', toolbar))..add(DiagnosticsProperty('temporaryToolbar', temporaryToolbar));
}



@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ToolRuntimeState(index: $index, handler: $handler, temporaryHandler: $temporaryHandler, temporaryIndex: $temporaryIndex, foregrounds: $foregrounds, selection: $selection, pinned: $pinned, temporaryForegrounds: $temporaryForegrounds, toggleableHandlers: $toggleableHandlers, networkingForegrounds: $networkingForegrounds, toggleableForegrounds: $toggleableForegrounds, cursor: $cursor, temporaryCursor: $temporaryCursor, temporaryState: $temporaryState, toolbar: $toolbar, temporaryToolbar: $temporaryToolbar)';
}


}

/// @nodoc
abstract mixin class _$ToolRuntimeStateCopyWith<$Res> implements $ToolRuntimeStateCopyWith<$Res> {
  factory _$ToolRuntimeStateCopyWith(_ToolRuntimeState value, $Res Function(_ToolRuntimeState) _then) = __$ToolRuntimeStateCopyWithImpl;
@override @useResult
$Res call({
 int? index, Handler handler, Handler<Tool>? temporaryHandler, int? temporaryIndex, List<Renderer> foregrounds, Selection? selection, bool pinned, List<Renderer>? temporaryForegrounds, Map<int, Handler<Tool>> toggleableHandlers, List<Renderer> networkingForegrounds, Map<int, List<Renderer>> toggleableForegrounds, MouseCursor cursor, MouseCursor? temporaryCursor, TemporaryState temporaryState, PreferredSizeWidget? toolbar, PreferredSizeWidget? temporaryToolbar
});




}
/// @nodoc
class __$ToolRuntimeStateCopyWithImpl<$Res>
    implements _$ToolRuntimeStateCopyWith<$Res> {
  __$ToolRuntimeStateCopyWithImpl(this._self, this._then);

  final _ToolRuntimeState _self;
  final $Res Function(_ToolRuntimeState) _then;

/// Create a copy of ToolRuntimeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = freezed,Object? handler = null,Object? temporaryHandler = freezed,Object? temporaryIndex = freezed,Object? foregrounds = null,Object? selection = freezed,Object? pinned = null,Object? temporaryForegrounds = freezed,Object? toggleableHandlers = null,Object? networkingForegrounds = null,Object? toggleableForegrounds = null,Object? cursor = null,Object? temporaryCursor = freezed,Object? temporaryState = null,Object? toolbar = freezed,Object? temporaryToolbar = freezed,}) {
  return _then(_ToolRuntimeState(
index: freezed == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int?,handler: null == handler ? _self.handler : handler // ignore: cast_nullable_to_non_nullable
as Handler,temporaryHandler: freezed == temporaryHandler ? _self.temporaryHandler : temporaryHandler // ignore: cast_nullable_to_non_nullable
as Handler<Tool>?,temporaryIndex: freezed == temporaryIndex ? _self.temporaryIndex : temporaryIndex // ignore: cast_nullable_to_non_nullable
as int?,foregrounds: null == foregrounds ? _self._foregrounds : foregrounds // ignore: cast_nullable_to_non_nullable
as List<Renderer>,selection: freezed == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as Selection?,pinned: null == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool,temporaryForegrounds: freezed == temporaryForegrounds ? _self._temporaryForegrounds : temporaryForegrounds // ignore: cast_nullable_to_non_nullable
as List<Renderer>?,toggleableHandlers: null == toggleableHandlers ? _self._toggleableHandlers : toggleableHandlers // ignore: cast_nullable_to_non_nullable
as Map<int, Handler<Tool>>,networkingForegrounds: null == networkingForegrounds ? _self._networkingForegrounds : networkingForegrounds // ignore: cast_nullable_to_non_nullable
as List<Renderer>,toggleableForegrounds: null == toggleableForegrounds ? _self._toggleableForegrounds : toggleableForegrounds // ignore: cast_nullable_to_non_nullable
as Map<int, List<Renderer>>,cursor: null == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as MouseCursor,temporaryCursor: freezed == temporaryCursor ? _self.temporaryCursor : temporaryCursor // ignore: cast_nullable_to_non_nullable
as MouseCursor?,temporaryState: null == temporaryState ? _self.temporaryState : temporaryState // ignore: cast_nullable_to_non_nullable
as TemporaryState,toolbar: freezed == toolbar ? _self.toolbar : toolbar // ignore: cast_nullable_to_non_nullable
as PreferredSizeWidget?,temporaryToolbar: freezed == temporaryToolbar ? _self.temporaryToolbar : temporaryToolbar // ignore: cast_nullable_to_non_nullable
as PreferredSizeWidget?,
  ));
}


}

/// @nodoc
mixin _$EditorInputState implements DiagnosticableTreeMixin {

 Offset? get lastPosition; List<int> get pointers; int? get buttons; bool get penDetected; bool get sessionPenOnlyInput; HideState get hideUi;
/// Create a copy of EditorInputState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditorInputStateCopyWith<EditorInputState> get copyWith => _$EditorInputStateCopyWithImpl<EditorInputState>(this as EditorInputState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EditorInputState'))
    ..add(DiagnosticsProperty('lastPosition', lastPosition))..add(DiagnosticsProperty('pointers', pointers))..add(DiagnosticsProperty('buttons', buttons))..add(DiagnosticsProperty('penDetected', penDetected))..add(DiagnosticsProperty('sessionPenOnlyInput', sessionPenOnlyInput))..add(DiagnosticsProperty('hideUi', hideUi));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditorInputState&&(identical(other.lastPosition, lastPosition) || other.lastPosition == lastPosition)&&const DeepCollectionEquality().equals(other.pointers, pointers)&&(identical(other.buttons, buttons) || other.buttons == buttons)&&(identical(other.penDetected, penDetected) || other.penDetected == penDetected)&&(identical(other.sessionPenOnlyInput, sessionPenOnlyInput) || other.sessionPenOnlyInput == sessionPenOnlyInput)&&(identical(other.hideUi, hideUi) || other.hideUi == hideUi));
}


@override
int get hashCode => Object.hash(runtimeType,lastPosition,const DeepCollectionEquality().hash(pointers),buttons,penDetected,sessionPenOnlyInput,hideUi);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EditorInputState(lastPosition: $lastPosition, pointers: $pointers, buttons: $buttons, penDetected: $penDetected, sessionPenOnlyInput: $sessionPenOnlyInput, hideUi: $hideUi)';
}


}

/// @nodoc
abstract mixin class $EditorInputStateCopyWith<$Res>  {
  factory $EditorInputStateCopyWith(EditorInputState value, $Res Function(EditorInputState) _then) = _$EditorInputStateCopyWithImpl;
@useResult
$Res call({
 Offset? lastPosition, List<int> pointers, int? buttons, bool penDetected, bool sessionPenOnlyInput, HideState hideUi
});




}
/// @nodoc
class _$EditorInputStateCopyWithImpl<$Res>
    implements $EditorInputStateCopyWith<$Res> {
  _$EditorInputStateCopyWithImpl(this._self, this._then);

  final EditorInputState _self;
  final $Res Function(EditorInputState) _then;

/// Create a copy of EditorInputState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastPosition = freezed,Object? pointers = null,Object? buttons = freezed,Object? penDetected = null,Object? sessionPenOnlyInput = null,Object? hideUi = null,}) {
  return _then(_self.copyWith(
lastPosition: freezed == lastPosition ? _self.lastPosition : lastPosition // ignore: cast_nullable_to_non_nullable
as Offset?,pointers: null == pointers ? _self.pointers : pointers // ignore: cast_nullable_to_non_nullable
as List<int>,buttons: freezed == buttons ? _self.buttons : buttons // ignore: cast_nullable_to_non_nullable
as int?,penDetected: null == penDetected ? _self.penDetected : penDetected // ignore: cast_nullable_to_non_nullable
as bool,sessionPenOnlyInput: null == sessionPenOnlyInput ? _self.sessionPenOnlyInput : sessionPenOnlyInput // ignore: cast_nullable_to_non_nullable
as bool,hideUi: null == hideUi ? _self.hideUi : hideUi // ignore: cast_nullable_to_non_nullable
as HideState,
  ));
}

}



/// @nodoc


class _EditorInputState with DiagnosticableTreeMixin implements EditorInputState {
  const _EditorInputState({this.lastPosition, final  List<int> pointers = const [], this.buttons, this.penDetected = false, this.sessionPenOnlyInput = false, this.hideUi = HideState.visible}): _pointers = pointers;
  

@override final  Offset? lastPosition;
 final  List<int> _pointers;
@override@JsonKey() List<int> get pointers {
  if (_pointers is EqualUnmodifiableListView) return _pointers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pointers);
}

@override final  int? buttons;
@override@JsonKey() final  bool penDetected;
@override@JsonKey() final  bool sessionPenOnlyInput;
@override@JsonKey() final  HideState hideUi;

/// Create a copy of EditorInputState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditorInputStateCopyWith<_EditorInputState> get copyWith => __$EditorInputStateCopyWithImpl<_EditorInputState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EditorInputState'))
    ..add(DiagnosticsProperty('lastPosition', lastPosition))..add(DiagnosticsProperty('pointers', pointers))..add(DiagnosticsProperty('buttons', buttons))..add(DiagnosticsProperty('penDetected', penDetected))..add(DiagnosticsProperty('sessionPenOnlyInput', sessionPenOnlyInput))..add(DiagnosticsProperty('hideUi', hideUi));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditorInputState&&(identical(other.lastPosition, lastPosition) || other.lastPosition == lastPosition)&&const DeepCollectionEquality().equals(other._pointers, _pointers)&&(identical(other.buttons, buttons) || other.buttons == buttons)&&(identical(other.penDetected, penDetected) || other.penDetected == penDetected)&&(identical(other.sessionPenOnlyInput, sessionPenOnlyInput) || other.sessionPenOnlyInput == sessionPenOnlyInput)&&(identical(other.hideUi, hideUi) || other.hideUi == hideUi));
}


@override
int get hashCode => Object.hash(runtimeType,lastPosition,const DeepCollectionEquality().hash(_pointers),buttons,penDetected,sessionPenOnlyInput,hideUi);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EditorInputState(lastPosition: $lastPosition, pointers: $pointers, buttons: $buttons, penDetected: $penDetected, sessionPenOnlyInput: $sessionPenOnlyInput, hideUi: $hideUi)';
}


}

/// @nodoc
abstract mixin class _$EditorInputStateCopyWith<$Res> implements $EditorInputStateCopyWith<$Res> {
  factory _$EditorInputStateCopyWith(_EditorInputState value, $Res Function(_EditorInputState) _then) = __$EditorInputStateCopyWithImpl;
@override @useResult
$Res call({
 Offset? lastPosition, List<int> pointers, int? buttons, bool penDetected, bool sessionPenOnlyInput, HideState hideUi
});




}
/// @nodoc
class __$EditorInputStateCopyWithImpl<$Res>
    implements _$EditorInputStateCopyWith<$Res> {
  __$EditorInputStateCopyWithImpl(this._self, this._then);

  final _EditorInputState _self;
  final $Res Function(_EditorInputState) _then;

/// Create a copy of EditorInputState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastPosition = freezed,Object? pointers = null,Object? buttons = freezed,Object? penDetected = null,Object? sessionPenOnlyInput = null,Object? hideUi = null,}) {
  return _then(_EditorInputState(
lastPosition: freezed == lastPosition ? _self.lastPosition : lastPosition // ignore: cast_nullable_to_non_nullable
as Offset?,pointers: null == pointers ? _self._pointers : pointers // ignore: cast_nullable_to_non_nullable
as List<int>,buttons: freezed == buttons ? _self.buttons : buttons // ignore: cast_nullable_to_non_nullable
as int?,penDetected: null == penDetected ? _self.penDetected : penDetected // ignore: cast_nullable_to_non_nullable
as bool,sessionPenOnlyInput: null == sessionPenOnlyInput ? _self.sessionPenOnlyInput : sessionPenOnlyInput // ignore: cast_nullable_to_non_nullable
as bool,hideUi: null == hideUi ? _self.hideUi : hideUi // ignore: cast_nullable_to_non_nullable
as HideState,
  ));
}


}

/// @nodoc
mixin _$DocumentSaveState implements DiagnosticableTreeMixin {

 bool get isSaveDelayed; AssetLocation get location; Embedding? get embedding; SaveState get saved; bool get isCreating;
/// Create a copy of DocumentSaveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentSaveStateCopyWith<DocumentSaveState> get copyWith => _$DocumentSaveStateCopyWithImpl<DocumentSaveState>(this as DocumentSaveState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DocumentSaveState'))
    ..add(DiagnosticsProperty('isSaveDelayed', isSaveDelayed))..add(DiagnosticsProperty('location', location))..add(DiagnosticsProperty('embedding', embedding))..add(DiagnosticsProperty('saved', saved))..add(DiagnosticsProperty('isCreating', isCreating));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentSaveState&&(identical(other.isSaveDelayed, isSaveDelayed) || other.isSaveDelayed == isSaveDelayed)&&(identical(other.location, location) || other.location == location)&&(identical(other.embedding, embedding) || other.embedding == embedding)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating));
}


@override
int get hashCode => Object.hash(runtimeType,isSaveDelayed,location,embedding,saved,isCreating);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DocumentSaveState(isSaveDelayed: $isSaveDelayed, location: $location, embedding: $embedding, saved: $saved, isCreating: $isCreating)';
}


}

/// @nodoc
abstract mixin class $DocumentSaveStateCopyWith<$Res>  {
  factory $DocumentSaveStateCopyWith(DocumentSaveState value, $Res Function(DocumentSaveState) _then) = _$DocumentSaveStateCopyWithImpl;
@useResult
$Res call({
 bool isSaveDelayed, AssetLocation location, Embedding? embedding, SaveState saved, bool isCreating
});




}
/// @nodoc
class _$DocumentSaveStateCopyWithImpl<$Res>
    implements $DocumentSaveStateCopyWith<$Res> {
  _$DocumentSaveStateCopyWithImpl(this._self, this._then);

  final DocumentSaveState _self;
  final $Res Function(DocumentSaveState) _then;

/// Create a copy of DocumentSaveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSaveDelayed = null,Object? location = null,Object? embedding = freezed,Object? saved = null,Object? isCreating = null,}) {
  return _then(_self.copyWith(
isSaveDelayed: null == isSaveDelayed ? _self.isSaveDelayed : isSaveDelayed // ignore: cast_nullable_to_non_nullable
as bool,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as AssetLocation,embedding: freezed == embedding ? _self.embedding : embedding // ignore: cast_nullable_to_non_nullable
as Embedding?,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as SaveState,isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _DocumentSaveState extends DocumentSaveState with DiagnosticableTreeMixin {
  const _DocumentSaveState({this.isSaveDelayed = false, this.location = const AssetLocation(path: ''), this.embedding, this.saved = SaveState.saved, this.isCreating = false}): super._();
  

@override@JsonKey() final  bool isSaveDelayed;
@override@JsonKey() final  AssetLocation location;
@override final  Embedding? embedding;
@override@JsonKey() final  SaveState saved;
@override@JsonKey() final  bool isCreating;

/// Create a copy of DocumentSaveState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentSaveStateCopyWith<_DocumentSaveState> get copyWith => __$DocumentSaveStateCopyWithImpl<_DocumentSaveState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DocumentSaveState'))
    ..add(DiagnosticsProperty('isSaveDelayed', isSaveDelayed))..add(DiagnosticsProperty('location', location))..add(DiagnosticsProperty('embedding', embedding))..add(DiagnosticsProperty('saved', saved))..add(DiagnosticsProperty('isCreating', isCreating));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentSaveState&&(identical(other.isSaveDelayed, isSaveDelayed) || other.isSaveDelayed == isSaveDelayed)&&(identical(other.location, location) || other.location == location)&&(identical(other.embedding, embedding) || other.embedding == embedding)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating));
}


@override
int get hashCode => Object.hash(runtimeType,isSaveDelayed,location,embedding,saved,isCreating);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DocumentSaveState(isSaveDelayed: $isSaveDelayed, location: $location, embedding: $embedding, saved: $saved, isCreating: $isCreating)';
}


}

/// @nodoc
abstract mixin class _$DocumentSaveStateCopyWith<$Res> implements $DocumentSaveStateCopyWith<$Res> {
  factory _$DocumentSaveStateCopyWith(_DocumentSaveState value, $Res Function(_DocumentSaveState) _then) = __$DocumentSaveStateCopyWithImpl;
@override @useResult
$Res call({
 bool isSaveDelayed, AssetLocation location, Embedding? embedding, SaveState saved, bool isCreating
});




}
/// @nodoc
class __$DocumentSaveStateCopyWithImpl<$Res>
    implements _$DocumentSaveStateCopyWith<$Res> {
  __$DocumentSaveStateCopyWithImpl(this._self, this._then);

  final _DocumentSaveState _self;
  final $Res Function(_DocumentSaveState) _then;

/// Create a copy of DocumentSaveState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSaveDelayed = null,Object? location = null,Object? embedding = freezed,Object? saved = null,Object? isCreating = null,}) {
  return _then(_DocumentSaveState(
isSaveDelayed: null == isSaveDelayed ? _self.isSaveDelayed : isSaveDelayed // ignore: cast_nullable_to_non_nullable
as bool,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as AssetLocation,embedding: freezed == embedding ? _self.embedding : embedding // ignore: cast_nullable_to_non_nullable
as Embedding?,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as SaveState,isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$EditorViewState implements DiagnosticableTreeMixin {

 UtilitiesState get utilities; ViewOption get viewOption; bool get areaNavigatorCreate; bool get areaNavigatorExact; bool get areaNavigatorAsk; bool get navigatorEnabled; NavigatorPage get navigatorPage; String get userName;
/// Create a copy of EditorViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditorViewStateCopyWith<EditorViewState> get copyWith => _$EditorViewStateCopyWithImpl<EditorViewState>(this as EditorViewState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EditorViewState'))
    ..add(DiagnosticsProperty('utilities', utilities))..add(DiagnosticsProperty('viewOption', viewOption))..add(DiagnosticsProperty('areaNavigatorCreate', areaNavigatorCreate))..add(DiagnosticsProperty('areaNavigatorExact', areaNavigatorExact))..add(DiagnosticsProperty('areaNavigatorAsk', areaNavigatorAsk))..add(DiagnosticsProperty('navigatorEnabled', navigatorEnabled))..add(DiagnosticsProperty('navigatorPage', navigatorPage))..add(DiagnosticsProperty('userName', userName));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditorViewState&&(identical(other.utilities, utilities) || other.utilities == utilities)&&(identical(other.viewOption, viewOption) || other.viewOption == viewOption)&&(identical(other.areaNavigatorCreate, areaNavigatorCreate) || other.areaNavigatorCreate == areaNavigatorCreate)&&(identical(other.areaNavigatorExact, areaNavigatorExact) || other.areaNavigatorExact == areaNavigatorExact)&&(identical(other.areaNavigatorAsk, areaNavigatorAsk) || other.areaNavigatorAsk == areaNavigatorAsk)&&(identical(other.navigatorEnabled, navigatorEnabled) || other.navigatorEnabled == navigatorEnabled)&&(identical(other.navigatorPage, navigatorPage) || other.navigatorPage == navigatorPage)&&(identical(other.userName, userName) || other.userName == userName));
}


@override
int get hashCode => Object.hash(runtimeType,utilities,viewOption,areaNavigatorCreate,areaNavigatorExact,areaNavigatorAsk,navigatorEnabled,navigatorPage,userName);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EditorViewState(utilities: $utilities, viewOption: $viewOption, areaNavigatorCreate: $areaNavigatorCreate, areaNavigatorExact: $areaNavigatorExact, areaNavigatorAsk: $areaNavigatorAsk, navigatorEnabled: $navigatorEnabled, navigatorPage: $navigatorPage, userName: $userName)';
}


}

/// @nodoc
abstract mixin class $EditorViewStateCopyWith<$Res>  {
  factory $EditorViewStateCopyWith(EditorViewState value, $Res Function(EditorViewState) _then) = _$EditorViewStateCopyWithImpl;
@useResult
$Res call({
 UtilitiesState utilities, ViewOption viewOption, bool areaNavigatorCreate, bool areaNavigatorExact, bool areaNavigatorAsk, bool navigatorEnabled, NavigatorPage navigatorPage, String userName
});


$UtilitiesStateCopyWith<$Res> get utilities;$ViewOptionCopyWith<$Res> get viewOption;

}
/// @nodoc
class _$EditorViewStateCopyWithImpl<$Res>
    implements $EditorViewStateCopyWith<$Res> {
  _$EditorViewStateCopyWithImpl(this._self, this._then);

  final EditorViewState _self;
  final $Res Function(EditorViewState) _then;

/// Create a copy of EditorViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? utilities = null,Object? viewOption = null,Object? areaNavigatorCreate = null,Object? areaNavigatorExact = null,Object? areaNavigatorAsk = null,Object? navigatorEnabled = null,Object? navigatorPage = null,Object? userName = null,}) {
  return _then(_self.copyWith(
utilities: null == utilities ? _self.utilities : utilities // ignore: cast_nullable_to_non_nullable
as UtilitiesState,viewOption: null == viewOption ? _self.viewOption : viewOption // ignore: cast_nullable_to_non_nullable
as ViewOption,areaNavigatorCreate: null == areaNavigatorCreate ? _self.areaNavigatorCreate : areaNavigatorCreate // ignore: cast_nullable_to_non_nullable
as bool,areaNavigatorExact: null == areaNavigatorExact ? _self.areaNavigatorExact : areaNavigatorExact // ignore: cast_nullable_to_non_nullable
as bool,areaNavigatorAsk: null == areaNavigatorAsk ? _self.areaNavigatorAsk : areaNavigatorAsk // ignore: cast_nullable_to_non_nullable
as bool,navigatorEnabled: null == navigatorEnabled ? _self.navigatorEnabled : navigatorEnabled // ignore: cast_nullable_to_non_nullable
as bool,navigatorPage: null == navigatorPage ? _self.navigatorPage : navigatorPage // ignore: cast_nullable_to_non_nullable
as NavigatorPage,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of EditorViewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UtilitiesStateCopyWith<$Res> get utilities {
  
  return $UtilitiesStateCopyWith<$Res>(_self.utilities, (value) {
    return _then(_self.copyWith(utilities: value));
  });
}/// Create a copy of EditorViewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ViewOptionCopyWith<$Res> get viewOption {
  
  return $ViewOptionCopyWith<$Res>(_self.viewOption, (value) {
    return _then(_self.copyWith(viewOption: value));
  });
}
}



/// @nodoc


class _EditorViewState with DiagnosticableTreeMixin implements EditorViewState {
  const _EditorViewState({this.utilities = const UtilitiesState(), this.viewOption = const ViewOption(), this.areaNavigatorCreate = true, this.areaNavigatorExact = true, this.areaNavigatorAsk = false, this.navigatorEnabled = false, this.navigatorPage = NavigatorPage.waypoints, this.userName = ''});
  

@override@JsonKey() final  UtilitiesState utilities;
@override@JsonKey() final  ViewOption viewOption;
@override@JsonKey() final  bool areaNavigatorCreate;
@override@JsonKey() final  bool areaNavigatorExact;
@override@JsonKey() final  bool areaNavigatorAsk;
@override@JsonKey() final  bool navigatorEnabled;
@override@JsonKey() final  NavigatorPage navigatorPage;
@override@JsonKey() final  String userName;

/// Create a copy of EditorViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditorViewStateCopyWith<_EditorViewState> get copyWith => __$EditorViewStateCopyWithImpl<_EditorViewState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'EditorViewState'))
    ..add(DiagnosticsProperty('utilities', utilities))..add(DiagnosticsProperty('viewOption', viewOption))..add(DiagnosticsProperty('areaNavigatorCreate', areaNavigatorCreate))..add(DiagnosticsProperty('areaNavigatorExact', areaNavigatorExact))..add(DiagnosticsProperty('areaNavigatorAsk', areaNavigatorAsk))..add(DiagnosticsProperty('navigatorEnabled', navigatorEnabled))..add(DiagnosticsProperty('navigatorPage', navigatorPage))..add(DiagnosticsProperty('userName', userName));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditorViewState&&(identical(other.utilities, utilities) || other.utilities == utilities)&&(identical(other.viewOption, viewOption) || other.viewOption == viewOption)&&(identical(other.areaNavigatorCreate, areaNavigatorCreate) || other.areaNavigatorCreate == areaNavigatorCreate)&&(identical(other.areaNavigatorExact, areaNavigatorExact) || other.areaNavigatorExact == areaNavigatorExact)&&(identical(other.areaNavigatorAsk, areaNavigatorAsk) || other.areaNavigatorAsk == areaNavigatorAsk)&&(identical(other.navigatorEnabled, navigatorEnabled) || other.navigatorEnabled == navigatorEnabled)&&(identical(other.navigatorPage, navigatorPage) || other.navigatorPage == navigatorPage)&&(identical(other.userName, userName) || other.userName == userName));
}


@override
int get hashCode => Object.hash(runtimeType,utilities,viewOption,areaNavigatorCreate,areaNavigatorExact,areaNavigatorAsk,navigatorEnabled,navigatorPage,userName);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'EditorViewState(utilities: $utilities, viewOption: $viewOption, areaNavigatorCreate: $areaNavigatorCreate, areaNavigatorExact: $areaNavigatorExact, areaNavigatorAsk: $areaNavigatorAsk, navigatorEnabled: $navigatorEnabled, navigatorPage: $navigatorPage, userName: $userName)';
}


}

/// @nodoc
abstract mixin class _$EditorViewStateCopyWith<$Res> implements $EditorViewStateCopyWith<$Res> {
  factory _$EditorViewStateCopyWith(_EditorViewState value, $Res Function(_EditorViewState) _then) = __$EditorViewStateCopyWithImpl;
@override @useResult
$Res call({
 UtilitiesState utilities, ViewOption viewOption, bool areaNavigatorCreate, bool areaNavigatorExact, bool areaNavigatorAsk, bool navigatorEnabled, NavigatorPage navigatorPage, String userName
});


@override $UtilitiesStateCopyWith<$Res> get utilities;@override $ViewOptionCopyWith<$Res> get viewOption;

}
/// @nodoc
class __$EditorViewStateCopyWithImpl<$Res>
    implements _$EditorViewStateCopyWith<$Res> {
  __$EditorViewStateCopyWithImpl(this._self, this._then);

  final _EditorViewState _self;
  final $Res Function(_EditorViewState) _then;

/// Create a copy of EditorViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? utilities = null,Object? viewOption = null,Object? areaNavigatorCreate = null,Object? areaNavigatorExact = null,Object? areaNavigatorAsk = null,Object? navigatorEnabled = null,Object? navigatorPage = null,Object? userName = null,}) {
  return _then(_EditorViewState(
utilities: null == utilities ? _self.utilities : utilities // ignore: cast_nullable_to_non_nullable
as UtilitiesState,viewOption: null == viewOption ? _self.viewOption : viewOption // ignore: cast_nullable_to_non_nullable
as ViewOption,areaNavigatorCreate: null == areaNavigatorCreate ? _self.areaNavigatorCreate : areaNavigatorCreate // ignore: cast_nullable_to_non_nullable
as bool,areaNavigatorExact: null == areaNavigatorExact ? _self.areaNavigatorExact : areaNavigatorExact // ignore: cast_nullable_to_non_nullable
as bool,areaNavigatorAsk: null == areaNavigatorAsk ? _self.areaNavigatorAsk : areaNavigatorAsk // ignore: cast_nullable_to_non_nullable
as bool,navigatorEnabled: null == navigatorEnabled ? _self.navigatorEnabled : navigatorEnabled // ignore: cast_nullable_to_non_nullable
as bool,navigatorPage: null == navigatorPage ? _self.navigatorPage : navigatorPage // ignore: cast_nullable_to_non_nullable
as NavigatorPage,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of EditorViewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UtilitiesStateCopyWith<$Res> get utilities {
  
  return $UtilitiesStateCopyWith<$Res>(_self.utilities, (value) {
    return _then(_self.copyWith(utilities: value));
  });
}/// Create a copy of EditorViewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ViewOptionCopyWith<$Res> get viewOption {
  
  return $ViewOptionCopyWith<$Res>(_self.viewOption, (value) {
    return _then(_self.copyWith(viewOption: value));
  });
}
}

// dart format on
