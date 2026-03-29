import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();
const _maxLogEntries = 1000;
const _logFileName = 'logs.json';

Future<File> _getLogFile() async {
  final directory = await getApplicationSupportDirectory();
  return File('${directory.path}/$_logFileName');
}

Future<void> _saveLogsToFile() async {
  if (kIsWeb) return;
  try {
    final file = await _getLogFile();
    final logs = talker.history
        .where(
          (e) => e.logLevel != LogLevel.verbose && e.logLevel != LogLevel.debug,
        )
        .take(_maxLogEntries)
        .map((log) {
          return {
            'message': log.message,
            'logLevel': log.logLevel?.name,
            'title': log.title,
            'time': log.time.toIso8601String(),
            'key': log.key,
            if (log.exception != null) 'exception': log.exception.toString(),
            if (log.stackTrace != null) 'stackTrace': log.stackTrace.toString(),
          };
        })
        .toList();
    await file.writeAsString(jsonEncode(logs));
  } catch (e) {
    // Silently fail to avoid recursive logging
  }
}

Future<void> rotatePersistedLogs() async {
  if (kIsWeb) return;
  try {
    final file = await _getLogFile();
    final directory = await getApplicationSupportDirectory();
    if (await file.exists()) {
      final stat = await file.stat();
      final dateStr = stat.modified
          .toIso8601String()
          .replaceAll(':', '-')
          .split('.')
          .first;
      final newFile = File('${directory.path}/logs_$dateStr.json');
      await file.rename(newFile.path);
    }

    final files = directory
        .listSync()
        .whereType<File>()
        .where((e) => e.path.contains('logs_') && e.path.endsWith('.json'))
        .toList();
    files.sort((a, b) => b.path.compareTo(a.path));

    for (var i = 3; i < files.length; i++) {
      await files[i].delete();
    }
  } catch (e) {
    // Log file doesn't exist or is corrupted, start fresh
  }
}

Future<List<File>> getArchivedLogs() async {
  if (kIsWeb) return [];
  try {
    final directory = await getApplicationSupportDirectory();
    final files = directory
        .listSync()
        .whereType<File>()
        .where((e) => e.path.contains('logs_') && e.path.endsWith('.json'))
        .toList();
    files.sort((a, b) => b.path.compareTo(a.path));
    return files;
  } catch (e) {
    return [];
  }
}

Future<List<TalkerData>> loadArchivedLogFile(File file) async {
  if (kIsWeb) return [];
  try {
    if (await file.exists()) {
      final content = await file.readAsString();
      final logs = jsonDecode(content) as List;
      return logs.map((logData) {
        final map = logData as Map<String, dynamic>;
        final logLevel = LogLevel.values.firstWhere(
          (l) => l.name == map['logLevel'],
          orElse: () => LogLevel.debug,
        );
        final time =
            DateTime.tryParse(map['time'] as String? ?? '') ?? DateTime.now();

        final exception = map['exception'] as String?;
        final stackTraceString = map['stackTrace'] as String?;

        if (exception != null) {
          return TalkerLog(
            '${map['message'] as String? ?? ''}\n$exception\n${stackTraceString ?? ''}',
            logLevel: LogLevel.error,
            title: map['title'] as String? ?? 'Error',
            time: time,
          );
        } else {
          return TalkerLog(
            map['message'] as String? ?? '',
            logLevel: logLevel,
            title: map['title'] as String?,
            time: time,
          );
        }
      }).toList();
    }
  } catch (e) {
    // Ignore
  }
  return [];
}

Future<void> clearPersistedLogs() async {
  if (kIsWeb) return;
  try {
    final directory = await getApplicationSupportDirectory();
    final file = await _getLogFile();
    if (await file.exists()) {
      await file.delete();
    }
    final files = directory.listSync().whereType<File>().where(
      (e) => e.path.contains('logs_') && e.path.endsWith('.json'),
    );
    for (final f in files) {
      await f.delete();
    }
  } catch (e) {
    // Silently fail
  }
}

void initLogger() {
  setupErrorHooks(talker);

  // Add observer to persist logs
  talker.stream.listen((_) {
    _saveLogsToFile();
  });

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printEventFullData: false,
      printStateFullData: false,
    ),
  );
}
