import 'dart:async';
import 'dart:typed_data';

import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/import/confirmation.dart';
import 'package:butterfly/dialogs/import/pages.dart';
import 'package:butterfly/dialogs/load.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
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

  Future<void> mount(WidgetTester tester) async {
    final settings = MockSettingsCubit();
    when(() => settings.state).thenReturn(const ButterflySettings());
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
    expect(elements.map((e) => e.position.y), [0, 1000]);
    expect(result.areas.map((e) => e.position.y), [0, 1000]);
    expect(result.exportPresets.map((e) => e.name), ['first', 'second']);
    expect(find.byType(LoadingDialog), findsNothing);
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
