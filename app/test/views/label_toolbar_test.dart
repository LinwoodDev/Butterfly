import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/models/label.dart';
import 'package:butterfly/services/font.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/views/toolbar/label.dart';
import 'package:butterfly/visualizer/text.dart';
import 'package:butterfly/widgets/font_style_field.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../helpers/mocks.dart';

class _Bloc extends Mock implements DocumentBloc {}

class _Loaded extends Mock implements DocumentLoadSuccess {}

Future<void> _pumpToolbar(
  WidgetTester tester,
  TextContext value,
  ValueChanged<TextContext> onChanged,
) async {
  final bloc = _Bloc();
  final loaded = _Loaded();
  when(() => bloc.state).thenReturn(loaded);
  when(() => bloc.stream).thenAnswer((_) => const Stream.empty());
  when(() => loaded.data).thenReturn(NoteData(Archive()));
  await tester.pumpWidget(
    RepositoryProvider.value(
      value: FontService(MockButterflyFileSystem()),
      child: BlocProvider<DocumentBloc>.value(
        value: bloc,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Material(
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 60,
                child: StatefulBuilder(
                  builder: (context, setState) => LabelToolbarView(
                    value: value,
                    onChanged: (next) => setState(() {
                      value = next as TextContext;
                      onChanged(value);
                    }),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  for (final paragraphMode in [true, false]) {
    testWidgets(
      'first Bold click applies the inherited weight (paragraph: $paragraphMode)',
      (tester) async {
        final painter = TextPainter();
        addTearDown(painter.dispose);
        var value = TextContext(
          tool: LabelTool(),
          textPainter: painter,
          forceParagraph: paragraphMode,
          selection: const TextSelection(baseOffset: 0, extentOffset: 3),
          element: TextElement(
            area: const text.TextArea(
              paragraph: text.TextParagraph(
                textSpans: [text.InlineSpan.text(text: 'abc')],
              ),
            ),
          ),
        );

        await _pumpToolbar(tester, value, (next) => value = next);

        final bold = find.byWidgetPredicate(
          (widget) =>
              widget is PhosphorIcon && widget.icon == PhosphorIconsLight.textB,
        );
        await tester.ensureVisible(bold);
        await tester.tap(bold);
        await tester.pumpAndSettle();

        final paragraph = value.element!.area.paragraph;
        final weight = paragraphMode
            ? (paragraph.property as text.DefinedParagraphProperty)
                  .span
                  .fontWeight
            : (paragraph.textSpans.single.property as text.DefinedSpanProperty)
                  .fontWeight;
        expect(weight, text.kFontWeightBold);
      },
    );
  }

  testWidgets('font changes preserve styles outside and across the selection', (
    tester,
  ) async {
    final painter = TextPainter();
    addTearDown(painter.dispose);
    const styleSheet = NamedItem(
      name: 'test',
      item: text.TextStyleSheet(fontFamily: 'Roboto'),
    );
    var value = TextContext(
      tool: LabelTool(),
      textPainter: painter,
      selection: const TextSelection(baseOffset: 4, extentOffset: 1),
      element: TextElement(
        styleSheet: styleSheet,
        area: const text.TextArea(
          paragraph: text.TextParagraph(
            textSpans: [
              text.InlineSpan.text(
                text: 'abc',
                property: text.DefinedSpanProperty(
                  fontWeight: text.kFontWeightBold,
                ),
              ),
              text.InlineSpan.text(
                text: 'def',
                property: text.DefinedSpanProperty(italic: true),
              ),
            ],
          ),
        ),
      ),
    );
    await _pumpToolbar(tester, value, (next) => value = next);

    final fontField = find.byType(FontStyleField);
    tester.widget<FontStyleField>(fontField).onFontFamilyChanged('Comfortaa');
    await tester.pumpAndSettle();
    expect(tester.widget<FontStyleField>(fontField).fontFamily, 'Comfortaa');
    tester.widget<FontStyleField>(fontField).onFontFamilyFallbackChanged([
      'Inter',
    ]);
    await tester.pumpAndSettle();

    final element = value.element!;
    expect(element.styleSheet, styleSheet);
    final paragraph = element.area.paragraph;
    expect(text.TextParagraph.fromJson(paragraph.toJson()), paragraph);
    final spans = paragraph.textSpans;
    expect(spans.map((span) => span.text), ['a', 'bc', 'd', 'ef']);
    final properties = spans.map(
      (span) => span.property as text.DefinedSpanProperty,
    );
    expect(properties.map((span) => span.toFlutter().fontFamily), [
      'Roboto',
      'Comfortaa',
      'Comfortaa',
      'Roboto',
    ]);
    expect(properties.map((span) => span.toFlutter().fontFamilyFallback), [
      [],
      ['Inter'],
      ['Inter'],
      [],
    ]);
    expect(properties.map((span) => span.fontWeight), [6, 6, null, null]);
    expect(properties.map((span) => span.italic), [null, null, true, true]);
  });
}
