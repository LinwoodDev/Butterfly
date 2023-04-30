import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';

import 'legacy.dart';

const kArchiveSignature = 0x50;

Archive noteDataMigrator(Uint8List data) {
  if (data[0] != kArchiveSignature) {
    final map = json.decode(utf8.decode(data)) as Map<String, dynamic>;
    return convertLegacyDataToArchive(map);
  }
  return ZipDecoder().decodeBytes(data);
}
