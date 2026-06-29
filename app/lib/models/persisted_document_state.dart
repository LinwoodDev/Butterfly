import 'dart:convert';
import 'dart:typed_data';

import 'package:butterfly_api/butterfly_api.dart';
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
sealed class PersistedDocumentState with _$PersistedDocumentState {
  const PersistedDocumentState._();

  const factory PersistedDocumentState({
    @Default(kPersistedDocumentStateVersion) int version,
    String? pathKey,
    String? contentHash,
    String? pageName,
    @Default(PersistedCameraState()) PersistedCameraState camera,
    @Default(UtilitiesState()) UtilitiesState utilities,
    @Default(PersistedToolSelection()) PersistedToolSelection selectedTool,
    @Default(false) bool navigatorEnabled,
    @Default('waypoints') String navigatorPage,
    @Default('') String currentLayer,
    @Default('') String currentCollection,
    @Default({}) Set<String> invisibleLayers,
    @Default(true) bool areaNavigatorCreate,
    @Default(true) bool areaNavigatorExact,
    @Default(false) bool areaNavigatorAsk,
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
