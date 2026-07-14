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

  test('resolves template filename date and time placeholders', () {
    expect(
      resolveTemplateFileName(
        'Daily {date:dd.MM.yyyy} {time:HH-mm-ss}',
        DateTime(2026, 7, 10, 9, 8, 7),
      ),
      'Daily 10.07.2026 09-08-07',
    );
  });

  test('resolves simple user-facing date and time placeholders', () {
    expect(
      resolveTemplateFileName(
        'Note {date} {time}',
        DateTime(2026, 7, 10, 9, 8),
      ),
      'Note 2026-07-10 09-08',
    );
  });

  test('rejects incomplete template filename placeholders', () {
    expect(
      () => resolveTemplateFileName('Daily {date:}', DateTime(2026)),
      throwsFormatException,
    );
  });
}
