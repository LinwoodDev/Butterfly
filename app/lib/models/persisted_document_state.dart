import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lw_file_system/lw_file_system.dart';

part 'persisted_document_state.freezed.dart';
part 'persisted_document_state.g.dart';

const kPersistedDocumentStateVersion = 1;

String documentStateContentKey(String contentHash) => 'content/$contentHash';

String documentStatePathKey(AssetLocation location) {
  final normalized = _normalizeDocumentStatePath(location.path);
  final bytes = utf8.encode('${location.remote}:$normalized');
  return 'path/${base64Url.encode(bytes)}';
}

String? documentStatePathKeyOrNull(AssetLocation? location) {
  if (location == null || location.path.isEmpty) return null;
  return documentStatePathKey(location);
}

String documentStateContentHash(Uint8List bytes) =>
    sha512256.convert(bytes).toString();

String _normalizeDocumentStatePath(String path) {
  path = path.replaceAll('\\', '/');
  while (path.contains('//')) {
    path = path.replaceAll('//', '/');
  }
  if (path.endsWith('/') && path.length > 1) {
    path = path.substring(0, path.length - 1);
  }
  if (path.isNotEmpty && !path.startsWith('/')) {
    path = '/$path';
  }
  return path;
}

@freezed
sealed class PersistedToolSelection with _$PersistedToolSelection {
  const factory PersistedToolSelection({String? toolId, int? toolIndex}) =
      _PersistedToolSelection;

  factory PersistedToolSelection.fromJson(Map<String, dynamic> json) =>
      _$PersistedToolSelectionFromJson(json);
}

@freezed
sealed class PersistedCameraState with _$PersistedCameraState {
  const factory PersistedCameraState({
    @Default(0) double positionX,
    @Default(0) double positionY,
    @Default(1) double zoom,
  }) = _PersistedCameraState;

  factory PersistedCameraState.fromJson(Map<String, dynamic> json) =>
      _$PersistedCameraStateFromJson(json);
}

@freezed
sealed class PersistentLockState with _$PersistentLockState {
  const PersistentLockState._();

  const factory PersistentLockState({
    @Default(false) bool lockCollection,
    @Default(false) bool lockLayer,
    @Default(false) bool lockZoom,
    @Default(false) bool lockHorizontal,
    @Default(false) bool lockVertical,
  }) = _PersistentLockState;

  factory PersistentLockState.fromJson(Map<String, dynamic> json) =>
      _$PersistentLockStateFromJson(json);
}

@freezed
sealed class PersistedNavigatorState with _$PersistedNavigatorState {
  const factory PersistedNavigatorState({
    @Default(false) bool enabled,
    @Default('waypoints') String page,
  }) = _PersistedNavigatorState;

  factory PersistedNavigatorState.fromJson(Map<String, dynamic> json) =>
      _$PersistedNavigatorStateFromJson(json);
}

@freezed
sealed class PersistedLayerState with _$PersistedLayerState {
  const factory PersistedLayerState({
    @Default('') String currentLayer,
    @Default('') String currentCollection,
    @Default({}) Set<String> invisibleLayers,
  }) = _PersistedLayerState;

  factory PersistedLayerState.fromJson(Map<String, dynamic> json) =>
      _$PersistedLayerStateFromJson(json);
}

@freezed
sealed class PersistedAreaNavigatorState with _$PersistedAreaNavigatorState {
  const factory PersistedAreaNavigatorState({
    @Default(true) bool create,
    @Default(true) bool exact,
    @Default(false) bool ask,
  }) = _PersistedAreaNavigatorState;

  factory PersistedAreaNavigatorState.fromJson(Map<String, dynamic> json) =>
      _$PersistedAreaNavigatorStateFromJson(json);
}

Object? _readLocks(Map json, String key) => json[key] ?? json['utilities'];

Object? _readNavigator(Map json, String key) =>
    json[key] ??
    <String, dynamic>{
      if (json.containsKey('navigatorEnabled'))
        'enabled': json['navigatorEnabled'],
      if (json.containsKey('navigatorPage')) 'page': json['navigatorPage'],
    };

Object? _readLayers(Map json, String key) =>
    json[key] ??
    <String, dynamic>{
      if (json.containsKey('currentLayer'))
        'currentLayer': json['currentLayer'],
      if (json.containsKey('currentCollection'))
        'currentCollection': json['currentCollection'],
      if (json.containsKey('invisibleLayers'))
        'invisibleLayers': json['invisibleLayers'],
    };

Object? _readAreaNavigator(Map json, String key) =>
    json[key] ??
    <String, dynamic>{
      if (json.containsKey('areaNavigatorCreate'))
        'create': json['areaNavigatorCreate'],
      if (json.containsKey('areaNavigatorExact'))
        'exact': json['areaNavigatorExact'],
      if (json.containsKey('areaNavigatorAsk')) 'ask': json['areaNavigatorAsk'],
    };

@freezed
sealed class PersistedDocumentState with _$PersistedDocumentState {
  const PersistedDocumentState._();

  const factory PersistedDocumentState({
    @Default(kPersistedDocumentStateVersion) int version,
    String? pathKey,
    String? contentHash,
    String? pageName,
    @Default(PersistedCameraState()) PersistedCameraState camera,
    @JsonKey(readValue: _readLocks)
    @Default(PersistentLockState())
    PersistentLockState locks,
    @Default(PersistedToolSelection()) PersistedToolSelection selectedTool,
    @JsonKey(readValue: _readNavigator)
    @Default(PersistedNavigatorState())
    PersistedNavigatorState navigator,
    @JsonKey(readValue: _readLayers)
    @Default(PersistedLayerState())
    PersistedLayerState layers,
    @JsonKey(readValue: _readAreaNavigator)
    @Default(PersistedAreaNavigatorState())
    PersistedAreaNavigatorState areaNavigator,
    DateTime? updatedAt,
  }) = _PersistedDocumentState;

  factory PersistedDocumentState.fromJson(Map<String, dynamic> json) =>
      _$PersistedDocumentStateFromJson(json);

  PersistedDocumentState touch({
    String? pathKey,
    String? contentHash,
    DateTime? now,
  }) => copyWith(
    pathKey: pathKey ?? this.pathKey,
    contentHash: contentHash ?? this.contentHash,
    updatedAt: now ?? DateTime.now().toUtc(),
  );
}

Uint8List encodePersistedDocumentState(PersistedDocumentState state) =>
    Uint8List.fromList(utf8.encode(json.encode(state.toJson())));

PersistedDocumentState decodePersistedDocumentState(Uint8List bytes) {
  final decoded = json.decode(utf8.decode(bytes));
  if (decoded is Map<String, dynamic>) {
    return PersistedDocumentState.fromJson(decoded);
  }
  if (decoded is Map) {
    return PersistedDocumentState.fromJson(decoded.cast<String, dynamic>());
  }
  throw const FormatException('Invalid persisted document state');
}
