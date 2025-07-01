import 'dart:io';

import 'package:args/args.dart';
import 'package:intl/intl.dart';

Future<void> main(List<String> args) async {
  var parser = ArgParser()
    ..addOption(
      'build-number',
      abbr: 'b',
      valueHelp: "Number, 'keep' or 'increment'",
      defaultsTo: 'keep',
    )
    ..addFlag(
      'changelog',
      abbr: 'c',
      defaultsTo: true,
      help: 'Generate changelog',
    );

  var results = parser.parse(args);

  String buildNumber = results['build-number'].toString().toLowerCase();
  if (buildNumber != 'increment' &&
      buildNumber != 'keep' &&
      int.tryParse(buildNumber) == null) {
    print(
      "Please provide a valid build number or 'increment' as the build-number argument",
    );
    return;
  }
  var version = results.rest.isEmpty ? null : results.rest[0];
  // Update the version in the pubspec.yaml
  File pubspec = File('app/pubspec.yaml');
  String content = await pubspec.readAsString();
  // Get last version from pubspec.yaml
  RegExp exp = RegExp(r'version:\s(?<version>.+)\+(?<build>.+)');
  var match = exp.firstMatch(content);
  if (match == null) {
    print('Could not find the version in the pubspec.yaml');
    exit(1);
  }
  var lastVersion = match.namedGroup('version') ?? '';
  version ??= lastVersion;
  // Get build number from lastVersion
  var lastBuildNumber = match.namedGroup('build') ?? '0';
  String newBuildNumber = buildNumber;
  if (buildNumber == 'increment') {
    newBuildNumber = (int.parse(lastBuildNumber) + 1).toString();
  }
  if (buildNumber == 'keep') newBuildNumber = lastBuildNumber;

  var newVersion = '$version+$newBuildNumber';
  // Update the version in the pubspec.yaml
  content = content.replaceAll(exp, 'version: $newVersion');

  await pubspec.writeAsString(content);
  print(
    'Updating the version in the pubspec.yaml from $lastVersion to $newVersion',
  );

  // Update api
  final apiPubspec = File('api/pubspec.yaml');
  var apiContent = await apiPubspec.readAsString();
  apiContent = apiContent.replaceAll(
    RegExp(r'version: .+'),
    'version: $version',
  );
  await apiPubspec.writeAsString(apiContent);
  print(
    'Updating the version in the api pubspec.yaml from $lastVersion to $newVersion',
  );

  await updateAppImageVersion(version);
  await updateDebianVersion(version);
  if (results['changelog']) {
    var changelogFile = File('metadata/en-US/changelogs/$newBuildNumber.txt');
    var changelog = await changelogFile.readAsString();
    await updateChangelog(version, changelog);
    await updateAppData(version);
  }

  // Run flutter pub get in app directory
  await Process.run(
    'flutter',
    ['pub', 'get'],
    workingDirectory: 'app',
    runInShell: true,
  );

  print('Successfully updated!');
}

Future<void> updateAppImageVersion(String version) async {
  var file = File('app/AppImageBuilder.yml');
  var lines = await file.readAsLines();
  lines[16] = '    version: $version';
  lines.add('');
  await file.writeAsString(lines.join('\r\n'));
  print('Successfully updated app image version to $version');
}

Future<void> updateDebianVersion(String version) async {
  var file = File('app/linux/debian/DEBIAN/control');
  var lines = await file.readAsLines();
  lines[1] = 'Version: $version';
  lines.add('');
  await file.writeAsString(lines.join('\r\n'));
  print('Successfully updated debian version to $version');
}

bool isPreRelease(String version) {
  return version.contains('-');
}

Future<void> updateAppData(String version) async {
  var file = File(
    'app/linux/debian/usr/share/metainfo/dev.linwood.butterfly.appdata.xml',
  );
  if (isPreRelease(version)) {
    return;
  }
  var currentDate = DateTime.now();
  var dateString = DateFormat('yyyy-MM-dd').format(currentDate);
  var line = '\t\t<release version="$version" date="$dateString" />';
  var lines = List<String>.from(await file.readAsLines());
  lines.insert(71, line);
  await file.writeAsString(lines.join('\n'));
  print('Successfully updated appdata version to $version');
}

Future<void> updateChangelog(String version, String changelog) async {
  var currentDate = DateTime.now();
  final changelogRegex = RegExp(r'<!--ENTER CHANGELOG HERE-->');
  var dateString = DateFormat('yyyy-MM-dd').format(currentDate);
  var file = File('CHANGELOG.md');
  var content = await file.readAsString();
  content = content.replaceAll(
    changelogRegex,
    '<!--ENTER CHANGELOG HERE-->\r\n\r\n## $version ($dateString)\r\n\r\n$changelog',
  );
  await file.writeAsString(content);
  print('Successfully updated docs for version $version');
}
