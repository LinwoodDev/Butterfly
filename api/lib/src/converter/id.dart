import 'package:freezed_annotation/freezed_annotation.dart';

import '../helpers/string.dart';

class const IdJsonConverter() extends JsonConverter<String?, String?> {
  @override
  String? fromJson(String? json) {
    json ??= '';
    return json.isEmpty ? createUniqueId() : json;
  }

  @override
  String? toJson(String? object) => object;
}
