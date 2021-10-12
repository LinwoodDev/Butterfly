import 'package:butterfly/models/backgrounds/box.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/elements/eraser.dart';
import 'package:butterfly/models/elements/label.dart';
import 'package:butterfly/models/elements/paint.dart';
import 'package:butterfly/models/elements/path.dart';
import 'package:butterfly/models/tool.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/cubits/transform.dart';
import 'package:butterfly/pad/dialogs/object.dart';
import 'package:butterfly/painter/eraser.dart';
import 'package:butterfly/painter/path_eraser.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:butterfly/painter/pen.dart';
import 'package:butterfly/painter/label.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainViewViewport extends StatefulWidget {
  final DocumentBloc bloc;

  const MainViewViewport({Key? key, required this.bloc}) : super(key: key);
  @override
  _MainViewViewportState createState() => _MainViewViewportState();
}

class _MainViewViewportState extends State<MainViewViewport> {
  bool _moveEnabled = false;
  late TransformationController _controller;
  GlobalKey transformKey = GlobalKey();
  ElementLayer? currentEditingLayer;

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
    _controller.addListener(() => context.read<TransformCubit>().emit(_controller.value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
        bloc: widget.bloc,
        builder: (context, state) {
          return LayoutBuilder(builder: (context, constraints) {
            final viewportSize = Size(constraints.maxWidth, constraints.maxHeight);
            if (state is DocumentLoadSuccess) {
              List<ElementLayer> raycast(Offset offset) {
                return state.document.content.where((element) => element.hit(offset)).toList();
              }

              return SizedBox.expand(
                  child: BlocBuilder<TransformCubit, Matrix4>(builder: (context, transform) {
                var translation = -transform.getTranslation();
                var paintViewport = Size(translation.x * 4 + viewportSize.width * 4,
                    translation.y * 4 + viewportSize.height * 4);
                _controller.value = transform;
                return Listener(
                  onPointerSignal: (pointerSignal) {
                    if (pointerSignal is PointerScrollEvent) {
                      // Scale the matrix
                      var up = transform.up;
                      if (up.y < 3.5 && pointerSignal.scrollDelta.dy < 0 ||
                          up.y > 0.5 && pointerSignal.scrollDelta.dy > 0) {
                        var scale = 1 - pointerSignal.scrollDelta.dy / 100;
                        var currentScale = transform.up.y;
                        scale *= currentScale;
                        scale = scale.clamp(0.5, 2.5);
                        scale /= currentScale;
                        context
                            .read<TransformCubit>()
                            .emit(Matrix4.copy(transform)..scale(scale, scale, scale));
                      }
                    }
                  },
                  onPointerDown: (PointerDownEvent event) {
                    if (event.kind == PointerDeviceKind.stylus ||
                        state.currentTool == ToolType.edit) {
                      if (state.currentPainter is PenPainter) {
                        var painter = state.currentPainter as PenPainter;
                        setState(() => currentEditingLayer = PaintElement(
                            color: painter.color,
                            strokeWidth:
                                painter.strokeWidth + event.pressure * painter.strokeMultiplier,
                            points: [_controller.toScene(event.localPosition)]));
                      }
                      if (state.currentPainter is EraserPainter) {
                        var painter = state.currentPainter as EraserPainter;
                        setState(() => currentEditingLayer = EraserElement(
                            strokeWidth:
                                painter.strokeWidth + event.pressure * painter.strokeMultiplier,
                            points: [_controller.toScene(event.localPosition)]));
                      }
                      if (state.currentPainter is LabelPainter) {
                        var painter = state.currentPainter as LabelPainter;
                        var _textController = TextEditingController();
                        void submit() {
                          Navigator.of(context).pop();
                          widget.bloc.add(LayerCreated(LabelElement(
                              text: _textController.text,
                              size: painter.size,
                              color: painter.color,
                              position: _controller.toScene(event.localPosition))));
                        }

                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                    title: Text(AppLocalizations.of(context)!.enterText),
                                    content: TextField(
                                      controller: _textController,
                                      autofocus: true,
                                      onSubmitted: (text) => submit(),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                            AppLocalizations.of(context)!.cancel.toUpperCase()),
                                        onPressed: () => Navigator.of(context).pop(),
                                      ),
                                      TextButton(
                                          child:
                                              Text(AppLocalizations.of(context)!.ok.toUpperCase()),
                                          onPressed: submit)
                                    ]));
                      }
                    } else if (state.currentTool == ToolType.view) {
                      setState(() => _moveEnabled = true);
                    }
                  },
                  onPointerUp: (PointerUpEvent event) {
                    if ((event.kind == PointerDeviceKind.stylus ||
                            state.currentTool == ToolType.edit) &&
                        currentEditingLayer != null) {
                      widget.bloc.add(LayerCreated(currentEditingLayer!));
                      setState(() => currentEditingLayer = null);
                    } else if (state.currentTool == ToolType.object) {
                      var hits = raycast(_controller.toScene(event.localPosition));
                      var hit = hits.isEmpty ? null : hits.last;
                      if (hit != null) {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => ObjectDialog(
                                index: state.document.content.indexOf(hit), bloc: widget.bloc));
                      }
                    }
                    setState(() => _moveEnabled = false);
                  },
                  behavior: HitTestBehavior.translucent,
                  onPointerMove: (PointerMoveEvent event) {
                    if ((event.kind == PointerDeviceKind.stylus ||
                        state.currentTool == ToolType.edit)) {
                      if (state.currentPainter is PathEraserPainter) {
                        widget.bloc.add(LayersRemoved(
                            raycast(_controller.toScene(event.localPosition))
                                .where((element) =>
                                    element is! EraserElement ||
                                    (state.currentPainter as PathEraserPainter).canDeleteEraser)
                                .toList()));
                      } else if (currentEditingLayer != null &&
                          currentEditingLayer is PathElement) {
                        // Add point to custom paint
                        var layer = currentEditingLayer as PathElement;
                        setState(() => currentEditingLayer = layer.copyWith(
                            points: List.from(layer.points)
                              ..add(_controller.toScene(event.localPosition))));
                      }
                    }
                  },
                  child: InteractiveViewer(
                    constrained: false,
                    transformationController: _controller,
                    panEnabled: _moveEnabled,
                    minScale: 0.5,
                    maxScale: 2.5,
                    scaleEnabled: _moveEnabled,
                    child: Container(
                      color: Colors.white,
                      child: CustomPaint(
                        key: transformKey,
                        size: paintViewport,
                        painter: PathPainter(state.document, currentEditingLayer),
                      ),
                    ),
                  ),
                );
              }));
            }
            return Container();
          });
        });
  }
}

class PathPainter extends CustomPainter {
  final AppDocument document;
  final ElementLayer? editingLayer;
  final bool renderBackground;

  PathPainter(this.document, this.editingLayer, {this.renderBackground = true});
  @override
  void paint(Canvas canvas, Size size, {Offset? offset}) {
    var background = document.background;
    if (background is BoxBackground && renderBackground) {
      canvas.drawColor(background.boxColor, BlendMode.srcOver);
      if (background.boxWidth > 0 && background.boxXCount > 0) {
        double x = offset?.dx ?? 0;
        x += background.boxXSpace;
        int count = 0;
        while (x < size.width) {
          canvas.drawLine(
              Offset(x, 0),
              Offset(x, size.height),
              Paint()
                ..strokeWidth = background.boxXStroke
                ..color = background.boxXColor);
          count++;
          if (count >= background.boxXCount) {
            count = 0;
            x += background.boxXSpace;
          }
          x += background.boxWidth;
        }
      }
      if (background.boxHeight > 0 && background.boxYCount > 0) {
        double y = offset?.dy ?? 0;
        y += background.boxYSpace;
        int count = 0;
        while (y < size.width) {
          canvas.drawLine(
              Offset(0, y),
              Offset(size.width, y),
              Paint()
                ..strokeWidth = background.boxYStroke
                ..color = background.boxYColor);
          count++;
          if (count >= background.boxYCount) {
            count = 0;
            y += background.boxYSpace;
          }
          y += background.boxHeight;
        }
      }
    }
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    List.from(document.content)
      ..addAll([if (editingLayer != null) editingLayer])
      ..forEach((element) {
        if (element is PathElement) {
          var path = element.buildPath();
          if (offset != null) {
            path = path.shift(offset);
          }
          canvas.drawPath(path, element.buildPaint());
        } else if (element is LabelElement) {
          TextSpan span = TextSpan(
              style: TextStyle(fontSize: element.size, color: element.color), text: element.text);
          TextPainter tp = TextPainter(
              text: span,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              textScaleFactor: 1.0);
          tp.layout();
          var position = element.position;
          if (offset != null) {
            position += offset;
          }
          tp.paint(canvas, position);
        }
      });
    canvas.restore();
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => document != oldDelegate.document;
}
