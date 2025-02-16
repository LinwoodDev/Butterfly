import 'dart:math';

import 'package:dart_leap/dart_leap.dart';

SRGBColor getRandomColor([int seed = 0]) {
  final random = Random(seed);
  final color = random.nextInt(0xFFFFFF);
  return SRGBColor(color + 0xFF000000);
}
