import 'package:butterfly/dialogs/export/batch.dart';
import 'package:butterfly/services/batch_export.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/export.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Future<void> setWindowSize(WidgetTester tester, Size size) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  await tester.binding.setSurfaceSize(size);
  addTearDown(() {
    tester.view.resetDevicePixelRatio();
    tester.view.resetPhysicalSize();
    return tester.binding.setSurfaceSize(null);
  });
}

Future<void> selectFormat(WidgetTester tester, String format) async {
  await tester.ensureVisible(find.byKey(const ValueKey('export-format')));
  await tester.tap(find.byKey(const ValueKey('export-format')));
  await tester.pumpAndSettle();
  final group = ['PNG', 'JPG', 'WebP'].contains(format)
      ? 'Images'
      : ['SVG', 'PDF'].contains(format)
      ? 'Vector & PDF'
      : 'Other images';
  await tester.tap(find.widgetWithText(SubmenuButton, group));
  await tester.pumpAndSettle();
  await tester.ensureVisible(find.text(format).last);
  await tester.tap(find.text(format).last);
  await tester.pumpAndSettle();
}

class _UntitledSource extends Mock implements ExportSource {}

void main() {
  setUpAll(() => registerFallbackValue(ExportTestSource().view()));
  testWidgets('unnamed page keeps its label and both pane headings align', (
    tester,
  ) async {
    await setWindowSize(tester, const Size(1100, 850));
    final source = _UntitledSource();
    when(() => source.documentName).thenReturn('Note');
    when(() => source.presets).thenReturn([]);
    when(() => source.pages).thenReturn([('', '0.')]);
    when(() => source.canPin).thenReturn(false);
    when(() => source.renderPng(any(), preview: true))
        .thenAnswer((_) async => null);
    when(() => source.view()).thenReturn(
      ExportItem(
        '',
        '0.',
        const ImageExportOptions(width: 100, height: 100),
        region: .view,
      ),
    );
    when(() => source.page('0.')).thenAnswer(
      (_) async => ExportItem(
        '',
        '0.',
        const ImageExportOptions(width: 80.123456, height: 60),
        region: .page,
      ),
    );
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          LeapLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: BatchExportDialog(source: source)),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      tester.getCenter(find.text('Current view')).dy,
      closeTo(tester.getCenter(find.text('Export as')).dy, 1),
    );
    await tester.tap(find.byTooltip('Current page'));
    await tester.pumpAndSettle();
    expect(find.text('Current page'), findsOneWidget);
    expect(find.text('Custom'), findsNothing);
    expect(
      tester
          .widget<SegmentedButton<ExportRegion>>(
            find.byKey(const ValueKey('export-region')),
          )
          .selected,
      {ExportRegion.page},
    );
    expect(
      tester
          .widget<TextField>(find.widgetWithText(TextField, 'Width'))
          .controller!
          .text,
      '80.123',
    );
    await tester.enterText(find.widgetWithText(TextField, 'Width'), '90');
    await tester.pumpAndSettle();
    expect(find.text('Custom'), findsOneWidget);
    expect(
      tester
          .widget<SegmentedButton<ExportRegion>>(
            find.byKey(const ValueKey('export-region')),
          )
          .selected,
      isEmpty,
    );
    await selectFormat(tester, 'PDF');
    final tileFinder = find.widgetWithText(ListTile, 'Custom');
    expect(tester.widget<ListTile>(tileFinder).subtitle, isNull);
    expect(
      tester
          .getCenter(
            find.descendant(of: tileFinder, matching: find.text('Custom')),
          )
          .dy,
      closeTo(
        tester
            .getCenter(
              find.descendant(of: tileFinder, matching: find.text('1')),
            )
            .dy,
        1,
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('adding an export preserves the first item; PDF keeps the list', (
    tester,
  ) async {
    await setWindowSize(tester, const Size(1100, 850));
    await tester.pumpWidget(const ExportTestApp());
    await tester.pumpAndSettle();
    expect(find.text('Export items'), findsNothing);
    expect(find.textContaining('960 × 540 px'), findsOneWidget);
    final sizeLabel = find.text('Size');
    final widthField = find.widgetWithText(TextField, 'Width');
    final heightField = find.widgetWithText(TextField, 'Height');
    for (final field in [widthField, heightField]) {
      expect(
        tester.getCenter(field).dy,
        closeTo(tester.getCenter(sizeLabel).dy, 1),
      );
    }
    await tester.tap(find.byTooltip('Current page'));
    await tester.pumpAndSettle();
    expect(find.textContaining('794 × 1123 px'), findsOneWidget);
    await tester.tap(find.byTooltip('Current view'));
    await tester.pumpAndSettle();
    expect(find.textContaining('960 × 540 px'), findsOneWidget);
    await tester.tap(find.byTooltip('Add export'));
    await tester.pumpAndSettle();
    expect(find.byType(SimpleDialog), findsNothing);
    expect(
      find.widgetWithText(MenuItemButton, 'All pages in note'),
      findsOneWidget,
    );
    await tester.tap(find.text('Current page'));
    await tester.pumpAndSettle();
    expect(find.text('Export items'), findsOneWidget);
    expect(find.text('Current view'), findsOneWidget);
    expect(find.text('Field notes.zip'), findsOneWidget);
    final pane = find.byKey(const ValueKey('export-preview-scroll'));
    expect(
      tester.getTopLeft(find.widgetWithText(ListTile, 'Current view')).dx -
          tester.getTopLeft(pane).dx,
      8,
    );
    await selectFormat(tester, 'PDF');
    await tester.tap(find.byTooltip('Remove').last);
    await tester.pumpAndSettle();
    expect(find.text('Export items'), findsOneWidget);
    expect(find.textContaining('1 page · One PDF'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('presets select areas without changing format', (tester) async {
    await setWindowSize(tester, const Size(1100, 850));
    await tester.pumpWidget(const ExportTestApp());
    await tester.pumpAndSettle();
    await selectFormat(tester, 'SVG');
    await tester.tap(find.byTooltip('Presets'));
    await tester.pumpAndSettle();
    expect(find.byType(Dialog), findsOneWidget);
    expect(
      find.widgetWithText(MenuItemButton, 'Save current selection…'),
      findsOneWidget,
    );
    await tester.tap(find.text('Botanical studies'));
    await tester.pumpAndSettle();
    expect(find.textContaining('2 SVG images'), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Botanical study'), findsOneWidget);
    expect(find.text('Leaf details'), findsOneWidget);
    await tester.tap(find.byTooltip('Presets'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save current selection…'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(TextField),
      ),
      'Saved selection',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Create'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Presets'));
    await tester.pumpAndSettle();
    expect(
      find.widgetWithText(MenuItemButton, 'Saved selection'),
      findsOneWidget,
    );
    await tester.tap(find.text('Saved selection'));
    await tester.pumpAndSettle();
    expect(find.textContaining('2 SVG images'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('grouped format menu supports JPG, WebP and TIFF', (
    tester,
  ) async {
    await setWindowSize(tester, const Size(1100, 850));
    await tester.pumpWidget(const ExportTestApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('export-format')));
    await tester.pumpAndSettle();
    for (final label in ['Images', 'Vector & PDF', 'Other images']) {
      expect(find.widgetWithText(SubmenuButton, label), findsOneWidget);
    }
    await tester.tap(find.widgetWithText(SubmenuButton, 'Images'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('JPG').last);
    await tester.pumpAndSettle();
    expect(find.text('Field notes.jpg'), findsOneWidget);
    await selectFormat(tester, 'WebP');
    expect(find.text('Field notes.webp'), findsOneWidget);
    await selectFormat(tester, 'TIFF');
    expect(find.text('Field notes.tiff'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('icon and texture limits are explained before export', (
    tester,
  ) async {
    await setWindowSize(tester, const Size(1100, 850));
    await tester.pumpWidget(const ExportTestApp());
    await tester.pumpAndSettle();
    await selectFormat(tester, 'ICO');
    expect(find.textContaining('ICO and CUR require'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Export'))
          .onPressed,
      isNull,
    );
    await tester.enterText(find.widgetWithText(TextField, 'Width'), '128');
    await tester.enterText(find.widgetWithText(TextField, 'Height'), '128');
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Export'))
          .onPressed,
      isNotNull,
    );
    await selectFormat(tester, 'PVR');
    expect(find.textContaining('PVR requires'), findsNothing);
    await tester.enterText(find.widgetWithText(TextField, 'Width'), '100');
    await tester.pumpAndSettle();
    expect(find.textContaining('PVR requires'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Export'))
          .onPressed,
      isNull,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('desktop preview and settings scroll independently', (
    tester,
  ) async {
    await setWindowSize(tester, const Size(1100, 850));
    await tester.pumpWidget(const ExportTestApp());
    await tester.pumpAndSettle();
    for (var i = 0; i < 2; i++) {
      await tester.tap(find.byTooltip('Add export'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('All pages in note'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('More options'));
    await tester.pumpAndSettle();
    final left = find.byKey(const ValueKey('export-preview-scroll'));
    final right = find.byKey(const ValueKey('export-settings-scroll'));
    ScrollPosition position(Finder panel) => tester
        .state<ScrollableState>(
          find.descendant(of: panel, matching: find.byType(Scrollable)).first,
        )
        .position;
    final leftPosition = position(left), rightPosition = position(right);
    final footerBefore = tester.getCenter(find.text('Field notes.zip'));
    await tester.drag(right, const Offset(0, -250));
    await tester.pumpAndSettle();
    expect(rightPosition.pixels, greaterThan(0));
    expect(leftPosition.pixels, 0);
    final rightOffset = rightPosition.pixels;
    await tester.drag(left, const Offset(0, -250));
    await tester.pumpAndSettle();
    expect(leftPosition.pixels, greaterThan(0));
    expect(rightPosition.pixels, rightOffset);
    expect(tester.getCenter(find.text('Field notes.zip')), footerBefore);
    expect(tester.takeException(), isNull);
  });

  for (final width in [712.0, 1100.0]) {
    testWidgets('desktop sliders share one row at $width pixels', (
      tester,
    ) async {
      await setWindowSize(tester, Size(width, 850));
      await tester.pumpWidget(const ExportTestApp());
      await tester.pumpAndSettle();
      final row = find.byKey(const ValueKey('export-slider-Quality'));
      final label = find.descendant(of: row, matching: find.text('Quality'));
      final slider = find.descendant(of: row, matching: find.byType(Slider));
      final value = find.descendant(of: row, matching: find.byType(TextField));
      final reset = find.descendant(of: row, matching: find.byType(IconButton));
      for (final control in [slider, value, reset]) {
        expect(
          tester.getCenter(control).dy,
          closeTo(tester.getCenter(label).dy, 1),
        );
      }
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets(
    'mobile keeps preview and settings together without losing edits',
    (tester) async {
      await setWindowSize(tester, const Size(390, 844));
      await tester.pumpWidget(const ExportTestApp());
      await tester.pumpAndSettle();
      expect(find.textContaining('960 × 540 px'), findsOneWidget);
      expect(find.text('Quality'), findsOneWidget);
      await tester.ensureVisible(find.byType(CheckboxListTile));
      await tester.tap(find.byType(CheckboxListTile));
      await tester.pumpAndSettle();
      expect(
        tester.widget<CheckboxListTile>(find.byType(CheckboxListTile)).value,
        isFalse,
      );
      await tester.ensureVisible(find.byTooltip('Expand preview'));
      await tester.tap(find.byTooltip('Expand preview'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Collapse preview'));
      await tester.pumpAndSettle();
      expect(
        tester.widget<CheckboxListTile>(find.byType(CheckboxListTile)).value,
        isFalse,
      );
      expect(tester.takeException(), isNull);
    },
  );

  for (final width in [320.0, 736.0]) {
    testWidgets('export dialog fits a $width pixel window', (tester) async {
      await setWindowSize(tester, Size(width, 850));
      await tester.pumpWidget(const ExportTestApp());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.tap(find.byTooltip('Add export'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('All pages in note'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.text('More options'));
      await tester.tap(find.text('More options'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
