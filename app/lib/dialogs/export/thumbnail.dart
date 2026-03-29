import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/view_painter.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';

enum _CropHandle {
  topLeft,
  top,
  topRight,
  left,
  right,
  bottomLeft,
  bottom,
  bottomRight,
  pan,
  none,
}

class ThumbnailCaptureDialog extends StatefulWidget {
  final DocumentLoadSuccess state;

  const ThumbnailCaptureDialog({super.key, required this.state});

  @override
  State<ThumbnailCaptureDialog> createState() => _ThumbnailCaptureDialogState();
}

class _ThumbnailCaptureDialogState extends State<ThumbnailCaptureDialog> {
  late CameraTransform _transform;
  Rect? _cropRect;
  Rect? _baseCropRect;
  Offset? _baseFocalPoint;
  _CropHandle _currentHandle = _CropHandle.none;
  MouseCursor _cursor = SystemMouseCursors.basic;

  @override
  void initState() {
    super.initState();
    _transform = widget.state.transformCubit.state;
  }

  _CropHandle _getHandleForOffset(Offset offset) {
    if (_cropRect == null) return _CropHandle.none;
    const hitRegion = 20.0;
    final rect = _cropRect!;

    bool isTop = (offset.dy - rect.top).abs() < hitRegion;
    bool isBottom = (offset.dy - rect.bottom).abs() < hitRegion;
    bool isLeft = (offset.dx - rect.left).abs() < hitRegion;
    bool isRight = (offset.dx - rect.right).abs() < hitRegion;

    bool withinX =
        offset.dx >= rect.left - hitRegion &&
        offset.dx <= rect.right + hitRegion;
    bool withinY =
        offset.dy >= rect.top - hitRegion &&
        offset.dy <= rect.bottom + hitRegion;

    if (!withinX || !withinY) return _CropHandle.none;

    if (isTop && isLeft) return _CropHandle.topLeft;
    if (isTop && isRight) return _CropHandle.topRight;
    if (isBottom && isLeft) return _CropHandle.bottomLeft;
    if (isBottom && isRight) return _CropHandle.bottomRight;
    if (isTop) return _CropHandle.top;
    if (isBottom) return _CropHandle.bottom;
    if (isLeft) return _CropHandle.left;
    if (isRight) return _CropHandle.right;

    if (rect.contains(offset)) return _CropHandle.pan;

    return _CropHandle.none;
  }

  MouseCursor _getCursorForHandle(_CropHandle handle) {
    switch (handle) {
      case _CropHandle.topLeft:
      case _CropHandle.bottomRight:
        return SystemMouseCursors.resizeUpLeftDownRight;
      case _CropHandle.topRight:
      case _CropHandle.bottomLeft:
        return SystemMouseCursors.resizeUpRightDownLeft;
      case _CropHandle.top:
      case _CropHandle.bottom:
        return SystemMouseCursors.resizeUpDown;
      case _CropHandle.left:
      case _CropHandle.right:
        return SystemMouseCursors.resizeLeftRight;
      case _CropHandle.pan:
        return SystemMouseCursors.move;
      case _CropHandle.none:
        return SystemMouseCursors.basic;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).captureThumbnail),
      constraints: const BoxConstraints(
        maxWidth: LeapBreakpoints.medium,
        maxHeight: 700,
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 800,
          height: 600,
          child: ClipRect(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (_cropRect == null) {
                  final center = Offset(
                    constraints.maxWidth / 2,
                    constraints.maxHeight / 2,
                  );
                  var cropWidth = constraints.maxWidth;
                  var cropHeight =
                      cropWidth / (kThumbnailWidth / kThumbnailHeight);
                  if (cropHeight > constraints.maxHeight) {
                    cropHeight = constraints.maxHeight;
                    cropWidth =
                        cropHeight * (kThumbnailWidth / kThumbnailHeight);
                  }
                  cropWidth *= 0.8;
                  cropHeight *= 0.8;

                  Future.microtask(() {
                    if (mounted) {
                      setState(() {
                        _cropRect = Rect.fromCenter(
                          center: center,
                          width: cropWidth,
                          height: cropHeight,
                        );
                      });
                    }
                  });

                  return const Center(child: CircularProgressIndicator());
                }

                Rect restrictRect(Rect rect) {
                  var restricted = rect;
                  if (restricted.left < 0) {
                    restricted = restricted.shift(Offset(-restricted.left, 0));
                  }
                  if (restricted.top < 0) {
                    restricted = restricted.shift(Offset(0, -restricted.top));
                  }
                  if (restricted.right > constraints.maxWidth) {
                    restricted = restricted.shift(
                      Offset(constraints.maxWidth - restricted.right, 0),
                    );
                  }
                  if (restricted.bottom > constraints.maxHeight) {
                    restricted = restricted.shift(
                      Offset(0, constraints.maxHeight - restricted.bottom),
                    );
                  }
                  return restricted;
                }

                return MouseRegion(
                  cursor: _cursor,
                  onHover: (event) {
                    final handle = _getHandleForOffset(event.localPosition);
                    final newCursor = _getCursorForHandle(handle);
                    if (_cursor != newCursor) {
                      setState(() {
                        _cursor = newCursor;
                      });
                    }
                  },
                  child: Listener(
                    onPointerSignal: (event) {
                      if (event is PointerScrollEvent && _cropRect != null) {
                        final scaleDelta = event.scrollDelta.dy > 0 ? 0.9 : 1.1;
                        setState(() {
                          var newWidth = _cropRect!.width * scaleDelta;
                          var newHeight = _cropRect!.height * scaleDelta;

                          if (newWidth < 50) {
                            newWidth = 50;
                            newHeight =
                                50 / (kThumbnailWidth / kThumbnailHeight);
                          }
                          if (newWidth > constraints.maxWidth) {
                            newWidth = constraints.maxWidth;
                            newHeight =
                                constraints.maxWidth /
                                (kThumbnailWidth / kThumbnailHeight);
                          }
                          if (newHeight > constraints.maxHeight) {
                            newHeight = constraints.maxHeight;
                            newWidth =
                                constraints.maxHeight *
                                (kThumbnailWidth / kThumbnailHeight);
                          }

                          final actualScale = newWidth / _cropRect!.width;
                          final focalPoint = event.localPosition;
                          final fromFocalToCenter =
                              _cropRect!.center - focalPoint;

                          var newCenter =
                              focalPoint + fromFocalToCenter * actualScale;

                          _cropRect = restrictRect(
                            Rect.fromCenter(
                              center: newCenter,
                              width: newWidth,
                              height: newHeight,
                            ),
                          );
                        });
                      }
                    },
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onScaleStart: (details) {
                        _baseCropRect = _cropRect;
                        _baseFocalPoint = details.localFocalPoint;
                        _currentHandle = _getHandleForOffset(
                          details.localFocalPoint,
                        );
                      },
                      onScaleUpdate: (details) {
                        if (_baseCropRect == null || _baseFocalPoint == null) {
                          return;
                        }
                        if (_currentHandle == _CropHandle.none) return;

                        setState(() {
                          final double ar = kThumbnailWidth / kThumbnailHeight;

                          if (_currentHandle == _CropHandle.pan) {
                            var newWidth = _baseCropRect!.width * details.scale;
                            var newHeight =
                                _baseCropRect!.height * details.scale;

                            if (newWidth < 50) {
                              newWidth = 50;
                              newHeight = 50 / ar;
                            }
                            if (newWidth > constraints.maxWidth) {
                              newWidth = constraints.maxWidth;
                              newHeight = constraints.maxWidth / ar;
                            }
                            if (newHeight > constraints.maxHeight) {
                              newHeight = constraints.maxHeight;
                              newWidth = constraints.maxHeight * ar;
                            }

                            final actualScale = newWidth / _baseCropRect!.width;
                            final fromFocalToCenter =
                                _baseCropRect!.center - _baseFocalPoint!;
                            final currentFocalPoint = details.localFocalPoint;

                            var newCenter =
                                currentFocalPoint +
                                fromFocalToCenter * actualScale;

                            _cropRect = restrictRect(
                              Rect.fromCenter(
                                center: newCenter,
                                width: newWidth,
                                height: newHeight,
                              ),
                            );
                          } else {
                            final delta =
                                details.localFocalPoint - _baseFocalPoint!;

                            Offset anchor;
                            double signX = 0;
                            double signY = 0;

                            switch (_currentHandle) {
                              case _CropHandle.topLeft:
                                anchor = _baseCropRect!.bottomRight;
                                signX = -1;
                                signY = -1;
                                break;
                              case _CropHandle.top:
                                anchor = _baseCropRect!.bottomCenter;
                                signY = -1;
                                break;
                              case _CropHandle.topRight:
                                anchor = _baseCropRect!.bottomLeft;
                                signX = 1;
                                signY = -1;
                                break;
                              case _CropHandle.left:
                                anchor = _baseCropRect!.centerRight;
                                signX = -1;
                                break;
                              case _CropHandle.right:
                                anchor = _baseCropRect!.centerLeft;
                                signX = 1;
                                break;
                              case _CropHandle.bottomLeft:
                                anchor = _baseCropRect!.topRight;
                                signX = -1;
                                signY = 1;
                                break;
                              case _CropHandle.bottom:
                                anchor = _baseCropRect!.topCenter;
                                signY = 1;
                                break;
                              case _CropHandle.bottomRight:
                                anchor = _baseCropRect!.topLeft;
                                signX = 1;
                                signY = 1;
                                break;
                              default:
                                anchor = _baseCropRect!.center;
                                break;
                            }

                            double scaleX = 1.0;
                            double scaleY = 1.0;

                            if (signX != 0) {
                              scaleX =
                                  (_baseCropRect!.width + delta.dx * signX) /
                                  _baseCropRect!.width;
                            }
                            if (signY != 0) {
                              scaleY =
                                  (_baseCropRect!.height + delta.dy * signY) /
                                  _baseCropRect!.height;
                            }

                            double combinedScale = 1.0;
                            if (signX != 0 && signY != 0) {
                              combinedScale = (scaleX + scaleY) / 2.0;
                            } else if (signX != 0) {
                              combinedScale = scaleX;
                            } else if (signY != 0) {
                              combinedScale = scaleY;
                            }

                            var finalScale = combinedScale;

                            if (_baseCropRect!.width * finalScale < 50) {
                              finalScale = 50 / _baseCropRect!.width;
                            }

                            double maxScaleX1 = anchor.dx > _baseCropRect!.left
                                ? anchor.dx / (anchor.dx - _baseCropRect!.left)
                                : double.infinity;
                            double maxScaleX2 = _baseCropRect!.right > anchor.dx
                                ? (constraints.maxWidth - anchor.dx) /
                                      (_baseCropRect!.right - anchor.dx)
                                : double.infinity;
                            double maxScaleY1 = anchor.dy > _baseCropRect!.top
                                ? anchor.dy / (anchor.dy - _baseCropRect!.top)
                                : double.infinity;
                            double maxScaleY2 =
                                _baseCropRect!.bottom > anchor.dy
                                ? (constraints.maxHeight - anchor.dy) /
                                      (_baseCropRect!.bottom - anchor.dy)
                                : double.infinity;

                            if (maxScaleX1 < 0) maxScaleX1 = double.infinity;
                            if (maxScaleX2 < 0) maxScaleX2 = double.infinity;
                            if (maxScaleY1 < 0) maxScaleY1 = double.infinity;
                            if (maxScaleY2 < 0) maxScaleY2 = double.infinity;

                            double maxAllowedScale = maxScaleX1;
                            if (maxScaleX2 < maxAllowedScale) {
                              maxAllowedScale = maxScaleX2;
                            }
                            if (maxScaleY1 < maxAllowedScale) {
                              maxAllowedScale = maxScaleY1;
                            }
                            if (maxScaleY2 < maxAllowedScale) {
                              maxAllowedScale = maxScaleY2;
                            }

                            if (finalScale > maxAllowedScale) {
                              finalScale = maxAllowedScale;
                            }

                            var newWidth = _baseCropRect!.width * finalScale;
                            var newHeight = _baseCropRect!.height * finalScale;

                            var newCenter =
                                anchor +
                                (_baseCropRect!.center - anchor) * finalScale;

                            _cropRect = restrictRect(
                              Rect.fromCenter(
                                center: newCenter,
                                width: newWidth,
                                height: newHeight,
                              ),
                            );
                          }
                        });
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CustomPaint(
                            painter: ViewPainter(
                              widget.state.data,
                              widget.state.page,
                              widget.state.info,
                              cameraViewport: widget
                                  .state
                                  .currentIndexCubit
                                  .state
                                  .cameraViewport,
                              transform: _transform,
                              invisibleLayers: widget.state.invisibleLayers,
                              renderBackground: true,
                              renderBaked: true,
                            ),
                            isComplex: true,
                            willChange: false,
                          ),
                          IgnorePointer(
                            child: CustomPaint(
                              painter: _CropOverlayPainter(
                                holeRect: _cropRect!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: _capture,
          child: Text(AppLocalizations.of(context).captureThumbnail),
        ),
      ],
    );
  }

  void _capture() async {
    if (_cropRect == null) return;
    final cropRect = _cropRect!;
    final docTopLeft = _transform.localToGlobal(cropRect.topLeft);
    final docWidth = cropRect.width / _transform.size;

    final targetWidth = kThumbnailWidth.toDouble();
    final targetHeight = kThumbnailHeight.toDouble();
    final scale = targetWidth / docWidth;

    final options = ImageExportOptions(
      width: targetWidth,
      height: targetHeight,
      x: docTopLeft.dx,
      y: docTopLeft.dy,
      scale: scale,
    );

    final thumbnail = await widget.state.currentIndexCubit.render(
      widget.state.data,
      widget.state.page,
      widget.state.info,
      options,
      invisibleLayers: widget.state.invisibleLayers,
      cameraViewport: widget.state.currentIndexCubit.state.cameraViewport
          .unbake(unbakedElements: widget.state.renderers),
      docState: widget.state,
    );

    if (thumbnail != null && mounted) {
      final bytes = thumbnail.buffer.asUint8List();
      context.read<DocumentBloc>().add(ThumbnailCaptured(bytes));
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Image.memory(bytes, height: 42),
                Flexible(
                  child: Text(AppLocalizations.of(context).capturedThumbnail),
                ),
              ],
            ),
          ),
        );
      }
    }
  }
}

class _CropOverlayPainter extends CustomPainter {
  final Rect holeRect;

  _CropOverlayPainter({required this.holeRect});

  @override
  void paint(Canvas canvas, Size size) {
    // Fill the outer area with semi-transparent black, leaving a hole
    // Use an expanded bounds to prevent 1px bleeding on the edges from subpixel rounding
    final bounds = Rect.fromLTWH(
      -100,
      -100,
      size.width + 200,
      size.height + 200,
    );

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(bounds),
        Path()..addRect(holeRect),
      ),
      Paint()..color = Colors.black.withAlpha(128),
    );

    // Draw a border around the hole
    canvas.drawRect(
      holeRect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant _CropOverlayPainter oldDelegate) {
    return oldDelegate.holeRect != holeRect;
  }
}
