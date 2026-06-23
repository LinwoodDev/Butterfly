import 'package:butterfly/api/save.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sanitizes export filenames', () {
    expect(
      sanitizeExportFileName(r'Lecture: chapter 1/2?'),
      'Lecture_ chapter 1_2_',
    );
  });

  test('uses a fallback for empty export filenames', () {
    expect(sanitizeExportFileName('  '), 'output');
  });
}
