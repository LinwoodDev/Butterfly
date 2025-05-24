import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:butterfly/services/network.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../renderer.dart';

class UserCursor extends Renderer<NetworkingUser> {
  final int? userId;

  UserCursor(super.element, this.userId);

  @override
  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    final position = element.cursor?.toOffset();
    if (position == null) {
      return;
    }
    const icon = PhosphorIconsFill.cursor;
    final iconSize = 16 / transform.size;
    final iconColor = getRandomColor(userId ?? 0);
    final iconPainter = TextPainter(
      textDirection: TextDirection.rtl,
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          fontSize: iconSize,
          color: iconColor.toColor(),
          fontStyle: FontStyle.normal,
        ),
      ),
      textAlign: TextAlign.center,
    );
    iconPainter.layout();
    iconPainter.paint(canvas, position);
  }
}
