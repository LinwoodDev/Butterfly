import 'dart:math';

import 'package:butterfly/cubits/editor_runtime.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

class _Runtime extends Mock implements EditorRuntimeContext {}

class _Settings extends Mock implements SettingsCubit {}

class _Renderer extends Mock implements RendererCubit {}

class _View extends Mock implements EditorViewCubit {}

void main() {
  late _Runtime runtime;
  late _Settings settings;
  late _Renderer renderer;
  late _View view;
  late TransformCubit transform;
  const screen = Size(800, 600);

  setUp(() {
    runtime = _Runtime();
    settings = _Settings();
    renderer = _Renderer();
    view = _View();
    transform = TransformCubit(1);
    when(() => runtime.settingsCubit).thenReturn(settings);
    when(() => runtime.rendererCubit).thenReturn(renderer);
    when(() => runtime.viewCubit).thenReturn(view);
    when(() => settings.state).thenReturn(
      const ButterflySettings(
        limitViewportMultiplier: 1,
        navigationRail: false,
        renderResolution: RenderResolution.performance,
      ),
    );
    when(() => renderer.state).thenReturn(
      const RendererRuntimeState(
        cameraViewport: CameraViewport.unbaked(
          width: 800,
          height: 600,
          viewportSize: screen,
        ),
      ),
    );
    when(() => renderer.renderers).thenReturn([
      ShapeRenderer(
        ShapeElement(
          firstPosition: const Point(0, 0),
          secondPosition: const Point(100, 100),
        ),
      ),
    ]);
    when(() => view.state).thenReturn(const EditorViewState());
  });

  tearDown(() => transform.close());

  test('uses the screen size instead of the expanded render cache', () {
    transform.rotate(3 * pi / 4);
    final bounds = transform.calculateViewportBounds(runtime: runtime)!;
    when(() => settings.state).thenReturn(
      settings.state.copyWith(renderResolution: RenderResolution.high),
    );
    when(() => renderer.state).thenReturn(
      const RendererRuntimeState(
        cameraViewport: CameraViewport.unbaked(
          width: 1600,
          height: 1600,
          viewportSize: screen,
        ),
      ),
    );

    expect(transform.calculateViewportBounds(runtime: runtime), bounds);
  });

  test('inertia can move back into a rotated viewport from either limit', () {
    when(() => settings.state)
        .thenReturn(settings.state.copyWith(flags: ['smoothNavigation']));
    transform.rotate(3 * pi / 4);
    final bounds = transform.calculateViewportBounds(runtime: runtime)!;

    transform.teleport(bounds.topLeft);
    transform.slideConstrained(const Offset(-100, -100), 0, runtime: runtime);
    expect(transform.state.position.dx, greaterThan(bounds.left));
    expect(transform.state.position.dy, greaterThan(bounds.top));

    transform.teleport(bounds.bottomRight);
    transform.slideConstrained(const Offset(100, 100), 0, runtime: runtime);
    expect(transform.state.position.dx, lessThan(bounds.right));
    expect(transform.state.position.dy, lessThan(bounds.bottom));
  });
}
