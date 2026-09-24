// Run between msix:build and msix:pack. The msix package does not expose
// thumbnail and preview handler declarations in its configuration.
import 'dart:io';

import 'package:xml/xml.dart';

String patchMsixNotePreview(String manifest, String flavor) {
  final (thumbnail, preview) = switch (flavor) {
    'production' => (
      '1D0ED140-D9FB-4212-B05F-95D0816DE3CC',
      'D8380BD5-6F06-421E-93D3-474D246C5041',
    ),
    'nightly' => (
      '59FB241D-FFA6-4C01-8A66-2BBA71384A55',
      'AF658105-F78A-4EB4-A1B4-AF964045838F',
    ),
    _ => throw ArgumentError.value(flavor, 'flavor'),
  };
  if (manifest.contains('butterfly_note_preview.dll')) {
    throw StateError('Note preview is already registered');
  }
  final associationPattern = RegExp(
    r'<uap:FileTypeAssociation\b[\s\S]*?</uap:FileTypeAssociation>',
  );
  final match = associationPattern.firstMatch(manifest);
  if (match == null) throw StateError('MSIX file association not found');
  var association = match.group(0)!;
  for (final extension in ['bfly', 'tbfly']) {
    final fileType = '<uap:FileType>.$extension</uap:FileType>';
    if (fileType.allMatches(association).length != 1) {
      throw StateError('Expected exactly one $fileType');
    }
    association = association.replaceFirst(fileType, '');
  }
  // The generated association also includes PDF and image formats. Keep the
  // note handlers on their own association so they do not claim those formats.
  final noteAssociation =
      '''<uap:Extension Category="windows.fileTypeAssociation">
            <uap:FileTypeAssociation Name="butterflynotes">
              <uap:SupportedFileTypes>
                <uap:FileType>.bfly</uap:FileType>
                <uap:FileType>.tbfly</uap:FileType>
              </uap:SupportedFileTypes>
              <desktop2:ThumbnailHandler Clsid="$thumbnail" />
              <desktop2:DesktopPreviewHandler Clsid="$preview" />
            </uap:FileTypeAssociation>
          </uap:Extension>''';
  manifest = manifest.replaceRange(
    match.start,
    match.end,
    '$association\n$noteAssociation',
  );
  if ('</Extensions>'.allMatches(manifest).length != 1) {
    throw StateError('Expected one application Extensions element');
  }
  final comServer =
      '''<com:Extension Category="windows.comServer">
            <com:ComServer>
              <com:SurrogateServer DisplayName="Butterfly note preview">
                <com:Class Id="$thumbnail" Path="butterfly_note_preview.dll" ThreadingModel="STA" />
                <com:Class Id="$preview" Path="butterfly_note_preview.dll" ThreadingModel="STA" />
              </com:SurrogateServer>
            </com:ComServer>
          </com:Extension>
          ''';
  manifest = manifest.replaceFirst('</Extensions>', '$comServer</Extensions>');
  XmlDocument.parse(manifest);
  return manifest;
}

Future<void> main(List<String> args) async {
  if (args.length != 2) {
    stderr.writeln(
      'usage: patch_msix_note_preview.dart AppxManifest.xml production|nightly',
    );
    exit(2);
  }
  final file = File(args[0]);
  await file.writeAsString(
    patchMsixNotePreview(await file.readAsString(), args[1]),
  );
}
