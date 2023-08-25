import 'dart:ui';

import 'package:butterfly/helpers/xml_helper.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_leap/material_leap.dart';
import 'package:xml/xml.dart';

part 'pattern.dart';

void drawSurfaceTextureOnCanvas(SurfaceTexture texture, Canvas canvas,
        double scale, Offset offset, Size size) =>
    texture.map(
      pattern: (e) =>
          drawPatternTextureOnCanvas(e, canvas, scale, offset, size),
    );

void drawSurfaceTextureOnSvg(
  SurfaceTexture texture,
  XmlDocument xml,
  Offset offset,
  Size size,
) =>
    texture.map(
      pattern: (e) => drawPatternTextureOnSvg(e, xml, offset, size),
    );
