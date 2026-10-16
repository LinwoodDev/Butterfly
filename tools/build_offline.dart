import 'dart:convert';
import 'dart:ffi' show Abi;
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:args/args.dart';
import 'package:crypto/crypto.dart';
import 'package:yaml/yaml.dart';

import 'build_web_service_worker.dart' show buildServiceWorker;

typedef Json = Map<String, dynamic>;

const _flutterFlags = ['--no-version-check', '--suppress-analytics'];
const _targets = {
  'android-arm': (
    archive: 'android-arm',
    rust: 'armv7-linux-androideabi',
    elfClass: 1,
    machine: 40,
  ),
  'android-arm64': (
    archive: 'android-arm64',
    rust: 'aarch64-linux-android',
    elfClass: 2,
    machine: 183,
  ),
  'android-x64': (
    archive: 'android-x64',
    rust: 'x86_64-linux-android',
    elfClass: 2,
    machine: 62,
  ),
  'linux-x64': (
    archive: 'linux-x64',
    rust: 'x86_64-unknown-linux-gnu',
    elfClass: 2,
    machine: 62,
  ),
  'linux-arm64': (
    archive: 'linux-arm64',
    rust: 'aarch64-unknown-linux-gnu',
    elfClass: 2,
    machine: 183,
  ),
  'windows-x64': (
    archive: 'win-x64',
    rust: 'x86_64-pc-windows-msvc',
    elfClass: 0,
    machine: 0x8664,
  ),
  'windows-arm64': (
    archive: 'win-arm64',
    rust: 'aarch64-pc-windows-msvc',
    elfClass: 0,
    machine: 0xaa64,
  ),
  'macos-x64': (
    archive: 'mac-x64',
    rust: 'x86_64-apple-darwin',
    elfClass: 0,
    machine: 0x1000007,
  ),
  'macos-arm64': (
    archive: 'mac-arm64',
    rust: 'aarch64-apple-darwin',
    elfClass: 0,
    machine: 0x100000c,
  ),
  'ios-arm64': (
    archive: '',
    rust: 'aarch64-apple-ios',
    elfClass: 0,
    machine: 0,
  ),
  'web': (archive: '', rust: 'wasm32-unknown-unknown', elfClass: 0, machine: 0),
};

const _platforms = ['android', 'linux', 'windows', 'macos', 'ios', 'web'];

Future<void> main(List<String> arguments) async {
  final parser = ArgParser()
    ..addFlag('help', abbr: 'h', negatable: false)
    ..addOption(
      'platform',
      allowed: _platforms,
      help: 'Defaults to the host OS.',
    )
    ..addOption('cache-dir', help: 'Defaults to .offline-build/<platform>.')
    ..addOption('flutter', help: 'Flutter executable (defaults to PATH).')
    ..addOption('flavor', allowed: ['production', 'nightly'])
    ..addMultiOption(
      'dart-define',
      splitCommas: false,
      help: 'Additional compile-time values, remembered during preparation.',
    )
    ..addFlag('analyze-size', negatable: false)
    ..addOption('code-size-directory')
    ..addOption(
      'target-platform',
      help: 'Android ABIs or a Linux target, e.g. linux-arm64.',
    )
    ..addOption(
      'pdfium-dir',
      defaultsTo: Platform.environment['PDFIUM_ARCHIVE_DIR'],
      help: 'Use local PDFium archives instead of downloading them.',
    );
  try {
    final options = parser.parse(arguments);
    if (options.flag('help')) {
      stdout.writeln(
        'Usage: dart tools/build_offline.dart <prepare|build> [options]\n'
        '\n${parser.usage}',
      );
      return;
    }
    if (options.rest.length != 1 ||
        !['prepare', 'build'].contains(options.rest.single)) {
      throw const FormatException('Choose a command: prepare or build.');
    }
    await _OfflineBuild(options).run();
  } catch (error) {
    stderr.writeln('Offline build: $error');
    exitCode = 1;
  }
}

class _OfflineBuild {
  final ArgResults options;
  final root = File.fromUri(Platform.script).parent.parent;
  late final Directory cache;
  late final String flutter;
  late final String platform;
  late final List<String> dartDefines;

  _OfflineBuild(this.options);

  File file(String path) => File('${root.path}/$path');
  File cached(String path) => File('${cache.path}/$path');
  File get hook => file('tools/offline/pdfium_build.dart.template');

  Future<void> run() async {
    platform = options.option('platform') ?? Platform.operatingSystem;
    if (!_platforms.contains(platform)) {
      throw UnsupportedError('Unsupported platform: $platform.');
    }
    final host = platform == 'ios' ? 'macos' : platform;
    if (!['android', 'web'].contains(platform) &&
        host != Platform.operatingSystem) {
      throw UnsupportedError('$platform builds require a $host host.');
    }
    final directory = Directory(
      options.option('cache-dir') ?? '${root.path}/.offline-build/$platform',
    )..createSync(recursive: true);
    cache = Directory(directory.resolveSymbolicLinksSync());
    final lock = cached('.lock').openSync(mode: FileMode.append);
    try {
      lock.lockSync(FileLock.exclusive);
    } on FileSystemException {
      lock.closeSync();
      throw StateError('Another build is using ${cache.path}.');
    }
    try {
      final preparing = options.rest.single == 'prepare';
      final manifest = cached('prepared.json');
      if (!preparing && !manifest.existsSync()) {
        throw StateError('No successful preparation found. Run prepare first.');
      }
      final prepared = preparing ? null : _readJson(manifest);
      dartDefines = options.wasParsed('dart-define')
          ? options.multiOption('dart-define')
          : prepared == null
          ? []
          : (prepared['dart_defines'] as List).cast<String>();
      flutter = File(
        options.option('flutter') ??
            (prepared == null
                ? await _executable('flutter')
                : prepared['flutter'] as String),
      ).resolveSymbolicLinksSync();
      if (prepared == null) {
        await prepare();
      } else {
        await build(prepared);
      }
    } finally {
      lock.unlockSync();
      lock.closeSync();
    }
  }

  Future<String> command(
    String executable,
    List<String> arguments,
    Map<String, String> environment, {
    bool capture = false,
  }) async {
    stdout.writeln('+ ${[executable, ...arguments].map(_quote).join(' ')}');
    if (capture) {
      final result = await Process.run(
        executable,
        arguments,
        workingDirectory: '${root.path}/app',
        environment: environment,
        runInShell: Platform.isWindows && executable.endsWith('.bat'),
      );
      if (result.exitCode == 0) return result.stdout as String;
      stderr.write(result.stderr);
      throw ProcessException(executable, arguments, '', result.exitCode);
    }
    final process = await Process.start(
      executable,
      arguments,
      workingDirectory: '${root.path}/app',
      environment: environment,
      runInShell: Platform.isWindows && executable.endsWith('.bat'),
      mode: ProcessStartMode.inheritStdio,
    );
    final status = await process.exitCode;
    if (status != 0) {
      throw ProcessException(executable, arguments, '', status);
    }
    return '';
  }

  List<String>? get selectedPlatforms {
    final value = options.option('target-platform');
    if (value == null) return null;
    final platforms = value.split(',').map((p) => p.trim()).toList();
    if (platforms.toSet().length != platforms.length ||
        platforms.any(
          (p) => !p.startsWith('$platform-') || !_targets.containsKey(p),
        ) ||
        !['android', 'linux'].contains(platform) ||
        (platform != 'android' && platforms.length != 1)) {
      throw FormatException(
        'Select targets for $platform from ${_targets.keys.where((p) => p.startsWith('$platform-')).join(', ')}. '
        'Only Android supports multiple selected targets.',
      );
    }
    if (platform == 'linux' && platforms.single != defaultTargets.single) {
      throw UnsupportedError(
        'Linux builds require a matching host architecture.',
      );
    }
    return platforms;
  }

  List<String> get defaultTargets {
    if (platform == 'android') return _targets.keys.take(3).toList();
    if (platform == 'macos') return ['macos-x64', 'macos-arm64'];
    if (platform == 'ios') return ['ios-arm64'];
    if (platform == 'web') return ['web'];
    final architecture = Abi.current().toString().split('_').last;
    if (!['x64', 'arm64'].contains(architecture)) {
      throw UnsupportedError('Unsupported host architecture: $architecture.');
    }
    return ['$platform-$architecture'];
  }

  Future<Map<String, String>> fingerprint() async {
    final paths = [
      'app/pubspec.yaml',
      'app/pubspec.lock',
      'api/pubspec.yaml',
      'tools/pubspec.yaml',
      'tools/pubspec.lock',
      'tools/build_offline.dart',
      'tools/build_web_service_worker.dart',
      'tools/offline/rustup.dart',
      'tools/offline/pdfium_build.dart.template',
    ];
    if (platform != 'web') {
      void configurations(Directory directory) {
        for (final entry in directory.listSync(followLinks: false)) {
          final name = entry.uri.pathSegments.where((p) => p.isNotEmpty).last;
          if (entry is Directory) {
            if (!name.startsWith('.') &&
                ![
                  'build',
                  'Pods',
                  'ephemeral',
                  'FlutterGeneratedPluginSwiftPackage',
                ].contains(name)) {
              configurations(entry);
            }
          } else if (entry is File &&
              (name == 'CMakeLists.txt' ||
                  name == 'Podfile' ||
                  name.endsWith('.gradle.kts') ||
                  name.endsWith('.properties') &&
                      name != 'local.properties' &&
                      name != 'key.properties' ||
                  name.endsWith('.pbxproj') ||
                  name.endsWith('.xcconfig') ||
                  name.endsWith('.xcscheme') ||
                  name == 'Package.swift' ||
                  name == 'Podfile.lock' ||
                  name == 'Package.resolved')) {
            if (![
              'Generated.xcconfig',
              'Flutter-Generated.xcconfig',
            ].contains(name)) {
              paths.add(entry.uri.path.substring(root.uri.path.length));
            }
          }
        }
      }

      configurations(Directory('${root.path}/app/$platform'));
    }
    return {for (final path in paths) path: await _digest(file(path))};
  }

  Map<String, Directory> packages() {
    final config = file('app/.dart_tool/package_config.json');
    final roots = {
      for (final entry in _readJson(config)['packages'] as List)
        entry['name'] as String: Directory.fromUri(
          config.uri.resolve(entry['rootUri'] as String),
        ),
    };
    final prefix =
        '${Directory('${cache.path}/pub-cache').resolveSymbolicLinksSync()}${Platform.pathSeparator}';
    for (final name in ['pdfium_dart', 'onenote_parser']) {
      final package = roots[name];
      if (package == null ||
          !package.resolveSymbolicLinksSync().startsWith(prefix)) {
        throw StateError('$name must resolve inside $prefix.');
      }
    }
    return roots;
  }

  Future<Map<String, String>> environment({
    required bool offline,
    String? rustup,
    String? channel,
    bool compileLauncher = false,
  }) async {
    _write(
      cached('gradle/init.d/butterfly-offline.gradle'),
      "if (System.getenv('BUTTERFLY_OFFLINE_BUILD') == '1') {\n"
      '    gradle.startParameter.offline = true\n}\n',
    );
    final environment = {
      for (final entry in Platform.environment.entries)
        (Platform.isWindows ? entry.key.toUpperCase() : entry.key): entry.value,
      'PUB_CACHE': '${cache.path}/pub-cache',
      'GRADLE_USER_HOME': '${cache.path}/gradle',
      'CARGO_HOME': '${cache.path}/cargo',
      'CARGO_NET_OFFLINE': '$offline',
      'BUTTERFLY_OFFLINE_BUILD': offline ? '1' : '0',
      'CI': 'true',
      'COCOAPODS_DISABLE_STATS': 'true',
    };
    if (rustup != null) {
      // Hooks retain PATH but filter CARGO_* and RUSTUP_*. The native Dart
      // launcher restores those variables on every supported host OS.
      final directory = '${cache.path}/bin';
      final userHome =
          Platform.environment[Platform.isWindows ? 'USERPROFILE' : 'HOME']!;
      final variables = {
        'CARGO_HOME': '${cache.path}/cargo',
        'RUSTUP_HOME':
            Platform.environment['RUSTUP_HOME'] ?? '$userHome/.rustup',
        'RUSTUP_TOOLCHAIN': channel!,
        'RUSTUP_AUTO_INSTALL': offline ? '0' : '1',
        'CARGO_NET_OFFLINE': '$offline',
      };
      final wrapper = File(
        '$directory/rustup${Platform.isWindows ? '.exe' : ''}',
      );
      _writeJson(File('$directory/rustup.json'), {
        'executable': rustup,
        'environment': variables,
      });
      if (compileLauncher) {
        await command(Platform.resolvedExecutable, [
          'compile',
          'exe',
          file('tools/offline/rustup.dart').path,
          '-o',
          wrapper.path,
        ], environment);
      } else if (!wrapper.existsSync()) {
        throw StateError('The Rust launcher is missing. Run prepare again.');
      }
      environment['PATH'] =
          '$directory${Platform.isWindows ? ';' : ':'}${environment['PATH'] ?? ''}';
      environment['RUSTUP_TOOLCHAIN'] = channel;
      environment['RUSTUP_AUTO_INSTALL'] = offline ? '0' : '1';
    }
    return environment;
  }

  Future<void> checkFlutter(Map<String, String> environment) async {
    final specification = loadYaml(file('app/pubspec.yaml').readAsStringSync());
    final expected = specification['environment']['flutter'].toString();
    final version = jsonDecode(
      await command(
        flutter,
        [..._flutterFlags, '--version', '--machine'],
        environment,
        capture: true,
      ),
    )['frameworkVersion'];
    if (version != expected) {
      throw StateError(
        'Flutter $expected is required; $flutter reports $version.',
      );
    }
  }

  Future<FileSystemEntity> buildTarget(
    Map<String, String> environment,
    String flavor,
    List<String> platforms,
  ) async {
    // --no-pub also skips release-specific plugin registration in Flutter.
    // Mark the resolved config as ours: Flutter skips dependency resolution
    // while still regenerating release tooling without dev-only plugins.
    final config = file('app/.dart_tool/package_config.json');
    _writeJson(config, {
      ..._readJson(config),
      'generator': 'butterfly_offline_build',
    });
    if (platform == 'web') {
      final bridge = packages()['flutter_rust_bridge']!;
      await command(Platform.resolvedExecutable, [
        '--packages=${config.path}',
        '${bridge.path}/bin/flutter_rust_bridge.dart',
        'build-web',
        '--dart-root',
        packages()['onenote_parser']!.path,
        '--rust-root',
        '${packages()['onenote_parser']!.path}/rust',
        '--output',
        '${root.path}/app/web',
        '--release',
        '--cargo-build-args=--locked',
      ], environment);
      for (final name in [
        'rust_lib_onenote_parser.js',
        'rust_lib_onenote_parser_bg.wasm',
      ]) {
        if (!file('app/web/pkg/$name').existsSync()) {
          throw StateError('The OneNote web build did not produce $name.');
        }
      }
    }
    await command(flutter, [
      ..._flutterFlags,
      'build',
      platform == 'android' ? 'apk' : platform,
      '--release',
      if (platform == 'android') '--no-android-gradle-daemon',
      if (['android', 'linux', 'windows'].contains(platform)) ...[
        '--flavor',
        flavor,
      ] else if (!dartDefines.any((value) => value.startsWith('flavor='))) ...[
        '--dart-define=flavor=$flavor',
      ],
      for (final value in dartDefines) '--dart-define=$value',
      if (['android', 'linux'].contains(platform)) ...[
        '--target-platform',
        platforms.join(','),
      ],
      if (platform == 'ios') '--no-codesign',
      if (platform == 'web') ...['--wasm', '--no-web-resources-cdn'],
      if (options.flag('analyze-size')) '--analyze-size',
      if (options.option('code-size-directory') case final directory?)
        '--code-size-directory=$directory',
    ], environment);
    final arch = platforms.singleOrNull?.split('-').last;
    final path = switch (platform) {
      'android' => 'app/outputs/flutter-apk/app-$flavor-release.apk',
      'linux' => 'linux/$arch/$flavor/release/bundle',
      'windows' => 'windows/$arch/$flavor/runner/Release',
      'macos' => 'macos/Build/Products/Release/butterfly.app',
      'ios' => 'ios/iphoneos/Runner.app',
      'web' => 'web',
      _ => throw UnsupportedError(platform),
    };
    final artifact = platform == 'android'
        ? file('app/build/$path')
        : Directory('${root.path}/app/build/$path');
    if (!artifact.existsSync()) {
      throw StateError('The build did not produce ${artifact.path}.');
    }
    if (platform == 'web') await buildServiceWorker(artifact as Directory);
    return artifact;
  }

  Future<void> prepare() async {
    final platforms = selectedPlatforms ?? defaultTargets;
    final manifest = cached('prepared.json');
    if (manifest.existsSync()) manifest.deleteSync();
    final flavor = options.option('flavor') ?? 'production';
    var env = await environment(offline: false);
    await checkFlutter(env);
    await command(flutter, [..._flutterFlags, 'precache', '--$platform'], env);
    await command(flutter, [
      ..._flutterFlags,
      'pub',
      'get',
      '--enforce-lockfile',
    ], env);
    final resolved = packages();
    final pdfium = resolved['pdfium_dart']!;
    final original = File('${pdfium.path}/hook/build.dart.online');
    if (!original.existsSync()) {
      File('${pdfium.path}/hook/build.dart').copySync(original.path);
    }
    final source = original.readAsStringSync();
    final release = RegExp(
      r"const _pdfiumRelease = '(chromium%2F[0-9]+)';",
    ).firstMatch(source)?.group(1);
    if (release == null ||
        !source.contains("const _assetName = 'libpdfium';")) {
      throw StateError(
        'The pdfium_dart hook changed. Update the offline adapter.',
      );
    }
    final local = options.option('pdfium-dir');
    final directory = Directory(
      local ?? '${cache.path}/pdfium/${release.replaceAll('%2F', '_')}',
    )..createSync(recursive: true);
    final archives = Directory(directory.resolveSymbolicLinksSync());
    final hashes = <String, String>{};
    for (final platform in platforms) {
      if (_targets[platform]!.archive.isEmpty) continue;
      final name = 'pdfium-${_targets[platform]!.archive}.tgz';
      final archive = File('${archives.path}/$name');
      if (!archive.existsSync()) {
        if (local != null) {
          throw StateError('Missing local PDFium archive: ${archive.path}');
        }
        final uri = Uri.parse(
          'https://github.com/bblanchon/pdfium-binaries/releases/download/'
          '$release/$name',
        );
        stdout.writeln('Downloading $uri');
        await _download(uri, archive, platform);
      }
      _validateArchive(archive, platform);
      hashes[name] = await _digest(archive);
    }
    _write(File('${pdfium.path}/hook/build.dart'), hook.readAsStringSync());
    _writeJson(File('${pdfium.path}/hook/offline.json'), {
      'archive_directory': archives.path,
      'release': release,
    });
    final crate = '${resolved['onenote_parser']!.path}/rust';
    final toolchain = File('$crate/rust-toolchain.toml').readAsStringSync();
    final channel = RegExp(
      r'^channel\s*=\s*"([^"]+)"\s*$',
      multiLine: true,
    ).firstMatch(toolchain)?.group(1);
    if (channel == null ||
        !RegExp(
          r'^(\d+\.\d+\.\d+|nightly-\d{4}-\d{2}-\d{2})$',
        ).hasMatch(channel)) {
      throw StateError('OneNote must specify a pinned Rust toolchain.');
    }
    final rustup = await _executable('rustup');
    env = await environment(
      offline: false,
      rustup: rustup,
      channel: channel,
      compileLauncher: true,
    );
    await command(rustup, [
      'toolchain',
      'install',
      channel,
      '--profile',
      'minimal',
      '--no-self-update',
      '--target',
      platforms.map((p) => _targets[p]!.rust).join(','),
    ], env);
    await command(rustup, [
      'run',
      channel,
      'cargo',
      'fetch',
      '--locked',
      '--manifest-path',
      '$crate/Cargo.toml',
    ], env);
    if (platform == 'web') {
      await _executable('wasm-pack');
      await command(rustup, [
        'toolchain',
        'install',
        'nightly',
        '--profile',
        'minimal',
        '--component',
        'rust-src',
        '--target',
        'wasm32-unknown-unknown',
        '--no-self-update',
      ], env);
    }
    stdout.writeln('Warming $platform dependencies with a release build...');
    await buildTarget(env, flavor, platforms);
    _writeJson(manifest, {
      'platform': platform,
      'host': Platform.operatingSystem,
      'root': root.path,
      'flutter': flutter,
      'flavor': flavor,
      'dart_defines': dartDefines,
      'platforms': platforms,
      'sources': await fingerprint(),
      'pdfium': pdfium.path,
      'pdfium_directory': archives.path,
      'archives': hashes,
      'rustup': rustup,
      'rust_channel': channel,
      'rust_launcher': await _digest(
        cached('bin/rustup${Platform.isWindows ? '.exe' : ''}'),
      ),
    });
    stdout.writeln(
      'Prepared ${cache.path}. The build command can now run offline.',
    );
  }

  Future<void> build(Json data) async {
    final platforms = selectedPlatforms;
    if (data['platform'] != platform ||
        data['host'] != Platform.operatingSystem ||
        data['root'] != root.path ||
        data['flutter'] != flutter ||
        !_sameMap(await fingerprint(), data['sources'] as Map) ||
        jsonEncode(dartDefines) != jsonEncode(data['dart_defines']) ||
        (options.option('flavor') != null &&
            options.option('flavor') != data['flavor']) ||
        (platforms != null &&
            jsonEncode(platforms) != jsonEncode(data['platforms'])) ||
        (options.option('pdfium-dir') != null &&
            Directory(
                  options.option('pdfium-dir')!,
                ).resolveSymbolicLinksSync() !=
                data['pdfium_directory'])) {
      throw StateError(
        'Build inputs changed. Run prepare again for this configuration.',
      );
    }
    for (final entry in (data['archives'] as Map).entries) {
      final archive = File('${data['pdfium_directory']}/${entry.key}');
      if (!archive.existsSync() || await _digest(archive) != entry.value) {
        throw StateError(
          'PDFium archive changed or is missing: ${archive.path}. Run prepare again.',
        );
      }
    }
    final installedHook = File('${data['pdfium']}/hook/build.dart');
    if (!installedHook.existsSync() ||
        installedHook.readAsStringSync() != hook.readAsStringSync()) {
      throw StateError('The prepared PDFium hook changed. Run prepare again.');
    }
    final config = _readJson(File('${data['pdfium']}/hook/offline.json'));
    if (config['archive_directory'] != data['pdfium_directory']) {
      throw StateError(
        'The PDFium archive directory changed. Run prepare again.',
      );
    }
    final env = await environment(
      offline: true,
      rustup: data['rustup'] as String,
      channel: data['rust_channel'] as String,
    );
    if (await _digest(
          cached('bin/rustup${Platform.isWindows ? '.exe' : ''}'),
        ) !=
        data['rust_launcher']) {
      throw StateError('The Rust launcher changed. Run prepare again.');
    }
    await checkFlutter(env);
    await command(flutter, [
      ..._flutterFlags,
      'pub',
      'get',
      '--offline',
      '--enforce-lockfile',
    ], env);
    if (packages()['pdfium_dart']!.path != data['pdfium']) {
      throw StateError(
        'The resolved PDFium package changed. Run prepare again.',
      );
    }
    final installed = const LineSplitter().convert(
      await command(
        data['rustup'] as String,
        [
          'target',
          'list',
          '--installed',
          '--toolchain',
          data['rust_channel'] as String,
        ],
        env,
        capture: true,
      ),
    );
    final targets = (data['platforms'] as List).cast<String>();
    final missing = targets
        .map((p) => _targets[p]!.rust)
        .where((p) => !installed.contains(p));
    if (missing.isNotEmpty) {
      throw StateError(
        'Missing Rust targets: ${missing.join(', ')}. Run prepare again.',
      );
    }
    final artifact = await buildTarget(env, data['flavor'] as String, targets);
    stdout.writeln('Offline $platform build: ${artifact.path}');
  }
}

Json _readJson(File file) => jsonDecode(file.readAsStringSync()) as Json;

void _write(File file, String content) {
  if (file.existsSync() && file.readAsStringSync() == content) return;
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(content);
}

void _writeJson(File file, Json value) =>
    _write(file, '${const JsonEncoder.withIndent('  ').convert(value)}\n');

Future<String> _digest(File file) async =>
    (await sha256.bind(file.openRead()).first).toString();

bool _sameMap(Map actual, Map expected) =>
    actual.length == expected.length &&
    actual.entries.every((e) => expected[e.key] == e.value);

String _quote(String value) => "'${value.replaceAll("'", "'\\''")}'";

Future<String> _executable(String name) async {
  final result = await Process.run(Platform.isWindows ? 'where.exe' : 'which', [
    name,
  ]);
  if (result.exitCode != 0) {
    throw StateError('Install $name before running prepare.');
  }
  final paths = const LineSplitter().convert(result.stdout as String);
  return File(
    paths.firstWhere(
      (p) =>
          !Platform.isWindows ||
          RegExp(r'\.(exe|bat|cmd)$', caseSensitive: false).hasMatch(p),
    ),
  ).absolute.path;
}

void _validateArchive(File file, String platform) {
  final archive = TarDecoder().decodeBytes(
    GZipDecoder().decodeBytes(file.readAsBytesSync()),
  );
  final target = _targets[platform]!;
  final path = platform.startsWith('windows-')
      ? 'bin/pdfium.dll'
      : platform.startsWith('macos-')
      ? 'lib/libpdfium.dylib'
      : 'lib/libpdfium.so';
  final member = archive.find(path);
  if (member == null || !member.isFile || member.isSymbolicLink) {
    throw FormatException('${file.path} must contain a regular $path.');
  }
  final header = member.content;
  var valid = false;
  int u32(int offset) =>
      header[offset] |
      header[offset + 1] << 8 |
      header[offset + 2] << 16 |
      header[offset + 3] << 24;
  if (target.elfClass != 0) {
    valid =
        !(header.length < 20 ||
            header[0] != 0x7f ||
            header[1] != 0x45 ||
            header[2] != 0x4c ||
            header[3] != 0x46 ||
            header[4] != target.elfClass ||
            header[5] != 1 ||
            header[18] + (header[19] << 8) != target.machine);
  } else if (platform.startsWith('windows-') &&
      header.length >= 64 &&
      header[0] == 0x4d &&
      header[1] == 0x5a) {
    final offset = u32(60);
    valid =
        offset >= 0 &&
        offset + 6 <= header.length &&
        u32(offset) == 0x4550 &&
        header[offset + 4] + (header[offset + 5] << 8) == target.machine;
  } else if (platform.startsWith('macos-') && header.length >= 32) {
    valid = u32(0) == 0xfeedfacf && u32(4) == target.machine;
  }
  if (!valid) {
    throw FormatException(
      '${file.path} does not contain a native library for $platform.',
    );
  }
}

Future<void> _download(Uri uri, File destination, String platform) async {
  final temporary = File('${destination.path}.part');
  final client = HttpClient()
    ..connectionTimeout = const Duration(seconds: 120)
    ..findProxy = HttpClient.findProxyFromEnvironment;
  try {
    final response = await (await client.getUrl(uri)).close();
    if (response.statusCode != HttpStatus.ok) {
      throw HttpException('HTTP ${response.statusCode}', uri: uri);
    }
    await response.pipe(temporary.openWrite());
    _validateArchive(temporary, platform);
    temporary.renameSync(destination.path);
  } finally {
    client.close(force: true);
    if (temporary.existsSync()) temporary.deleteSync();
  }
}
