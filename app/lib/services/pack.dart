import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';

class PackService {
  final SettingsCubit settingsCubit;

  PackService(this.settingsCubit);

  Future<List<FileMetadata>> getPacks() async {
    return [(await DocumentDefaults.getCorePack()).getMetadata()!];
  }

  Future<NoteData?> getPack(
      String repository, String author, String name) async {
    final core = await DocumentDefaults.getCorePack();
    if (core.getMetadata()!.isSame(repository, author, name)) {
      return core;
    }
    return null;
  }
}
