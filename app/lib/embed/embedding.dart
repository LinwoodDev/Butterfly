import 'dart:ui';

import 'package:butterfly/embed/handler.dart';

class Embedding {
  final EmbedHandler? handler;
  final bool save, editable;
  final VoidCallback? onExit;
  final String language, theme;

  bool get isInternal => handler == null;

  Embedding({
    this.save = true,
    this.editable = true,
    this.language = '',
    this.theme = 'user',
    bool internal = false,
    this.onExit,
  }) : handler = internal ? null : EmbedHandler();
  Embedding.fromQuery(Map<String, String> query)
      : save = query['save'] != 'false',
        editable = query['editable'] != 'false',
        language = query['language'] ?? 'user',
        theme = query['theme'] ?? '',
        handler = EmbedHandler(),
        onExit = null;
}
