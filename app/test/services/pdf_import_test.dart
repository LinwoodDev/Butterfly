import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/import/confirmation.dart';
import 'package:butterfly/dialogs/import/pages.dart';
import 'package:butterfly/dialogs/load.dart';
import 'package:butterfly/helpers/pdf.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/widgets/area_size_picker.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdfrx/pdfrx.dart';

import '../helpers/mocks.dart';

class _Engine extends Mock implements PdfrxEntryFunctions {}

class _Document extends Mock implements PdfDocument {}

class _Page extends Mock implements PdfPage {}

void main() {
  late PdfrxEntryFunctions originalEngine;
  late _Engine engine;
  late _Document pdf;
  late _Page page;
  late ImportService service;
  final bytes = Uint8List.fromList([1, 2, 3]);

  setUp(() {
    originalEngine = PdfrxEntryFunctions.instance;
    engine = _Engine();
    PdfrxEntryFunctions.instance = engine;
    pdf = _Document();
    page = _Page();
    when(() => pdf.pages).thenReturn([page]);
    when(() => pdf.dispose()).thenAnswer((_) async {});
    when(() => page.width).thenReturn(2000);
    when(() => page.height).thenReturn(1000);
    when(() => engine.openData(bytes)).thenAnswer((_) async => pdf);
  });

  tearDown(() => PdfrxEntryFunctions.instance = originalEngine);

  Future<void> mount(WidgetTester tester, {bool spreadPages = false}) async {
    final settings = MockSettingsCubit();
    when(() => settings.state)
        .thenReturn(ButterflySettings(spreadPages: spreadPages));
    when(() => settings.stream).thenAnswer((_) => const Stream.empty());
    await tester.pumpWidget(
      BlocProvider<SettingsCubit>.value(
        value: settings,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              service = ImportService(context);
              return const Scaffold();
            },
          ),
        ),
      ),
    );
  }

  Future<void> closeError(WidgetTester tester) async {
    final dialog = find.byType(UnknownImportConfirmationDialog);
    expect(dialog, findsOneWidget);
    expect(find.byType(LoadingDialog), findsNothing);
    await tester.tap(
      find.descendant(of: dialog, matching: find.byType(TextButton)),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('PDF opening shows loading before the engine completes', (
    tester,
  ) async {
    await mount(tester);
    final opening = Completer<PdfDocument>();
    when(() => engine.openData(bytes)).thenAnswer((_) => opening.future);
    final importing = service.importPdf(
      bytes,
      DocumentDefaults.createDocument(),
    );
    await tester.pump();
    expect(find.byType(LoadingDialog), findsOneWidget);
    opening.completeError(StateError('PDF open failed'));
    await tester.pumpAndSettle();
    expect(find.textContaining('PDF open failed'), findsOneWidget);
    await closeError(tester);
    expect(await importing, isNull);
  });

  testWidgets('PDF batch keeps each file asset and its areas', (tester) async {
    await mount(tester);
    final otherBytes = Uint8List.fromList([4, 5, 6]);
    when(() => engine.openData(otherBytes)).thenAnswer((_) async => pdf);
    final importing = service.importBatch(
      [
        (AssetFileType.pdf, bytes, 'first'),
        (AssetFileType.pdf, otherBytes, 'second'),
      ],
      document: DocumentDefaults.createDocument(),
      advanced: false,
    );
    await tester.pumpAndSettle();
    final result = (await importing)!;
    final elements = result.elements.cast<PdfElement>();
    expect(elements.length, 2);
    expect(elements.first.source, isNot(elements.last.source));
    expect(result.assets[elements.first.source], bytes);
    expect(result.assets[elements.last.source], otherBytes);
    expect(elements.map((e) => e.position.y), [
      0,
      closeTo(1333.3333333333, 1e-8),
    ]);
    expect(result.areas.map((e) => e.position.y), [
      0,
      closeTo(1333.3333333333, 1e-8),
    ]);
    expect(result.exportPresets.map((e) => e.name), ['first', 'second']);
    expect(find.byType(LoadingDialog), findsNothing);
  });

  for (final spreadPages in [false, true]) {
    testWidgets(
      'A4 PDF pages import at 96 units per inch with spreadPages=$spreadPages',
      (tester) async {
        await mount(tester, spreadPages: spreadPages);
        when(() => page.width).thenReturn(595.2755905511812);
        when(() => page.height).thenReturn(841.8897637795276);

        final importing = service.importPdf(
          bytes,
          DocumentDefaults.createDocument(),
          position: const Offset(12, 34),
          advanced: false,
        );
        await tester.pumpAndSettle();
        final result = (await importing)!;
        final importedPage = spreadPages ? result.pages.single.$2 : null;
        final element =
            (importedPage?.layers.single.content.single ??
                    result.elements.single)
                as PdfElement;
        final area = (importedPage?.areas ?? result.areas).single;

        expect(element.width, closeTo(793.7007874016, 1e-9));
        expect(element.height, closeTo(1122.5196850394, 1e-9));
        expect(
          canvasUnitsToPdfPoints(element.width),
          closeTo(page.width, 1e-9),
        );
        expect(
          canvasUnitsToPdfPoints(element.height),
          closeTo(page.height, 1e-9),
        );
        expect(area.width, closeTo(element.width, 1e-9));
        expect(area.height, closeTo(element.height, 1e-9));
        expect(element.position, const Point(12.0, 34.0));
        expect(area.position, element.position);
        expect(result.assets[element.source], bytes);

        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: AreaSizePicker(
                width: area.width,
                height: area.height,
                onChanged: (_) {},
              ),
            ),
          ),
        );
        expect(
          tester
              .widget<DropdownMenuFormField<AreaSizePreset>>(
                find.byType(DropdownMenuFormField<AreaSizePreset>),
              )
              .initialValue,
          AreaSizePreset.a4,
        );
      },
    );
  }

  testWidgets('PDF import preserves existing document content and tools', (
    tester,
  ) async {
    await mount(tester);
    final existingPdf = PdfElement(
      id: 'existing-pdf',
      source: 'existing.pdf',
      width: 210,
      height: 297,
      position: const Point(10, 20),
    );
    final existingPage = DocumentPage(
      layers: [
        DocumentLayer(id: 'existing-layer', content: [existingPdf]),
      ],
      areas: [const Area(width: 210, height: 297, position: Point(10, 20))],
    );
    final document = DocumentDefaults.createDocument(page: existingPage);
    final tools = document.getInfo()!.tools;
    final importing = service.importPdf(bytes, document, advanced: false);
    await tester.pumpAndSettle();
    final result = (await importing)!;

    expect(result.document, same(document));
    expect(result.document!.getPage(), existingPage);
    expect(result.document!.getInfo()!.tools, tools);
    expect(existingPdf.width, 210);
    expect(existingPdf.height, 297);
    expect(existingPdf.position, const Point(10, 20));
  });

  for (final returnsNull in [false, true]) {
    testWidgets(
      'preview ${returnsNull ? 'null result' : 'failure'} closes loading and allows retry',
      (tester) async {
        await mount(tester);
        when(
          () => page.render(
            width: any(named: 'width'),
            height: any(named: 'height'),
            fullWidth: any(named: 'fullWidth'),
            fullHeight: any(named: 'fullHeight'),
          ),
        ).thenAnswer((_) async {
          if (returnsNull) return null;
          throw StateError('PDF render failed');
        });
        final importing = service.importPdf(
          bytes,
          DocumentDefaults.createDocument(),
        );
        await tester.pumpAndSettle();
        expect(find.byType(ImportPagesDialog), findsNothing);
        await closeError(tester);
        expect(await importing, isNull);
        verify(() => pdf.dispose()).called(1);
        verify(
          () => page.render(
            width: 512,
            height: 256,
            fullWidth: 512,
            fullHeight: 256,
          ),
        ).called(1);

        final retry = service.importPdf(
          bytes,
          DocumentDefaults.createDocument(),
          advanced: false,
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 10));
        final result = await retry;
        expect(result, isNotNull);
        expect(result!.elements.length + result.pages.length, 1);
        await tester.pumpAndSettle();
        expect(find.byType(LoadingDialog), findsNothing);
        verify(() => pdf.dispose()).called(1);
      },
    );
  }
}
