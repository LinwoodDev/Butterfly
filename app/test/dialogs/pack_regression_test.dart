import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  test('creating a pack stores it in the global pack filesystem', () async {
    final fileSystem = MockButterflyFileSystem();
    final settingsCubit = fileSystem.settingsCubit as MockSettingsCubit;
    when(
      () => settingsCubit.state,
    ).thenReturn(const ButterflySettings(autosave: false));
    final packSystem = fileSystem.buildDefaultPackSystem();
    final pack = DocumentDefaults.createPack().setMetadata(
      DocumentDefaults.createMetadata(
        type: NoteFileType.pack,
        name: 'New Pack',
      ),
    );

    final createdPath = await fileSystem.createPack(pack);
    final packs = await packSystem.getFiles();

    expect(createdPath, packs.single.path);
    expect(packs.single.pathWithoutLeadingSlash, 'New Pack.bfly');
  });
}
