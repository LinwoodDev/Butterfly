import 'package:butterfly/widgets/number_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

void main() {
  Future<void> pumpInput(
    WidgetTester tester, {
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NumberInput(
            value: value,
            min: 0,
            step: 0.1,
            errorText: 'Error',
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  testWidgets('rejects a number outside the allowed range', (tester) async {
    final changes = <double>[];
    await pumpInput(tester, value: 5, onChanged: changes.add);

    await tester.enterText(find.byType(TextField), '-2');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(changes, isEmpty);
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.decoration?.errorText, 'Error');
  });

  testWidgets('marks an initial out-of-range value without changing it', (
    tester,
  ) async {
    final changes = <double>[];
    await pumpInput(tester, value: -2, onChanged: changes.add);

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller?.text, '-2.0');
    expect(field.decoration?.errorText, 'Error');
    expect(changes, isEmpty);
  });

  testWidgets('decrementing stops at the minimum', (tester) async {
    final changes = <double>[];
    await pumpInput(tester, value: 0.05, onChanged: changes.add);

    await tester.tap(find.byIcon(PhosphorIconsLight.minus));
    await tester.pump();

    expect(changes, [0]);
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller?.text, '0.0');
  });

  testWidgets('shows an invalid value in a compact toolbar', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: NumberInput(value: -2, min: 0, errorText: 'Error'),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });
}
