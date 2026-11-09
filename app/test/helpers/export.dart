import 'dart:typed_data';

import 'package:butterfly/dialogs/export/batch.dart';
import 'package:butterfly/services/batch_export.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/theme.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';

class ExportTestApp extends StatefulWidget {
  const ExportTestApp({super.key});
  @override
  State<ExportTestApp> createState() => _ExportTestAppState();
}

class _ExportTestAppState extends State<ExportTestApp> {
  final source = ExportTestSource();
  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: getThemeData('Classic', false),
    localizationsDelegates: const [
      ...AppLocalizations.localizationsDelegates,
      LeapLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: BatchExportDialog(source: source)),
  );
}

class ExportTestSource extends ExportSource {
  @override
  String get documentName => 'Field notes';
  @override
  String get currentPage => 'Studies';
  @override
  List<(String, String)> get pages => [
    ('Cover', 'Cover'),
    ('Studies', 'Studies'),
    ('Observations', 'Observations'),
  ];
  @override
  final presets = <ExportPreset>[
    const ExportPreset(
      name: 'Botanical studies',
      areas: [
        AreaPreset(page: 'Studies', name: 'Botanical study'),
        AreaPreset(page: 'Studies', name: 'Leaf details', quality: 2),
      ],
    ),
  ];
  @override
  ExportItem view() => ExportItem(
    '',
    currentPage,
    const ImageExportOptions(width: 960, height: 540),
    region: .view,
  );
  @override
  Future<ExportItem> page(String page) async => ExportItem(
    page,
    page,
    const ImageExportOptions(width: 794, height: 1123),
    region: .page,
  );
  @override
  List<ExportItem> areas(String page) => switch (page) {
    'Studies' => [
      ExportItem(
        'Botanical study',
        page,
        const ImageExportOptions(width: 640, height: 480, x: 120, y: 80),
        region: .area,
      ),
      ExportItem(
        'Leaf details',
        page,
        const ImageExportOptions(width: 320, height: 240, x: 200, y: 160),
        region: .area,
      ),
    ],
    'Observations' => [
      ExportItem(
        'Summary',
        page,
        const ImageExportOptions(width: 600, height: 400),
        region: .area,
      ),
    ],
    _ => [],
  };
  @override
  void savePreset(ExportPreset preset) => presets.add(preset);
  @override
  void removePreset(String name) => presets.removeWhere((e) => e.name == name);
  @override
  Future<Uint8List?> renderPng(ExportItem item, {bool preview = false}) async =>
      null;

  @override
  Future<String> renderSvg(ExportItem item) async =>
      '<svg xmlns="http://www.w3.org/2000/svg" width="${item.options.width}" height="${item.options.height}"><text x="20" y="40">Field notes</text></svg>';
}
