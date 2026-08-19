import 'dart:io';

/// Applies source-level branding for platforms whose packagers cannot select
/// assets from Flutter's `--flavor` value themselves.
///
/// CI always starts from a clean checkout, so production builds keep the
/// checked-in stable assets while nightly builds call this script before the
/// native build starts.
void main(List<String> arguments) {
  if (arguments.length != 2) {
    stderr.writeln(
      'Usage: dart run scripts/apply_branding.dart <flavor> <platform>',
    );
    exitCode = 64;
    return;
  }

  final flavor = arguments[0].toLowerCase();
  final platform = arguments[1].toLowerCase();
  if (!const {'nightly', 'development', 'dev'}.contains(flavor)) {
    stdout.writeln('Keeping production branding for $platform.');
    return;
  }

  final appRoot = File.fromUri(Platform.script).parent.parent;
  switch (platform) {
    case 'windows':
      _replaceAll(_file(appRoot, 'pubspec.yaml'), {
        'display_name: Linwood Butterfly':
            'display_name: Linwood Butterfly Nightly',
        'identity_name: LinwoodDevelopment.linwood-butterfly':
            'identity_name: LinwoodDevelopment.linwood-butterfly-nightly',
        'logo_path: images/logo.png': 'logo_path: images/nightly.png',
      });
    case 'linux':
      for (final size in const [128, 256]) {
        _copy(
          _file(appRoot, 'linux/branding/nightly-$size.png'),
          _file(
            appRoot,
            'linux/debian/usr/share/icons/hicolor/$size'
            'x$size/apps/dev.linwood.butterfly.png',
          ),
        );
      }
      _replaceAll(
        _file(
          appRoot,
          'linux/debian/usr/share/applications/dev.linwood.butterfly.desktop',
        ),
        {'Name=Linwood Butterfly': 'Name=Linwood Butterfly Nightly'},
      );
      _replaceAll(
        _file(
          appRoot,
          'linux/debian/usr/share/metainfo/dev.linwood.butterfly.appdata.xml',
        ),
        {
          '<name>Linwood Butterfly</name>':
              '<name>Linwood Butterfly Nightly</name>',
        },
      );
      _replaceAll(_file(appRoot, 'linux/rpm/linwood-butterfly.desktop'), {
        'Name=Linwood Butterfly': 'Name=Linwood Butterfly Nightly',
        'images/logo.svg': 'images/nightly.svg',
      });
    case 'macos':
      final iconDirectory = _directory(
        appRoot,
        'macos/Runner/Assets.xcassets/AppIcon.appiconset',
      );
      for (final size in const [16, 32, 64, 128, 256, 512, 1024]) {
        _copy(
          _file(appRoot, 'web_nightly/ios/$size.png'),
          _file(iconDirectory, 'app_icon_$size.png'),
        );
      }
      _replaceAll(_file(appRoot, 'macos/Runner/Configs/AppInfo.xcconfig'), {
        'PRODUCT_BUNDLE_IDENTIFIER = dev.linwood.butterfly':
            'PRODUCT_BUNDLE_IDENTIFIER = dev.linwood.butterfly.nightly',
        'APP_DISPLAY_NAME = Linwood Butterfly':
            'APP_DISPLAY_NAME = Linwood Butterfly Nightly',
      });
    case 'ios':
      _copy(
        _file(appRoot, 'web_nightly/ios/1024.png'),
        _file(
          appRoot,
          'ios/Runner/Assets.xcassets/AppIcon.appiconset/logo1024.png',
        ),
      );
      _replaceAll(_file(appRoot, 'ios/Runner/Info.plist'), {
        '<string>Butterfly</string>': '<string>Butterfly Nightly</string>',
      });
      _replaceAll(_file(appRoot, 'ios/Runner.xcodeproj/project.pbxproj'), {
        'PRODUCT_BUNDLE_IDENTIFIER = dev.linwood.butterfly;':
            'PRODUCT_BUNDLE_IDENTIFIER = dev.linwood.butterfly.nightly;',
      });
    default:
      stderr.writeln('Unsupported branding platform: $platform');
      exitCode = 64;
      return;
  }
  stdout.writeln('Applied Butterfly Nightly branding for $platform.');
}

File _file(Directory root, String relativePath) =>
    File.fromUri(root.uri.resolve(relativePath));

Directory _directory(Directory root, String relativePath) =>
    Directory.fromUri(root.uri.resolve('$relativePath/'));

void _copy(File source, File destination) {
  if (!source.existsSync()) {
    throw StateError('Missing branding asset: ${source.path}');
  }
  source.copySync(destination.path);
}

void _replaceAll(File file, Map<String, String> replacements) {
  var content = file.readAsStringSync();
  for (final MapEntry(key: from, value: to) in replacements.entries) {
    if (!content.contains(from)) {
      throw StateError(
        'Expected branding value not found in ${file.path}: $from',
      );
    }
    content = content.replaceAll(from, to);
  }
  file.writeAsStringSync(content);
}
