import 'package:freezed_annotation/freezed_annotation.dart';

import 'painter.dart';
import 'tool.dart';

part 'info.freezed.dart';
part 'info.g.dart';

@freezed
class DocumentInfo with _$DocumentInfo {
  const factory DocumentInfo({
    @Default([]) List<Painter> painters,
    @Default(ToolOption()) ToolOption tool,
  }) = _DocumentInfo;

  factory DocumentInfo.fromJson(Map<String, dynamic> json) =>
      _$DocumentInfoFromJson(json);
}
