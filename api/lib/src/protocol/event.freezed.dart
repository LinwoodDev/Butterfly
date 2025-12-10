// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageAddedDetails {

 int? get index; DocumentPage? get page; bool get addNumber; String get name;
/// Create a copy of PageAddedDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageAddedDetailsCopyWith<PageAddedDetails> get copyWith => _$PageAddedDetailsCopyWithImpl<PageAddedDetails>(this as PageAddedDetails, _$identity);

  /// Serializes this PageAddedDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageAddedDetails&&(identical(other.index, index) || other.index == index)&&(identical(other.page, page) || other.page == page)&&(identical(other.addNumber, addNumber) || other.addNumber == addNumber)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,page,addNumber,name);

@override
String toString() {
  return 'PageAddedDetails(index: $index, page: $page, addNumber: $addNumber, name: $name)';
}


}

/// @nodoc
abstract mixin class $PageAddedDetailsCopyWith<$Res>  {
  factory $PageAddedDetailsCopyWith(PageAddedDetails value, $Res Function(PageAddedDetails) _then) = _$PageAddedDetailsCopyWithImpl;
@useResult
$Res call({
 int? index, DocumentPage? page, bool addNumber, String name
});


$DocumentPageCopyWith<$Res>? get page;

}
/// @nodoc
class _$PageAddedDetailsCopyWithImpl<$Res>
    implements $PageAddedDetailsCopyWith<$Res> {
  _$PageAddedDetailsCopyWithImpl(this._self, this._then);

  final PageAddedDetails _self;
  final $Res Function(PageAddedDetails) _then;

/// Create a copy of PageAddedDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = freezed,Object? page = freezed,Object? addNumber = null,Object? name = null,}) {
  return _then(_self.copyWith(
index: freezed == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as DocumentPage?,addNumber: null == addNumber ? _self.addNumber : addNumber // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of PageAddedDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DocumentPageCopyWith<$Res>? get page {
    if (_self.page == null) {
    return null;
  }

  return $DocumentPageCopyWith<$Res>(_self.page!, (value) {
    return _then(_self.copyWith(page: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _PageAddedDetails implements PageAddedDetails {
  const _PageAddedDetails({this.index, this.page, this.addNumber = true, this.name = ''});
  factory _PageAddedDetails.fromJson(Map<String, dynamic> json) => _$PageAddedDetailsFromJson(json);

@override final  int? index;
@override final  DocumentPage? page;
@override@JsonKey() final  bool addNumber;
@override@JsonKey() final  String name;

/// Create a copy of PageAddedDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageAddedDetailsCopyWith<_PageAddedDetails> get copyWith => __$PageAddedDetailsCopyWithImpl<_PageAddedDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageAddedDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageAddedDetails&&(identical(other.index, index) || other.index == index)&&(identical(other.page, page) || other.page == page)&&(identical(other.addNumber, addNumber) || other.addNumber == addNumber)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,page,addNumber,name);

@override
String toString() {
  return 'PageAddedDetails(index: $index, page: $page, addNumber: $addNumber, name: $name)';
}


}

/// @nodoc
abstract mixin class _$PageAddedDetailsCopyWith<$Res> implements $PageAddedDetailsCopyWith<$Res> {
  factory _$PageAddedDetailsCopyWith(_PageAddedDetails value, $Res Function(_PageAddedDetails) _then) = __$PageAddedDetailsCopyWithImpl;
@override @useResult
$Res call({
 int? index, DocumentPage? page, bool addNumber, String name
});


@override $DocumentPageCopyWith<$Res>? get page;

}
/// @nodoc
class __$PageAddedDetailsCopyWithImpl<$Res>
    implements _$PageAddedDetailsCopyWith<$Res> {
  __$PageAddedDetailsCopyWithImpl(this._self, this._then);

  final _PageAddedDetails _self;
  final $Res Function(_PageAddedDetails) _then;

/// Create a copy of PageAddedDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = freezed,Object? page = freezed,Object? addNumber = null,Object? name = null,}) {
  return _then(_PageAddedDetails(
index: freezed == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as DocumentPage?,addNumber: null == addNumber ? _self.addNumber : addNumber // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of PageAddedDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DocumentPageCopyWith<$Res>? get page {
    if (_self.page == null) {
    return null;
  }

  return $DocumentPageCopyWith<$Res>(_self.page!, (value) {
    return _then(_self.copyWith(page: value));
  });
}
}

DocumentEvent _$DocumentEventFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'pagesAdded':
          return PagesAdded.fromJson(
            json
          );
                case 'pageChanged':
          return PageChanged.fromJson(
            json
          );
                case 'pageReordered':
          return PageReordered.fromJson(
            json
          );
                case 'pageRenamed':
          return PageRenamed.fromJson(
            json
          );
                case 'pageRemoved':
          return PageRemoved.fromJson(
            json
          );
                case 'thumbnailCaptured':
          return ThumbnailCaptured.fromJson(
            json
          );
                case 'viewChanged':
          return ViewChanged.fromJson(
            json
          );
                case 'utilitiesChanged':
          return UtilitiesChanged.fromJson(
            json
          );
                case 'elementsCreated':
          return ElementsCreated.fromJson(
            json
          );
                case 'elementsChanged':
          return ElementsChanged.fromJson(
            json
          );
                case 'elementsRemoved':
          return ElementsRemoved.fromJson(
            json
          );
                case 'elementsArranged':
          return ElementsArranged.fromJson(
            json
          );
                case 'documentDescriptionChanged':
          return DocumentDescriptionChanged.fromJson(
            json
          );
                case 'documentSaved':
          return DocumentSaved.fromJson(
            json
          );
                case 'toolCreated':
          return ToolCreated.fromJson(
            json
          );
                case 'toolsChanged':
          return ToolsChanged.fromJson(
            json
          );
                case 'toolsRemoved':
          return ToolsRemoved.fromJson(
            json
          );
                case 'toolsReplaced':
          return ToolsReplaced.fromJson(
            json
          );
                case 'toolReordered':
          return ToolReordered.fromJson(
            json
          );
                case 'documentBackgroundsChanged':
          return DocumentBackgroundsChanged.fromJson(
            json
          );
                case 'waypointCreated':
          return WaypointCreated.fromJson(
            json
          );
                case 'waypointChanged':
          return WaypointChanged.fromJson(
            json
          );
                case 'waypointRemoved':
          return WaypointRemoved.fromJson(
            json
          );
                case 'waypointReordered':
          return WaypointReordered.fromJson(
            json
          );
                case 'collectionRenamed':
          return CollectionRenamed.fromJson(
            json
          );
                case 'collectionElementsRemoved':
          return CollectionElementsRemoved.fromJson(
            json
          );
                case 'currentCollectionChanged':
          return CurrentCollectionChanged.fromJson(
            json
          );
                case 'currentLayerChanged':
          return CurrentLayerChanged.fromJson(
            json
          );
                case 'layerCreated':
          return LayerCreated.fromJson(
            json
          );
                case 'layerChanged':
          return LayerChanged.fromJson(
            json
          );
                case 'layerRemoved':
          return LayerRemoved.fromJson(
            json
          );
                case 'layersMerged':
          return LayersMerged.fromJson(
            json
          );
                case 'layerOrderChanged':
          return LayerOrderChanged.fromJson(
            json
          );
                case 'layerVisibilityChanged':
          return LayerVisibilityChanged.fromJson(
            json
          );
                case 'elementsCollectionChanged':
          return ElementsCollectionChanged.fromJson(
            json
          );
                case 'areasCreated':
          return AreasCreated.fromJson(
            json
          );
                case 'areasRemoved':
          return AreasRemoved.fromJson(
            json
          );
                case 'areaChanged':
          return AreaChanged.fromJson(
            json
          );
                case 'areaReordered':
          return AreaReordered.fromJson(
            json
          );
                case 'currentAreaChanged':
          return CurrentAreaChanged.fromJson(
            json
          );
                case 'exportPresetCreated':
          return ExportPresetCreated.fromJson(
            json
          );
                case 'exportPresetUpdated':
          return ExportPresetUpdated.fromJson(
            json
          );
                case 'exportPresetRemoved':
          return ExportPresetRemoved.fromJson(
            json
          );
                case 'packAdded':
          return PackAdded.fromJson(
            json
          );
                case 'packUpdated':
          return PackUpdated.fromJson(
            json
          );
                case 'packRemoved':
          return PackRemoved.fromJson(
            json
          );
                case 'animationAdded':
          return AnimationAdded.fromJson(
            json
          );
                case 'animationUpdated':
          return AnimationUpdated.fromJson(
            json
          );
                case 'animationRemoved':
          return AnimationRemoved.fromJson(
            json
          );
                case 'presentationModeEntered':
          return PresentationModeEntered.fromJson(
            json
          );
                case 'presentationModeExited':
          return PresentationModeExited.fromJson(
            json
          );
                case 'presentationTick':
          return PresentationTick.fromJson(
            json
          );
                case 'assetUpdated':
          return AssetUpdated.fromJson(
            json
          );
                case 'elementsLayerConverted':
          return ElementsLayerConverted.fromJson(
            json
          );
                case 'encryptionChanged':
          return EncryptionChanged.fromJson(
            json
          );
                case 'documentRebuilt':
          return DocumentRebuilt.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'DocumentEvent',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$DocumentEvent {



  /// Serializes this DocumentEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentEvent);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DocumentEvent()';
}


}

/// @nodoc
class $DocumentEventCopyWith<$Res>  {
$DocumentEventCopyWith(DocumentEvent _, $Res Function(DocumentEvent) __);
}



/// @nodoc
@JsonSerializable()

class PagesAdded extends DocumentEvent {
  const PagesAdded(final  List<PageAddedDetails> pages, {final  String? $type}): _pages = pages,$type = $type ?? 'pagesAdded',super._();
  factory PagesAdded.fromJson(Map<String, dynamic> json) => _$PagesAddedFromJson(json);

 final  List<PageAddedDetails> _pages;
 List<PageAddedDetails> get pages {
  if (_pages is EqualUnmodifiableListView) return _pages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pages);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagesAddedCopyWith<PagesAdded> get copyWith => _$PagesAddedCopyWithImpl<PagesAdded>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PagesAddedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PagesAdded&&const DeepCollectionEquality().equals(other._pages, _pages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_pages));

@override
String toString() {
  return 'DocumentEvent.pagesAdded(pages: $pages)';
}


}

/// @nodoc
abstract mixin class $PagesAddedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $PagesAddedCopyWith(PagesAdded value, $Res Function(PagesAdded) _then) = _$PagesAddedCopyWithImpl;
@useResult
$Res call({
 List<PageAddedDetails> pages
});




}
/// @nodoc
class _$PagesAddedCopyWithImpl<$Res>
    implements $PagesAddedCopyWith<$Res> {
  _$PagesAddedCopyWithImpl(this._self, this._then);

  final PagesAdded _self;
  final $Res Function(PagesAdded) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pages = null,}) {
  return _then(PagesAdded(
null == pages ? _self._pages : pages // ignore: cast_nullable_to_non_nullable
as List<PageAddedDetails>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PageChanged extends DocumentEvent {
  const PageChanged(this.pageName, {final  String? $type}): $type = $type ?? 'pageChanged',super._();
  factory PageChanged.fromJson(Map<String, dynamic> json) => _$PageChangedFromJson(json);

 final  String pageName;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageChangedCopyWith<PageChanged> get copyWith => _$PageChangedCopyWithImpl<PageChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageChanged&&(identical(other.pageName, pageName) || other.pageName == pageName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pageName);

@override
String toString() {
  return 'DocumentEvent.pageChanged(pageName: $pageName)';
}


}

/// @nodoc
abstract mixin class $PageChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $PageChangedCopyWith(PageChanged value, $Res Function(PageChanged) _then) = _$PageChangedCopyWithImpl;
@useResult
$Res call({
 String pageName
});




}
/// @nodoc
class _$PageChangedCopyWithImpl<$Res>
    implements $PageChangedCopyWith<$Res> {
  _$PageChangedCopyWithImpl(this._self, this._then);

  final PageChanged _self;
  final $Res Function(PageChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pageName = null,}) {
  return _then(PageChanged(
null == pageName ? _self.pageName : pageName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PageReordered extends DocumentEvent {
  const PageReordered(this.page, [this.newIndex, final  String? $type]): $type = $type ?? 'pageReordered',super._();
  factory PageReordered.fromJson(Map<String, dynamic> json) => _$PageReorderedFromJson(json);

 final  String page;
 final  int? newIndex;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageReorderedCopyWith<PageReordered> get copyWith => _$PageReorderedCopyWithImpl<PageReordered>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageReorderedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageReordered&&(identical(other.page, page) || other.page == page)&&(identical(other.newIndex, newIndex) || other.newIndex == newIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,newIndex);

@override
String toString() {
  return 'DocumentEvent.pageReordered(page: $page, newIndex: $newIndex)';
}


}

/// @nodoc
abstract mixin class $PageReorderedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $PageReorderedCopyWith(PageReordered value, $Res Function(PageReordered) _then) = _$PageReorderedCopyWithImpl;
@useResult
$Res call({
 String page, int? newIndex
});




}
/// @nodoc
class _$PageReorderedCopyWithImpl<$Res>
    implements $PageReorderedCopyWith<$Res> {
  _$PageReorderedCopyWithImpl(this._self, this._then);

  final PageReordered _self;
  final $Res Function(PageReordered) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,Object? newIndex = freezed,}) {
  return _then(PageReordered(
null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as String,freezed == newIndex ? _self.newIndex : newIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PageRenamed extends DocumentEvent {
  const PageRenamed(this.oldName, this.newName, {final  String? $type}): $type = $type ?? 'pageRenamed',super._();
  factory PageRenamed.fromJson(Map<String, dynamic> json) => _$PageRenamedFromJson(json);

 final  String oldName;
 final  String newName;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageRenamedCopyWith<PageRenamed> get copyWith => _$PageRenamedCopyWithImpl<PageRenamed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageRenamedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageRenamed&&(identical(other.oldName, oldName) || other.oldName == oldName)&&(identical(other.newName, newName) || other.newName == newName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oldName,newName);

@override
String toString() {
  return 'DocumentEvent.pageRenamed(oldName: $oldName, newName: $newName)';
}


}

/// @nodoc
abstract mixin class $PageRenamedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $PageRenamedCopyWith(PageRenamed value, $Res Function(PageRenamed) _then) = _$PageRenamedCopyWithImpl;
@useResult
$Res call({
 String oldName, String newName
});




}
/// @nodoc
class _$PageRenamedCopyWithImpl<$Res>
    implements $PageRenamedCopyWith<$Res> {
  _$PageRenamedCopyWithImpl(this._self, this._then);

  final PageRenamed _self;
  final $Res Function(PageRenamed) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldName = null,Object? newName = null,}) {
  return _then(PageRenamed(
null == oldName ? _self.oldName : oldName // ignore: cast_nullable_to_non_nullable
as String,null == newName ? _self.newName : newName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PageRemoved extends DocumentEvent {
  const PageRemoved(this.page, {final  String? $type}): $type = $type ?? 'pageRemoved',super._();
  factory PageRemoved.fromJson(Map<String, dynamic> json) => _$PageRemovedFromJson(json);

 final  String page;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageRemovedCopyWith<PageRemoved> get copyWith => _$PageRemovedCopyWithImpl<PageRemoved>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageRemovedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageRemoved&&(identical(other.page, page) || other.page == page));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page);

@override
String toString() {
  return 'DocumentEvent.pageRemoved(page: $page)';
}


}

/// @nodoc
abstract mixin class $PageRemovedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $PageRemovedCopyWith(PageRemoved value, $Res Function(PageRemoved) _then) = _$PageRemovedCopyWithImpl;
@useResult
$Res call({
 String page
});




}
/// @nodoc
class _$PageRemovedCopyWithImpl<$Res>
    implements $PageRemovedCopyWith<$Res> {
  _$PageRemovedCopyWithImpl(this._self, this._then);

  final PageRemoved _self;
  final $Res Function(PageRemoved) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,}) {
  return _then(PageRemoved(
null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ThumbnailCaptured extends DocumentEvent {
  const ThumbnailCaptured(@Uint8ListJsonConverter() this.data, {final  String? $type}): $type = $type ?? 'thumbnailCaptured',super._();
  factory ThumbnailCaptured.fromJson(Map<String, dynamic> json) => _$ThumbnailCapturedFromJson(json);

@Uint8ListJsonConverter() final  Uint8List data;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThumbnailCapturedCopyWith<ThumbnailCaptured> get copyWith => _$ThumbnailCapturedCopyWithImpl<ThumbnailCaptured>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ThumbnailCapturedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThumbnailCaptured&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'DocumentEvent.thumbnailCaptured(data: $data)';
}


}

/// @nodoc
abstract mixin class $ThumbnailCapturedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ThumbnailCapturedCopyWith(ThumbnailCaptured value, $Res Function(ThumbnailCaptured) _then) = _$ThumbnailCapturedCopyWithImpl;
@useResult
$Res call({
@Uint8ListJsonConverter() Uint8List data
});




}
/// @nodoc
class _$ThumbnailCapturedCopyWithImpl<$Res>
    implements $ThumbnailCapturedCopyWith<$Res> {
  _$ThumbnailCapturedCopyWithImpl(this._self, this._then);

  final ThumbnailCaptured _self;
  final $Res Function(ThumbnailCaptured) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(ThumbnailCaptured(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ViewChanged extends DocumentEvent {
  const ViewChanged(this.view, {final  String? $type}): $type = $type ?? 'viewChanged',super._();
  factory ViewChanged.fromJson(Map<String, dynamic> json) => _$ViewChangedFromJson(json);

 final  ViewOption view;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ViewChangedCopyWith<ViewChanged> get copyWith => _$ViewChangedCopyWithImpl<ViewChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ViewChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ViewChanged&&(identical(other.view, view) || other.view == view));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,view);

@override
String toString() {
  return 'DocumentEvent.viewChanged(view: $view)';
}


}

/// @nodoc
abstract mixin class $ViewChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ViewChangedCopyWith(ViewChanged value, $Res Function(ViewChanged) _then) = _$ViewChangedCopyWithImpl;
@useResult
$Res call({
 ViewOption view
});


$ViewOptionCopyWith<$Res> get view;

}
/// @nodoc
class _$ViewChangedCopyWithImpl<$Res>
    implements $ViewChangedCopyWith<$Res> {
  _$ViewChangedCopyWithImpl(this._self, this._then);

  final ViewChanged _self;
  final $Res Function(ViewChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? view = null,}) {
  return _then(ViewChanged(
null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as ViewOption,
  ));
}

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ViewOptionCopyWith<$Res> get view {
  
  return $ViewOptionCopyWith<$Res>(_self.view, (value) {
    return _then(_self.copyWith(view: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class UtilitiesChanged extends DocumentEvent {
  const UtilitiesChanged(this.state, {final  String? $type}): $type = $type ?? 'utilitiesChanged',super._();
  factory UtilitiesChanged.fromJson(Map<String, dynamic> json) => _$UtilitiesChangedFromJson(json);

 final  UtilitiesState state;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UtilitiesChangedCopyWith<UtilitiesChanged> get copyWith => _$UtilitiesChangedCopyWithImpl<UtilitiesChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UtilitiesChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UtilitiesChanged&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'DocumentEvent.utilitiesChanged(state: $state)';
}


}

/// @nodoc
abstract mixin class $UtilitiesChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $UtilitiesChangedCopyWith(UtilitiesChanged value, $Res Function(UtilitiesChanged) _then) = _$UtilitiesChangedCopyWithImpl;
@useResult
$Res call({
 UtilitiesState state
});


$UtilitiesStateCopyWith<$Res> get state;

}
/// @nodoc
class _$UtilitiesChangedCopyWithImpl<$Res>
    implements $UtilitiesChangedCopyWith<$Res> {
  _$UtilitiesChangedCopyWithImpl(this._self, this._then);

  final UtilitiesChanged _self;
  final $Res Function(UtilitiesChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = null,}) {
  return _then(UtilitiesChanged(
null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as UtilitiesState,
  ));
}

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UtilitiesStateCopyWith<$Res> get state {
  
  return $UtilitiesStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ElementsCreated extends DocumentEvent {
  const ElementsCreated(final  List<PadElement> elements, {@Uint8ListJsonConverter() final  Map<String, Uint8List> assets = const {}, final  String? $type}): _elements = elements,_assets = assets,$type = $type ?? 'elementsCreated',super._();
  factory ElementsCreated.fromJson(Map<String, dynamic> json) => _$ElementsCreatedFromJson(json);

 final  List<PadElement> _elements;
 List<PadElement> get elements {
  if (_elements is EqualUnmodifiableListView) return _elements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_elements);
}

 final  Map<String, Uint8List> _assets;
@JsonKey()@Uint8ListJsonConverter() Map<String, Uint8List> get assets {
  if (_assets is EqualUnmodifiableMapView) return _assets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_assets);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElementsCreatedCopyWith<ElementsCreated> get copyWith => _$ElementsCreatedCopyWithImpl<ElementsCreated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElementsCreatedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElementsCreated&&const DeepCollectionEquality().equals(other._elements, _elements)&&const DeepCollectionEquality().equals(other._assets, _assets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_elements),const DeepCollectionEquality().hash(_assets));

@override
String toString() {
  return 'DocumentEvent.elementsCreated(elements: $elements, assets: $assets)';
}


}

/// @nodoc
abstract mixin class $ElementsCreatedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ElementsCreatedCopyWith(ElementsCreated value, $Res Function(ElementsCreated) _then) = _$ElementsCreatedCopyWithImpl;
@useResult
$Res call({
 List<PadElement> elements,@Uint8ListJsonConverter() Map<String, Uint8List> assets
});




}
/// @nodoc
class _$ElementsCreatedCopyWithImpl<$Res>
    implements $ElementsCreatedCopyWith<$Res> {
  _$ElementsCreatedCopyWithImpl(this._self, this._then);

  final ElementsCreated _self;
  final $Res Function(ElementsCreated) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? elements = null,Object? assets = null,}) {
  return _then(ElementsCreated(
null == elements ? _self._elements : elements // ignore: cast_nullable_to_non_nullable
as List<PadElement>,assets: null == assets ? _self._assets : assets // ignore: cast_nullable_to_non_nullable
as Map<String, Uint8List>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ElementsChanged extends DocumentEvent {
  const ElementsChanged(final  Map<String, List<PadElement>> elements, {final  String? $type}): _elements = elements,$type = $type ?? 'elementsChanged',super._();
  factory ElementsChanged.fromJson(Map<String, dynamic> json) => _$ElementsChangedFromJson(json);

 final  Map<String, List<PadElement>> _elements;
 Map<String, List<PadElement>> get elements {
  if (_elements is EqualUnmodifiableMapView) return _elements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_elements);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElementsChangedCopyWith<ElementsChanged> get copyWith => _$ElementsChangedCopyWithImpl<ElementsChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElementsChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElementsChanged&&const DeepCollectionEquality().equals(other._elements, _elements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_elements));

@override
String toString() {
  return 'DocumentEvent.elementsChanged(elements: $elements)';
}


}

/// @nodoc
abstract mixin class $ElementsChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ElementsChangedCopyWith(ElementsChanged value, $Res Function(ElementsChanged) _then) = _$ElementsChangedCopyWithImpl;
@useResult
$Res call({
 Map<String, List<PadElement>> elements
});




}
/// @nodoc
class _$ElementsChangedCopyWithImpl<$Res>
    implements $ElementsChangedCopyWith<$Res> {
  _$ElementsChangedCopyWithImpl(this._self, this._then);

  final ElementsChanged _self;
  final $Res Function(ElementsChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? elements = null,}) {
  return _then(ElementsChanged(
null == elements ? _self._elements : elements // ignore: cast_nullable_to_non_nullable
as Map<String, List<PadElement>>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ElementsRemoved extends DocumentEvent {
  const ElementsRemoved(final  List<String> elements, {final  String? $type}): _elements = elements,$type = $type ?? 'elementsRemoved',super._();
  factory ElementsRemoved.fromJson(Map<String, dynamic> json) => _$ElementsRemovedFromJson(json);

 final  List<String> _elements;
 List<String> get elements {
  if (_elements is EqualUnmodifiableListView) return _elements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_elements);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElementsRemovedCopyWith<ElementsRemoved> get copyWith => _$ElementsRemovedCopyWithImpl<ElementsRemoved>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElementsRemovedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElementsRemoved&&const DeepCollectionEquality().equals(other._elements, _elements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_elements));

@override
String toString() {
  return 'DocumentEvent.elementsRemoved(elements: $elements)';
}


}

/// @nodoc
abstract mixin class $ElementsRemovedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ElementsRemovedCopyWith(ElementsRemoved value, $Res Function(ElementsRemoved) _then) = _$ElementsRemovedCopyWithImpl;
@useResult
$Res call({
 List<String> elements
});




}
/// @nodoc
class _$ElementsRemovedCopyWithImpl<$Res>
    implements $ElementsRemovedCopyWith<$Res> {
  _$ElementsRemovedCopyWithImpl(this._self, this._then);

  final ElementsRemoved _self;
  final $Res Function(ElementsRemoved) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? elements = null,}) {
  return _then(ElementsRemoved(
null == elements ? _self._elements : elements // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ElementsArranged extends DocumentEvent {
  const ElementsArranged(this.arrangement, final  List<String> elements, {final  String? $type}): _elements = elements,$type = $type ?? 'elementsArranged',super._();
  factory ElementsArranged.fromJson(Map<String, dynamic> json) => _$ElementsArrangedFromJson(json);

 final  Arrangement arrangement;
 final  List<String> _elements;
 List<String> get elements {
  if (_elements is EqualUnmodifiableListView) return _elements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_elements);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElementsArrangedCopyWith<ElementsArranged> get copyWith => _$ElementsArrangedCopyWithImpl<ElementsArranged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElementsArrangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElementsArranged&&(identical(other.arrangement, arrangement) || other.arrangement == arrangement)&&const DeepCollectionEquality().equals(other._elements, _elements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrangement,const DeepCollectionEquality().hash(_elements));

@override
String toString() {
  return 'DocumentEvent.elementsArranged(arrangement: $arrangement, elements: $elements)';
}


}

/// @nodoc
abstract mixin class $ElementsArrangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ElementsArrangedCopyWith(ElementsArranged value, $Res Function(ElementsArranged) _then) = _$ElementsArrangedCopyWithImpl;
@useResult
$Res call({
 Arrangement arrangement, List<String> elements
});




}
/// @nodoc
class _$ElementsArrangedCopyWithImpl<$Res>
    implements $ElementsArrangedCopyWith<$Res> {
  _$ElementsArrangedCopyWithImpl(this._self, this._then);

  final ElementsArranged _self;
  final $Res Function(ElementsArranged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? arrangement = null,Object? elements = null,}) {
  return _then(ElementsArranged(
null == arrangement ? _self.arrangement : arrangement // ignore: cast_nullable_to_non_nullable
as Arrangement,null == elements ? _self._elements : elements // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DocumentDescriptionChanged extends DocumentEvent {
  const DocumentDescriptionChanged({this.name, this.description, final  String? $type}): $type = $type ?? 'documentDescriptionChanged',super._();
  factory DocumentDescriptionChanged.fromJson(Map<String, dynamic> json) => _$DocumentDescriptionChangedFromJson(json);

 final  String? name;
 final  String? description;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentDescriptionChangedCopyWith<DocumentDescriptionChanged> get copyWith => _$DocumentDescriptionChangedCopyWithImpl<DocumentDescriptionChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentDescriptionChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentDescriptionChanged&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description);

@override
String toString() {
  return 'DocumentEvent.documentDescriptionChanged(name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $DocumentDescriptionChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $DocumentDescriptionChangedCopyWith(DocumentDescriptionChanged value, $Res Function(DocumentDescriptionChanged) _then) = _$DocumentDescriptionChangedCopyWithImpl;
@useResult
$Res call({
 String? name, String? description
});




}
/// @nodoc
class _$DocumentDescriptionChangedCopyWithImpl<$Res>
    implements $DocumentDescriptionChangedCopyWith<$Res> {
  _$DocumentDescriptionChangedCopyWithImpl(this._self, this._then);

  final DocumentDescriptionChanged _self;
  final $Res Function(DocumentDescriptionChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? description = freezed,}) {
  return _then(DocumentDescriptionChanged(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DocumentSaved extends DocumentEvent {
  const DocumentSaved([@JsonKey(fromJson: AssetLocationMapper.fromMap, toJson: _assetLocationToJson) this.location, final  String? $type]): $type = $type ?? 'documentSaved',super._();
  factory DocumentSaved.fromJson(Map<String, dynamic> json) => _$DocumentSavedFromJson(json);

@JsonKey(fromJson: AssetLocationMapper.fromMap, toJson: _assetLocationToJson) final  AssetLocation? location;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentSavedCopyWith<DocumentSaved> get copyWith => _$DocumentSavedCopyWithImpl<DocumentSaved>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentSavedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentSaved&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location);

@override
String toString() {
  return 'DocumentEvent.documentSaved(location: $location)';
}


}

/// @nodoc
abstract mixin class $DocumentSavedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $DocumentSavedCopyWith(DocumentSaved value, $Res Function(DocumentSaved) _then) = _$DocumentSavedCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: AssetLocationMapper.fromMap, toJson: _assetLocationToJson) AssetLocation? location
});




}
/// @nodoc
class _$DocumentSavedCopyWithImpl<$Res>
    implements $DocumentSavedCopyWith<$Res> {
  _$DocumentSavedCopyWithImpl(this._self, this._then);

  final DocumentSaved _self;
  final $Res Function(DocumentSaved) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? location = freezed,}) {
  return _then(DocumentSaved(
freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as AssetLocation?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ToolCreated extends DocumentEvent {
  const ToolCreated(this.tool, {final  String? $type}): $type = $type ?? 'toolCreated',super._();
  factory ToolCreated.fromJson(Map<String, dynamic> json) => _$ToolCreatedFromJson(json);

 final  Tool tool;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolCreatedCopyWith<ToolCreated> get copyWith => _$ToolCreatedCopyWithImpl<ToolCreated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToolCreatedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolCreated&&(identical(other.tool, tool) || other.tool == tool));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tool);

@override
String toString() {
  return 'DocumentEvent.toolCreated(tool: $tool)';
}


}

/// @nodoc
abstract mixin class $ToolCreatedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ToolCreatedCopyWith(ToolCreated value, $Res Function(ToolCreated) _then) = _$ToolCreatedCopyWithImpl;
@useResult
$Res call({
 Tool tool
});


$ToolCopyWith<$Res> get tool;

}
/// @nodoc
class _$ToolCreatedCopyWithImpl<$Res>
    implements $ToolCreatedCopyWith<$Res> {
  _$ToolCreatedCopyWithImpl(this._self, this._then);

  final ToolCreated _self;
  final $Res Function(ToolCreated) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tool = null,}) {
  return _then(ToolCreated(
null == tool ? _self.tool : tool // ignore: cast_nullable_to_non_nullable
as Tool,
  ));
}

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToolCopyWith<$Res> get tool {
  
  return $ToolCopyWith<$Res>(_self.tool, (value) {
    return _then(_self.copyWith(tool: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ToolsChanged extends DocumentEvent {
  const ToolsChanged(final  List<Tool> tools, {final  String? $type}): _tools = tools,$type = $type ?? 'toolsChanged',super._();
  factory ToolsChanged.fromJson(Map<String, dynamic> json) => _$ToolsChangedFromJson(json);

 final  List<Tool> _tools;
 List<Tool> get tools {
  if (_tools is EqualUnmodifiableListView) return _tools;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tools);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolsChangedCopyWith<ToolsChanged> get copyWith => _$ToolsChangedCopyWithImpl<ToolsChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToolsChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolsChanged&&const DeepCollectionEquality().equals(other._tools, _tools));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tools));

@override
String toString() {
  return 'DocumentEvent.toolsChanged(tools: $tools)';
}


}

/// @nodoc
abstract mixin class $ToolsChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ToolsChangedCopyWith(ToolsChanged value, $Res Function(ToolsChanged) _then) = _$ToolsChangedCopyWithImpl;
@useResult
$Res call({
 List<Tool> tools
});




}
/// @nodoc
class _$ToolsChangedCopyWithImpl<$Res>
    implements $ToolsChangedCopyWith<$Res> {
  _$ToolsChangedCopyWithImpl(this._self, this._then);

  final ToolsChanged _self;
  final $Res Function(ToolsChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tools = null,}) {
  return _then(ToolsChanged(
null == tools ? _self._tools : tools // ignore: cast_nullable_to_non_nullable
as List<Tool>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ToolsRemoved extends DocumentEvent {
  const ToolsRemoved(final  List<String> tools, {final  String? $type}): _tools = tools,$type = $type ?? 'toolsRemoved',super._();
  factory ToolsRemoved.fromJson(Map<String, dynamic> json) => _$ToolsRemovedFromJson(json);

 final  List<String> _tools;
 List<String> get tools {
  if (_tools is EqualUnmodifiableListView) return _tools;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tools);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolsRemovedCopyWith<ToolsRemoved> get copyWith => _$ToolsRemovedCopyWithImpl<ToolsRemoved>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToolsRemovedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolsRemoved&&const DeepCollectionEquality().equals(other._tools, _tools));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tools));

@override
String toString() {
  return 'DocumentEvent.toolsRemoved(tools: $tools)';
}


}

/// @nodoc
abstract mixin class $ToolsRemovedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ToolsRemovedCopyWith(ToolsRemoved value, $Res Function(ToolsRemoved) _then) = _$ToolsRemovedCopyWithImpl;
@useResult
$Res call({
 List<String> tools
});




}
/// @nodoc
class _$ToolsRemovedCopyWithImpl<$Res>
    implements $ToolsRemovedCopyWith<$Res> {
  _$ToolsRemovedCopyWithImpl(this._self, this._then);

  final ToolsRemoved _self;
  final $Res Function(ToolsRemoved) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tools = null,}) {
  return _then(ToolsRemoved(
null == tools ? _self._tools : tools // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ToolsReplaced extends DocumentEvent {
  const ToolsReplaced(final  List<Tool> tools, {final  String? $type}): _tools = tools,$type = $type ?? 'toolsReplaced',super._();
  factory ToolsReplaced.fromJson(Map<String, dynamic> json) => _$ToolsReplacedFromJson(json);

 final  List<Tool> _tools;
 List<Tool> get tools {
  if (_tools is EqualUnmodifiableListView) return _tools;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tools);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolsReplacedCopyWith<ToolsReplaced> get copyWith => _$ToolsReplacedCopyWithImpl<ToolsReplaced>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToolsReplacedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolsReplaced&&const DeepCollectionEquality().equals(other._tools, _tools));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tools));

@override
String toString() {
  return 'DocumentEvent.toolsReplaced(tools: $tools)';
}


}

/// @nodoc
abstract mixin class $ToolsReplacedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ToolsReplacedCopyWith(ToolsReplaced value, $Res Function(ToolsReplaced) _then) = _$ToolsReplacedCopyWithImpl;
@useResult
$Res call({
 List<Tool> tools
});




}
/// @nodoc
class _$ToolsReplacedCopyWithImpl<$Res>
    implements $ToolsReplacedCopyWith<$Res> {
  _$ToolsReplacedCopyWithImpl(this._self, this._then);

  final ToolsReplaced _self;
  final $Res Function(ToolsReplaced) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tools = null,}) {
  return _then(ToolsReplaced(
null == tools ? _self._tools : tools // ignore: cast_nullable_to_non_nullable
as List<Tool>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ToolReordered extends DocumentEvent {
  const ToolReordered(this.id, this.newIndex, {final  String? $type}): $type = $type ?? 'toolReordered',super._();
  factory ToolReordered.fromJson(Map<String, dynamic> json) => _$ToolReorderedFromJson(json);

 final  String id;
 final  int newIndex;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolReorderedCopyWith<ToolReordered> get copyWith => _$ToolReorderedCopyWithImpl<ToolReordered>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToolReorderedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolReordered&&(identical(other.id, id) || other.id == id)&&(identical(other.newIndex, newIndex) || other.newIndex == newIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,newIndex);

@override
String toString() {
  return 'DocumentEvent.toolReordered(id: $id, newIndex: $newIndex)';
}


}

/// @nodoc
abstract mixin class $ToolReorderedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ToolReorderedCopyWith(ToolReordered value, $Res Function(ToolReordered) _then) = _$ToolReorderedCopyWithImpl;
@useResult
$Res call({
 String id, int newIndex
});




}
/// @nodoc
class _$ToolReorderedCopyWithImpl<$Res>
    implements $ToolReorderedCopyWith<$Res> {
  _$ToolReorderedCopyWithImpl(this._self, this._then);

  final ToolReordered _self;
  final $Res Function(ToolReordered) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? newIndex = null,}) {
  return _then(ToolReordered(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,null == newIndex ? _self.newIndex : newIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DocumentBackgroundsChanged extends DocumentEvent {
  const DocumentBackgroundsChanged(final  List<Background> backgrounds, {final  String? $type}): _backgrounds = backgrounds,$type = $type ?? 'documentBackgroundsChanged',super._();
  factory DocumentBackgroundsChanged.fromJson(Map<String, dynamic> json) => _$DocumentBackgroundsChangedFromJson(json);

 final  List<Background> _backgrounds;
 List<Background> get backgrounds {
  if (_backgrounds is EqualUnmodifiableListView) return _backgrounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_backgrounds);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentBackgroundsChangedCopyWith<DocumentBackgroundsChanged> get copyWith => _$DocumentBackgroundsChangedCopyWithImpl<DocumentBackgroundsChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentBackgroundsChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentBackgroundsChanged&&const DeepCollectionEquality().equals(other._backgrounds, _backgrounds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_backgrounds));

@override
String toString() {
  return 'DocumentEvent.documentBackgroundsChanged(backgrounds: $backgrounds)';
}


}

/// @nodoc
abstract mixin class $DocumentBackgroundsChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $DocumentBackgroundsChangedCopyWith(DocumentBackgroundsChanged value, $Res Function(DocumentBackgroundsChanged) _then) = _$DocumentBackgroundsChangedCopyWithImpl;
@useResult
$Res call({
 List<Background> backgrounds
});




}
/// @nodoc
class _$DocumentBackgroundsChangedCopyWithImpl<$Res>
    implements $DocumentBackgroundsChangedCopyWith<$Res> {
  _$DocumentBackgroundsChangedCopyWithImpl(this._self, this._then);

  final DocumentBackgroundsChanged _self;
  final $Res Function(DocumentBackgroundsChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? backgrounds = null,}) {
  return _then(DocumentBackgroundsChanged(
null == backgrounds ? _self._backgrounds : backgrounds // ignore: cast_nullable_to_non_nullable
as List<Background>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class WaypointCreated extends DocumentEvent {
  const WaypointCreated(this.waypoint, {final  String? $type}): $type = $type ?? 'waypointCreated',super._();
  factory WaypointCreated.fromJson(Map<String, dynamic> json) => _$WaypointCreatedFromJson(json);

 final  Waypoint waypoint;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaypointCreatedCopyWith<WaypointCreated> get copyWith => _$WaypointCreatedCopyWithImpl<WaypointCreated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaypointCreatedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaypointCreated&&(identical(other.waypoint, waypoint) || other.waypoint == waypoint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,waypoint);

@override
String toString() {
  return 'DocumentEvent.waypointCreated(waypoint: $waypoint)';
}


}

/// @nodoc
abstract mixin class $WaypointCreatedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $WaypointCreatedCopyWith(WaypointCreated value, $Res Function(WaypointCreated) _then) = _$WaypointCreatedCopyWithImpl;
@useResult
$Res call({
 Waypoint waypoint
});


$WaypointCopyWith<$Res> get waypoint;

}
/// @nodoc
class _$WaypointCreatedCopyWithImpl<$Res>
    implements $WaypointCreatedCopyWith<$Res> {
  _$WaypointCreatedCopyWithImpl(this._self, this._then);

  final WaypointCreated _self;
  final $Res Function(WaypointCreated) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? waypoint = null,}) {
  return _then(WaypointCreated(
null == waypoint ? _self.waypoint : waypoint // ignore: cast_nullable_to_non_nullable
as Waypoint,
  ));
}

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WaypointCopyWith<$Res> get waypoint {
  
  return $WaypointCopyWith<$Res>(_self.waypoint, (value) {
    return _then(_self.copyWith(waypoint: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class WaypointChanged extends DocumentEvent {
  const WaypointChanged(this.name, this.waypoint, {final  String? $type}): $type = $type ?? 'waypointChanged',super._();
  factory WaypointChanged.fromJson(Map<String, dynamic> json) => _$WaypointChangedFromJson(json);

 final  String? name;
 final  Waypoint waypoint;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaypointChangedCopyWith<WaypointChanged> get copyWith => _$WaypointChangedCopyWithImpl<WaypointChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaypointChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaypointChanged&&(identical(other.name, name) || other.name == name)&&(identical(other.waypoint, waypoint) || other.waypoint == waypoint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,waypoint);

@override
String toString() {
  return 'DocumentEvent.waypointChanged(name: $name, waypoint: $waypoint)';
}


}

/// @nodoc
abstract mixin class $WaypointChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $WaypointChangedCopyWith(WaypointChanged value, $Res Function(WaypointChanged) _then) = _$WaypointChangedCopyWithImpl;
@useResult
$Res call({
 String? name, Waypoint waypoint
});


$WaypointCopyWith<$Res> get waypoint;

}
/// @nodoc
class _$WaypointChangedCopyWithImpl<$Res>
    implements $WaypointChangedCopyWith<$Res> {
  _$WaypointChangedCopyWithImpl(this._self, this._then);

  final WaypointChanged _self;
  final $Res Function(WaypointChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? waypoint = null,}) {
  return _then(WaypointChanged(
freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,null == waypoint ? _self.waypoint : waypoint // ignore: cast_nullable_to_non_nullable
as Waypoint,
  ));
}

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WaypointCopyWith<$Res> get waypoint {
  
  return $WaypointCopyWith<$Res>(_self.waypoint, (value) {
    return _then(_self.copyWith(waypoint: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class WaypointRemoved extends DocumentEvent {
  const WaypointRemoved(this.name, {final  String? $type}): $type = $type ?? 'waypointRemoved',super._();
  factory WaypointRemoved.fromJson(Map<String, dynamic> json) => _$WaypointRemovedFromJson(json);

 final  String? name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaypointRemovedCopyWith<WaypointRemoved> get copyWith => _$WaypointRemovedCopyWithImpl<WaypointRemoved>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaypointRemovedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaypointRemoved&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'DocumentEvent.waypointRemoved(name: $name)';
}


}

/// @nodoc
abstract mixin class $WaypointRemovedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $WaypointRemovedCopyWith(WaypointRemoved value, $Res Function(WaypointRemoved) _then) = _$WaypointRemovedCopyWithImpl;
@useResult
$Res call({
 String? name
});




}
/// @nodoc
class _$WaypointRemovedCopyWithImpl<$Res>
    implements $WaypointRemovedCopyWith<$Res> {
  _$WaypointRemovedCopyWithImpl(this._self, this._then);

  final WaypointRemoved _self;
  final $Res Function(WaypointRemoved) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = freezed,}) {
  return _then(WaypointRemoved(
freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class WaypointReordered extends DocumentEvent {
  const WaypointReordered(this.name, this.newIndex, {final  String? $type}): $type = $type ?? 'waypointReordered',super._();
  factory WaypointReordered.fromJson(Map<String, dynamic> json) => _$WaypointReorderedFromJson(json);

 final  String? name;
 final  int newIndex;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaypointReorderedCopyWith<WaypointReordered> get copyWith => _$WaypointReorderedCopyWithImpl<WaypointReordered>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaypointReorderedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaypointReordered&&(identical(other.name, name) || other.name == name)&&(identical(other.newIndex, newIndex) || other.newIndex == newIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,newIndex);

@override
String toString() {
  return 'DocumentEvent.waypointReordered(name: $name, newIndex: $newIndex)';
}


}

/// @nodoc
abstract mixin class $WaypointReorderedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $WaypointReorderedCopyWith(WaypointReordered value, $Res Function(WaypointReordered) _then) = _$WaypointReorderedCopyWithImpl;
@useResult
$Res call({
 String? name, int newIndex
});




}
/// @nodoc
class _$WaypointReorderedCopyWithImpl<$Res>
    implements $WaypointReorderedCopyWith<$Res> {
  _$WaypointReorderedCopyWithImpl(this._self, this._then);

  final WaypointReordered _self;
  final $Res Function(WaypointReordered) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? newIndex = null,}) {
  return _then(WaypointReordered(
freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,null == newIndex ? _self.newIndex : newIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CollectionRenamed extends DocumentEvent {
  const CollectionRenamed(this.oldName, this.newName, {final  String? $type}): $type = $type ?? 'collectionRenamed',super._();
  factory CollectionRenamed.fromJson(Map<String, dynamic> json) => _$CollectionRenamedFromJson(json);

 final  String oldName;
 final  String newName;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionRenamedCopyWith<CollectionRenamed> get copyWith => _$CollectionRenamedCopyWithImpl<CollectionRenamed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectionRenamedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionRenamed&&(identical(other.oldName, oldName) || other.oldName == oldName)&&(identical(other.newName, newName) || other.newName == newName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oldName,newName);

@override
String toString() {
  return 'DocumentEvent.collectionRenamed(oldName: $oldName, newName: $newName)';
}


}

/// @nodoc
abstract mixin class $CollectionRenamedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $CollectionRenamedCopyWith(CollectionRenamed value, $Res Function(CollectionRenamed) _then) = _$CollectionRenamedCopyWithImpl;
@useResult
$Res call({
 String oldName, String newName
});




}
/// @nodoc
class _$CollectionRenamedCopyWithImpl<$Res>
    implements $CollectionRenamedCopyWith<$Res> {
  _$CollectionRenamedCopyWithImpl(this._self, this._then);

  final CollectionRenamed _self;
  final $Res Function(CollectionRenamed) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldName = null,Object? newName = null,}) {
  return _then(CollectionRenamed(
null == oldName ? _self.oldName : oldName // ignore: cast_nullable_to_non_nullable
as String,null == newName ? _self.newName : newName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CollectionElementsRemoved extends DocumentEvent {
  const CollectionElementsRemoved(this.name, {final  String? $type}): $type = $type ?? 'collectionElementsRemoved',super._();
  factory CollectionElementsRemoved.fromJson(Map<String, dynamic> json) => _$CollectionElementsRemovedFromJson(json);

 final  String name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionElementsRemovedCopyWith<CollectionElementsRemoved> get copyWith => _$CollectionElementsRemovedCopyWithImpl<CollectionElementsRemoved>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectionElementsRemovedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionElementsRemoved&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'DocumentEvent.collectionElementsRemoved(name: $name)';
}


}

/// @nodoc
abstract mixin class $CollectionElementsRemovedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $CollectionElementsRemovedCopyWith(CollectionElementsRemoved value, $Res Function(CollectionElementsRemoved) _then) = _$CollectionElementsRemovedCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$CollectionElementsRemovedCopyWithImpl<$Res>
    implements $CollectionElementsRemovedCopyWith<$Res> {
  _$CollectionElementsRemovedCopyWithImpl(this._self, this._then);

  final CollectionElementsRemoved _self;
  final $Res Function(CollectionElementsRemoved) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(CollectionElementsRemoved(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CurrentCollectionChanged extends DocumentEvent {
  const CurrentCollectionChanged(this.name, {final  String? $type}): $type = $type ?? 'currentCollectionChanged',super._();
  factory CurrentCollectionChanged.fromJson(Map<String, dynamic> json) => _$CurrentCollectionChangedFromJson(json);

 final  String name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentCollectionChangedCopyWith<CurrentCollectionChanged> get copyWith => _$CurrentCollectionChangedCopyWithImpl<CurrentCollectionChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentCollectionChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentCollectionChanged&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'DocumentEvent.currentCollectionChanged(name: $name)';
}


}

/// @nodoc
abstract mixin class $CurrentCollectionChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $CurrentCollectionChangedCopyWith(CurrentCollectionChanged value, $Res Function(CurrentCollectionChanged) _then) = _$CurrentCollectionChangedCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$CurrentCollectionChangedCopyWithImpl<$Res>
    implements $CurrentCollectionChangedCopyWith<$Res> {
  _$CurrentCollectionChangedCopyWithImpl(this._self, this._then);

  final CurrentCollectionChanged _self;
  final $Res Function(CurrentCollectionChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(CurrentCollectionChanged(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CurrentLayerChanged extends DocumentEvent {
  const CurrentLayerChanged(this.name, {final  String? $type}): $type = $type ?? 'currentLayerChanged',super._();
  factory CurrentLayerChanged.fromJson(Map<String, dynamic> json) => _$CurrentLayerChangedFromJson(json);

 final  String name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentLayerChangedCopyWith<CurrentLayerChanged> get copyWith => _$CurrentLayerChangedCopyWithImpl<CurrentLayerChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentLayerChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentLayerChanged&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'DocumentEvent.currentLayerChanged(name: $name)';
}


}

/// @nodoc
abstract mixin class $CurrentLayerChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $CurrentLayerChangedCopyWith(CurrentLayerChanged value, $Res Function(CurrentLayerChanged) _then) = _$CurrentLayerChangedCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$CurrentLayerChangedCopyWithImpl<$Res>
    implements $CurrentLayerChangedCopyWith<$Res> {
  _$CurrentLayerChangedCopyWithImpl(this._self, this._then);

  final CurrentLayerChanged _self;
  final $Res Function(CurrentLayerChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(CurrentLayerChanged(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class LayerCreated extends DocumentEvent {
  const LayerCreated({this.name = '', this.id, final  String? $type}): $type = $type ?? 'layerCreated',super._();
  factory LayerCreated.fromJson(Map<String, dynamic> json) => _$LayerCreatedFromJson(json);

@JsonKey() final  String name;
 final  String? id;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LayerCreatedCopyWith<LayerCreated> get copyWith => _$LayerCreatedCopyWithImpl<LayerCreated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LayerCreatedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LayerCreated&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,id);

@override
String toString() {
  return 'DocumentEvent.layerCreated(name: $name, id: $id)';
}


}

/// @nodoc
abstract mixin class $LayerCreatedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $LayerCreatedCopyWith(LayerCreated value, $Res Function(LayerCreated) _then) = _$LayerCreatedCopyWithImpl;
@useResult
$Res call({
 String name, String? id
});




}
/// @nodoc
class _$LayerCreatedCopyWithImpl<$Res>
    implements $LayerCreatedCopyWith<$Res> {
  _$LayerCreatedCopyWithImpl(this._self, this._then);

  final LayerCreated _self;
  final $Res Function(LayerCreated) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? id = freezed,}) {
  return _then(LayerCreated(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class LayerChanged extends DocumentEvent {
  const LayerChanged(this.id, {this.name, final  String? $type}): $type = $type ?? 'layerChanged',super._();
  factory LayerChanged.fromJson(Map<String, dynamic> json) => _$LayerChangedFromJson(json);

 final  String id;
 final  String? name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LayerChangedCopyWith<LayerChanged> get copyWith => _$LayerChangedCopyWithImpl<LayerChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LayerChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LayerChanged&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'DocumentEvent.layerChanged(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $LayerChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $LayerChangedCopyWith(LayerChanged value, $Res Function(LayerChanged) _then) = _$LayerChangedCopyWithImpl;
@useResult
$Res call({
 String id, String? name
});




}
/// @nodoc
class _$LayerChangedCopyWithImpl<$Res>
    implements $LayerChangedCopyWith<$Res> {
  _$LayerChangedCopyWithImpl(this._self, this._then);

  final LayerChanged _self;
  final $Res Function(LayerChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,}) {
  return _then(LayerChanged(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class LayerRemoved extends DocumentEvent {
  const LayerRemoved(this.id, {final  String? $type}): $type = $type ?? 'layerRemoved',super._();
  factory LayerRemoved.fromJson(Map<String, dynamic> json) => _$LayerRemovedFromJson(json);

 final  String id;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LayerRemovedCopyWith<LayerRemoved> get copyWith => _$LayerRemovedCopyWithImpl<LayerRemoved>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LayerRemovedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LayerRemoved&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'DocumentEvent.layerRemoved(id: $id)';
}


}

/// @nodoc
abstract mixin class $LayerRemovedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $LayerRemovedCopyWith(LayerRemoved value, $Res Function(LayerRemoved) _then) = _$LayerRemovedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$LayerRemovedCopyWithImpl<$Res>
    implements $LayerRemovedCopyWith<$Res> {
  _$LayerRemovedCopyWithImpl(this._self, this._then);

  final LayerRemoved _self;
  final $Res Function(LayerRemoved) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(LayerRemoved(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class LayersMerged extends DocumentEvent {
  const LayersMerged(final  List<String> layers, [this.duplicate = false, final  String? $type]): _layers = layers,$type = $type ?? 'layersMerged',super._();
  factory LayersMerged.fromJson(Map<String, dynamic> json) => _$LayersMergedFromJson(json);

 final  List<String> _layers;
 List<String> get layers {
  if (_layers is EqualUnmodifiableListView) return _layers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_layers);
}

@JsonKey() final  bool duplicate;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LayersMergedCopyWith<LayersMerged> get copyWith => _$LayersMergedCopyWithImpl<LayersMerged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LayersMergedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LayersMerged&&const DeepCollectionEquality().equals(other._layers, _layers)&&(identical(other.duplicate, duplicate) || other.duplicate == duplicate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_layers),duplicate);

@override
String toString() {
  return 'DocumentEvent.layersMerged(layers: $layers, duplicate: $duplicate)';
}


}

/// @nodoc
abstract mixin class $LayersMergedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $LayersMergedCopyWith(LayersMerged value, $Res Function(LayersMerged) _then) = _$LayersMergedCopyWithImpl;
@useResult
$Res call({
 List<String> layers, bool duplicate
});




}
/// @nodoc
class _$LayersMergedCopyWithImpl<$Res>
    implements $LayersMergedCopyWith<$Res> {
  _$LayersMergedCopyWithImpl(this._self, this._then);

  final LayersMerged _self;
  final $Res Function(LayersMerged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? layers = null,Object? duplicate = null,}) {
  return _then(LayersMerged(
null == layers ? _self._layers : layers // ignore: cast_nullable_to_non_nullable
as List<String>,null == duplicate ? _self.duplicate : duplicate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class LayerOrderChanged extends DocumentEvent {
  const LayerOrderChanged(this.id, this.index, {final  String? $type}): $type = $type ?? 'layerOrderChanged',super._();
  factory LayerOrderChanged.fromJson(Map<String, dynamic> json) => _$LayerOrderChangedFromJson(json);

 final  String id;
 final  int index;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LayerOrderChangedCopyWith<LayerOrderChanged> get copyWith => _$LayerOrderChangedCopyWithImpl<LayerOrderChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LayerOrderChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LayerOrderChanged&&(identical(other.id, id) || other.id == id)&&(identical(other.index, index) || other.index == index));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,index);

@override
String toString() {
  return 'DocumentEvent.layerOrderChanged(id: $id, index: $index)';
}


}

/// @nodoc
abstract mixin class $LayerOrderChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $LayerOrderChangedCopyWith(LayerOrderChanged value, $Res Function(LayerOrderChanged) _then) = _$LayerOrderChangedCopyWithImpl;
@useResult
$Res call({
 String id, int index
});




}
/// @nodoc
class _$LayerOrderChangedCopyWithImpl<$Res>
    implements $LayerOrderChangedCopyWith<$Res> {
  _$LayerOrderChangedCopyWithImpl(this._self, this._then);

  final LayerOrderChanged _self;
  final $Res Function(LayerOrderChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? index = null,}) {
  return _then(LayerOrderChanged(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class LayerVisibilityChanged extends DocumentEvent {
  const LayerVisibilityChanged(this.id, this.visible, {final  String? $type}): $type = $type ?? 'layerVisibilityChanged',super._();
  factory LayerVisibilityChanged.fromJson(Map<String, dynamic> json) => _$LayerVisibilityChangedFromJson(json);

 final  String id;
 final  bool visible;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LayerVisibilityChangedCopyWith<LayerVisibilityChanged> get copyWith => _$LayerVisibilityChangedCopyWithImpl<LayerVisibilityChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LayerVisibilityChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LayerVisibilityChanged&&(identical(other.id, id) || other.id == id)&&(identical(other.visible, visible) || other.visible == visible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,visible);

@override
String toString() {
  return 'DocumentEvent.layerVisibilityChanged(id: $id, visible: $visible)';
}


}

/// @nodoc
abstract mixin class $LayerVisibilityChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $LayerVisibilityChangedCopyWith(LayerVisibilityChanged value, $Res Function(LayerVisibilityChanged) _then) = _$LayerVisibilityChangedCopyWithImpl;
@useResult
$Res call({
 String id, bool visible
});




}
/// @nodoc
class _$LayerVisibilityChangedCopyWithImpl<$Res>
    implements $LayerVisibilityChangedCopyWith<$Res> {
  _$LayerVisibilityChangedCopyWithImpl(this._self, this._then);

  final LayerVisibilityChanged _self;
  final $Res Function(LayerVisibilityChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? visible = null,}) {
  return _then(LayerVisibilityChanged(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ElementsCollectionChanged extends DocumentEvent {
  const ElementsCollectionChanged(final  List<String> elements, this.collection, {final  String? $type}): _elements = elements,$type = $type ?? 'elementsCollectionChanged',super._();
  factory ElementsCollectionChanged.fromJson(Map<String, dynamic> json) => _$ElementsCollectionChangedFromJson(json);

 final  List<String> _elements;
 List<String> get elements {
  if (_elements is EqualUnmodifiableListView) return _elements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_elements);
}

 final  String collection;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElementsCollectionChangedCopyWith<ElementsCollectionChanged> get copyWith => _$ElementsCollectionChangedCopyWithImpl<ElementsCollectionChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElementsCollectionChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElementsCollectionChanged&&const DeepCollectionEquality().equals(other._elements, _elements)&&(identical(other.collection, collection) || other.collection == collection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_elements),collection);

@override
String toString() {
  return 'DocumentEvent.elementsCollectionChanged(elements: $elements, collection: $collection)';
}


}

/// @nodoc
abstract mixin class $ElementsCollectionChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ElementsCollectionChangedCopyWith(ElementsCollectionChanged value, $Res Function(ElementsCollectionChanged) _then) = _$ElementsCollectionChangedCopyWithImpl;
@useResult
$Res call({
 List<String> elements, String collection
});




}
/// @nodoc
class _$ElementsCollectionChangedCopyWithImpl<$Res>
    implements $ElementsCollectionChangedCopyWith<$Res> {
  _$ElementsCollectionChangedCopyWithImpl(this._self, this._then);

  final ElementsCollectionChanged _self;
  final $Res Function(ElementsCollectionChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? elements = null,Object? collection = null,}) {
  return _then(ElementsCollectionChanged(
null == elements ? _self._elements : elements // ignore: cast_nullable_to_non_nullable
as List<String>,null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AreasCreated extends DocumentEvent {
  const AreasCreated(final  List<Area> areas, {final  String? $type}): _areas = areas,$type = $type ?? 'areasCreated',super._();
  factory AreasCreated.fromJson(Map<String, dynamic> json) => _$AreasCreatedFromJson(json);

 final  List<Area> _areas;
 List<Area> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreasCreatedCopyWith<AreasCreated> get copyWith => _$AreasCreatedCopyWithImpl<AreasCreated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreasCreatedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AreasCreated&&const DeepCollectionEquality().equals(other._areas, _areas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_areas));

@override
String toString() {
  return 'DocumentEvent.areasCreated(areas: $areas)';
}


}

/// @nodoc
abstract mixin class $AreasCreatedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $AreasCreatedCopyWith(AreasCreated value, $Res Function(AreasCreated) _then) = _$AreasCreatedCopyWithImpl;
@useResult
$Res call({
 List<Area> areas
});




}
/// @nodoc
class _$AreasCreatedCopyWithImpl<$Res>
    implements $AreasCreatedCopyWith<$Res> {
  _$AreasCreatedCopyWithImpl(this._self, this._then);

  final AreasCreated _self;
  final $Res Function(AreasCreated) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? areas = null,}) {
  return _then(AreasCreated(
null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<Area>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AreasRemoved extends DocumentEvent {
  const AreasRemoved(final  List<String> areas, {final  String? $type}): _areas = areas,$type = $type ?? 'areasRemoved',super._();
  factory AreasRemoved.fromJson(Map<String, dynamic> json) => _$AreasRemovedFromJson(json);

 final  List<String> _areas;
 List<String> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreasRemovedCopyWith<AreasRemoved> get copyWith => _$AreasRemovedCopyWithImpl<AreasRemoved>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreasRemovedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AreasRemoved&&const DeepCollectionEquality().equals(other._areas, _areas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_areas));

@override
String toString() {
  return 'DocumentEvent.areasRemoved(areas: $areas)';
}


}

/// @nodoc
abstract mixin class $AreasRemovedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $AreasRemovedCopyWith(AreasRemoved value, $Res Function(AreasRemoved) _then) = _$AreasRemovedCopyWithImpl;
@useResult
$Res call({
 List<String> areas
});




}
/// @nodoc
class _$AreasRemovedCopyWithImpl<$Res>
    implements $AreasRemovedCopyWith<$Res> {
  _$AreasRemovedCopyWithImpl(this._self, this._then);

  final AreasRemoved _self;
  final $Res Function(AreasRemoved) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? areas = null,}) {
  return _then(AreasRemoved(
null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AreaChanged extends DocumentEvent {
  const AreaChanged(this.name, this.area, {final  String? $type}): $type = $type ?? 'areaChanged',super._();
  factory AreaChanged.fromJson(Map<String, dynamic> json) => _$AreaChangedFromJson(json);

 final  String name;
 final  Area area;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaChangedCopyWith<AreaChanged> get copyWith => _$AreaChangedCopyWithImpl<AreaChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreaChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AreaChanged&&(identical(other.name, name) || other.name == name)&&(identical(other.area, area) || other.area == area));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,area);

@override
String toString() {
  return 'DocumentEvent.areaChanged(name: $name, area: $area)';
}


}

/// @nodoc
abstract mixin class $AreaChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $AreaChangedCopyWith(AreaChanged value, $Res Function(AreaChanged) _then) = _$AreaChangedCopyWithImpl;
@useResult
$Res call({
 String name, Area area
});


$AreaCopyWith<$Res> get area;

}
/// @nodoc
class _$AreaChangedCopyWithImpl<$Res>
    implements $AreaChangedCopyWith<$Res> {
  _$AreaChangedCopyWithImpl(this._self, this._then);

  final AreaChanged _self;
  final $Res Function(AreaChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? area = null,}) {
  return _then(AreaChanged(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as Area,
  ));
}

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AreaCopyWith<$Res> get area {
  
  return $AreaCopyWith<$Res>(_self.area, (value) {
    return _then(_self.copyWith(area: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class AreaReordered extends DocumentEvent {
  const AreaReordered(this.name, this.newIndex, {final  String? $type}): $type = $type ?? 'areaReordered',super._();
  factory AreaReordered.fromJson(Map<String, dynamic> json) => _$AreaReorderedFromJson(json);

 final  String name;
 final  int newIndex;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaReorderedCopyWith<AreaReordered> get copyWith => _$AreaReorderedCopyWithImpl<AreaReordered>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreaReorderedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AreaReordered&&(identical(other.name, name) || other.name == name)&&(identical(other.newIndex, newIndex) || other.newIndex == newIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,newIndex);

@override
String toString() {
  return 'DocumentEvent.areaReordered(name: $name, newIndex: $newIndex)';
}


}

/// @nodoc
abstract mixin class $AreaReorderedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $AreaReorderedCopyWith(AreaReordered value, $Res Function(AreaReordered) _then) = _$AreaReorderedCopyWithImpl;
@useResult
$Res call({
 String name, int newIndex
});




}
/// @nodoc
class _$AreaReorderedCopyWithImpl<$Res>
    implements $AreaReorderedCopyWith<$Res> {
  _$AreaReorderedCopyWithImpl(this._self, this._then);

  final AreaReordered _self;
  final $Res Function(AreaReordered) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? newIndex = null,}) {
  return _then(AreaReordered(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == newIndex ? _self.newIndex : newIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CurrentAreaChanged extends DocumentEvent {
  const CurrentAreaChanged(this.name, {final  String? $type}): $type = $type ?? 'currentAreaChanged',super._();
  factory CurrentAreaChanged.fromJson(Map<String, dynamic> json) => _$CurrentAreaChangedFromJson(json);

 final  String name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentAreaChangedCopyWith<CurrentAreaChanged> get copyWith => _$CurrentAreaChangedCopyWithImpl<CurrentAreaChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentAreaChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentAreaChanged&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'DocumentEvent.currentAreaChanged(name: $name)';
}


}

/// @nodoc
abstract mixin class $CurrentAreaChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $CurrentAreaChangedCopyWith(CurrentAreaChanged value, $Res Function(CurrentAreaChanged) _then) = _$CurrentAreaChangedCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$CurrentAreaChangedCopyWithImpl<$Res>
    implements $CurrentAreaChangedCopyWith<$Res> {
  _$CurrentAreaChangedCopyWithImpl(this._self, this._then);

  final CurrentAreaChanged _self;
  final $Res Function(CurrentAreaChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(CurrentAreaChanged(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ExportPresetCreated extends DocumentEvent {
  const ExportPresetCreated(this.name, [final  List<AreaPreset> areas = const [], final  String? $type]): _areas = areas,$type = $type ?? 'exportPresetCreated',super._();
  factory ExportPresetCreated.fromJson(Map<String, dynamic> json) => _$ExportPresetCreatedFromJson(json);

 final  String name;
 final  List<AreaPreset> _areas;
@JsonKey() List<AreaPreset> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportPresetCreatedCopyWith<ExportPresetCreated> get copyWith => _$ExportPresetCreatedCopyWithImpl<ExportPresetCreated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExportPresetCreatedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportPresetCreated&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._areas, _areas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_areas));

@override
String toString() {
  return 'DocumentEvent.exportPresetCreated(name: $name, areas: $areas)';
}


}

/// @nodoc
abstract mixin class $ExportPresetCreatedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ExportPresetCreatedCopyWith(ExportPresetCreated value, $Res Function(ExportPresetCreated) _then) = _$ExportPresetCreatedCopyWithImpl;
@useResult
$Res call({
 String name, List<AreaPreset> areas
});




}
/// @nodoc
class _$ExportPresetCreatedCopyWithImpl<$Res>
    implements $ExportPresetCreatedCopyWith<$Res> {
  _$ExportPresetCreatedCopyWithImpl(this._self, this._then);

  final ExportPresetCreated _self;
  final $Res Function(ExportPresetCreated) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? areas = null,}) {
  return _then(ExportPresetCreated(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<AreaPreset>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ExportPresetUpdated extends DocumentEvent {
  const ExportPresetUpdated(this.name, final  List<AreaPreset> areas, {final  String? $type}): _areas = areas,$type = $type ?? 'exportPresetUpdated',super._();
  factory ExportPresetUpdated.fromJson(Map<String, dynamic> json) => _$ExportPresetUpdatedFromJson(json);

 final  String name;
 final  List<AreaPreset> _areas;
 List<AreaPreset> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportPresetUpdatedCopyWith<ExportPresetUpdated> get copyWith => _$ExportPresetUpdatedCopyWithImpl<ExportPresetUpdated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExportPresetUpdatedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportPresetUpdated&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._areas, _areas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_areas));

@override
String toString() {
  return 'DocumentEvent.exportPresetUpdated(name: $name, areas: $areas)';
}


}

/// @nodoc
abstract mixin class $ExportPresetUpdatedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ExportPresetUpdatedCopyWith(ExportPresetUpdated value, $Res Function(ExportPresetUpdated) _then) = _$ExportPresetUpdatedCopyWithImpl;
@useResult
$Res call({
 String name, List<AreaPreset> areas
});




}
/// @nodoc
class _$ExportPresetUpdatedCopyWithImpl<$Res>
    implements $ExportPresetUpdatedCopyWith<$Res> {
  _$ExportPresetUpdatedCopyWithImpl(this._self, this._then);

  final ExportPresetUpdated _self;
  final $Res Function(ExportPresetUpdated) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? areas = null,}) {
  return _then(ExportPresetUpdated(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<AreaPreset>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ExportPresetRemoved extends DocumentEvent {
  const ExportPresetRemoved(this.name, {final  String? $type}): $type = $type ?? 'exportPresetRemoved',super._();
  factory ExportPresetRemoved.fromJson(Map<String, dynamic> json) => _$ExportPresetRemovedFromJson(json);

 final  String name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportPresetRemovedCopyWith<ExportPresetRemoved> get copyWith => _$ExportPresetRemovedCopyWithImpl<ExportPresetRemoved>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExportPresetRemovedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportPresetRemoved&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'DocumentEvent.exportPresetRemoved(name: $name)';
}


}

/// @nodoc
abstract mixin class $ExportPresetRemovedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ExportPresetRemovedCopyWith(ExportPresetRemoved value, $Res Function(ExportPresetRemoved) _then) = _$ExportPresetRemovedCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$ExportPresetRemovedCopyWithImpl<$Res>
    implements $ExportPresetRemovedCopyWith<$Res> {
  _$ExportPresetRemovedCopyWithImpl(this._self, this._then);

  final ExportPresetRemoved _self;
  final $Res Function(ExportPresetRemoved) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(ExportPresetRemoved(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PackAdded extends DocumentEvent {
  const PackAdded(this.pack, {final  String? $type}): $type = $type ?? 'packAdded',super._();
  factory PackAdded.fromJson(Map<String, dynamic> json) => _$PackAddedFromJson(json);

 final  NoteData pack;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PackAddedCopyWith<PackAdded> get copyWith => _$PackAddedCopyWithImpl<PackAdded>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PackAddedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PackAdded&&(identical(other.pack, pack) || other.pack == pack));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pack);

@override
String toString() {
  return 'DocumentEvent.packAdded(pack: $pack)';
}


}

/// @nodoc
abstract mixin class $PackAddedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $PackAddedCopyWith(PackAdded value, $Res Function(PackAdded) _then) = _$PackAddedCopyWithImpl;
@useResult
$Res call({
 NoteData pack
});




}
/// @nodoc
class _$PackAddedCopyWithImpl<$Res>
    implements $PackAddedCopyWith<$Res> {
  _$PackAddedCopyWithImpl(this._self, this._then);

  final PackAdded _self;
  final $Res Function(PackAdded) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pack = null,}) {
  return _then(PackAdded(
null == pack ? _self.pack : pack // ignore: cast_nullable_to_non_nullable
as NoteData,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PackUpdated extends DocumentEvent {
  const PackUpdated(this.name, this.pack, {final  String? $type}): $type = $type ?? 'packUpdated',super._();
  factory PackUpdated.fromJson(Map<String, dynamic> json) => _$PackUpdatedFromJson(json);

 final  String name;
 final  NoteData pack;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PackUpdatedCopyWith<PackUpdated> get copyWith => _$PackUpdatedCopyWithImpl<PackUpdated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PackUpdatedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PackUpdated&&(identical(other.name, name) || other.name == name)&&(identical(other.pack, pack) || other.pack == pack));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,pack);

@override
String toString() {
  return 'DocumentEvent.packUpdated(name: $name, pack: $pack)';
}


}

/// @nodoc
abstract mixin class $PackUpdatedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $PackUpdatedCopyWith(PackUpdated value, $Res Function(PackUpdated) _then) = _$PackUpdatedCopyWithImpl;
@useResult
$Res call({
 String name, NoteData pack
});




}
/// @nodoc
class _$PackUpdatedCopyWithImpl<$Res>
    implements $PackUpdatedCopyWith<$Res> {
  _$PackUpdatedCopyWithImpl(this._self, this._then);

  final PackUpdated _self;
  final $Res Function(PackUpdated) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? pack = null,}) {
  return _then(PackUpdated(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == pack ? _self.pack : pack // ignore: cast_nullable_to_non_nullable
as NoteData,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PackRemoved extends DocumentEvent {
  const PackRemoved(this.name, {final  String? $type}): $type = $type ?? 'packRemoved',super._();
  factory PackRemoved.fromJson(Map<String, dynamic> json) => _$PackRemovedFromJson(json);

 final  String name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PackRemovedCopyWith<PackRemoved> get copyWith => _$PackRemovedCopyWithImpl<PackRemoved>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PackRemovedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PackRemoved&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'DocumentEvent.packRemoved(name: $name)';
}


}

/// @nodoc
abstract mixin class $PackRemovedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $PackRemovedCopyWith(PackRemoved value, $Res Function(PackRemoved) _then) = _$PackRemovedCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$PackRemovedCopyWithImpl<$Res>
    implements $PackRemovedCopyWith<$Res> {
  _$PackRemovedCopyWithImpl(this._self, this._then);

  final PackRemoved _self;
  final $Res Function(PackRemoved) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(PackRemoved(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AnimationAdded extends DocumentEvent {
  const AnimationAdded(this.animation, {final  String? $type}): $type = $type ?? 'animationAdded',super._();
  factory AnimationAdded.fromJson(Map<String, dynamic> json) => _$AnimationAddedFromJson(json);

 final  AnimationTrack animation;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimationAddedCopyWith<AnimationAdded> get copyWith => _$AnimationAddedCopyWithImpl<AnimationAdded>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimationAddedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimationAdded&&(identical(other.animation, animation) || other.animation == animation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,animation);

@override
String toString() {
  return 'DocumentEvent.animationAdded(animation: $animation)';
}


}

/// @nodoc
abstract mixin class $AnimationAddedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $AnimationAddedCopyWith(AnimationAdded value, $Res Function(AnimationAdded) _then) = _$AnimationAddedCopyWithImpl;
@useResult
$Res call({
 AnimationTrack animation
});


$AnimationTrackCopyWith<$Res> get animation;

}
/// @nodoc
class _$AnimationAddedCopyWithImpl<$Res>
    implements $AnimationAddedCopyWith<$Res> {
  _$AnimationAddedCopyWithImpl(this._self, this._then);

  final AnimationAdded _self;
  final $Res Function(AnimationAdded) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? animation = null,}) {
  return _then(AnimationAdded(
null == animation ? _self.animation : animation // ignore: cast_nullable_to_non_nullable
as AnimationTrack,
  ));
}

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnimationTrackCopyWith<$Res> get animation {
  
  return $AnimationTrackCopyWith<$Res>(_self.animation, (value) {
    return _then(_self.copyWith(animation: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class AnimationUpdated extends DocumentEvent {
  const AnimationUpdated(this.name, this.animation, {final  String? $type}): $type = $type ?? 'animationUpdated',super._();
  factory AnimationUpdated.fromJson(Map<String, dynamic> json) => _$AnimationUpdatedFromJson(json);

 final  String name;
 final  AnimationTrack animation;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimationUpdatedCopyWith<AnimationUpdated> get copyWith => _$AnimationUpdatedCopyWithImpl<AnimationUpdated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimationUpdatedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimationUpdated&&(identical(other.name, name) || other.name == name)&&(identical(other.animation, animation) || other.animation == animation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,animation);

@override
String toString() {
  return 'DocumentEvent.animationUpdated(name: $name, animation: $animation)';
}


}

/// @nodoc
abstract mixin class $AnimationUpdatedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $AnimationUpdatedCopyWith(AnimationUpdated value, $Res Function(AnimationUpdated) _then) = _$AnimationUpdatedCopyWithImpl;
@useResult
$Res call({
 String name, AnimationTrack animation
});


$AnimationTrackCopyWith<$Res> get animation;

}
/// @nodoc
class _$AnimationUpdatedCopyWithImpl<$Res>
    implements $AnimationUpdatedCopyWith<$Res> {
  _$AnimationUpdatedCopyWithImpl(this._self, this._then);

  final AnimationUpdated _self;
  final $Res Function(AnimationUpdated) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? animation = null,}) {
  return _then(AnimationUpdated(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == animation ? _self.animation : animation // ignore: cast_nullable_to_non_nullable
as AnimationTrack,
  ));
}

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnimationTrackCopyWith<$Res> get animation {
  
  return $AnimationTrackCopyWith<$Res>(_self.animation, (value) {
    return _then(_self.copyWith(animation: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class AnimationRemoved extends DocumentEvent {
  const AnimationRemoved(this.name, {final  String? $type}): $type = $type ?? 'animationRemoved',super._();
  factory AnimationRemoved.fromJson(Map<String, dynamic> json) => _$AnimationRemovedFromJson(json);

 final  String name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnimationRemovedCopyWith<AnimationRemoved> get copyWith => _$AnimationRemovedCopyWithImpl<AnimationRemoved>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnimationRemovedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnimationRemoved&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'DocumentEvent.animationRemoved(name: $name)';
}


}

/// @nodoc
abstract mixin class $AnimationRemovedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $AnimationRemovedCopyWith(AnimationRemoved value, $Res Function(AnimationRemoved) _then) = _$AnimationRemovedCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$AnimationRemovedCopyWithImpl<$Res>
    implements $AnimationRemovedCopyWith<$Res> {
  _$AnimationRemovedCopyWithImpl(this._self, this._then);

  final AnimationRemoved _self;
  final $Res Function(AnimationRemoved) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(AnimationRemoved(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PresentationModeEntered extends DocumentEvent {
  const PresentationModeEntered(this.track, this.fullScreen, {final  String? $type}): $type = $type ?? 'presentationModeEntered',super._();
  factory PresentationModeEntered.fromJson(Map<String, dynamic> json) => _$PresentationModeEnteredFromJson(json);

 final  AnimationTrack track;
 final  bool fullScreen;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PresentationModeEnteredCopyWith<PresentationModeEntered> get copyWith => _$PresentationModeEnteredCopyWithImpl<PresentationModeEntered>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PresentationModeEnteredToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PresentationModeEntered&&(identical(other.track, track) || other.track == track)&&(identical(other.fullScreen, fullScreen) || other.fullScreen == fullScreen));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,track,fullScreen);

@override
String toString() {
  return 'DocumentEvent.presentationModeEntered(track: $track, fullScreen: $fullScreen)';
}


}

/// @nodoc
abstract mixin class $PresentationModeEnteredCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $PresentationModeEnteredCopyWith(PresentationModeEntered value, $Res Function(PresentationModeEntered) _then) = _$PresentationModeEnteredCopyWithImpl;
@useResult
$Res call({
 AnimationTrack track, bool fullScreen
});


$AnimationTrackCopyWith<$Res> get track;

}
/// @nodoc
class _$PresentationModeEnteredCopyWithImpl<$Res>
    implements $PresentationModeEnteredCopyWith<$Res> {
  _$PresentationModeEnteredCopyWithImpl(this._self, this._then);

  final PresentationModeEntered _self;
  final $Res Function(PresentationModeEntered) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? track = null,Object? fullScreen = null,}) {
  return _then(PresentationModeEntered(
null == track ? _self.track : track // ignore: cast_nullable_to_non_nullable
as AnimationTrack,null == fullScreen ? _self.fullScreen : fullScreen // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnimationTrackCopyWith<$Res> get track {
  
  return $AnimationTrackCopyWith<$Res>(_self.track, (value) {
    return _then(_self.copyWith(track: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class PresentationModeExited extends DocumentEvent {
  const PresentationModeExited({final  String? $type}): $type = $type ?? 'presentationModeExited',super._();
  factory PresentationModeExited.fromJson(Map<String, dynamic> json) => _$PresentationModeExitedFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$PresentationModeExitedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PresentationModeExited);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DocumentEvent.presentationModeExited()';
}


}




/// @nodoc
@JsonSerializable()

class PresentationTick extends DocumentEvent {
  const PresentationTick(this.tick, {final  String? $type}): $type = $type ?? 'presentationTick',super._();
  factory PresentationTick.fromJson(Map<String, dynamic> json) => _$PresentationTickFromJson(json);

 final  int tick;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PresentationTickCopyWith<PresentationTick> get copyWith => _$PresentationTickCopyWithImpl<PresentationTick>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PresentationTickToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PresentationTick&&(identical(other.tick, tick) || other.tick == tick));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tick);

@override
String toString() {
  return 'DocumentEvent.presentationTick(tick: $tick)';
}


}

/// @nodoc
abstract mixin class $PresentationTickCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $PresentationTickCopyWith(PresentationTick value, $Res Function(PresentationTick) _then) = _$PresentationTickCopyWithImpl;
@useResult
$Res call({
 int tick
});




}
/// @nodoc
class _$PresentationTickCopyWithImpl<$Res>
    implements $PresentationTickCopyWith<$Res> {
  _$PresentationTickCopyWithImpl(this._self, this._then);

  final PresentationTick _self;
  final $Res Function(PresentationTick) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tick = null,}) {
  return _then(PresentationTick(
null == tick ? _self.tick : tick // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AssetUpdated extends DocumentEvent {
  const AssetUpdated(this.path, final  List<int> data, {final  String? $type}): _data = data,$type = $type ?? 'assetUpdated',super._();
  factory AssetUpdated.fromJson(Map<String, dynamic> json) => _$AssetUpdatedFromJson(json);

 final  String path;
 final  List<int> _data;
 List<int> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetUpdatedCopyWith<AssetUpdated> get copyWith => _$AssetUpdatedCopyWithImpl<AssetUpdated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetUpdatedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetUpdated&&(identical(other.path, path) || other.path == path)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,path,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'DocumentEvent.assetUpdated(path: $path, data: $data)';
}


}

/// @nodoc
abstract mixin class $AssetUpdatedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $AssetUpdatedCopyWith(AssetUpdated value, $Res Function(AssetUpdated) _then) = _$AssetUpdatedCopyWithImpl;
@useResult
$Res call({
 String path, List<int> data
});




}
/// @nodoc
class _$AssetUpdatedCopyWithImpl<$Res>
    implements $AssetUpdatedCopyWith<$Res> {
  _$AssetUpdatedCopyWithImpl(this._self, this._then);

  final AssetUpdated _self;
  final $Res Function(AssetUpdated) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? path = null,Object? data = null,}) {
  return _then(AssetUpdated(
null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ElementsLayerConverted extends DocumentEvent {
  const ElementsLayerConverted(final  List<String> elements, [this.name = '', final  String? $type]): _elements = elements,$type = $type ?? 'elementsLayerConverted',super._();
  factory ElementsLayerConverted.fromJson(Map<String, dynamic> json) => _$ElementsLayerConvertedFromJson(json);

 final  List<String> _elements;
 List<String> get elements {
  if (_elements is EqualUnmodifiableListView) return _elements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_elements);
}

@JsonKey() final  String name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElementsLayerConvertedCopyWith<ElementsLayerConverted> get copyWith => _$ElementsLayerConvertedCopyWithImpl<ElementsLayerConverted>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElementsLayerConvertedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElementsLayerConverted&&const DeepCollectionEquality().equals(other._elements, _elements)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_elements),name);

@override
String toString() {
  return 'DocumentEvent.elementsLayerConverted(elements: $elements, name: $name)';
}


}

/// @nodoc
abstract mixin class $ElementsLayerConvertedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $ElementsLayerConvertedCopyWith(ElementsLayerConverted value, $Res Function(ElementsLayerConverted) _then) = _$ElementsLayerConvertedCopyWithImpl;
@useResult
$Res call({
 List<String> elements, String name
});




}
/// @nodoc
class _$ElementsLayerConvertedCopyWithImpl<$Res>
    implements $ElementsLayerConvertedCopyWith<$Res> {
  _$ElementsLayerConvertedCopyWithImpl(this._self, this._then);

  final ElementsLayerConverted _self;
  final $Res Function(ElementsLayerConverted) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? elements = null,Object? name = null,}) {
  return _then(ElementsLayerConverted(
null == elements ? _self._elements : elements // ignore: cast_nullable_to_non_nullable
as List<String>,null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class EncryptionChanged extends DocumentEvent {
  const EncryptionChanged(this.password, {final  String? $type}): $type = $type ?? 'encryptionChanged',super._();
  factory EncryptionChanged.fromJson(Map<String, dynamic> json) => _$EncryptionChangedFromJson(json);

 final  String? password;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EncryptionChangedCopyWith<EncryptionChanged> get copyWith => _$EncryptionChangedCopyWithImpl<EncryptionChanged>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EncryptionChangedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EncryptionChanged&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString() {
  return 'DocumentEvent.encryptionChanged(password: $password)';
}


}

/// @nodoc
abstract mixin class $EncryptionChangedCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $EncryptionChangedCopyWith(EncryptionChanged value, $Res Function(EncryptionChanged) _then) = _$EncryptionChangedCopyWithImpl;
@useResult
$Res call({
 String? password
});




}
/// @nodoc
class _$EncryptionChangedCopyWithImpl<$Res>
    implements $EncryptionChangedCopyWith<$Res> {
  _$EncryptionChangedCopyWithImpl(this._self, this._then);

  final EncryptionChanged _self;
  final $Res Function(EncryptionChanged) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? password = freezed,}) {
  return _then(EncryptionChanged(
freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DocumentRebuilt extends DocumentEvent {
  const DocumentRebuilt(@Uint8ListJsonConverter() this.data, {final  String? $type}): $type = $type ?? 'documentRebuilt',super._();
  factory DocumentRebuilt.fromJson(Map<String, dynamic> json) => _$DocumentRebuiltFromJson(json);

@Uint8ListJsonConverter() final  Uint8List data;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentRebuiltCopyWith<DocumentRebuilt> get copyWith => _$DocumentRebuiltCopyWithImpl<DocumentRebuilt>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentRebuiltToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentRebuilt&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'DocumentEvent.documentRebuilt(data: $data)';
}


}

/// @nodoc
abstract mixin class $DocumentRebuiltCopyWith<$Res> implements $DocumentEventCopyWith<$Res> {
  factory $DocumentRebuiltCopyWith(DocumentRebuilt value, $Res Function(DocumentRebuilt) _then) = _$DocumentRebuiltCopyWithImpl;
@useResult
$Res call({
@Uint8ListJsonConverter() Uint8List data
});




}
/// @nodoc
class _$DocumentRebuiltCopyWithImpl<$Res>
    implements $DocumentRebuiltCopyWith<$Res> {
  _$DocumentRebuiltCopyWithImpl(this._self, this._then);

  final DocumentRebuilt _self;
  final $Res Function(DocumentRebuilt) _then;

/// Create a copy of DocumentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(DocumentRebuilt(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

// dart format on
