import 'dart:math';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';

/// The document rectangle shown in a fixed-aspect thumbnail of [area].
Rect? thumbnailAreaBounds(Rect area, PersistedThumbnailArea settings) {
  if (!area.isFinite || area.isEmpty) return null;
  final widthScale = kThumbnailWidth / area.width;
  final heightScale = kThumbnailHeight / area.height;
  final scale = settings.fit == ThumbnailAreaFit.fill
      ? max(widthScale, heightScale)
      : min(widthScale, heightScale);
  if (!scale.isFinite || scale <= 0) return null;
  final width = kThumbnailWidth / scale;
  final height = kThumbnailHeight / scale;
  final alignment = settings.fit == ThumbnailAreaFit.fill
      ? settings.alignment
      : ThumbnailAreaAlignment.center;
  return Rect.fromLTWH(
    area.left + (area.width - width) * alignment.x,
    area.top + (area.height - height) * alignment.y,
    width,
    height,
  );
}
