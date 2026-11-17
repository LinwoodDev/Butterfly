import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  for (final reduceMotion in [false, true]) {
    testWidgets('context menu respects Reduce Motion = $reduceMotion', (
      tester,
    ) async {
      final settings = MockSettingsCubit();
      when(() => settings.state).thenReturn(
        const ButterflySettings(platformTheme: PlatformTheme.desktop),
      );
      when(() => settings.stream).thenAnswer((_) => const Stream.empty());
      var selected = false;
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SettingsCubit>.value(
            value: settings,
            child: MediaQuery(
              data: MediaQueryData(reduceMotion: reduceMotion),
              child: ContextMenu(
                builder: (_) => [
                  ContextMenuItem(
                    label: 'Select',
                    icon: const Icon(Icons.check),
                    onPressed: () => selected = true,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      final menu = find.byType(ContextMenu);
      SlideTransition slide() => tester.widget(
        find.descendant(of: menu, matching: find.byType(SlideTransition)),
      );
      FadeTransition fade() => tester.widget(
        find.descendant(of: menu, matching: find.byType(FadeTransition)),
      );
      expect(slide().position.value.dy, reduceMotion ? 0 : -.5);
      expect(fade().opacity.value, reduceMotion ? 0 : 1);
      await tester.pump(const Duration(milliseconds: 100));
      if (reduceMotion) {
        expect(slide().position.value, Offset.zero);
        expect(fade().opacity.value, inExclusiveRange(0, 1));
      } else {
        expect(slide().position.value.dy, inExclusiveRange(-.5, 0));
        expect(fade().opacity.value, 1);
      }
      await tester.pumpAndSettle();
      expect(slide().position.value, Offset.zero);
      expect(fade().opacity.value, 1);
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();
      expect(selected, isTrue);
    });
  }
}
