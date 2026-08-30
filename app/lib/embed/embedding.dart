import 'dart:ui';

import 'package:butterfly/embed/handler.dart';
import 'package:lw_file_system/lw_file_system.dart';

class Embedding {
  final EmbedHandler? handler;
  final bool save, editable, fullScreen;
  final VoidCallback? onExit, onOpen;
  final String language, theme, fileName;
  final AssetLocation? location;

  bool get isInternal => handler == null;

  Embedding({
    this.save = true,
    this.editable = true,
    this.fullScreen = false,
    this.language = 'user',
    this.theme = 'user',
    this.fileName = '',
    bool internal = false,
    this.onExit,
    this.onOpen,
    this.location,
  }) : handler = internal ? null : EmbedHandler();
  Embedding.fromQuery(Map<String, String> query)
    : save = query['save'] != 'false',
      editable = query['editable'] != 'false',
      fullScreen = query['fullScreen'] == 'true',
      language = query['language'] ?? 'user',
      theme = query['theme'] ?? '',
      fileName = query['fileName'] ?? '',
      handler = EmbedHandler(),
      onExit = null,
      location = null,
      onOpen = null;
}
