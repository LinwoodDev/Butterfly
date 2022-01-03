import 'dart:io';

Future<void> main(List<String> args) async {
  // Get the version from args
  if (args.length != 1) {
    print("Please provide the version number as the first argument");
    exit(1);
  }
  var version = args[0];
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
  print(lastVersion);
  // Get build number from lastVersion
  var lastBuildNumber = lastVersion.split('+')[1];
  var newBuildNumber = (int.parse(lastBuildNumber) + 1).toString();

  var newVersion = '$version+$newBuildNumber';
  // Update the version in the pubspec.yaml
  content = content.replaceAll(lastVersion, 'version: $newVersion');

  await pubspec.writeAsString(content);
  print(
      "Updating the version in the pubspec.yaml from $lastVersion to $newVersion");
}
