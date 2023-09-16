part of 'handler.dart';

class ShapeHandler extends PastingHandler<ShapeTool> {
  ShapeHandler(super.data);

  @override
  PreferredSizeWidget getToolbar(DocumentBloc bloc) => ColorToolbarView(
        color: data.property.color,
        onChanged: (value) {
          final state = bloc.state;
          if (state is! DocumentLoadSuccess) return;
          final index = state.info.tools.indexOf(data);
          bloc.add(ToolsChanged({
            index: data.copyWith(
                property: data.property.copyWith(
                    color: convertOldColor(value, data.property.color))),
          }));
        },
      );

  @override
  List<PadElement> transformElements(Rect rect, String layer) {
    if (rect.isEmpty) return [];

    return [
      ShapeElement(
        firstPosition: rect.topLeft.toPoint(),
        secondPosition: rect.bottomRight.toPoint(),
        property: data.property,
        layer: layer,
      ),
    ];
  }

  @override
  double get constraintedAspectRatio => data.constrainedAspectRatio;
  @override
  double get constraintedHeight => data.constrainedHeight;
  @override
  double get constraintedWidth => data.constrainedWidth;
}
