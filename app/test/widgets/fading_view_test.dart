import 'dart:ui' show PointerDeviceKind;

import 'package:butterfly/widgets/fading_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/rendering.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Widget buildView({
    bool autoHide = true,
    Object? activityKey,
    Widget child = const ColoredBox(
      color: Colors.white,
      child: SizedBox(key: ValueKey('controls'), width: 300, height: 80),
    ),
  }) => MaterialApp(
    home: Scaffold(
      body: Align(
        alignment: Alignment.topLeft,
        child: FadingView(
          autoHide: autoHide,
          activityKey: activityKey,
          child: child,
        ),
      ),
    ),
  );

  final controls = find.byKey(const ValueKey('controls'));

  testWidgets('fading eases gradually and reverses without an opacity jump', (
    tester,
  ) async {
    await tester.pumpWidget(buildView());
    RenderAnimatedOpacity opacity() => tester
        .renderObject<RenderAnimatedOpacity>(find.byType(AnimatedOpacity));
    await tester.pump(const Duration(seconds: 5));
    await tester.pump(const Duration(milliseconds: 125));
    expect(opacity().opacity.value, inExclusiveRange(0.75, 1));
    await tester.pump(const Duration(milliseconds: 125));
    final halfway = opacity().opacity.value;
    expect(halfway, closeTo(0.5, 0.01));

    await tester.pumpWidget(buildView(activityKey: 1));
    expect(opacity().opacity.value, closeTo(halfway, 0.001));
    await tester.pump(const Duration(milliseconds: 125));
    expect(opacity().opacity.value, greaterThan(halfway));
    await tester.pumpAndSettle();
    expect(opacity().opacity.value, 1);

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(controls, findsNothing);
    await tester.pumpWidget(buildView(activityKey: 2));
    await tester.pump(const Duration(milliseconds: 250));
    expect(opacity().opacity.value, closeTo(0.5, 0.01));
    await tester.pumpAndSettle();
    expect(controls, findsOneWidget);
    expect(opacity().opacity.value, 1);
  });

  testWidgets('fading controls let taps reach the canvas', (tester) async {
    var canvasTaps = 0;
    var controlTaps = 0;
    await tester.pumpWidget(
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => canvasTaps++,
        child: buildView(
          child: GestureDetector(
            onTap: () => controlTaps++,
            child: const ColoredBox(
              color: Colors.white,
              child: SizedBox(
                key: ValueKey('controls'),
                width: 300,
                height: 80,
              ),
            ),
          ),
        ),
      ),
    );
    final position = tester.getCenter(controls);
    await tester.tapAt(position);
    expect(controlTaps, 1);
    expect(canvasTaps, 0);
    await tester.pump(const Duration(seconds: 5));
    await tester.pump(const Duration(milliseconds: 125));
    expect(controls, findsOneWidget);
    await tester.tapAt(position);
    expect(controlTaps, 1);
    expect(canvasTaps, 1);
    await tester.pumpAndSettle();
  });

  testWidgets('changing auto-hide mode resets visibility', (tester) async {
    await tester.pumpWidget(buildView());
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(controls, findsNothing);
    await tester.pumpWidget(buildView(autoHide: false));
    await tester.pump(const Duration(seconds: 6));
    expect(controls, findsOneWidget);
    await tester.pumpWidget(buildView());
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(controls, findsNothing);
  });

  testWidgets('held pointers keep the controls visible until release', (
    tester,
  ) async {
    await tester.pumpWidget(buildView());
    final gesture = await tester.startGesture(tester.getCenter(controls));
    await tester.pump(const Duration(seconds: 6));
    expect(controls, findsOneWidget);
    await gesture.up();
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(controls, findsNothing);
  });

  testWidgets('hover keeps the controls visible until the pointer leaves', (
    tester,
  ) async {
    await tester.pumpWidget(buildView());
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer(location: const Offset(500, 500));
    await mouse.moveTo(tester.getCenter(controls));
    await tester.pump(const Duration(seconds: 6));
    expect(controls, findsOneWidget);
    await mouse.moveTo(const Offset(500, 500));
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(controls, findsNothing);
    await mouse.removePointer();
  });
}
