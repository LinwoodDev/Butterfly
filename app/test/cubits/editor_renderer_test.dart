import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}
