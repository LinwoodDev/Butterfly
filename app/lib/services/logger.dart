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
    final logs = talker.history.take(_maxLogEntries).map((log) {
      return {
        'message': log.message,
        'logLevel': log.logLevel?.name,
        'title': log.title,
        'time': log.time.toIso8601String(),
        'key': log.key,
        if (log.exception != null) 'exception': log.exception.toString(),
        if (log.stackTrace != null) 'stackTrace': log.stackTrace.toString(),
      };
    }).toList();
    await file.writeAsString(jsonEncode(logs));
  } catch (e) {
    // Silently fail to avoid recursive logging
  }
}

Future<void> loadPersistedLogs() async {
  if (kIsWeb) return;
  try {
    final file = await _getLogFile();
    if (await file.exists()) {
      final content = await file.readAsString();
      final logs = jsonDecode(content) as List;
      for (final logData in logs.reversed) {
        final map = logData as Map<String, dynamic>;
        final logLevel = LogLevel.values.firstWhere(
          (l) => l.name == map['logLevel'],
          orElse: () => LogLevel.debug,
        );
        final time =
            DateTime.tryParse(map['time'] as String? ?? '') ?? DateTime.now();
        final exception = map['exception'] as String?;
        final stackTrace = map['stackTrace'] as String?;

        if (exception != null) {
          talker.handle(
            Exception(exception),
            stackTrace != null ? StackTrace.fromString(stackTrace) : null,
            map['message'] as String?,
          );
        } else {
          talker.logCustom(
            TalkerLog(
              map['message'] as String? ?? '',
              logLevel: logLevel,
              title: map['title'] as String?,
              time: time,
            ),
          );
        }
      }
    }
  } catch (e) {
    // Log file doesn't exist or is corrupted, start fresh
  }
}

Future<void> clearPersistedLogs() async {
  if (kIsWeb) return;
  try {
    final file = await _getLogFile();
    if (await file.exists()) {
      await file.delete();
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
