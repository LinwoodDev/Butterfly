import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'export.dart';
import 'painter.dart';
import 'tool.dart';

part 'info.freezed.dart';
part 'info.g.dart';

@freezed
class DocumentInfo with _$DocumentInfo {
  const factory DocumentInfo({
    @Default([]) List<Painter> painters,
    @Default([]) List<ExportPreset> exportPresets,
    @Default(ToolOption()) ToolOption tool,
  }) = _DocumentInfo;

  factory DocumentInfo.fromJson(Map<String, dynamic> json) =>
      _$DocumentInfoFromJson(json);
}

extension DocumentInfoGetter on DocumentInfo {
  ExportPreset? getExportPreset(String name) {
    return exportPresets.firstWhereOrNull((e) => e.name == name);
  }
}
