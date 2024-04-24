import 'package:butterfly/api/save.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum ExportTransformPreset { page, view }

ImageExportOptions getDefaultImageExportOptions(BuildContext context,
    {CameraTransform? transform}) {
  transform ??= context.read<TransformCubit>().state;
  final size = MediaQuery.of(context).size;
  return ImageExportOptions(
    width: size.width,
    height: size.height,
    x: transform.position.dx,
    y: transform.position.dy,
    scale: transform.size,
  );
}

SVGExportOptions getDefaultSVGExportOptions(BuildContext context,
    {CameraTransform? transform}) {
  transform ??= context.read<TransformCubit>().state;
  final size = MediaQuery.of(context).size;
  final scale = transform.size;
  return SVGExportOptions(
    width: size.width / scale,
    height: size.height / scale,
    x: transform.position.dx,
    y: transform.position.dy,
  );
}

class GeneralExportDialog extends StatefulWidget {
  final ExportOptions options;
  final ExportTransformPreset? preset;

  const GeneralExportDialog({
    super.key,
    required this.options,
    this.preset,
  });

  @override
  State<GeneralExportDialog> createState() => _GeneralExportDialogState();
}

class _GeneralExportDialogState extends State<GeneralExportDialog> {
  final TextEditingController _xController = TextEditingController(text: '0');

  final TextEditingController _yController = TextEditingController(text: '0');

  final TextEditingController _widthController =
      TextEditingController(text: '1000');

  final TextEditingController _heightController =
      TextEditingController(text: '1000');

  ExportTransformPreset? _preset;

  late ExportOptions _options;

  ByteData? _previewImage;
  Future<ByteData?>? _regeneratingFuture;

  @override
  void initState() {
    _preset = widget.preset;
    _applyOptions(widget.options);
    _regeneratePreviewImage();

    super.initState();
  }

  void _applyOptions(ExportOptions options) {
    _options = options;
    _xController.text = _options.x.toString();
    _yController.text = _options.y.toString();
    _widthController.text = _options.width.toString();
    _heightController.text = _options.height.toString();
  }

  Future<void> _regeneratePreviewImage() async {
    if (_regeneratingFuture != null) return;
    var imageFuture = generateImage();
    _regeneratingFuture =
        _regeneratingFuture?.then((value) => imageFuture) ?? imageFuture;
    var image = await _regeneratingFuture;
    _regeneratingFuture = null;
    if (mounted) setState(() => _previewImage = image);
  }

  Future<ByteData?> generateImage() async {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoaded) return null;
    return state.currentIndexCubit
        .render(state.data, state.page, state.info, _options.toImageOptions());
  }

  Future<String?> generateSVG(SVGExportOptions options) async {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoaded) return null;
    return state.currentIndexCubit
        .renderSVG(state.data, state.page, options)
        .toXmlString();
  }

  Future<void> export(bool share) async {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) {
      return;
    }
    switch (_options) {
      case ImageExportOptions():
        final data = await generateImage();
        if (data == null) {
          return;
        }
        await exportImage(context, data.buffer.asUint8List(), share);
      case final SVGExportOptions options:
        final data = await generateSVG(options);
        if (data == null) {
          return;
        }
        await exportSvg(context, data, share);
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Dialog(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 600, maxWidth: 1000),
          child: Column(
            children: [
              Header(
                title: Text(AppLocalizations.of(context).export),
                leading: const PhosphorIcon(PhosphorIconsLight.export),
                actions: [
                  IconButton(
                    icon: const Icon(PhosphorIconsLight.mapPin),
                    tooltip: AppLocalizations.of(context).pin,
                    onPressed: () {
                      final tool = ExportTool(options: _options);
                      context.read<DocumentBloc>().add(ToolCreated(tool));
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    children: [
                      Expanded(
                        child: LayoutBuilder(builder: (context, constraints) {
                          var isMobile = constraints.maxWidth < 600;
                          if (isMobile) {
                            return ListView(
                              children: [
                                SizedBox(
                                  height: 500,
                                  child: _buildPreview(),
                                ),
                                _buildProperties()
                              ],
                            );
                          }
                          return Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: _buildPreview(),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: _buildProperties(),
                                  ),
                                )
                              ]);
                        }),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          TextButton(
                            child: Text(AppLocalizations.of(context).cancel),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          if (supportsShare())
                            ElevatedButton(
                              child: Text(AppLocalizations.of(context).export),
                              onPressed: () => export(true),
                            ),
                          ElevatedButton(
                            child: Text(AppLocalizations.of(context).export),
                            onPressed: () => export(false),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPreview() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Wrap(
              spacing: 4,
              children: [
                IconButton.filledTonal(
                  onPressed: () {
                    final transform = context
                        .read<DocumentBloc>()
                        .state
                        .currentIndexCubit
                        ?.state
                        .transformCubit
                        .state;
                    _applyOptions(_options.map(
                      image: (e) => getDefaultImageExportOptions(context,
                          transform: transform),
                      svg: (e) => getDefaultSVGExportOptions(context,
                          transform: transform),
                    ));
                    setState(() => _preset = ExportTransformPreset.view);
                    _regeneratePreviewImage();
                  },
                  icon: const PhosphorIcon(PhosphorIconsLight.userRectangle),
                  selectedIcon:
                      const PhosphorIcon(PhosphorIconsFill.userRectangle),
                  isSelected: _preset == ExportTransformPreset.view,
                ),
                IconButton.filledTonal(
                  onPressed: () {
                    final cubit =
                        context.read<DocumentBloc>().state.currentIndexCubit;
                    if (cubit == null) return;
                    final rect = cubit.getPageRect();
                    _applyOptions(_options.map(
                      image: (e) => e.copyWith(
                        width: rect.width,
                        height: rect.height,
                        x: rect.left,
                        y: rect.top,
                        scale: 1,
                      ),
                      svg: (e) => e.copyWith(
                        width: rect.width,
                        height: rect.height,
                        x: rect.left,
                        y: rect.top,
                      ),
                    ));
                    setState(() => _preset = ExportTransformPreset.page);
                    _regeneratePreviewImage();
                  },
                  icon: const PhosphorIcon(PhosphorIconsLight.file),
                  selectedIcon: const PhosphorIcon(PhosphorIconsFill.file),
                  isSelected: _preset == ExportTransformPreset.page,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<DocumentBloc, DocumentState>(
                  builder: (context, state) {
                if (state is! DocumentLoadSuccess || _previewImage == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Image(
                  fit: BoxFit.contain,
                  image: MemoryImage(_previewImage!.buffer.asUint8List()),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      );

  Widget _buildProperties() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          AppLocalizations.of(context).position,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _xController,
                decoration: const InputDecoration(labelText: 'X', filled: true),
                onChanged: (value) {
                  _options = _options.copyWith(
                      x: double.tryParse(value) ?? _options.x);
                  setState(() => _preset = null);
                },
                onSubmitted: (value) => _regeneratePreviewImage(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _yController,
                decoration: const InputDecoration(labelText: 'Y', filled: true),
                onChanged: (value) {
                  _options = _options.copyWith(
                      y: double.tryParse(value) ?? _options.y);
                  setState(() => _preset = null);
                },
                onSubmitted: (value) => _regeneratePreviewImage(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          AppLocalizations.of(context).size,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _widthController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).width,
                    filled: true),
                onChanged: (value) {
                  _options = _options.copyWith(
                      width: double.tryParse(value) ?? _options.width);
                  setState(() => _preset = null);
                },
                onSubmitted: (value) => _regeneratePreviewImage(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _heightController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).height,
                    filled: true),
                onChanged: (value) {
                  _options = _options.copyWith(
                      height: double.tryParse(value) ?? _options.height);
                  setState(() => _preset = null);
                },
                onSubmitted: (value) => _regeneratePreviewImage(),
              ),
            ),
          ],
        ),
        if (_options is ImageExportOptions)
          ..._getImageOptions(_options as ImageExportOptions),
        const SizedBox(height: 8),
        CheckboxListTile(
            value: _options.renderBackground,
            title: Text(AppLocalizations.of(context).background),
            onChanged: (value) {
              setState(() => _options = _options.copyWith(
                    renderBackground: value ?? !_options.renderBackground,
                  ));
              _regeneratePreviewImage();
            })
      ]);

  List<Widget> _getImageOptions(ImageExportOptions options) {
    return [
      const SizedBox(height: 8),
      ExactSlider(
          header: Text(AppLocalizations.of(context).scale),
          min: 0.1,
          max: 10,
          value: options.scale,
          defaultValue: 1,
          onChangeEnd: (value) {
            _options = options.copyWith(scale: value);
            setState(() => _preset = null);
            _regeneratePreviewImage();
          }),
      const SizedBox(height: 8),
      ExactSlider(
          header: Text(AppLocalizations.of(context).quality),
          min: 0.1,
          max: 10,
          value: options.quality,
          defaultValue: 1,
          onChangeEnd: (value) {
            _options = options.copyWith(quality: value);
            setState(() => _preset = null);
            _regeneratePreviewImage();
          }),
    ];
  }
}
