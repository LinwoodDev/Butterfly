import 'dart:io';

import 'package:args/args.dart';

Future<void> main(List<String> args) async {
  var parser = ArgParser();

  parser.addOption("build-number",
      abbr: "b",
      valueHelp: "Number, 'keep' or 'increment'",
      defaultsTo: "keep");
  parser.addFlag("changelog",
      abbr: "c", defaultsTo: true, help: "Generate changelog");

  var results = parser.parse(args);

  // Get the version from args
  if (results.rest.length != 1) {
    print("Please provide the version number as the first argument");
    exit(1);
  }

  String buildNumber = results['build-number'].toString().toLowerCase();
  if (buildNumber != 'increment' &&
      buildNumber != 'keep' &&
      int.tryParse(buildNumber) == null) {
    print(
        "Please provide a valid build number or 'increment' as the build-number argument");
    return;
  }
  var version = results.rest[0];
  // Update the version in the pubspec.yaml
  File pubspec = new File('app/pubspec.yaml');
  String content = await pubspec.readAsString();
  // Get last version from pubspec.yaml
  RegExp exp = new RegExp(r'^version:\s(.+)\+(.+)', multiLine: true);
  Iterable<Match> matches = exp.allMatches(content);
  if (matches.length != 1) {
    print("Could not find the version in the pubspec.yaml");
    exit(1);
  }
  var lastVersion = matches.first.group(0) ?? '';
  // Get build number from lastVersion
  var lastBuildNumber = lastVersion.split('+')[1];
  String newBuildNumber = buildNumber;
  if (buildNumber == 'increment')
    newBuildNumber = (int.parse(lastBuildNumber) + 1).toString();
  if (buildNumber == 'keep') newBuildNumber = lastBuildNumber;

  var newVersion = '$version+$newBuildNumber';
  // Update the version in the pubspec.yaml
  content = content.replaceAll(lastVersion, 'version: $newVersion');

  await pubspec.writeAsString(content);
  print(
      "Updating the version in the pubspec.yaml from $lastVersion to $newVersion");

  await updateAppImageVersion(version);
  await updateDebianVersion(version);
  await updateWindowsVersion(version);
  await updateSnapcraftVersion(version);
  if (results['changelog']) {
    var changelogFile =
        File("fastlane/metadata/android/en-US/changelogs/$newBuildNumber.txt");
    var changelog = await changelogFile.readAsString();
    await updateChangelog(version, changelog);
  }

  print("Successfully updated!");
}

Future<void> updateAppImageVersion(String version) async {
  var file = File("app/AppImageBuilder.yml");
  var lines = await file.readAsLines();
  lines[13] = "    version: ${version}";
  lines.add('');
  await file.writeAsString(lines.join("\r\n"));
  print("Successfully updated app image version to ${version}");
}

Future<void> updateDebianVersion(String version) async {
  var file = File("app/linux/debian/DEBIAN/control");
  var lines = await file.readAsLines();
  lines[1] = "Version: ${version}";
  lines.add('');
  await file.writeAsString(lines.join("\r\n"));
  print("Successfully updated debian version to ${version}");
}

Future<void> updateWindowsVersion(String version) async {
  var file = File("app/windows/runner/Runner.rc");
  var lines = await file.readAsLines();
  lines[71] = "#define VERSION_AS_STRING \"${version}\"";
  lines.add('');
  await file.writeAsString(lines.join("\r\n"));
  print("Successfully updated windows version to ${version}");
}

Future<void> updateSnapcraftVersion(String version) async {
  var file = File("app/snap/snapcraft.yaml");
  var lines = await file.readAsLines();
  lines[1] = "version: ${version}";
  lines.add('');
  await file.writeAsString(lines.join("\r\n"));
  print("Successfully updated snapcraft version to ${version}");
}

Future<void> updateChangelog(String version, String changelog) async {
  var currentDate = DateTime.now();
  final changelogRegex = RegExp(r"<!--ENTER CHANGELOG HERE-->");
  var dateString =
      "${currentDate.year}-${currentDate.month}-${currentDate.day}";
  var file = File("docs/community/CHANGELOG.md");
  var content = await file.readAsString();
  print(content);
  content.replaceAll(changelogRegex,
      "<!--ENTER CHANGELOG HERE-->\r\n## ${version} (${dateString})\r\n\r\n${changelog}");
  await file.writeAsString(content);
  print("Successfully updated docs for version ${version}");
}
