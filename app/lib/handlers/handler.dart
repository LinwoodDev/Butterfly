import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/painter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pen.dart';
part 'eraser.dart';
part 'hand.dart';
part 'label.dart';
part 'area.dart';
part 'path_eraser.dart';
part 'layer.dart';

abstract class Handler {
  const Handler();

  List<PadElement> createForegrounds() => [];
  List<Rect> createSelections() => [];

  void onTapUp(BuildContext context, TapUpDetails details) {}
  void onTapDown(BuildContext context, TapDownDetails details) {}
  void onSecondaryTapUp(BuildContext context, TapUpDetails details) {}
  void onSecondaryTapDown(BuildContext context, TapDownDetails details) {}
  void onPointerDown(BuildContext context, PointerDownEvent event) {}
  void onPointerMove(BuildContext context, PointerMoveEvent event) {}
  void onPointerUp(BuildContext context, PointerUpEvent event) {}
  void onPointerHover(BuildContext context, PointerHoverEvent event) {}
  void onLongPressEnd(BuildContext context, LongPressEndDetails details) {}

  factory Handler.fromBloc(DocumentBloc bloc) {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) {
      throw Exception('Invalid document state');
    }
    final painter = state.currentPainter;
    if (painter is PenPainter) {
      return PenHandler(painter);
    }
    if (painter is EraserPainter) {
      return EraserHandler(painter);
    }
    if (painter is LabelPainter) {
      return LabelHandler(painter);
    }
    if (painter is AreaPainter) {
      return AreaHandler(painter);
    }
    if (painter is PathEraserPainter) {
      return PathEraserHandler(painter);
    }
    if (painter is LayerPainter) {
      return LayerHandler(painter);
    }
    return HandHandler();
  }
}
