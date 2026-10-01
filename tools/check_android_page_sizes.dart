import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';

// https://developer.android.com/guide/practices/page-sizes
const pageSize = 16384;
const _machines = {'arm64-v8a': 183, 'x86_64': 62};
final _nativeLibrary = RegExp(r'(?:^|/)lib/([^/]+)/[^/]+\.so$');

/// Check every LOAD segment, including segments after the first one.
List<String> checkElf(Uint8List bytes, String abi) {
  if (bytes.length < 64 ||
      bytes[0] != 0x7f ||
      bytes[1] != 0x45 ||
      bytes[2] != 0x4c ||
      bytes[3] != 0x46 ||
      bytes[4] != 2 ||
      bytes[5] != 1) {
    throw const FormatException('expected a little-endian 64-bit ELF library');
  }
  final data = ByteData.sublistView(bytes);
  final machine = data.getUint16(18, Endian.little);
  if (machine != _machines[abi]) {
    throw FormatException('ELF machine $machine does not match $abi');
  }
  final phoff = data.getUint64(32, Endian.little);
  final phentsize = data.getUint16(54, Endian.little);
  final phnum = data.getUint16(56, Endian.little);
  if (phoff < 64 ||
      phentsize < 56 ||
      phnum == 0 ||
      phoff + phentsize * phnum > bytes.length) {
    throw const FormatException('invalid or missing ELF program headers');
  }
  final errors = <String>[];
  var loads = 0;
  for (var index = 0; index < phnum; index++) {
    final start = phoff + index * phentsize;
    if (data.getUint32(start, Endian.little) != 1) continue; // PT_LOAD
    loads++;
    final offset = data.getUint64(start + 8, Endian.little);
    final vaddr = data.getUint64(start + 16, Endian.little);
    final alignment = data.getUint64(start + 48, Endian.little);
    if (alignment < pageSize || alignment & (alignment - 1) != 0) {
      errors.add(
        'LOAD $index: alignment 0x${alignment.toRadixString(16)} '
        'is below 16 KB or invalid',
      );
    }
    if ((vaddr - offset) % pageSize != 0) {
      errors.add(
        'LOAD $index: file offset and virtual address disagree modulo 16 KB',
      );
    }
  }
  if (loads == 0) throw const FormatException('ELF has no LOAD segments');
  return errors;
}

int zipDataOffset(Uint8List bytes, int headerOffset) {
  final data = ByteData.sublistView(bytes);
  if (headerOffset < 0 ||
      headerOffset + 30 > bytes.length ||
      data.getUint32(headerOffset, Endian.little) != 0x04034b50) {
    throw const FormatException('invalid ZIP local header');
  }
  return headerOffset +
      30 +
      data.getUint16(headerOffset + 26, Endian.little) +
      data.getUint16(headerOffset + 28, Endian.little);
}

Map<int, Object> _protobufFields(Uint8List bytes) {
  var offset = 0;
  int varint() {
    var value = 0;
    for (var shift = 0; shift < 64; shift += 7) {
      if (offset >= bytes.length) {
        throw const FormatException('truncated BundleConfig protobuf');
      }
      final byte = bytes[offset++];
      value |= (byte & 127) << shift;
      if (byte < 128) return value;
    }
    throw const FormatException('invalid BundleConfig varint');
  }

  final fields = <int, Object>{};
  while (offset < bytes.length) {
    final tag = varint();
    final number = tag >> 3;
    final wire = tag & 7;
    if (number == 0) throw const FormatException('invalid BundleConfig field');
    if (wire == 0) {
      fields[number] = varint();
    } else if (wire == 1 || wire == 2 || wire == 5) {
      final size = wire == 2 ? varint() : (wire == 1 ? 8 : 4);
      if (size < 0 || offset + size > bytes.length) {
        throw const FormatException('truncated BundleConfig field');
      }
      fields[number] = Uint8List.sublistView(bytes, offset, offset + size);
      offset += size;
    } else {
      throw FormatException('unsupported BundleConfig wire type $wire');
    }
  }
  return fields;
}

List<String> checkBundleConfig(Uint8List bytes) {
  // BundleConfig.optimizations(2).uncompress_native_libraries(2).
  // Field numbers/enums: google/bundletool src/main/proto/config.proto.
  final config = _protobufFields(bytes);
  final optimizations = _protobufFields(
    config[2] as Uint8List? ?? Uint8List(0),
  );
  final native = _protobufFields(
    optimizations[2] as Uint8List? ?? Uint8List(0),
  );
  final enabled = native[1] as int? ?? 0;
  final alignment = native[2] as int? ?? 0;
  if (enabled != 0 && alignment != 2 && alignment != 3) {
    return [
      'BundleConfig.pb: uncompressed native libraries must request '
          'PAGE_ALIGNMENT_16K or 64K',
    ];
  }
  return [];
}

({int checked, List<String> errors}) checkArchive(
  Uint8List bytes, {
  required bool isBundle,
}) {
  final decoder = ZipDecoder();
  final archive = decoder.decodeBytes(bytes);
  final errors = <String>[];
  var nativeCount = 0;
  var checked = 0;
  for (final header in decoder.directory.fileHeaders) {
    final match = _nativeLibrary.firstMatch(header.filename);
    if (match == null) continue;
    nativeCount++;
    final abi = match[1]!;
    // 16 KB devices use arm64-v8a or x86_64, not 32-bit ABIs.
    if (!_machines.containsKey(abi)) continue;
    checked++;
    try {
      final library = archive.find(header.filename)!;
      final issues = checkElf(library.content, abi);
      // AAB ZIP offsets are not APK offsets. Check its config below.
      if (!isBundle && header.compressionMethod == 0) {
        final offset = zipDataOffset(bytes, header.localHeaderOffset);
        if (offset % pageSize != 0) {
          issues.add(
            'uncompressed ZIP data offset $offset is not 16 KB aligned',
          );
        }
      }
      errors.addAll(issues.map((issue) => '${header.filename}: $issue'));
    } catch (error) {
      errors.add('${header.filename}: $error');
    }
  }
  if (nativeCount == 0) {
    errors.add('no native libraries found; check the input artifact');
  }
  if (isBundle && checked > 0) {
    final config = archive.find('BundleConfig.pb');
    if (config == null) {
      errors.add('missing BundleConfig.pb');
    } else {
      errors.addAll(checkBundleConfig(config.content));
    }
  }
  return (checked: checked, errors: errors);
}

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    stderr.writeln(
      'Usage: dart run tools/check_android_page_sizes.dart <APK/AAB>...',
    );
    exitCode = 64;
    return;
  }
  for (final path in args) {
    try {
      if (!path.endsWith('.apk') && !path.endsWith('.aab')) {
        throw const FormatException('expected an .apk or .aab file');
      }
      final result = checkArchive(
        await File(path).readAsBytes(),
        isBundle: path.endsWith('.aab'),
      );
      if (result.errors.isEmpty) {
        stdout.writeln(
          'PASS $path: ${result.checked} 64-bit libraries support '
          '16 KB ELF/packaging alignment',
        );
      } else {
        exitCode = 1;
        for (final error in result.errors) {
          stderr.writeln('ERROR $path: $error');
        }
      }
    } catch (error) {
      stderr.writeln('ERROR $path: $error');
      exitCode = 1;
    }
  }
}
