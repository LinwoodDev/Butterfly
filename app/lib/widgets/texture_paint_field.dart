import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/widgets/color_field.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum _PaintKind { solid, gradient, texture }

class TexturePaintField extends StatelessWidget {
  final ElementPaint value;
  final Widget title;
  final ValueChanged<ElementPaint> onChanged;

  const TexturePaintField({
    super.key,
    required this.value,
    required this.title,
    required this.onChanged,
  });

  Future<void> _importTexture(BuildContext context) async {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    final (data, extension, _) = await importFile(context, [
      AssetFileType.image,
    ]);
    if (data == null) return;
    final (_, path) = state.data.importTexture(data, extension ?? 'png');
    bloc.add(AssetUpdated(path, data));
    onChanged(ElementPaint.texture(source: path, tint: value.previewColor));
  }

  @override
  Widget build(BuildContext context) {
    final kind = switch (value) {
      TextureElementPaint() => _PaintKind.texture,
      GradientElementPaint() => _PaintKind.gradient,
      _ => _PaintKind.solid,
    };
    final color = value.previewColor;
    return Column(
      children: [
        ListTile(
          leading: const PhosphorIcon(PhosphorIconsLight.paintBrush),
          title: title,
          trailing: SegmentedButton<_PaintKind>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(
                value: _PaintKind.solid,
                icon: PhosphorIcon(PhosphorIconsLight.circle),
                tooltip: 'Solid color',
              ),
              ButtonSegment(
                value: _PaintKind.texture,
                icon: PhosphorIcon(PhosphorIconsLight.image),
                tooltip: 'Texture',
              ),
              ButtonSegment(
                value: _PaintKind.gradient,
                icon: PhosphorIcon(PhosphorIconsLight.gradient),
                tooltip: 'Gradient',
              ),
            ],
            selected: {kind},
            onSelectionChanged: (selection) {
              final selected = selection.first;
              onChanged(switch (selected) {
                _PaintKind.solid => ElementPaint.solid(color: color),
                _PaintKind.gradient => switch (value) {
                  GradientElementPaint() => value,
                  _ => ElementPaint.gradient(
                    start: color,
                    end: SRGBColor.white.withValues(a: color.a),
                  ),
                },
                _PaintKind.texture => switch (value) {
                  TextureElementPaint() => value,
                  _ => ElementPaint.texture(source: '', tint: color),
                },
              });
            },
          ),
        ),
        if (value case final GradientElementPaint gradient) ...[
          ColorField(
            title: const Text('Start color'),
            value: gradient.start.withValues(a: 255),
            onChanged: (next) => onChanged(
              gradient.copyWith(start: next.withValues(a: gradient.start.a)),
            ),
          ),
          ColorField(
            title: const Text('End color'),
            value: gradient.end.withValues(a: 255),
            onChanged: (next) => onChanged(
              gradient.copyWith(end: next.withValues(a: gradient.end.a)),
            ),
          ),
          ExactSlider(
            value: gradient.angle,
            header: const Text('Gradient angle'),
            min: 0,
            max: 360,
            defaultValue: 0,
            onChangeEnd: (next) => onChanged(gradient.copyWith(angle: next)),
          ),
        ] else
          ColorField(
            title: Text(
              kind == _PaintKind.solid
                  ? LeapLocalizations.of(context).color
                  : 'Tint',
            ),
            value: color.withValues(a: 255),
            onChanged: (next) => onChanged(switch (value) {
              TextureElementPaint(:final source, :final scale, :final tint) =>
                ElementPaint.texture(
                  source: source,
                  tint: next.withValues(a: tint.a),
                  scale: scale,
                ),
              _ => ElementPaint.solid(color: next.withValues(a: color.a)),
            }),
          ),
        ExactSlider(
          value: color.a.toDouble(),
          header: const Text('Alpha'),
          fractionDigits: 0,
          max: 255,
          min: 0,
          defaultValue: 255,
          onChangeEnd: (alpha) => onChanged(value.withAlpha(alpha.toInt())),
        ),
        if (value case TextureElementPaint(:final source, :final scale)) ...[
          ListTile(
            leading: const PhosphorIcon(PhosphorIconsLight.imageSquare),
            title: const Text('Texture'),
            subtitle: Text(source.isEmpty ? 'No texture selected' : source),
            trailing: FilledButton.icon(
              icon: const PhosphorIcon(PhosphorIconsLight.uploadSimple),
              label: const Text('Import'),
              onPressed: () => _importTexture(context),
            ),
          ),
          ExactSlider(
            value: scale,
            header: const Text('Texture scale'),
            min: 0.1,
            max: 8,
            defaultValue: 1,
            onChangeEnd: (next) =>
                onChanged((value as TextureElementPaint).copyWith(scale: next)),
          ),
        ],
      ],
    );
  }
}
