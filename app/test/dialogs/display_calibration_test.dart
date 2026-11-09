import 'package:butterfly/dialogs/display_calibration.dart';
import 'package:butterfly/helpers/actual_size.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Future<void> openDialog(
    WidgetTester tester,
    ValueChanged<double?> onResult, {
    double? initialZoom,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async => onResult(
                await showDialog<double>(
                  context: context,
                  builder: (_) =>
                      DisplayCalibrationDialog(initialZoom: initialZoom),
                ),
              ),
              child: const Text('Calibrate'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Calibrate'));
    await tester.pumpAndSettle();
  }

  Future<void> chooseMethod(WidgetTester tester, String name) async {
    await tester.tap(find.byKey(const ValueKey('display-calibration-method')));
    await tester.pumpAndSettle();
    await tester.tap(find.text(name).last);
    await tester.pumpAndSettle();
  }

  testWidgets(
    'guided adjustment matches a known length and supports fine adjustments',
    (tester) async {
      double? result;
      await openDialog(tester, (value) => result = value);
      expect(
        find.text('How would you like to calibrate your display?'),
        findsOneWidget,
      );
      final slider = find.byKey(
        const ValueKey('display-calibration-adjustment'),
      );
      tester.widget<Slider>(slider).onChanged!(1);
      await tester.pump();
      final ruler = find.byKey(const ValueKey('display-calibration-ruler'));
      expect(
        tester.getSize(ruler).width,
        closeTo(50 * kCanvasUnitsPerMillimeter, 1e-8),
      );
      await tester.enterText(
        find.byKey(const ValueKey('display-calibration-reference-length')),
        '25',
      );
      await tester.pump();
      expect(
        tester.getSize(ruler).width,
        closeTo(25 * kCanvasUnitsPerMillimeter, 1e-8),
      );
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byTooltip('Zoom in'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Zoom in'));
      await tester.pump();
      expect(
        tester.getSize(ruler).width,
        closeTo(25 * kCanvasUnitsPerMillimeter * 1.001, 1e-8),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pumpAndSettle();
      expect(result, closeTo(1.001, 1e-9));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'measurement accepts decimal commas and rejects invalid or unsupported lengths',
    (tester) async {
      double? result;
      await openDialog(tester, (value) => result = value);
      await chooseMethod(tester, 'Measure the line');
      final input = find.byKey(const ValueKey('display-calibration-length'));
      final save = find.widgetWithText(FilledButton, 'Save');
      for (final value in ['', '0', '-1', 'NaN', 'Infinity', '2']) {
        await tester.enterText(input, value);
        await tester.pump();
        expect(tester.widget<FilledButton>(save).onPressed, isNull);
      }
      await tester.enterText(input, '40,0');
      await tester.pump();
      await tester.tap(save);
      await tester.pumpAndSettle();
      expect(result, closeTo(5 / kCanvasUnitsPerMillimeter, 1e-9));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('manual PPI loads existing sizing and converts at DPR 2', (
    tester,
  ) async {
    const ratio = 2.0;
    tester.view.devicePixelRatio = ratio;
    tester.view.physicalSize = Size(800 * ratio, 600 * ratio);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    double? result;
    await openDialog(tester, (value) => result = value, initialZoom: 1.5);
    await chooseMethod(tester, 'Enter display data');
    final input = find.byKey(const ValueKey('display-calibration-dpi'));
    expect(
      double.parse(tester.widget<TextField>(input).controller!.text),
      closeTo(288, 1e-9),
    );
    final save = find.widgetWithText(FilledButton, 'Save');
    for (final value in ['0', '-1', 'NaN', 'Infinity', '999999']) {
      await tester.enterText(input, value);
      await tester.pump();
      expect(tester.widget<FilledButton>(save).onPressed, isNull);
    }
    await tester.enterText(input, '254');
    await tester.pump();
    await tester.tap(save);
    await tester.pumpAndSettle();
    expect(result, closeTo(254 / (kCanvasUnitsPerInch * ratio), 1e-9));
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'guided calibration fits a narrow screen and cancel returns no value',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(360, 640);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      double? result = -1;
      await openDialog(tester, (value) => result = value);
      await tester.enterText(
        find.byKey(const ValueKey('display-calibration-reference-length')),
        '0',
      );
      await tester.pump();
      expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, 'Save'))
            .onPressed,
        isNull,
      );
      await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
      await tester.pumpAndSettle();
      expect(result, isNull);
      expect(tester.takeException(), isNull);
    },
  );
}
