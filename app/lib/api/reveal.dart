import 'package:lw_file_system/lw_file_system.dart';

import 'reveal_stub.dart' if (dart.library.io) 'reveal_io.dart' as platform;

bool get canRevealInFileExplorer => platform.canRevealInFileExplorer;

Future<bool> revealInFileExplorer(
  GeneralFileSystem fileSystem,
  String path, {
  bool directory = false,
}) async {
  if (!canRevealInFileExplorer) return false;
  final absolutePath = await fileSystem.getAbsolutePath(path);
  return platform.revealInFileExplorer(absolutePath, directory: directory);
}
