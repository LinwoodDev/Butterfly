import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lw_file_system_api/lw_file_system_api.dart';

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
@JsonSerializable()
class PersistedToolSelection with _$PersistedToolSelection {
  const new({this.toolId, this.toolIndex});

  final String? toolId;
  final int? toolIndex;

  factory PersistedToolSelection.fromJson(Map<String, dynamic> json) =>
      _$PersistedToolSelectionFromJson(json);

  Map<String, dynamic> toJson() => _$PersistedToolSelectionToJson(this);
}

@freezed
@JsonSerializable()
class PersistedCameraState with _$PersistedCameraState {
  const new({
    this.positionX = 0,
    this.positionY = 0,
    this.zoom = 1,
    this.rotation = 0,
  });

  final double positionX;
  final double positionY;
  final double zoom;
  final double rotation;

  factory PersistedCameraState.fromJson(Map<String, dynamic> json) =>
      _$PersistedCameraStateFromJson(json);

  Map<String, dynamic> toJson() => _$PersistedCameraStateToJson(this);
}

@freezed
@JsonSerializable()
class PersistentLockState with _$PersistentLockState {
  const new({
    this.lockCollection = false,
    this.lockLayer = false,
    this.lockZoom = false,
    this.lockHorizontal = false,
    this.lockVertical = false,
    this.lockRotation = false,
  });

  final bool lockCollection;
  final bool lockLayer;
  final bool lockZoom;
  final bool lockHorizontal;
  final bool lockVertical;
  final bool lockRotation;

  factory PersistentLockState.fromJson(Map<String, dynamic> json) =>
      _$PersistentLockStateFromJson(json);

  Map<String, dynamic> toJson() => _$PersistentLockStateToJson(this);
}

@freezed
@JsonSerializable()
class PersistedNavigatorState with _$PersistedNavigatorState {
  const new({this.enabled = false, this.page = 'waypoints'});

  final bool enabled;
  final String page;

  factory PersistedNavigatorState.fromJson(Map<String, dynamic> json) =>
      _$PersistedNavigatorStateFromJson(json);

  Map<String, dynamic> toJson() => _$PersistedNavigatorStateToJson(this);
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
@JsonSerializable()
class PersistedAreaNavigatorState with _$PersistedAreaNavigatorState {
  const new({this.create = true, this.exact = true, this.ask = false});

  final bool create;
  final bool exact;
  final bool ask;

  factory PersistedAreaNavigatorState.fromJson(Map<String, dynamic> json) =>
      _$PersistedAreaNavigatorStateFromJson(json);

  Map<String, dynamic> toJson() => _$PersistedAreaNavigatorStateToJson(this);
}

@freezed
sealed class PersistedDocumentState with _$PersistedDocumentState {
  const PersistedDocumentState._();

  const factory PersistedDocumentState({
    @Default(kPersistedDocumentStateVersion) int version,
    @JsonKey(includeFromJson: false, includeToJson: false) String? pathKey,
    @JsonKey(includeFromJson: false, includeToJson: false) String? contentHash,
    String? pageName,
    @Default(PersistedCameraState()) PersistedCameraState camera,
    @Default({}) Map<String, PersistedCameraState> pageCameras,
    @Default(PersistentLockState()) PersistentLockState locks,
    @Default(PersistedToolSelection()) PersistedToolSelection selectedTool,
    @Default(PersistedNavigatorState()) PersistedNavigatorState navigator,
    @Default(PersistedLayerState()) PersistedLayerState layers,
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
