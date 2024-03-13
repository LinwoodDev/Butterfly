import 'package:freezed_annotation/freezed_annotation.dart';

import '../helpers/string.dart';

class IdJsonConverter extends JsonConverter<String, String?> {
  const IdJsonConverter();

  @override
  String fromJson(String? json) => json ?? createUniqueId();

  @override
  String? toJson(String object) => object;
}
