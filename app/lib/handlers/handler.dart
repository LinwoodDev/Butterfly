import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/element.dart';
import 'package:butterfly/models/painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dialogs/background/context.dart';
import '../dialogs/elements/general.dart';
import '../dialogs/elements/image.dart';
import '../dialogs/elements/label.dart';
import '../dialogs/select.dart';
import '../models/path_point.dart';
import '../widgets/context_menu.dart';

part 'area.dart';
part 'eraser.dart';
part 'hand.dart';
part 'label.dart';
part 'layer.dart';
part 'path_eraser.dart';
part 'pen.dart';

abstract class Handler {
  const Handler();

  List<PadElement> createForegrounds() => [];

  List<Rect> createSelections() => [];

  void onTapUp(Size viewportSize, BuildContext context, TapUpDetails details) {}

  void onTapDown(
      Size viewportSize, BuildContext context, TapDownDetails details) {}

  void onSecondaryTapUp(
      Size viewportSize, BuildContext context, TapUpDetails details) {}

  void onSecondaryTapDown(
      Size viewportSize, BuildContext context, TapDownDetails details) {}

  void onPointerDown(
      Size viewportSize, BuildContext context, PointerDownEvent event) {}

  void onPointerMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) {}

  void onPointerUp(
      Size viewportSize, BuildContext context, PointerUpEvent event) {}

  void onPointerHover(
      Size viewportSize, BuildContext context, PointerHoverEvent event) {}

  void onLongPressEnd(
      Size viewportSize, BuildContext context, LongPressEndDetails details) {}

  factory Handler.fromBloc(DocumentBloc bloc, [int? index]) {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) {
      throw Exception('Invalid document state');
    }
    final painter =
        index != null ? state.document.painters[index] : state.currentPainter;
    if (painter is PenPainter) {
      return PenHandler();
    }
    if (painter is EraserPainter) {
      return EraserHandler();
    }
    if (painter is LabelPainter) {
      return LabelHandler();
    }
    if (painter is AreaPainter) {
      return AreaHandler();
    }
    if (painter is PathEraserPainter) {
      return PathEraserHandler();
    }
    if (painter is LayerPainter) {
      return LayerHandler();
    }
    return HandHandler();
  }
}

class _RayCastParams {
  final List<String> invisibleLayers;
  final List<PadElement> elements;
  final Offset globalPosition;
  final double radius;
  final double size;
  final bool includeEraser;

  const _RayCastParams(this.invisibleLayers, this.elements, this.globalPosition,
      this.radius, this.size, this.includeEraser);
}

Future<Set<int>> rayCast(
    BuildContext context, Offset localPosition, double radius,
    [bool includeEraser = false]) async {
  final bloc = context.read<DocumentBloc>();
  final transform = context.read<TransformCubit>().state;
  final state = bloc.state;
  if (state is! DocumentLoadSuccess) return {};
  final globalPosition = transform.localToGlobal(localPosition);
  return compute(
      _executeRayCast,
      _RayCastParams(state.invisibleLayers, state.document.content,
          globalPosition, radius, transform.size, includeEraser));
}

Set<int> _executeRayCast(_RayCastParams params) {
  var elements = Map<int, PadElement>.from(params.elements.asMap())
    ..removeWhere(
        (index, element) => params.invisibleLayers.contains(element.layer))
    ..removeWhere(
        (index, element) => !element.hit(params.globalPosition, params.radius))
    ..removeWhere(
        (index, element) => !params.includeEraser && element is EraserElement);
  return elements.keys.toSet();
}
