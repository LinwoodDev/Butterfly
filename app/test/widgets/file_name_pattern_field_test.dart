import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/widgets/file_name_pattern_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('filename pattern dialog shows full help and a live preview', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => showFileNamePatternDialog(
                context,
                initialValue: '{date}',
                label: 'Default file name',
              ),
              child: const Text('Configure'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Configure'));
    await tester.pumpAndSettle();

    final helpFinder = find.textContaining(
      'Documents opened from the template picker are saved automatically',
    );
    expect(helpFinder, findsOneWidget);
    final help = tester.widget<Text>(helpFinder);
    expect(help.maxLines, isNull);
    expect(help.overflow, isNull);
    expect(find.textContaining('{date}  →'), findsOneWidget);
    expect(find.textContaining('{time}  →'), findsOneWidget);
    expect(find.textContaining('Preview:'), findsOneWidget);

    final dialog = tester.widget<AlertDialog>(find.byType(AlertDialog));
    expect(dialog.constraints?.maxWidth, 420);

    await tester.enterText(find.byType(TextFormField), 'Notes {date}');
    await tester.pump();

    expect(find.textContaining('Preview: Notes '), findsOneWidget);
  });
}
