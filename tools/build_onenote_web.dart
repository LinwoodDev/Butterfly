import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final repositoryRoot = _findRepositoryRoot();
  final appDirectory = Directory('${repositoryRoot.path}/app');
  final packageConfig = File(
    '${appDirectory.path}/.dart_tool/package_config.json',
  );
  if (!packageConfig.existsSync()) {
    _fail(
      'Missing ${packageConfig.path}.\n'
      'Run "flutter pub get" in ${appDirectory.path} first.',
    );
  }

  final config =
      jsonDecode(await packageConfig.readAsString()) as Map<String, dynamic>;
  final packages = config['packages'] as List<dynamic>;
  final parserEntries = packages.cast<Map<String, dynamic>>().where(
    (entry) => entry['name'] == 'onenote_parser',
  );
  if (parserEntries.isEmpty) {
    _fail(
      'The onenote_parser package is not present in package_config.json.\n'
      'Run "flutter pub get" in ${appDirectory.path} first.',
    );
  }

  final packageRoot = packageConfig.uri
      .resolve(parserEntries.single['rootUri'] as String)
      .toFilePath();
  final rustRoot = Directory('$packageRoot/rust');
  if (!File('${rustRoot.path}/Cargo.toml').existsSync()) {
    _fail('Could not find the onenote_parser Rust crate at ${rustRoot.path}.');
  }

  final rustup = await Process.run('rustup', [
    'component',
    'list',
    '--toolchain',
    'nightly',
    '--installed',
  ]);
  if (rustup.exitCode != 0 ||
      !rustup.stdout.toString().split('\n').contains('rust-src')) {
    _fail(
      'The Rust nightly rust-src component is required.\n'
      'Install it with:\n'
      '  rustup toolchain install nightly --component rust-src',
    );
  }

  if (!await _commandExists('wasm-pack')) {
    _fail(
      'wasm-pack is required to build the OneNote parser for web.\n'
      'Install it with:\n'
      '  cargo install wasm-pack --locked',
    );
  }

  final outputDirectory = Directory('${appDirectory.path}/web');
  final generatedDirectory = Directory('${outputDirectory.path}/pkg');
  if (generatedDirectory.existsSync()) {
    await generatedDirectory.delete(recursive: true);
  }

  stdout.writeln('Building the OneNote parser web library...');
  final process = await Process.start(
    'dart',
    [
      'run',
      'flutter_rust_bridge:flutter_rust_bridge',
      'build-web',
      '--dart-root',
      packageRoot,
      '--rust-root',
      rustRoot.path,
      '--output',
      outputDirectory.path,
      '--release',
    ],
    workingDirectory: appDirectory.path,
    mode: ProcessStartMode.inheritStdio,
  );
  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    _fail('Failed to build the OneNote parser web library.', exitCode);
  }

  final expectedFiles = [
    File('${generatedDirectory.path}/rust_lib_onenote_parser.js'),
    File('${generatedDirectory.path}/rust_lib_onenote_parser_bg.wasm'),
  ];
  final missingFiles = expectedFiles.where((file) => !file.existsSync());
  if (missingFiles.isNotEmpty) {
    _fail(
      'The OneNote parser build completed without producing:\n'
      '${missingFiles.map((file) => '  ${file.path}').join('\n')}',
    );
  }

  stdout.writeln('OneNote parser web library written to app/web/pkg.');
}

Directory _findRepositoryRoot() {
  var directory = Directory.current.absolute;
  while (true) {
    if (File('${directory.path}/app/pubspec.yaml').existsSync() &&
        File('${directory.path}/tools/pubspec.yaml').existsSync()) {
      return directory;
    }
    final parent = directory.parent;
    if (parent.path == directory.path) {
      _fail(
        'Could not find the Butterfly repository root from '
        '${Directory.current.path}.',
      );
    }
    directory = parent;
  }
}

Future<bool> _commandExists(String command) async {
  final finder = Platform.isWindows ? 'where.exe' : 'which';
  final result = await Process.run(finder, [command]);
  return result.exitCode == 0;
}

Never _fail(String message, [int exitCode = 1]) {
  stderr.writeln(message);
  exit(exitCode);
}
