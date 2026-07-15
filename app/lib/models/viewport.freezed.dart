// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'viewport.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CameraViewport {

 List<Renderer<Background>> get backgrounds; List<Renderer<PadElement>> get bakedElements; List<Renderer<PadElement>> get unbakedElements; List<Renderer<PadElement>> get visibleElements; List<Renderer<PadElement>> get visibleUnbakedElements; double? get width; double? get height; ui.Size? get viewportSize; double get pixelRatio; double get scale; double get x; double get y; RenderResolution get resolution; Map<String, RendererState> get rendererStates; Set<String> get invisibleLayers; ui.Image? get image; ui.Image? get belowLayerImage; ui.Image? get aboveLayerImage;
/// Create a copy of CameraViewport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CameraViewportCopyWith<CameraViewport> get copyWith => _$CameraViewportCopyWithImpl<CameraViewport>(this as CameraViewport, _$identity);





@override
String toString() {
  return 'CameraViewport(backgrounds: $backgrounds, bakedElements: $bakedElements, unbakedElements: $unbakedElements, visibleElements: $visibleElements, visibleUnbakedElements: $visibleUnbakedElements, width: $width, height: $height, viewportSize: $viewportSize, pixelRatio: $pixelRatio, scale: $scale, x: $x, y: $y, resolution: $resolution, rendererStates: $rendererStates, invisibleLayers: $invisibleLayers, image: $image, belowLayerImage: $belowLayerImage, aboveLayerImage: $aboveLayerImage)';
}


}

/// @nodoc
abstract mixin class $CameraViewportCopyWith<$Res>  {
  factory $CameraViewportCopyWith(CameraViewport value, $Res Function(CameraViewport) _then) = _$CameraViewportCopyWithImpl;
@useResult
$Res call({
 List<Renderer<Background>> backgrounds, List<Renderer<PadElement>> bakedElements, List<Renderer<PadElement>> unbakedElements, List<Renderer<PadElement>> visibleElements, List<Renderer<PadElement>> visibleUnbakedElements, double? width, double? height, ui.Size? viewportSize, double pixelRatio, double scale, double x, double y, RenderResolution resolution, Map<String, RendererState> rendererStates, Set<String> invisibleLayers, ui.Image? image, ui.Image? belowLayerImage, ui.Image? aboveLayerImage
});




}
/// @nodoc
class _$CameraViewportCopyWithImpl<$Res>
    implements $CameraViewportCopyWith<$Res> {
  _$CameraViewportCopyWithImpl(this._self, this._then);

  final CameraViewport _self;
  final $Res Function(CameraViewport) _then;

/// Create a copy of CameraViewport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backgrounds = null,Object? bakedElements = null,Object? unbakedElements = null,Object? visibleElements = null,Object? visibleUnbakedElements = null,Object? width = freezed,Object? height = freezed,Object? viewportSize = freezed,Object? pixelRatio = null,Object? scale = null,Object? x = null,Object? y = null,Object? resolution = null,Object? rendererStates = null,Object? invisibleLayers = null,Object? image = freezed,Object? belowLayerImage = freezed,Object? aboveLayerImage = freezed,}) {
  return _then(_self.copyWith(
backgrounds: null == backgrounds ? _self.backgrounds : backgrounds // ignore: cast_nullable_to_non_nullable
as List<Renderer<Background>>,bakedElements: null == bakedElements ? _self.bakedElements : bakedElements // ignore: cast_nullable_to_non_nullable
as List<Renderer<PadElement>>,unbakedElements: null == unbakedElements ? _self.unbakedElements : unbakedElements // ignore: cast_nullable_to_non_nullable
as List<Renderer<PadElement>>,visibleElements: null == visibleElements ? _self.visibleElements : visibleElements // ignore: cast_nullable_to_non_nullable
as List<Renderer<PadElement>>,visibleUnbakedElements: null == visibleUnbakedElements ? _self.visibleUnbakedElements : visibleUnbakedElements // ignore: cast_nullable_to_non_nullable
as List<Renderer<PadElement>>,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,viewportSize: freezed == viewportSize ? _self.viewportSize : viewportSize // ignore: cast_nullable_to_non_nullable
as ui.Size?,pixelRatio: null == pixelRatio ? _self.pixelRatio : pixelRatio // ignore: cast_nullable_to_non_nullable
as double,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,resolution: null == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as RenderResolution,rendererStates: null == rendererStates ? _self.rendererStates : rendererStates // ignore: cast_nullable_to_non_nullable
as Map<String, RendererState>,invisibleLayers: null == invisibleLayers ? _self.invisibleLayers : invisibleLayers // ignore: cast_nullable_to_non_nullable
as Set<String>,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as ui.Image?,belowLayerImage: freezed == belowLayerImage ? _self.belowLayerImage : belowLayerImage // ignore: cast_nullable_to_non_nullable
as ui.Image?,aboveLayerImage: freezed == aboveLayerImage ? _self.aboveLayerImage : aboveLayerImage // ignore: cast_nullable_to_non_nullable
as ui.Image?,
  ));
}

}



/// @nodoc


class CameraViewportUnbaked extends CameraViewport {
  const CameraViewportUnbaked({final  List<Renderer<Background>> backgrounds = const [], final  List<Renderer<PadElement>> bakedElements = const [], final  List<Renderer<PadElement>> unbakedElements = const [], final  List<Renderer<PadElement>> visibleElements = const [], final  List<Renderer<PadElement>> visibleUnbakedElements = const [], this.width, this.height, this.viewportSize, this.pixelRatio = 1, this.scale = 1, this.x = 0, this.y = 0, this.resolution = RenderResolution.performance, final  Map<String, RendererState> rendererStates = const {}, final  Set<String> invisibleLayers = const {}, this.image = null, this.belowLayerImage = null, this.aboveLayerImage = null}): _backgrounds = backgrounds,_bakedElements = bakedElements,_unbakedElements = unbakedElements,_visibleElements = visibleElements,_visibleUnbakedElements = visibleUnbakedElements,_rendererStates = rendererStates,_invisibleLayers = invisibleLayers,super._();
  

 final  List<Renderer<Background>> _backgrounds;
@override@JsonKey() List<Renderer<Background>> get backgrounds {
  if (_backgrounds is EqualUnmodifiableListView) return _backgrounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_backgrounds);
}

 final  List<Renderer<PadElement>> _bakedElements;
@override@JsonKey() List<Renderer<PadElement>> get bakedElements {
  if (_bakedElements is EqualUnmodifiableListView) return _bakedElements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bakedElements);
}

 final  List<Renderer<PadElement>> _unbakedElements;
@override@JsonKey() List<Renderer<PadElement>> get unbakedElements {
  if (_unbakedElements is EqualUnmodifiableListView) return _unbakedElements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unbakedElements);
}

 final  List<Renderer<PadElement>> _visibleElements;
@override@JsonKey() List<Renderer<PadElement>> get visibleElements {
  if (_visibleElements is EqualUnmodifiableListView) return _visibleElements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visibleElements);
}

 final  List<Renderer<PadElement>> _visibleUnbakedElements;
@override@JsonKey() List<Renderer<PadElement>> get visibleUnbakedElements {
  if (_visibleUnbakedElements is EqualUnmodifiableListView) return _visibleUnbakedElements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visibleUnbakedElements);
}

@override final  double? width;
@override final  double? height;
@override final  ui.Size? viewportSize;
@override@JsonKey() final  double pixelRatio;
@override@JsonKey() final  double scale;
@override@JsonKey() final  double x;
@override@JsonKey() final  double y;
@override@JsonKey() final  RenderResolution resolution;
 final  Map<String, RendererState> _rendererStates;
@override@JsonKey() Map<String, RendererState> get rendererStates {
  if (_rendererStates is EqualUnmodifiableMapView) return _rendererStates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rendererStates);
}

 final  Set<String> _invisibleLayers;
@override@JsonKey() Set<String> get invisibleLayers {
  if (_invisibleLayers is EqualUnmodifiableSetView) return _invisibleLayers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_invisibleLayers);
}

@override@JsonKey() final  ui.Image? image;
@override@JsonKey() final  ui.Image? belowLayerImage;
@override@JsonKey() final  ui.Image? aboveLayerImage;

/// Create a copy of CameraViewport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CameraViewportUnbakedCopyWith<CameraViewportUnbaked> get copyWith => _$CameraViewportUnbakedCopyWithImpl<CameraViewportUnbaked>(this, _$identity);





@override
String toString() {
  return 'CameraViewport.unbaked(backgrounds: $backgrounds, bakedElements: $bakedElements, unbakedElements: $unbakedElements, visibleElements: $visibleElements, visibleUnbakedElements: $visibleUnbakedElements, width: $width, height: $height, viewportSize: $viewportSize, pixelRatio: $pixelRatio, scale: $scale, x: $x, y: $y, resolution: $resolution, rendererStates: $rendererStates, invisibleLayers: $invisibleLayers, image: $image, belowLayerImage: $belowLayerImage, aboveLayerImage: $aboveLayerImage)';
}


}

/// @nodoc
abstract mixin class $CameraViewportUnbakedCopyWith<$Res> implements $CameraViewportCopyWith<$Res> {
  factory $CameraViewportUnbakedCopyWith(CameraViewportUnbaked value, $Res Function(CameraViewportUnbaked) _then) = _$CameraViewportUnbakedCopyWithImpl;
@override @useResult
$Res call({
 List<Renderer<Background>> backgrounds, List<Renderer<PadElement>> bakedElements, List<Renderer<PadElement>> unbakedElements, List<Renderer<PadElement>> visibleElements, List<Renderer<PadElement>> visibleUnbakedElements, double? width, double? height, ui.Size? viewportSize, double pixelRatio, double scale, double x, double y, RenderResolution resolution, Map<String, RendererState> rendererStates, Set<String> invisibleLayers, ui.Image? image, ui.Image? belowLayerImage, ui.Image? aboveLayerImage
});




}
/// @nodoc
class _$CameraViewportUnbakedCopyWithImpl<$Res>
    implements $CameraViewportUnbakedCopyWith<$Res> {
  _$CameraViewportUnbakedCopyWithImpl(this._self, this._then);

  final CameraViewportUnbaked _self;
  final $Res Function(CameraViewportUnbaked) _then;

/// Create a copy of CameraViewport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? backgrounds = null,Object? bakedElements = null,Object? unbakedElements = null,Object? visibleElements = null,Object? visibleUnbakedElements = null,Object? width = freezed,Object? height = freezed,Object? viewportSize = freezed,Object? pixelRatio = null,Object? scale = null,Object? x = null,Object? y = null,Object? resolution = null,Object? rendererStates = null,Object? invisibleLayers = null,Object? image = freezed,Object? belowLayerImage = freezed,Object? aboveLayerImage = freezed,}) {
  return _then(CameraViewportUnbaked(
backgrounds: null == backgrounds ? _self._backgrounds : backgrounds // ignore: cast_nullable_to_non_nullable
as List<Renderer<Background>>,bakedElements: null == bakedElements ? _self._bakedElements : bakedElements // ignore: cast_nullable_to_non_nullable
as List<Renderer<PadElement>>,unbakedElements: null == unbakedElements ? _self._unbakedElements : unbakedElements // ignore: cast_nullable_to_non_nullable
as List<Renderer<PadElement>>,visibleElements: null == visibleElements ? _self._visibleElements : visibleElements // ignore: cast_nullable_to_non_nullable
as List<Renderer<PadElement>>,visibleUnbakedElements: null == visibleUnbakedElements ? _self._visibleUnbakedElements : visibleUnbakedElements // ignore: cast_nullable_to_non_nullable
as List<Renderer<PadElement>>,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,viewportSize: freezed == viewportSize ? _self.viewportSize : viewportSize // ignore: cast_nullable_to_non_nullable
as ui.Size?,pixelRatio: null == pixelRatio ? _self.pixelRatio : pixelRatio // ignore: cast_nullable_to_non_nullable
as double,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,resolution: null == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as RenderResolution,rendererStates: null == rendererStates ? _self._rendererStates : rendererStates // ignore: cast_nullable_to_non_nullable
as Map<String, RendererState>,invisibleLayers: null == invisibleLayers ? _self._invisibleLayers : invisibleLayers // ignore: cast_nullable_to_non_nullable
as Set<String>,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as ui.Image?,belowLayerImage: freezed == belowLayerImage ? _self.belowLayerImage : belowLayerImage // ignore: cast_nullable_to_non_nullable
as ui.Image?,aboveLayerImage: freezed == aboveLayerImage ? _self.aboveLayerImage : aboveLayerImage // ignore: cast_nullable_to_non_nullable
as ui.Image?,
  ));
}


}

/// @nodoc


class CameraViewportBaked extends CameraViewport {
  const CameraViewportBaked({final  List<Renderer<Background>> backgrounds = const [], this.image, this.belowLayerImage, this.aboveLayerImage, required this.width, required this.height, this.viewportSize, required this.pixelRatio, final  List<Renderer<PadElement>> bakedElements = const [], final  List<Renderer<PadElement>> unbakedElements = const [], required final  List<Renderer<PadElement>> visibleElements, required final  List<Renderer<PadElement>> visibleUnbakedElements, this.scale = 1, this.x = 0, required this.resolution, this.y = 0, final  Map<String, RendererState> rendererStates = const {}, final  Set<String> invisibleLayers = const {}}): _backgrounds = backgrounds,_bakedElements = bakedElements,_unbakedElements = unbakedElements,_visibleElements = visibleElements,_visibleUnbakedElements = visibleUnbakedElements,_rendererStates = rendererStates,_invisibleLayers = invisibleLayers,super._();
  

 final  List<Renderer<Background>> _backgrounds;
@override@JsonKey() List<Renderer<Background>> get backgrounds {
  if (_backgrounds is EqualUnmodifiableListView) return _backgrounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_backgrounds);
}

@override final  ui.Image? image;
@override final  ui.Image? belowLayerImage;
@override final  ui.Image? aboveLayerImage;
@override final  double? width;
@override final  double? height;
@override final  ui.Size? viewportSize;
@override final  double pixelRatio;
 final  List<Renderer<PadElement>> _bakedElements;
@override@JsonKey() List<Renderer<PadElement>> get bakedElements {
  if (_bakedElements is EqualUnmodifiableListView) return _bakedElements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bakedElements);
}

 final  List<Renderer<PadElement>> _unbakedElements;
@override@JsonKey() List<Renderer<PadElement>> get unbakedElements {
  if (_unbakedElements is EqualUnmodifiableListView) return _unbakedElements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unbakedElements);
}

 final  List<Renderer<PadElement>> _visibleElements;
@override List<Renderer<PadElement>> get visibleElements {
  if (_visibleElements is EqualUnmodifiableListView) return _visibleElements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visibleElements);
}

 final  List<Renderer<PadElement>> _visibleUnbakedElements;
@override List<Renderer<PadElement>> get visibleUnbakedElements {
  if (_visibleUnbakedElements is EqualUnmodifiableListView) return _visibleUnbakedElements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visibleUnbakedElements);
}

@override@JsonKey() final  double scale;
@override@JsonKey() final  double x;
@override final  RenderResolution resolution;
@override@JsonKey() final  double y;
 final  Map<String, RendererState> _rendererStates;
@override@JsonKey() Map<String, RendererState> get rendererStates {
  if (_rendererStates is EqualUnmodifiableMapView) return _rendererStates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rendererStates);
}

 final  Set<String> _invisibleLayers;
@override@JsonKey() Set<String> get invisibleLayers {
  if (_invisibleLayers is EqualUnmodifiableSetView) return _invisibleLayers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_invisibleLayers);
}


/// Create a copy of CameraViewport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CameraViewportBakedCopyWith<CameraViewportBaked> get copyWith => _$CameraViewportBakedCopyWithImpl<CameraViewportBaked>(this, _$identity);





@override
String toString() {
  return 'CameraViewport.baked(backgrounds: $backgrounds, image: $image, belowLayerImage: $belowLayerImage, aboveLayerImage: $aboveLayerImage, width: $width, height: $height, viewportSize: $viewportSize, pixelRatio: $pixelRatio, bakedElements: $bakedElements, unbakedElements: $unbakedElements, visibleElements: $visibleElements, visibleUnbakedElements: $visibleUnbakedElements, scale: $scale, x: $x, resolution: $resolution, y: $y, rendererStates: $rendererStates, invisibleLayers: $invisibleLayers)';
}


}

/// @nodoc
abstract mixin class $CameraViewportBakedCopyWith<$Res> implements $CameraViewportCopyWith<$Res> {
  factory $CameraViewportBakedCopyWith(CameraViewportBaked value, $Res Function(CameraViewportBaked) _then) = _$CameraViewportBakedCopyWithImpl;
@override @useResult
$Res call({
 List<Renderer<Background>> backgrounds, ui.Image? image, ui.Image? belowLayerImage, ui.Image? aboveLayerImage, double? width, double? height, ui.Size? viewportSize, double pixelRatio, List<Renderer<PadElement>> bakedElements, List<Renderer<PadElement>> unbakedElements, List<Renderer<PadElement>> visibleElements, List<Renderer<PadElement>> visibleUnbakedElements, double scale, double x, RenderResolution resolution, double y, Map<String, RendererState> rendererStates, Set<String> invisibleLayers
});




}
/// @nodoc
class _$CameraViewportBakedCopyWithImpl<$Res>
    implements $CameraViewportBakedCopyWith<$Res> {
  _$CameraViewportBakedCopyWithImpl(this._self, this._then);

  final CameraViewportBaked _self;
  final $Res Function(CameraViewportBaked) _then;

/// Create a copy of CameraViewport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? backgrounds = null,Object? image = freezed,Object? belowLayerImage = freezed,Object? aboveLayerImage = freezed,Object? width = freezed,Object? height = freezed,Object? viewportSize = freezed,Object? pixelRatio = null,Object? bakedElements = null,Object? unbakedElements = null,Object? visibleElements = null,Object? visibleUnbakedElements = null,Object? scale = null,Object? x = null,Object? resolution = null,Object? y = null,Object? rendererStates = null,Object? invisibleLayers = null,}) {
  return _then(CameraViewportBaked(
backgrounds: null == backgrounds ? _self._backgrounds : backgrounds // ignore: cast_nullable_to_non_nullable
as List<Renderer<Background>>,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as ui.Image?,belowLayerImage: freezed == belowLayerImage ? _self.belowLayerImage : belowLayerImage // ignore: cast_nullable_to_non_nullable
as ui.Image?,aboveLayerImage: freezed == aboveLayerImage ? _self.aboveLayerImage : aboveLayerImage // ignore: cast_nullable_to_non_nullable
as ui.Image?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,viewportSize: freezed == viewportSize ? _self.viewportSize : viewportSize // ignore: cast_nullable_to_non_nullable
as ui.Size?,pixelRatio: null == pixelRatio ? _self.pixelRatio : pixelRatio // ignore: cast_nullable_to_non_nullable
as double,bakedElements: null == bakedElements ? _self._bakedElements : bakedElements // ignore: cast_nullable_to_non_nullable
as List<Renderer<PadElement>>,unbakedElements: null == unbakedElements ? _self._unbakedElements : unbakedElements // ignore: cast_nullable_to_non_nullable
as List<Renderer<PadElement>>,visibleElements: null == visibleElements ? _self._visibleElements : visibleElements // ignore: cast_nullable_to_non_nullable
as List<Renderer<PadElement>>,visibleUnbakedElements: null == visibleUnbakedElements ? _self._visibleUnbakedElements : visibleUnbakedElements // ignore: cast_nullable_to_non_nullable
as List<Renderer<PadElement>>,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,resolution: null == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as RenderResolution,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,rendererStates: null == rendererStates ? _self._rendererStates : rendererStates // ignore: cast_nullable_to_non_nullable
as Map<String, RendererState>,invisibleLayers: null == invisibleLayers ? _self._invisibleLayers : invisibleLayers // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
