import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:butterfly/widgets/color_field.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum _PaintKind { solid, gradient, image, svg }

enum _GradientKind { linear, radial }

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

  Future<void> _importImage(BuildContext context) async {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoaded) return;

    final (data, extension, _) = await importFile(context, [
      AssetFileType.image,
    ]);
    if (data == null) return;

    final (_, path) = state.data.importTexture(data, extension ?? 'png');
    bloc.add(AssetUpdated(path, data));

    onChanged(
      ElementPaint.image(
        source: path,
        tint: value.previewColor,
        blur: value.blur,
      ),
    );
  }

  Future<void> _importSvg(BuildContext context) async {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoaded) return;

    final (data, extension, _) = await importFile(context, [AssetFileType.svg]);
    if (data == null) return;

    final (_, path) = state.data.importTexture(data, extension ?? 'svg');
    bloc.add(AssetUpdated(path, data));

    onChanged(
      ElementPaint.svg(
        source: path,
        tint: value.previewColor,
        blur: value.blur,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final kind = switch (value) {
      ImageElementPaint() => _PaintKind.image,
      SvgElementPaint() => _PaintKind.svg,
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
                value: _PaintKind.image,
                icon: PhosphorIcon(PhosphorIconsLight.image),
                tooltip: 'Image',
              ),
              ButtonSegment(
                value: _PaintKind.svg,
                icon: PhosphorIcon(PhosphorIconsLight.fileSvg),
                tooltip: 'SVG',
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
                _PaintKind.solid => ElementPaint.solid(
                  color: color,
                  blur: value.blur,
                ),
                _PaintKind.gradient => switch (value) {
                  GradientElementPaint() => value,
                  _ => ElementPaint.gradient(
                    blur: value.blur,
                    gradient: ElementGradient.linear(
                      stops: [
                        ElementGradientStop(offset: 0, color: color),
                        ElementGradientStop(
                          offset: 1,
                          color: SRGBColor.white.withValues(a: color.a),
                        ),
                      ],
                    ),
                  ),
                },
                _PaintKind.image => switch (value) {
                  ImageElementPaint() => value,
                  _ => ElementPaint.image(
                    source: '',
                    tint: color,
                    blur: value.blur,
                  ),
                },
                _PaintKind.svg => switch (value) {
                  SvgElementPaint() => value,
                  _ => ElementPaint.svg(
                    source: '',
                    tint: color,
                    blur: value.blur,
                  ),
                },
              });
            },
          ),
        ),

        if (value case GradientElementPaint(:final gradient))
          _GradientPaintEditor(
            value: gradient,
            onChanged: (gradient) {
              onChanged(
                ElementPaint.gradient(gradient: gradient, blur: value.blur),
              );
            },
          )
        else
          ColorField(
            title: Text(
              kind == _PaintKind.solid
                  ? LeapLocalizations.of(context).color
                  : 'Tint',
            ),
            value: color.withValues(a: 255),
            onChanged: (next) => onChanged(switch (value) {
              ImageElementPaint(
                :final source,
                :final scale,
                :final tint,
                :final blur,
              ) =>
                ElementPaint.image(
                  source: source,
                  tint: next.withValues(a: tint.a),
                  scale: scale,
                  blur: blur,
                ),
              SvgElementPaint(
                :final source,
                :final scale,
                :final tint,
                :final blur,
              ) =>
                ElementPaint.svg(
                  source: source,
                  tint: next.withValues(a: tint.a),
                  scale: scale,
                  blur: blur,
                ),
              _ => ElementPaint.solid(
                color: next.withValues(a: color.a),
                blur: value.blur,
              ),
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
        ExactSlider(
          value: value.blur,
          header: const Text('Blur'),
          min: 0,
          max: 50,
          defaultValue: 0,
          onChangeEnd: (blur) => onChanged(value.copyWith(blur: blur)),
        ),

        if (value case ImageElementPaint(:final source, :final scale)) ...[
          ListTile(
            leading: const PhosphorIcon(PhosphorIconsLight.imageSquare),
            title: const Text('Image'),
            subtitle: Text(source.isEmpty ? 'No image selected' : source),
            trailing: FilledButton.icon(
              icon: const PhosphorIcon(PhosphorIconsLight.uploadSimple),
              label: const Text('Import'),
              onPressed: () => _importImage(context),
            ),
          ),
          ExactSlider(
            value: scale,
            header: const Text('Image scale'),
            min: 0.1,
            max: 8,
            defaultValue: 1,
            onChangeEnd: (next) =>
                onChanged((value as ImageElementPaint).copyWith(scale: next)),
          ),
        ] else if (value case SvgElementPaint(:final source, :final scale)) ...[
          ListTile(
            leading: const PhosphorIcon(PhosphorIconsLight.fileSvg),
            title: const Text('SVG'),
            subtitle: Text(source.isEmpty ? 'No SVG selected' : source),
            trailing: FilledButton.icon(
              icon: const PhosphorIcon(PhosphorIconsLight.uploadSimple),
              label: const Text('Import'),
              onPressed: () => _importSvg(context),
            ),
          ),
          ExactSlider(
            value: scale,
            header: const Text('SVG scale'),
            min: 0.1,
            max: 8,
            defaultValue: 1,
            onChangeEnd: (next) =>
                onChanged((value as SvgElementPaint).copyWith(scale: next)),
          ),
        ],
      ],
    );
  }
}

class _GradientPaintEditor extends StatelessWidget {
  final ElementGradient value;
  final ValueChanged<ElementGradient> onChanged;

  const _GradientPaintEditor({required this.value, required this.onChanged});

  _GradientKind get kind => switch (value) {
    LinearElementGradient() => _GradientKind.linear,
    RadialElementGradient() => _GradientKind.radial,
  };

  List<ElementGradientStop> get stops => switch (value) {
    LinearElementGradient(:final stops) => stops,
    RadialElementGradient(:final stops) => stops,
  };

  ElementGradient _withStops(List<ElementGradientStop> stops) {
    return switch (value) {
      LinearElementGradient() => (value as LinearElementGradient).copyWith(
        stops: stops,
      ),
      RadialElementGradient() => (value as RadialElementGradient).copyWith(
        stops: stops,
      ),
    };
  }

  ElementGradient _convertTo(_GradientKind nextKind) {
    return switch (nextKind) {
      _GradientKind.linear => ElementGradient.linear(),
      _GradientKind.radial => ElementGradient.radial(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const PhosphorIcon(PhosphorIconsLight.gradient),
          title: const Text('Gradient type'),
          trailing: SegmentedButton<_GradientKind>(
            showSelectedIcon: false,
            selected: {kind},
            segments: const [
              ButtonSegment(
                value: _GradientKind.linear,
                icon: PhosphorIcon(PhosphorIconsLight.lineSegment),
                tooltip: 'Linear',
              ),
              ButtonSegment(
                value: _GradientKind.radial,
                icon: PhosphorIcon(PhosphorIconsLight.circle),
                tooltip: 'Radial',
              ),
            ],
            onSelectionChanged: (selection) {
              final selected = selection.first;
              if (selected == kind) return;
              onChanged(_convertTo(selected));
            },
          ),
        ),

        switch (value) {
          LinearElementGradient() => _LinearGradientEditor(
            value: value as LinearElementGradient,
            onChanged: onChanged,
          ),
          RadialElementGradient() => _RadialGradientEditor(
            value: value as RadialElementGradient,
            onChanged: onChanged,
          ),
        },

        _GradientStopsEditor(
          stops: stops,
          onChanged: (next) => onChanged(_withStops(next)),
        ),
      ],
    );
  }
}

class _LinearGradientEditor extends StatelessWidget {
  final LinearElementGradient value;
  final ValueChanged<ElementGradient> onChanged;

  const _LinearGradientEditor({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OffsetListTile(
          title: const Text('Start'),
          value: value.start.toOffset(),
          onChanged: (next) => onChanged(value.copyWith(start: next.toPoint())),
        ),
        OffsetListTile(
          title: const Text('End'),
          value: value.end.toOffset(),
          onChanged: (next) => onChanged(value.copyWith(end: next.toPoint())),
        ),
      ],
    );
  }
}

class _RadialGradientEditor extends StatelessWidget {
  final RadialElementGradient value;
  final ValueChanged<ElementGradient> onChanged;

  const _RadialGradientEditor({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final focal = value.focal;

    return Column(
      children: [
        OffsetListTile(
          title: const Text('Center'),
          value: value.center.toOffset(),
          onChanged: (next) =>
              onChanged(value.copyWith(center: next.toPoint())),
        ),
        ExactSlider(
          value: value.radius,
          header: const Text('Radius'),
          min: 0,
          max: 2,
          defaultValue: 0.5,
          onChangeEnd: (next) => onChanged(value.copyWith(radius: next)),
        ),
        SwitchListTile(
          secondary: const PhosphorIcon(PhosphorIconsLight.crosshair),
          title: const Text('Focal point'),
          subtitle: const Text('Use an off-center start point'),
          value: focal != null,
          onChanged: (enabled) {
            onChanged(
              value.copyWith(
                focal: enabled ? value.center : null,
                focalRadius: enabled ? value.focalRadius : 0,
              ),
            );
          },
        ),
        if (focal != null) ...[
          OffsetListTile(
            title: const Text('Focal'),
            value: focal.toOffset(),
            onChanged: (next) =>
                onChanged(value.copyWith(focal: next.toPoint())),
          ),
          ExactSlider(
            value: value.focalRadius ?? 0,
            header: const Text('Focal radius'),
            min: 0,
            max: 2,
            defaultValue: 0,
            onChangeEnd: (next) => onChanged(value.copyWith(focalRadius: next)),
          ),
        ],
      ],
    );
  }
}

List<ElementGradientStop> _sortStops(List<ElementGradientStop> stops) {
  return [...stops]..sort((a, b) => a.offset.compareTo(b.offset));
}

double _findNewStopOffset(List<ElementGradientStop> stops) {
  if (stops.isEmpty) return 0.5;
  if (stops.length == 1) return 1;

  final sorted = _sortStops(stops);

  var bestOffset = 0.5;
  var bestGap = -1.0;

  for (var i = 0; i < sorted.length - 1; i++) {
    final left = sorted[i].offset;
    final right = sorted[i + 1].offset;
    final gap = right - left;

    if (gap > bestGap) {
      bestGap = gap;
      bestOffset = left + gap / 2;
    }
  }

  return bestOffset.clamp(0, 1);
}

class _GradientStopsEditor extends StatelessWidget {
  final List<ElementGradientStop> stops;
  final ValueChanged<List<ElementGradientStop>> onChanged;

  const _GradientStopsEditor({required this.stops, required this.onChanged});

  List<ElementGradientStop> get effectiveStops {
    if (stops.isEmpty) return defaultGradientStops;
    return stops;
  }

  @override
  Widget build(BuildContext context) {
    final items = effectiveStops;

    return ExpansionTile(
      leading: const PhosphorIcon(PhosphorIconsLight.listBullets),
      title: const Text('Color stops'),
      initiallyExpanded: true,
      children: [
        for (final indexed in items.indexed)
          _GradientStopField(
            index: indexed.$1,
            value: indexed.$2,
            canRemove: items.length > 2,
            onChanged: (next) {
              final copy = [...items];
              copy[indexed.$1] = next;
              onChanged(_sortStops(copy));
            },
            onRemove: () {
              final copy = [...items]..removeAt(indexed.$1);
              onChanged(_sortStops(copy));
            },
          ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: OutlinedButton.icon(
              icon: const PhosphorIcon(PhosphorIconsLight.plus),
              label: const Text('Add stop'),
              onPressed: () {
                final nextOffset = _findNewStopOffset(items);
                final nextColor = items.isEmpty
                    ? SRGBColor.black
                    : items.last.color;

                onChanged(
                  _sortStops([
                    ...items,
                    ElementGradientStop(offset: nextOffset, color: nextColor),
                  ]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _GradientStopField extends StatelessWidget {
  final int index;
  final ElementGradientStop value;
  final bool canRemove;
  final ValueChanged<ElementGradientStop> onChanged;
  final VoidCallback onRemove;

  const _GradientStopField({
    required this.index,
    required this.value,
    required this.canRemove,
    required this.onChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const PhosphorIcon(PhosphorIconsLight.drop),
      title: Text('Stop ${index + 1}'),
      subtitle: Text('${(value.offset * 100).round()}%'),
      trailing: canRemove
          ? IconButton(
              icon: const PhosphorIcon(PhosphorIconsLight.trash),
              onPressed: onRemove,
            )
          : null,
      children: [
        ColorField(
          title: const Text('Color'),
          value: value.color.withValues(a: 255),
          onChanged: (next) {
            onChanged(value.copyWith(color: next.withValues(a: value.color.a)));
          },
        ),
        ExactSlider(
          value: value.offset,
          header: const Text('Offset'),
          min: 0,
          max: 1,
          defaultValue: index == 0 ? 0 : 1,
          onChangeEnd: (next) {
            onChanged(value.copyWith(offset: next));
          },
        ),
        ExactSlider(
          value: value.color.a.toDouble(),
          header: const Text('Alpha'),
          fractionDigits: 0,
          min: 0,
          max: 255,
          defaultValue: 255,
          onChangeEnd: (next) {
            onChanged(
              value.copyWith(color: value.color.withValues(a: next.toInt())),
            );
          },
        ),
      ],
    );
  }
}
