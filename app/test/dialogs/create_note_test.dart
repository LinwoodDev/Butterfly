import 'package:butterfly/dialogs/file_system/create_note.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Future<void> openDialog(
    WidgetTester tester, {
    required ValueChanged<String?> onResult,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          LeapLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async => onResult(
                await showDialog<String>(
                  context: context,
                  builder: (_) => const CreateNoteDialog(),
                ),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
  }

  testWidgets('rejects empty titles and returns the original title on create', (
    tester,
  ) async {
    String? result;
    await openDialog(tester, onResult: (value) => result = value);
    for (final title in ['', '   ']) {
      await tester.enterText(find.byType(TextFormField), title);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(find.byType(CreateNoteDialog), findsOneWidget);
      expect(result, isNull);
    }
    await tester.enterText(find.byType(TextFormField), 'This / That');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(find.byType(CreateNoteDialog), findsNothing);
    expect(result, 'This / That');
  });

  testWidgets('long titles fit on a narrow screen and can be cancelled', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    var completed = false;
    await openDialog(
      tester,
      onResult: (value) {
        expect(value, isNull);
        completed = true;
      },
    );
    await tester.enterText(
      find.byType(TextFormField),
      List.filled(8, 'A long title / with invalid characters?').join(' '),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('replaced with underscores'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Cancel'));
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(completed, isTrue);
    expect(find.byType(CreateNoteDialog), findsNothing);
  });

  testWidgets(
    'invalid symbols update the preview without resizing the dialog',
    (tester) async {
      await openDialog(tester, onResult: (_) {});
      await tester.enterText(find.byType(TextFormField), 'This   That');
      await tester.pumpAndSettle();
      final before = tester.getSize(find.byType(AlertDialog));
      await tester.enterText(find.byType(TextFormField), 'This / That');
      await tester.pumpAndSettle();
      expect(find.text('This _ That.bfly'), findsOneWidget);
      expect(tester.getSize(find.byType(AlertDialog)), before);
    },
  );
}
