import 'dart:math';

import 'package:butterfly/helpers/actual_size.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_sysapi/lw_sysapi.dart';

void main() {
  test('rounded display dimensions keep uniform canvas proportions', () {
    final metrics = DisplayMetrics(dpiX: 120, dpiY: 122);
    expect(actualSizeZoom(metrics, 2), closeTo(sqrt(120 * 122) / 192, 1e-9));
  });
}
