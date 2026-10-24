import 'package:butterfly/widgets/movable_dialog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Future<void> openDialog(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => showMovableDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Title'),
                content: const Text('Content'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
  }

  Rect dialogRect(WidgetTester tester) => tester.getRect(
    find
        .descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(Material),
        )
        .first,
  );

  testWidgets('dragging the title moves the dialog', (tester) async {
    await openDialog(tester);
    final before = dialogRect(tester);
    await tester.dragFrom(
      before.topCenter + const Offset(0, 24),
      const Offset(-200, 100),
    );
    await tester.pumpAndSettle();
    final after = dialogRect(tester);
    expect(after.size, before.size);
    expect(after.left, lessThan(before.left - 150));
    expect(after.top, greaterThan(before.top + 50));
  });

  testWidgets('dragging the content does not move the dialog', (tester) async {
    await openDialog(tester);
    final before = dialogRect(tester);
    await tester.drag(find.text('Content'), const Offset(-200, 100));
    await tester.pumpAndSettle();
    expect(dialogRect(tester), before);
  });

  testWidgets('dragging a corner resizes the dialog', (tester) async {
    await openDialog(tester);
    final before = dialogRect(tester);
    await tester.dragFrom(before.bottomRight, const Offset(200, 150));
    await tester.pumpAndSettle();
    final after = dialogRect(tester);
    expect(after.topLeft, before.topLeft);
    expect(after.width, greaterThan(before.width + 150));
    expect(after.height, greaterThan(before.height + 100));
    // The dialog stays usable and can still be closed.
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('tapping outside still dismisses the dialog', (tester) async {
    await openDialog(tester);
    await tester.tapAt(const Offset(5, 5));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  });
}
