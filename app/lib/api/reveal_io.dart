import 'dart:io';

bool get canRevealInFileExplorer =>
    Platform.isWindows || Platform.isMacOS || Platform.isLinux;

({String executable, List<String> arguments})? buildRevealCommand(
  String path, {
  bool directory = false,
  String? operatingSystem,
}) {
  final os = operatingSystem ?? Platform.operatingSystem;
  return switch (os) {
    'windows' => (executable: 'explorer.exe', arguments: ['/select,$path']),
    'macos' => (executable: 'open', arguments: ['-R', path]),
    'linux' => (
      executable: 'xdg-open',
      arguments: [directory ? path : File(path).parent.path],
    ),
    _ => null,
  };
}

Future<bool> revealInFileExplorer(String path, {bool directory = false}) async {
  final command = buildRevealCommand(path, directory: directory);
  if (command == null) return false;
  try {
    await Process.start(
      command.executable,
      command.arguments,
      mode: ProcessStartMode.detached,
    );
    return true;
  } on ProcessException {
    return false;
  }
}
