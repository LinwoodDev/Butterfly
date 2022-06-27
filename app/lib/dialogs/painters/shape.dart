import 'package:butterfly/dialogs/painters/general.dart';
import 'package:butterfly/models/painter.dart';
import 'package:butterfly/models/property.dart';
import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly/widgets/color_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/exact_slider.dart';

class ShapePainterDialog extends StatelessWidget {
  final int painterIndex;

  const ShapePainterDialog({super.key, required this.painterIndex});

  @override
  Widget build(BuildContext context) {
    return GeneralPainterDialog<ShapePainter>(
        index: painterIndex,
        title: AppLocalizations.of(context)!.shape,
        iconBuilder: (_, painter) => painter.property.shape.getIcon(),
        help: 'shape',
        builder: (context, painter, setPainter) => [
              ExactSlider(
                  header: Text(AppLocalizations.of(context)!.strokeWidth),
                  value: painter.property.strokeWidth,
                  min: 0,
                  max: 70,
                  defaultValue: 5,
                  onChanged: (value) => setPainter(painter.copyWith(
                      property:
                          painter.property.copyWith(strokeWidth: value)))),
              const SizedBox(height: 50),
              ColorField(
                color: Color(painter.property.color),
                onChanged: (color) => setPainter(painter.copyWith(
                    property: painter.property.copyWith(color: color.value))),
                title: Text(AppLocalizations.of(context)!.color),
              ),
              ShapeView(
                  shape: painter.property.shape,
                  onChanged: (shape) => setPainter(painter.copyWith(
                      property: painter.property.copyWith(shape: shape)))),
              const SizedBox(height: 15),
              CheckboxListTile(
                  value: painter.zoomDependent,
                  title: Text(AppLocalizations.of(context)!.zoomDependent),
                  onChanged: (value) => setPainter(painter.copyWith(
                      zoomDependent: value ?? painter.zoomDependent))),
            ]);
  }
}

class ShapeView extends StatefulWidget {
  final PathShape shape;
  final ValueChanged<PathShape> onChanged;
  const ShapeView({super.key, required this.shape, required this.onChanged});

  @override
  State<ShapeView> createState() => _ShapeViewState();
}

class _ShapeViewState extends State<ShapeView> {
  late PathShape currentShape;
  bool opened = false;

  @override
  void initState() {
    super.initState();
    currentShape = widget.shape;
  }

  void _onShapeChanged(PathShape shape) {
    setState(() {
      currentShape = shape;
    });
    widget.onChanged(shape);
  }

  Widget _buildShapeView() {
    final current = currentShape;
    if (current is CircleShape) {
      return _CircleShapeView(shape: current, onChanged: _onShapeChanged);
    }
    if (current is RectangleShape) {
      return _RectangleShapeView(shape: current, onChanged: _onShapeChanged);
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    Widget shapeView = _buildShapeView();

    return ExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        setState(() {
          opened = !isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          isExpanded: opened,
          headerBuilder: (context, expanded) => ListTile(
            title: Text(AppLocalizations.of(context)!.shape),
            trailing: DropdownButton<String>(
              value: widget.shape.runtimeType.toString(),
              items: [
                PathShape.circle,
                PathShape.rectangle,
                PathShape.line,
              ].map((e) {
                var shape = e();
                return DropdownMenuItem<String>(
                  value: shape.runtimeType.toString(),
                  child: Row(children: [
                    Icon(shape.getIcon()),
                    const SizedBox(width: 8),
                    Text(shape.getLocalizedName(context)),
                  ]),
                  onTap: () => _onShapeChanged(shape),
                );
              }).toList(),
              onChanged: (value) {},
            ),
          ),
          body: shapeView,
        )
      ],
    );
  }
}

class _CircleShapeView extends StatelessWidget {
  final CircleShape shape;
  final ValueChanged<CircleShape> onChanged;
  const _CircleShapeView({required this.shape, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ColorField(
        color: Color(shape.fillColor),
        title: Text(AppLocalizations.of(context)!.fill),
        leading: const Icon(PhosphorIcons.paintBucketLight),
        defaultColor: Colors.transparent,
        onChanged: (color) => onChanged(shape.copyWith(fillColor: color.value)),
      ),
    ]);
  }
}

class _RectangleShapeView extends StatefulWidget {
  final RectangleShape shape;
  final ValueChanged<RectangleShape> onChanged;
  const _RectangleShapeView({required this.shape, required this.onChanged});

  @override
  State<_RectangleShapeView> createState() => _RectangleShapeViewState();
}

class _RectangleShapeViewState extends State<_RectangleShapeView> {
  bool cornerOpened = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ColorField(
        title: Text(AppLocalizations.of(context)!.fill),
        leading: const Icon(PhosphorIcons.paintBucketLight),
        color: Color(widget.shape.fillColor),
        defaultColor: Colors.transparent,
        onChanged: (color) =>
            widget.onChanged(widget.shape.copyWith(fillColor: color.value)),
      ),
      ExpansionPanelList(
        expansionCallback: (index, isExpanded) {
          setState(() {
            cornerOpened = !isExpanded;
          });
        },
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) => ListTile(
              title: Text(AppLocalizations.of(context)!.cornerRadius),
            ),
            isExpanded: cornerOpened,
            body: Column(children: [
              ExactSlider(
                defaultValue: 0,
                min: 0,
                max: 100,
                value: widget.shape.topLeftCornerRadius,
                header: Text(AppLocalizations.of(context)!.topLeft),
                onChanged: (value) => widget.onChanged(
                    widget.shape.copyWith(topLeftCornerRadius: value)),
              ),
              ExactSlider(
                defaultValue: 0,
                min: 0,
                max: 100,
                value: widget.shape.topRightCornerRadius,
                header: Text(AppLocalizations.of(context)!.topRight),
                onChanged: (value) => widget.onChanged(
                    widget.shape.copyWith(topRightCornerRadius: value)),
              ),
              ExactSlider(
                defaultValue: 0,
                min: 0,
                max: 100,
                value: widget.shape.bottomLeftCornerRadius,
                header: Text(AppLocalizations.of(context)!.bottomLeft),
                onChanged: (value) => widget.onChanged(
                    widget.shape.copyWith(bottomLeftCornerRadius: value)),
              ),
              ExactSlider(
                defaultValue: 0,
                min: 0,
                max: 100,
                value: widget.shape.bottomRightCornerRadius,
                header: Text(AppLocalizations.of(context)!.bottomRight),
                onChanged: (value) => widget.onChanged(
                    widget.shape.copyWith(bottomRightCornerRadius: value)),
              ),
            ]),
          ),
        ],
      ),
    ]);
  }
}
