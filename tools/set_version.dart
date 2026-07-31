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

  await updateDebianVersion(version);
  if (results['changelog']) {
    var changelogFile = File('metadata/en-US/changelogs/$newBuildNumber.txt');
    var changelog = await changelogFile.readAsString();
    await updateChangelog(version, changelog);
    await updateAppData(version, changelog);
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

const _maximumDetailedAppDataReleases = 5;
const _maximumAppDataChanges = 10;

Future<void> updateAppData(String version, String changelog) async {
  var file = File(
    'app/linux/debian/usr/share/metainfo/dev.linwood.butterfly.appdata.xml',
  );
  var currentDate = DateTime.now();
  var dateString = DateFormat('yyyy-MM-dd').format(currentDate);
  var content = await file.readAsString();
  var releasesStart = content.indexOf('<releases>');
  var releasesEnd = content.indexOf('</releases>');
  if (releasesStart == -1 || releasesEnd == -1) {
    print('Could not find releases in the appdata file');
    exit(1);
  }

  var releasesContent = content.substring(
    releasesStart + '<releases>'.length,
    releasesEnd,
  );
  var releaseRegex = RegExp(
    r'^\t\t<release\b(?:[^>]*?/\s*>|[^>]*>[\s\S]*?^\t\t</release>)\r?$',
    multiLine: true,
  );
  var versionRegex = RegExp(r'\bversion="([^"]+)"');
  var oldReleases = releaseRegex
      .allMatches(releasesContent)
      .map((match) => match.group(0)!)
      .where((release) {
        return versionRegex.firstMatch(release)?.group(1) != version;
      });
  var taggedReleases = await _loadTaggedAppDataReleases();
  var releasesByVersion = <String, String>{};
  for (var release in [
    _buildAppDataRelease(version, dateString, changelog),
    ...oldReleases,
    ...taggedReleases,
  ]) {
    var releaseVersion = versionRegex.firstMatch(release)?.group(1);
    if (releaseVersion != null) {
      releasesByVersion.putIfAbsent(releaseVersion, () => release);
    }
  }
  var releases = releasesByVersion.values.toList();
  releases.sort((a, b) {
    var aVersion = versionRegex.firstMatch(a)!.group(1)!;
    var bVersion = versionRegex.firstMatch(b)!.group(1)!;
    return _compareVersions(bVersion, aVersion);
  });
  releases = _compactAppDataReleases(releases);
  var newReleasesContent = '\n${releases.join('\n')}\n\t';
  content = content.replaceRange(
    releasesStart + '<releases>'.length,
    releasesEnd,
    newReleasesContent,
  );
  await file.writeAsString(content);
  print('Successfully updated appdata version to $version');
}

String _buildAppDataRelease(String version, String date, String changelog) {
  var type = isPreRelease(version) ? 'development' : 'stable';
  var changes = changelog
      .split(RegExp(r'\r?\n'))
      .where((line) => line.startsWith('* '))
      .map((line) => _plainText(line.substring(2)))
      .take(_maximumAppDataChanges)
      .toList();
  var description = changes.isEmpty
      ? ''
      : '''
			<description>
				<ul>
${changes.map((change) => '\t\t\t\t\t<li>${_escapeXml(change)}</li>').join('\n')}
				</ul>
			</description>''';
  var escapedVersion = _escapeXml(version);
  return '''\t\t<release version="$escapedVersion" type="$type" date="$date">
$description
			<url type="details">https://linwood.dev/butterfly/$escapedVersion</url>
		</release>''';
}

String _plainText(String markdown) {
  return markdown
      .replaceAllMapped(
        RegExp(r'\[([^\]]+)\]\([^)]+\)'),
        (match) => match.group(1)!,
      )
      .replaceAll('`', '');
}

Future<List<String>> _loadTaggedAppDataReleases() async {
  var result = await Process.run('git', [
    'tag',
    '--list',
    'v[0-9]*',
    '--format=%(refname:strip=2)\t%(creatordate:short)',
  ]);
  if (result.exitCode != 0) return [];

  var tagRegex = RegExp(
    r'^v(\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?)\t(\d{4}-\d{2}-\d{2})$',
  );
  return result.stdout
      .toString()
      .split(RegExp(r'\r?\n'))
      .map(tagRegex.firstMatch)
      .whereType<RegExpMatch>()
      .map((match) {
        var version = match.group(1)!;
        var date = match.group(2)!;
        var type = isPreRelease(version) ? ' type="development"' : '';
        return '\t\t<release version="$version"$type date="$date" />';
      })
      .toList();
}

List<String> _compactAppDataReleases(List<String> releases) {
  return releases.indexed.map((entry) {
    var (index, release) = entry;
    if (index < _maximumDetailedAppDataReleases) return release;
    var openingTag = RegExp(r'^\t\t<release\b([^>]*)>').firstMatch(release);
    if (openingTag == null) return release;
    var attributes = openingTag
        .group(1)!
        .replaceFirst(RegExp(r'/\s*$'), '')
        .trimRight();
    return '\t\t<release$attributes />';
  }).toList();
}

int _compareVersions(String a, String b) {
  var aParts = _splitVersion(a);
  var bParts = _splitVersion(b);
  var aCore = aParts.first.split('.').map(int.parse).toList();
  var bCore = bParts.first.split('.').map(int.parse).toList();
  for (var index = 0; index < 3; index++) {
    var comparison = aCore[index].compareTo(bCore[index]);
    if (comparison != 0) return comparison;
  }
  // AppStream orders development suffixes ahead of the matching stable
  // version (for example, 2.5.3-rc.1 before 2.5.3).
  if (aParts.length == 1 && bParts.length > 1) return -1;
  if (aParts.length > 1 && bParts.length == 1) return 1;
  if (aParts.length == 1) return 0;

  var aPreRelease = aParts[1].split('.');
  var bPreRelease = bParts[1].split('.');
  for (
    var index = 0;
    index < aPreRelease.length && index < bPreRelease.length;
    index++
  ) {
    var aNumber = int.tryParse(aPreRelease[index]);
    var bNumber = int.tryParse(bPreRelease[index]);
    int comparison;
    if (aNumber != null && bNumber != null) {
      comparison = aNumber.compareTo(bNumber);
    } else if (aNumber != null) {
      comparison = -1;
    } else if (bNumber != null) {
      comparison = 1;
    } else {
      comparison = aPreRelease[index].compareTo(bPreRelease[index]);
    }
    if (comparison != 0) return comparison;
  }
  return aPreRelease.length.compareTo(bPreRelease.length);
}

List<String> _splitVersion(String version) {
  var separator = version.indexOf('-');
  if (separator == -1) return [version];
  return [version.substring(0, separator), version.substring(separator + 1)];
}

String _escapeXml(String value) {
  return value
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&apos;');
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
