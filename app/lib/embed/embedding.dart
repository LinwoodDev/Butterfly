import 'dart:ui';

import 'package:butterfly/embed/handler.dart';
import 'package:lw_file_system/lw_file_system.dart';

class Embedding {
  final EmbedHandler? handler;
  final bool save, editable;
  final VoidCallback? onExit, onOpen;
  final String language, theme;
  final AssetLocation? location;

  bool get isInternal => handler == null;

  Embedding({
    this.save = true,
    this.editable = true,
    this.language = '',
    this.theme = 'user',
    bool internal = false,
    this.onExit,
    this.onOpen,
    this.location,
  }) : handler = internal ? null : EmbedHandler();
  Embedding.fromQuery(Map<String, String> query)
    : save = query['save'] != 'false',
      editable = query['editable'] != 'false',
      language = query['language'] ?? 'user',
      theme = query['theme'] ?? '',
      handler = EmbedHandler(),
      onExit = null,
      location = null,
      onOpen = null;
}
