import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/models/painter.dart';
import 'package:flutter/material.dart';

part 'pen.dart';
part 'eraser.dart';
part 'label.dart';
part 'area.dart';
part 'path_eraser.dart';
part 'layer.dart';

abstract class Handler {
  final DocumentBloc bloc;
  Handler(this.bloc);
  void onTapUp(TapUpDetails details) {}
  void onTapDown(TapDownDetails details) {}
  void onSecondaryTapUp(TapUpDetails details) {}
  void onSecondaryTapDown(TapDownDetails details) {}
  void onPointerDown(PointerDownEvent details) {}
  void onPointerMove(PointerMoveEvent details) {}
  void onPointerUp(PointerUpEvent details) {}

  factory Handler.fromPainter(Painter painter, DocumentBloc bloc) {
    if (painter is PenPainter) {
      return PenHandler(painter, bloc);
    }
    if (painter is EraserPainter) {
      return EraserHandler(painter, bloc);
    }
    if (painter is LabelPainter) {
      return LabelHandler(painter, bloc);
    }
    if (painter is AreaPainter) {
      return AreaHandler(painter, bloc);
    }
    if (painter is PathEraserPainter) {
      return PathEraserHandler(painter, bloc);
    }
    if (painter is LayerPainter) {
      return LayerHandler(painter, bloc);
    }
    throw Exception('Unknown painter type');
  }
}
