import 'dart:io';

import 'package:generate_leap/flutter_build.dart';
import 'package:archive/archive.dart';

import 'build_web_service_worker.dart';

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

Future<void> main(List<String> args) => runFlutterBuild(
  args,
  _ButterflyBuild.new,
  configure: (parser) => parser.addOption(
    'pdfium-dir',
    defaultsTo: Platform.environment['PDFIUM_ARCHIVE_DIR'],
    help: 'Use local PDFium archives instead of downloading them.',
  ),
);

class _ButterflyBuild extends FlutterBuild {
  _ButterflyBuild(super.options)
    : super(
        name: 'butterfly',
        root: File.fromUri(Platform.script).parent.parent,
        appDirectory: 'app',
      );

  static const webNightly = 'nightly-2026-10-20';
  @override
  String get defaultFlavor => 'production';
  @override
  RustBuild get rust => RustBuild(
    crate: Directory('${packages()['onenote_parser']!.path}/rust'),
    sourceRoot: packages()['onenote_parser']!,
  );
  @override
  List<String> get inputFiles => [
    'tools/pubspec.yaml',
    'tools/pubspec.lock',
    'tools/build_offline.dart',
    if (file('tools/pubspec_overrides.yaml').existsSync())
      'tools/pubspec_overrides.yaml',
    'api/pubspec.yaml',
    'tools/build_web_service_worker.dart',
    'tools/offline/pdfium_build.dart.template',
  ];
  File get hook => file('tools/offline/pdfium_build.dart.template');

  @override
  Map<String, Directory> packages() {
    final roots = super.packages();
    final prefix =
        '${Directory('${cache.path}/pub-cache').resolveSymbolicLinksSync()}${Platform.pathSeparator}';
    for (final name in ['pdfium_dart', 'onenote_parser']) {
      if (roots[name] == null ||
          !roots[name]!.resolveSymbolicLinksSync().startsWith(prefix)) {
        throw StateError('$name must resolve inside $prefix.');
      }
    }
    return roots;
  }

  @override
  Future<Json> prepareDependencies(
    List<String> platforms,
    Map<String, String> env,
  ) async {
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
      hashes[name] = await digest(archive);
    }
    writeIfChanged(
      File('${pdfium.path}/hook/build.dart'),
      hook.readAsStringSync(),
    );
    writeJson(File('${pdfium.path}/hook/offline.json'), {
      'archive_directory': archives.path,
      'release': release,
    });
    return {
      'pdfium': pdfium.path,
      'pdfium_directory': archives.path,
      'archives': hashes,
    };
  }

  @override
  Future<void> checkDependencies(Json data) async {
    for (final entry in (data['archives'] as Map).entries) {
      final archive = File('${data['pdfium_directory']}/${entry.key}');
      if (!archive.existsSync() || await digest(archive) != entry.value) {
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
    final config = readJson(File('${data['pdfium']}/hook/offline.json'));
    if (config['archive_directory'] != data['pdfium_directory']) {
      throw StateError(
        'The PDFium archive directory changed. Run prepare again.',
      );
    }
    if (packages()['pdfium_dart']!.path != data['pdfium']) {
      throw StateError(
        'The resolved PDFium package changed. Run prepare again.',
      );
    }
    final local = options.option('pdfium-dir');
    if (local != null &&
        Directory(local).resolveSymbolicLinksSync() !=
            data['pdfium_directory']) {
      throw StateError(
        'The PDFium archive directory changed. Run prepare again.',
      );
    }
  }

  @override
  Future<void> prepareTools(Map<String, String> env) async {
    if (platform != 'web') return;
    await command('rustup', [
      'toolchain',
      'install',
      webNightly,
      '--profile',
      'minimal',
      '--component',
      'rust-src',
      '--target',
      'wasm32-unknown-unknown',
      '--no-self-update',
    ], env);
  }

  @override
  Future<void> checkTools(Map<String, String> env) async {
    if (platform != 'web') return;
    final version = await command(
      'wasm-pack',
      ['--version'],
      env,
      capture: true,
    );
    if (version.trim() != 'wasm-pack 0.15.0') {
      throw StateError(
        'Install wasm-pack 0.15.0 before preparing/building web.',
      );
    }
  }

  @override
  Future<void> beforeBuild(
    Map<String, String> environment,
    List<String> targets,
  ) async {
    final config = file('app/.dart_tool/package_config.json');
    if (platform == 'web') {
      // Cargo's encoded flags take precedence over the bridge's RUSTFLAGS.
      // Preserve its required threaded-WASM flags alongside the path maps.
      environment['CARGO_ENCODED_RUSTFLAGS'] = [
        environment['CARGO_ENCODED_RUSTFLAGS']!,
        '-C',
        'target-feature=+atomics,+bulk-memory,+mutable-globals',
        for (final argument in [
          '--shared-memory',
          '--max-memory=1073741824',
          '--import-memory',
          '--export=__heap_base',
          '--export=__wasm_init_tls',
          '--export=__tls_size',
          '--export=__tls_align',
          '--export=__tls_base',
        ]) ...['-C', 'link-args=$argument'],
      ].join('\u001f');
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
        '--wasm-pack-rustup-toolchain=$webNightly',
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
  }

  @override
  Future<void> cleanExtraOutputs() async {
    if (platform != 'web') return;
    final generated = Directory('${root.path}/app/web/pkg');
    if (generated.existsSync()) generated.deleteSync(recursive: true);
  }

  @override
  Future<void> afterBuild(FileSystemEntity artifact) async {
    if (platform == 'web') await buildServiceWorker(artifact as Directory);
  }
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
