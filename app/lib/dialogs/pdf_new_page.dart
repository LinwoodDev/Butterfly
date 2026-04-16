import 'dart:math';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';

enum PdfTemplateApplicationMode { guideOnly, insertIntoPage }

enum _PdfPageUnit { millimeters, inches }

enum _PdfPagePreset {
  letter('Letter', 215.9, 279.4),
  oficio('Oficio', 215.9, 340.0),
  legal('Legal', 215.9, 355.6),
  a4('A4', 210.0, 297.0),
  a5('A5', 148.0, 210.0),
  a3('A3', 297.0, 420.0),
  tabloid('Tabloid', 279.4, 431.8),
  custom('Custom', 215.9, 279.4);

  final String label;
  final double widthMm;
  final double heightMm;

  const _PdfPagePreset(this.label, this.widthMm, this.heightMm);
}

class _TemplateOption {
  final String id;
  final String label;
  final List<PatternTexture> textures;

  const _TemplateOption({
    required this.id,
    required this.label,
    required this.textures,
  });
}

class PdfNewPageDialog extends StatefulWidget {
  final int? insertIndex;
  final int nextPageNumber;

  const PdfNewPageDialog({
    super.key,
    required this.nextPageNumber,
    this.insertIndex,
  });

  @override
  State<PdfNewPageDialog> createState() => _PdfNewPageDialogState();
}

class _PdfNewPageDialogState extends State<PdfNewPageDialog> {
  late final TextEditingController _widthController;
  late final TextEditingController _heightController;
  late final Future<List<_TemplateOption>> _templatesFuture;
  _PdfPagePreset _preset = _PdfPagePreset.letter;
  _PdfPageUnit _unit = _PdfPageUnit.millimeters;
  String _selectedTemplateId = '';
  PdfTemplateApplicationMode _templateMode =
      PdfTemplateApplicationMode.guideOnly;

  @override
  void initState() {
    super.initState();
    _widthController = TextEditingController(
      text: _preset.widthMm.toStringAsFixed(1),
    );
    _heightController = TextEditingController(
      text: _preset.heightMm.toStringAsFixed(1),
    );
    _widthController.addListener(_handleDimensionChanged);
    _heightController.addListener(_handleDimensionChanged);
    _templatesFuture = _loadTemplateOptions();
  }

  @override
  void dispose() {
    _widthController.removeListener(_handleDimensionChanged);
    _heightController.removeListener(_handleDimensionChanged);
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _handleDimensionChanged() {
    if (!mounted) return;
    setState(() {});
  }

  Future<List<_TemplateOption>> _loadTemplateOptions() async {
    final localizations = AppLocalizations.of(context);
    final fileSystem = context.read<ButterflyFileSystem>();
    final templateSystem = fileSystem.buildTemplateSystem();
    await templateSystem.initialize();
    final userTemplates = await templateSystem.getFiles();
    final coreTemplates = await DocumentDefaults.getCoreTemplates(context);

    final options = <_TemplateOption>[
      const _TemplateOption(id: '', label: '', textures: []),
      ...coreTemplates.map(
        (template) => _TemplateOption(
          id: 'core:${template.name}',
          label: (template.name?.isEmpty ?? true)
              ? localizations.templates
              : template.name!,
          textures: _extractTemplateTextures(template),
        ),
      ),
      ...userTemplates.map(
        (template) => _TemplateOption(
          id: template.location.path,
          label: template.data?.name ?? template.location.fileName,
          textures: _extractTemplateTextures(template.data),
        ),
      ),
    ];
    return options
        .where((option) => option.id.isEmpty || option.textures.isNotEmpty)
        .toList();
  }

  List<PatternTexture> _extractTemplateTextures(NoteData? template) {
    if (template == null) return const [];
    final pageName = template.getPages(true).firstOrNull;
    final page = pageName == null ? null : template.getPage(pageName);
    if (page == null) return const [];
    return page.backgrounds
        .whereType<TextureBackground>()
        .map((background) => background.texture)
        .whereType<PatternTexture>()
        .where(_hasVisibleTemplateLines)
        .map((texture) => texture.copyWith(boxColor: SRGBColor.transparent))
        .toList();
  }

  bool _hasVisibleTemplateLines(PatternTexture texture) =>
      texture.boxWidth > 0 ||
      texture.boxHeight > 0 ||
      texture.boxXSpace > 0 ||
      texture.boxYSpace > 0 ||
      texture.boxXCount > 1 ||
      texture.boxYCount > 1;

  void _selectPreset(_PdfPagePreset preset) {
    setState(() {
      _preset = preset;
      if (preset != _PdfPagePreset.custom) {
        final width = _convertMillimetersForUi(preset.widthMm, _unit);
        final height = _convertMillimetersForUi(preset.heightMm, _unit);
        _widthController.text = width.toStringAsFixed(
          _unit == _PdfPageUnit.inches ? 2 : 1,
        );
        _heightController.text = height.toStringAsFixed(
          _unit == _PdfPageUnit.inches ? 2 : 1,
        );
      }
    });
  }

  double _convertMillimetersForUi(double millimeters, _PdfPageUnit unit) =>
      unit == _PdfPageUnit.millimeters ? millimeters : millimeters / 25.4;

  double _convertUiToPoints(double value) {
    final inches = _unit == _PdfPageUnit.inches ? value : value / 25.4;
    return inches * 72;
  }

  DocumentPage _buildPage(List<PatternTexture> textures) {
    final widthValue =
        double.tryParse(_widthController.text.replaceAll(',', '.')) ?? 0;
    final heightValue =
        double.tryParse(_heightController.text.replaceAll(',', '.')) ?? 0;
    final width = _convertUiToPoints(widthValue);
    final height = _convertUiToPoints(heightValue);
    final pageSize = Point(width, height);
    final elements = _templateMode == PdfTemplateApplicationMode.insertIntoPage
        ? textures
              .map(
                (texture) => TextureElement(
                  firstPosition: const Point(0, 0),
                  secondPosition: pageSize,
                  texture: texture,
                ),
              )
              .toList()
        : const <PadElement>[];
    final backgrounds = [
      Background.texture(texture: PatternTemplate.plain.create()),
      if (_templateMode == PdfTemplateApplicationMode.guideOnly)
        ...textures.map((texture) => Background.texture(texture: texture)),
    ];
    return DocumentPage(
      backgrounds: backgrounds,
      areas: [
        Area(
          name: AppLocalizations.of(context).areaIndex(1),
          width: width,
          height: height,
          position: const Point(0, 0),
          isInitial: true,
        ),
      ],
      layers: [DocumentLayer(id: createUniqueId(), content: elements)],
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final leapLocalizations = LeapLocalizations.of(context);
    return FutureBuilder<List<_TemplateOption>>(
      future: _templatesFuture,
      builder: (context, snapshot) {
        final options = snapshot.data ?? const <_TemplateOption>[];
        final selectedTemplate = options.firstWhereOrNull(
          (option) => option.id == _selectedTemplateId,
        );
        final hasTemplate = (selectedTemplate?.textures.isNotEmpty ?? false);
        final widthValue =
            double.tryParse(_widthController.text.replaceAll(',', '.')) ?? 0;
        final heightValue =
            double.tryParse(_heightController.text.replaceAll(',', '.')) ?? 0;
        final canCreate = widthValue > 0 && heightValue > 0;

        return AlertDialog(
          scrollable: true,
          title: Text(localizations.newPage),
          content: SizedBox(
            width: 440,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<_PdfPagePreset>(
                  key: ValueKey(_preset),
                  initialValue: _preset,
                  decoration: InputDecoration(
                    labelText: localizations.pageSize,
                    border: const OutlineInputBorder(),
                  ),
                  items: _PdfPagePreset.values
                      .map(
                        (preset) => DropdownMenuItem(
                          value: preset,
                          child: Text(preset.label),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) _selectPreset(value);
                  },
                ),
                const SizedBox(height: 16),
                SegmentedButton<_PdfPageUnit>(
                  selected: {_unit},
                  segments: [
                    ButtonSegment(
                      value: _PdfPageUnit.millimeters,
                      label: Text(localizations.millimeters),
                    ),
                    ButtonSegment(
                      value: _PdfPageUnit.inches,
                      label: Text(localizations.inches),
                    ),
                  ],
                  onSelectionChanged: (selection) {
                    final nextUnit = selection.first;
                    if (nextUnit == _unit) return;
                    final widthValue =
                        double.tryParse(
                          _widthController.text.replaceAll(',', '.'),
                        ) ??
                        0;
                    final heightValue =
                        double.tryParse(
                          _heightController.text.replaceAll(',', '.'),
                        ) ??
                        0;
                    final widthMm = _unit == _PdfPageUnit.millimeters
                        ? widthValue
                        : widthValue * 25.4;
                    final heightMm = _unit == _PdfPageUnit.millimeters
                        ? heightValue
                        : heightValue * 25.4;
                    setState(() {
                      _unit = nextUnit;
                      _widthController.text = _convertMillimetersForUi(
                        widthMm,
                        _unit,
                      ).toStringAsFixed(_unit == _PdfPageUnit.inches ? 2 : 1);
                      _heightController.text = _convertMillimetersForUi(
                        heightMm,
                        _unit,
                      ).toStringAsFixed(_unit == _PdfPageUnit.inches ? 2 : 1);
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _widthController,
                        enabled: _preset == _PdfPagePreset.custom,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: localizations.width,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _heightController,
                        enabled: _preset == _PdfPagePreset.custom,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: localizations.height,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  key: ValueKey(_selectedTemplateId),
                  initialValue: _selectedTemplateId,
                  decoration: InputDecoration(
                    labelText: localizations.templateOptional,
                    border: const OutlineInputBorder(),
                  ),
                  items: options
                      .map(
                        (option) => DropdownMenuItem(
                          value: option.id,
                          child: Text(
                            option.id.isEmpty
                                ? localizations.none
                                : option.label,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedTemplateId = value ?? '';
                    });
                  },
                ),
                if (hasTemplate) ...[
                  const SizedBox(height: 16),
                  SegmentedButton<PdfTemplateApplicationMode>(
                    selected: {_templateMode},
                    segments: [
                      ButtonSegment(
                        value: PdfTemplateApplicationMode.guideOnly,
                        label: Text(localizations.templateGuideOnly),
                      ),
                      ButtonSegment(
                        value: PdfTemplateApplicationMode.insertIntoPage,
                        label: Text(localizations.templateInsertReal),
                      ),
                    ],
                    onSelectionChanged: (selection) {
                      setState(() {
                        _templateMode = selection.first;
                      });
                    },
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
            FilledButton(
              onPressed: !canCreate
                  ? null
                  : () {
                      final page = _buildPage(
                        selectedTemplate?.textures ?? const [],
                      );
                      Navigator.of(context).pop(
                        PageAddedDetails(
                          index: widget.insertIndex,
                          name: localizations.pageIndex(widget.nextPageNumber),
                          page: page,
                        ),
                      );
                    },
              child: Text(leapLocalizations.create),
            ),
          ],
        );
      },
    );
  }
}
