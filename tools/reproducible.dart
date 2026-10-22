import 'dart:io';

import 'package:generate_leap/reproducible.dart';

Future<void> main(List<String> args) async {
  if (args.length < 2 || args.length > 3) {
    stderr.writeln(
      'Usage: dart tools/reproducible.dart <directory> <output.zip|output.tar.gz> [prefix]',
    );
    exitCode = 64;
    return;
  }
  final encode = args[1].endsWith('.tar.gz')
      ? reproducibleTarGz
      : reproducibleZip;
  await encode(
    Directory(args[0]),
    File(args[1]),
    await sourceDateEpoch(File.fromUri(Platform.script).parent.parent),
    prefix: args.length == 3 ? args[2] : null,
  );
}
