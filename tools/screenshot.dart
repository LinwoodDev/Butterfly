import 'dart:io';

Future<void> main(List<String> args) async {
  final isWindows = Platform.isWindows;
  final isLinux = Platform.isLinux;
  final device = switch ((isWindows, isLinux)) {
    (true, _) => 'windows',
    (_, true) => 'linux',
    _ => null,
  };
  print("Taking screenshot on ${device ?? 'connected device'}...");
  final args = [
    'drive',
    '--driver=test_driver/screenshot_test.dart',
    '--target=integration_test/screenshot.dart',
    if (device != null) ...['-d', device],
  ];
  final process = await Process.start(
    'flutter',
    args,
    workingDirectory: 'app',
    runInShell: true,
  );
  stdout.addStream(process.stdout);
  stderr.addStream(process.stderr);
  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    print('Failed to take screenshot');
    exit(exitCode);
  } else {
    print('Screenshot taken successfully');
  }
}
