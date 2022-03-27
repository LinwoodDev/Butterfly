import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/painter.dart';
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
  final DocumentBloc bloc;
  Handler(this.bloc);

  List<PadElement> createForeground() => [];

  void onTapUp(BuildContext context, TapUpDetails details) {}
  void onTapDown(BuildContext context, TapDownDetails details) {}
  void onSecondaryTapUp(BuildContext context, TapUpDetails details) {}
  void onSecondaryTapDown(BuildContext context, TapDownDetails details) {}
  void onPointerDown(BuildContext context, PointerDownEvent details) {}
  void onPointerMove(BuildContext context, PointerMoveEvent details) {}
  void onPointerUp(BuildContext context, PointerUpEvent details) {}

  factory Handler.fromBloc(DocumentBloc bloc) {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) {
      throw Exception('Invalid document state');
    }
    final painter = state.currentPainter;
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
    return HandHandler(bloc);
  }
}
