import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

class _MockBuildContext extends Mock implements BuildContext {}

class _TestButterflyFileSystem extends ButterflyFileSystem {
  final PackFileSystem packSystem;

  // The superclass context parameter is library-private, so it cannot be a
  // super parameter from this test library.
  // ignore: use_super_parameters
  _TestButterflyFileSystem(
    BuildContext context,
    SettingsCubit settingsCubit,
    this.packSystem,
  ) : super(context, settingsCubit);

  @override
  PackFileSystem buildDefaultPackSystem({bool forceRecreate = false}) =>
      packSystem;

  @override
  PackFileSystem buildPackSystem([
    ExternalStorage? storage,
    bool forceRecreate = false,
  ]) => packSystem;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('updates the pack file identified by the asset namespace', () async {
    final settingsCubit = MockSettingsCubit();
    when(() => settingsCubit.state).thenReturn(const ButterflySettings());
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => settingsCubit.getRemote(any())).thenReturn(null);
    final packSystem = buildMockPackFileSystem();
    final fileSystem = _TestButterflyFileSystem(
      _MockBuildContext(),
      settingsCubit,
      packSystem,
    );
    addTearDown(fileSystem.dispose);
    await packSystem.initialize();
    await packSystem.createFile('Core.bfly', NoteData(Archive()));
    final updated = NoteData(
      Archive(),
    ).setPalette('Default', const ColorPalette());

    await fileSystem.updatePack(
      const PackAssetLocation('Core.bfly', 'Default'),
      updated,
    );

    final stored = await packSystem.getFile('Core.bfly');
    expect(stored?.getPalette('Default'), isNotNull);
    expect(await packSystem.getFile('Default'), isNull);
  });

  test('core pack uses bundled assets with persisted user overrides', () async {
    final settingsCubit = MockSettingsCubit();
    when(() => settingsCubit.state).thenReturn(const ButterflySettings());
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => settingsCubit.getRemote(any())).thenReturn(null);
    final packSystem = buildMockPackFileSystem();
    final fileSystem = _TestButterflyFileSystem(
      _MockBuildContext(),
      settingsCubit,
      packSystem,
    );
    addTearDown(fileSystem.dispose);

    final initialPacks = await fileSystem.getCoreAndUserPacks();
    final (initialName, initialCore) = initialPacks.first;
    final inheritedPalette = initialCore.getNamedPalettes().first;
    expect(initialName, kCorePackFileName);
    expect(initialCore.parent, isNotNull);
    expect(await packSystem.getFile(kCorePackFileName), isNull);

    final override = const ColorPalette(colors: [SRGBColor(0xFFFF0000)]);
    final updatedCore = initialCore.setPalette(inheritedPalette.name, override);
    await fileSystem.updatePack(
      PackAssetLocation(kCorePackFileName, inheritedPalette.name),
      updatedCore,
    );

    final stored = await packSystem.getFile(kCorePackFileName);
    expect(stored?.parent, isNull);
    expect(stored?.getPalette(inheritedPalette.name), override);

    final reloadedCore = (await fileSystem.getCoreAndUserPacks()).first.$2;
    expect(reloadedCore.parent, isNotNull);
    expect(reloadedCore.getPalette(inheritedPalette.name), override);
  });
}
