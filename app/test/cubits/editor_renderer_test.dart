import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _CountingRenderer extends Renderer<ShapeElement> {
  _CountingRenderer(this.bounds) : super(ShapeElement());

  final Rect bounds;
  var boundsReads = 0;

  @override
  Rect get rect => bounds;

  @override
  Rect get expandedRect {
    boundsReads++;
    return bounds;
  }

  @override
  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('equivalent renderer states do not emit a runtime update', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final cubit = RendererCubit(SettingsCubit(preferences));
    final emissions = <RendererRuntimeState>[];
    final subscription = cubit.stream.listen(emissions.add);

    cubit.setRendererStates(
      rendererStates: const {'element': RendererState.visible},
    );
    cubit.setRendererStates(
      rendererStates: const {'element': RendererState.visible},
    );
    await Future<void>.delayed(Duration.zero);

    expect(emissions, hasLength(1));
    await subscription.cancel();
    await cubit.close();
  });

  test('spatial index reuses renderer bounds between queries', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final settings = SettingsCubit(preferences);
    final renderer = _CountingRenderer(const Rect.fromLTWH(10, 10, 20, 20));
    final cubit = RendererCubit(
      settings,
      RendererRuntimeState(
        cameraViewport: CameraViewport.unbaked(unbakedElements: [renderer]),
      ),
    );

    expect(cubit.visibleRenderers(const Rect.fromLTWH(0, 0, 100, 100)), [
      renderer,
    ]);
    expect(cubit.visibleRenderers(const Rect.fromLTWH(5, 5, 50, 50)), [
      renderer,
    ]);
    expect(renderer.boundsReads, 1);

    await cubit.close();
    await settings.close();
  });
}
