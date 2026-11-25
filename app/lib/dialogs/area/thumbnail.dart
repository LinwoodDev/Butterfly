import 'dart:typed_data';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_leap/material_leap.dart';

class AreaThumbnailDialog extends StatefulWidget {
  final DocumentBloc bloc;
  final String pageName;
  final Area area;

  const AreaThumbnailDialog({
    super.key,
    required this.bloc,
    required this.pageName,
    required this.area,
  });

  @override
  State<AreaThumbnailDialog> createState() => _AreaThumbnailDialogState();
}

class _AreaThumbnailDialogState extends State<AreaThumbnailDialog> {
  late PersistedThumbnailArea _settings;
  late Future<Uint8List?> _preview;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final previous =
        widget.bloc.editorController.editorSessionCubit?.state.thumbnailArea;
    _settings =
        (previous ??
                PersistedThumbnailArea(
                  pageName: widget.pageName,
                  areaName: widget.area.name,
                ))
            .copyWith(pageName: widget.pageName, areaName: widget.area.name);
    _preview = widget.bloc.renderAreaThumbnail(_settings);
  }

  void _update(PersistedThumbnailArea settings) {
    setState(() {
      _settings = settings;
      // Serialize previews: renderers temporarily change their export view.
      _preview = _preview.then(
        (_) => mounted ? widget.bloc.renderAreaThumbnail(settings) : null,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final alignmentLabels = [
      loc.topLeft,
      loc.topCenter,
      loc.topRight,
      loc.middleLeft,
      loc.center,
      loc.middleRight,
      loc.bottomLeft,
      loc.bottomCenter,
      loc.bottomRight,
    ];
    const arrows = ['↖', '↑', '↗', '←', '•', '→', '↙', '↓', '↘'];
    return ResponsiveAlertDialog(
      title: Text(loc.setAreaAsThumbnail),
      constraints: const BoxConstraints(maxWidth: 480, maxHeight: 720),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.area.name),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio: kThumbnailWidth / kThumbnailHeight,
              child: FutureBuilder<Uint8List?>(
                future: _preview,
                builder: (context, snapshot) =>
                    snapshot.connectionState != ConnectionState.done
                    ? const Center(child: CircularProgressIndicator())
                    : snapshot.data == null
                    ? Center(child: Text(loc.areaThumbnailUnavailable))
                    : Image.memory(
                        snapshot.data!,
                        fit: BoxFit.contain,
                        gaplessPlayback: true,
                      ),
              ),
            ),
            const SizedBox(height: 16),
            SegmentedButton<ThumbnailAreaFit>(
              segments: [
                ButtonSegment(
                  value: ThumbnailAreaFit.fit,
                  label: Text(loc.thumbnailFit),
                ),
                ButtonSegment(
                  value: ThumbnailAreaFit.fill,
                  label: Text(loc.thumbnailFill),
                ),
              ],
              selected: {_settings.fit},
              onSelectionChanged: _saving
                  ? null
                  : (value) => _update(_settings.copyWith(fit: value.single)),
            ),
            const SizedBox(height: 8),
            if (_settings.fit == ThumbnailAreaFit.fill) ...[
              Text(loc.thumbnailAlignment),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    3,
                    (row) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (column) {
                        final index = row * 3 + column;
                        final alignment = ThumbnailAreaAlignment.values[index];
                        return IconButton.filledTonal(
                          tooltip: alignmentLabels[index],
                          isSelected: _settings.alignment == alignment,
                          onPressed: _saving
                              ? null
                              : () => _update(
                                  _settings.copyWith(alignment: alignment),
                                ),
                          icon: Text(arrows[index]),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ] else
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(loc.thumbnailClipArea),
                value: _settings.clip,
                onChanged: _saving
                    ? null
                    : (value) => _update(_settings.copyWith(clip: value)),
              ),
            Text(loc.areaThumbnailDescription),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        FilledButton(
          onPressed: _saving
              ? null
              : () async {
                  setState(() => _saving = true);
                  try {
                    await _preview;
                    if (!mounted) return;
                    final captured = await widget.bloc.captureAreaThumbnail(
                      _settings,
                    );
                    if (!context.mounted) return;
                    if (captured) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(loc.areaThumbnailUnavailable)),
                      );
                    }
                  } finally {
                    if (mounted) setState(() => _saving = false);
                  }
                },
          child: Text(loc.setAreaAsThumbnail),
        ),
      ],
    );
  }
}
