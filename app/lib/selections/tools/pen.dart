part of '../selection.dart';

class _ShapeDetectionView extends StatefulWidget {
  final List<PenTool> selected;
  final Function(BuildContext, List<PenTool>) update;

  const _ShapeDetectionView({required this.selected, required this.update});

  @override
  __ShapeDetectionViewState createState() => __ShapeDetectionViewState();
}

class __ShapeDetectionViewState extends State<_ShapeDetectionView> {
  bool _isPanelOpen = false;

  void _updateShapeDetectionTime(double value) {
    widget.update(context, [
      widget.selected.first.copyWith(shapeDetectionTime: value),
    ]);
  }

  void _updateShapeDetectionEnabled(bool? value) {
    if (value != null) {
      setState(() {
        widget.update(
          context,
          widget.selected
              .map((e) => e.copyWith(shapeDetectionEnabled: value))
              .toList(),
        );
      });
    }
  }

  @override
  void didUpdateWidget(covariant _ShapeDetectionView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Control if PenTool is changed
    if (oldWidget.selected != widget.selected) {
      // if change force update
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isPanelOpen = !_isPanelOpen;
        });
      },
      children: [
        ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(AppLocalizations.of(context).shapeDetection),
              leading: Checkbox(
                value: widget.selected.first.shapeDetectionEnabled,
                onChanged: _updateShapeDetectionEnabled,
              ),
            );
          },
          body: ExactSlider(
            header: Text(AppLocalizations.of(context).delay),
            value: widget.selected.first.shapeDetectionTime,
            min: 0,
            max: 1,
            defaultValue: 0.5,
            onChangeEnd: _updateShapeDetectionTime,
          ),
          isExpanded: _isPanelOpen,
        ),
      ],
    );
  }
}

class PenToolSelection extends ToolSelection<PenTool> {
  final _propertySelection = PenPropertySelection();

  PenToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final property = selected.first.property;
    void updateProperty(PenProperty property) => update(
      context,
      selected.map((e) => e.copyWith(property: property)).toList(),
    );
    return [
      ...super.buildProperties(context),
      CheckboxListTile(
        value: selected.first.zoomDependent,
        title: Text(AppLocalizations.of(context).zoomDependent),
        onChanged: (value) => update(
          context,
          selected
              .map(
                (e) => e.copyWith(
                  zoomDependent: value ?? selected.first.zoomDependent,
                ),
              )
              .toList(),
        ),
      ),
      const SizedBox(height: 16),
      _ShapeDetectionView(selected: selected, update: update),
      const SizedBox(height: 16),
      ..._propertySelection.build(context, property, updateProperty),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is PenTool) {
      return PenToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
