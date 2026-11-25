import 'dart:math';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/area/thumbnail.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

class _MockDocumentBloc extends Mock implements DocumentBloc {}

void main() {
  const source = PersistedThumbnailArea(pageName: 'Page', areaName: 'Cover');
  setUpAll(() => registerFallbackValue(source));

  testWidgets(
    'compact area thumbnail dialog previews framing and applies alignment',
    (tester) async {
      tester.view.physicalSize = const Size(400, 700);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final settings = MockSettingsCubit();
      when(() => settings.state).thenReturn(const ButterflySettings());
      when(() => settings.stream).thenAnswer((_) => const Stream.empty());
      final controller = EditorController(
        settings,
        TransformCubit(1),
        CameraViewport.unbaked(),
      );
      addTearDown(controller.close);
      final bloc = _MockDocumentBloc();
      when(() => bloc.editorController).thenReturn(controller);
      final previews = <PersistedThumbnailArea>[];
      when(() => bloc.renderAreaThumbnail(any()))
          .thenAnswer((invocation) async {
            previews.add(
              invocation.positionalArguments.single as PersistedThumbnailArea,
            );
            return null;
          });
      PersistedThumbnailArea? captured;
      when(() => bloc.captureAreaThumbnail(any()))
          .thenAnswer((invocation) async {
            captured =
                invocation.positionalArguments.single as PersistedThumbnailArea;
            return true;
          });
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            LeapLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (context) => AreaThumbnailDialog(
                    bloc: bloc,
                    pageName: 'Page',
                    area: const Area(
                      name: 'Cover',
                      position: Point(0, 0),
                      width: 100,
                      height: 200,
                    ),
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
      expect(previews.last, source);
      expect(find.text('Hide content outside the area'), findsOneWidget);
      await tester.tap(find.byType(SwitchListTile));
      await tester.pumpAndSettle();
      expect(previews.last.clip, isFalse);
      await tester.tap(find.text('Fill thumbnail'));
      await tester.pumpAndSettle();
      expect(find.text('Hide content outside the area'), findsNothing);
      await tester.ensureVisible(find.byTooltip('Bottom right'));
      await tester.tap(find.byTooltip('Bottom right'));
      await tester.pumpAndSettle();
      expect(previews.last.fit, ThumbnailAreaFit.fill);
      expect(previews.last.alignment, ThumbnailAreaAlignment.bottomRight);
      expect(tester.takeException(), isNull);
      await tester.tap(find.widgetWithText(FilledButton, 'Set as thumbnail'));
      await tester.pumpAndSettle();
      expect(captured, previews.last);
      expect(find.byType(AreaThumbnailDialog), findsNothing);
    },
  );
}
