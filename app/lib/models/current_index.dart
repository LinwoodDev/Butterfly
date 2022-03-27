import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../handlers/handler.dart';
import 'elements/element.dart';

part 'current_index.freezed.dart';

@freezed
class CurrentIndex with _$CurrentIndex {
  const factory CurrentIndex(int index, Handler handler,
      [@Default([]) List<PadElement> foregrounds,
      @Default([]) List<Rect> selections]) = _CurrentIndex;
}
