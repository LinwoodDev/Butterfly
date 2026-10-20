// Compiled into the private cache so native hooks can use it on every host OS.
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  final config =
      jsonDecode(
            File(
              '${File(Platform.resolvedExecutable).parent.path}/rustup.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  final process = await Process.start(
    config['executable'] as String,
    [
      ...arguments,
      if (arguments.length >= 4 &&
          arguments[0] == 'run' &&
          arguments[2] == 'cargo' &&
          arguments[3] == 'build' &&
          !arguments.contains('--locked'))
        '--locked',
    ],
    environment: (config['environment'] as Map).cast<String, String>(),
    mode: ProcessStartMode.inheritStdio,
  );
  exitCode = await process.exitCode;
}
