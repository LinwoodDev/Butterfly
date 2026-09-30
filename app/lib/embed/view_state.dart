import 'package:butterfly/cubits/transform.dart';
import 'package:material_ui/material_ui.dart';

/// The document coordinates and camera settings exposed by the embed API.
class EmbedViewState {
  const EmbedViewState({
    required this.x,
    required this.y,
    required this.zoom,
    required this.rotation,
  });

  final double x, y, zoom, rotation;

  factory EmbedViewState.fromTransform(CameraTransform transform) =>
      EmbedViewState(
        x: transform.position.dx,
        y: transform.position.dy,
        zoom: transform.size,
        rotation: transform.rotation,
      );

  static EmbedViewState? tryParse(Object? value) {
    if (value is! Map) return null;
    final x = value['x'];
    final y = value['y'];
    final zoom = value['zoom'];
    final rotation = value['rotation'];
    if (x is! num || y is! num || zoom is! num || rotation is! num) {
      return null;
    }
    if (!x.isFinite ||
        !y.isFinite ||
        !zoom.isFinite ||
        !rotation.isFinite ||
        zoom < kMinZoom ||
        zoom > kMaxZoom) {
      return null;
    }
    return EmbedViewState(
      x: x.toDouble(),
      y: y.toDouble(),
      zoom: zoom.toDouble(),
      rotation: rotation.toDouble(),
    );
  }

  Map<String, double> toJson() => {
    'x': x,
    'y': y,
    'zoom': zoom,
    'rotation': rotation,
  };

  void apply(TransformCubit transformCubit) =>
      transformCubit.teleport(Offset(x, y), zoom, rotation);
}

/// Route data for an atomic document and camera replacement in an embed.
class EmbedDocumentData {
  const EmbedDocumentData(this.data, this.viewState);

  final Object data;
  final EmbedViewState? viewState;
}
