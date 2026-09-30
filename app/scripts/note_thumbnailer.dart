// Small native executable for Explorer and freedesktop thumbnailers. Uses the
// archive and image packages already used by Butterfly; it does not start Flutter.
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:image/image.dart' as img;

const _thumbnailPath = 'BFLY/thumbnail.png';
const _pngSignature = [137, 80, 78, 71, 13, 10, 26, 10];

Future<void> main(List<String> args) async {
  if (args.length < 2 || args.length > 3) exit(2);
  try {
    final size = args.length == 3 ? int.parse(args[2]) : 2048;
    if (size < 1 || size > 4096) exit(2);
    final fromPipe = args[0] == '-';
    Uint8List? note;
    late final int length;
    if (fromPipe) {
      final bytes = BytesBuilder(copy: false);
      await for (final chunk in stdin) {
        if (bytes.length + chunk.length > 512 * 1024 * 1024) exit(1);
        bytes.add(chunk);
      }
      note = bytes.takeBytes();
      length = note.length;
    } else {
      length = await File(args[0]).length();
    }
    if (length > 512 * 1024 * 1024 || length < 4) exit(1);
    final magic = fromPipe
        ? note!.sublist(0, 4)
        : await File(args[0]).openRead(0, 4).first;
    Uint8List? png;
    if (magic[0] == 0x50 && magic[1] == 0x4b) {
      if (fromPipe) {
        final entry = ZipDecoder().decodeBytes(note!).findFile(_thumbnailPath);
        if (entry != null && entry.size <= 16 * 1024 * 1024) {
          png = entry.content;
        }
      } else {
        final stream = InputFileStream(args[0]);
        try {
          final entry = ZipDecoder()
              .decodeStream(stream)
              .findFile(_thumbnailPath);
          if (entry != null && entry.size <= 16 * 1024 * 1024) {
            png = entry.content;
          }
        } finally {
          stream.closeSync();
        }
      }
    } else if (length <= 32 * 1024 * 1024) {
      note ??= await File(args[0]).readAsBytes();
      final json = jsonDecode(utf8.decode(note)) as Map<String, dynamic>;
      final data = json['thumbnail'];
      if (data is String && data.startsWith('data:image/png;base64,')) {
        png = base64Decode(data.substring('data:image/png;base64,'.length));
      }
    }
    if (png == null ||
        png.length < _pngSignature.length ||
        png.length > 16 * 1024 * 1024) {
      exit(1);
    }
    for (var i = 0; i < _pngSignature.length; i++) {
      if (png[i] != _pngSignature[i]) exit(1);
    }
    if (png.length < 24 ||
        png[12] != 73 ||
        png[13] != 72 ||
        png[14] != 68 ||
        png[15] != 82) {
      exit(1);
    }
    final header = ByteData.sublistView(png);
    final width = header.getUint32(16);
    final height = header.getUint32(20);
    if (width == 0 || height == 0 || width > 8192 || height > 8192) {
      exit(1);
    }
    final decoded = img.decodePng(png);
    if (decoded == null) exit(1);
    if (decoded.width > size || decoded.height > size) {
      final scale =
          size /
          (decoded.width > decoded.height ? decoded.width : decoded.height);
      png = img.encodePng(
        img.copyResize(
          decoded,
          width: (decoded.width * scale).round().clamp(1, size),
          height: (decoded.height * scale).round().clamp(1, size),
        ),
      );
    }
    if (args[1] == '-') {
      stdout.add(png);
      await stdout.flush();
    } else {
      await File(args[1]).writeAsBytes(png, flush: true);
    }
  } catch (_) {
    exit(1);
  }
}
