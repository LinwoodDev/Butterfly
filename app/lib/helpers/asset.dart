import 'dart:typed_data';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:super_clipboard/super_clipboard.dart';

const formatPage = CustomValueFormat<Uint8List>(
  applicationId: 'dev.linwood.butterfly.page',
);
const formatNote = CustomValueFormat<Uint8List>(
  applicationId: 'dev.linwood.butterfly.note',
);
const formatTextNote = CustomValueFormat<Uint8List>(
  applicationId: 'dev.linwood.butterfly.textnote',
);
final formatXopp = SimpleFileFormat(
  uniformTypeIdentifiers: AssetFileType.xopp.getUniformTypeIdentifiers(),
);

extension AssetFileTypeClipboardHelper on AssetFileType {
  List<DataFormat> getClipboardFormats() => switch (this) {
    AssetFileType.note => [formatNote],
    AssetFileType.textNote => [formatTextNote],
    AssetFileType.image => [Formats.png, Formats.jpeg, Formats.tiff],
    AssetFileType.pdf => [Formats.pdf],
    AssetFileType.svg => [Formats.svg],
    AssetFileType.markdown => [Formats.plainText],
    AssetFileType.page => [formatPage],
    AssetFileType.xopp => [formatXopp],
    AssetFileType.archive => [Formats.zip],
  };
}
