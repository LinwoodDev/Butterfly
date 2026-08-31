import 'dart:ui';

import 'package:butterfly/embed/handler.dart';
import 'package:lw_file_system/lw_file_system.dart';

enum EmbedFullScreen {
  enabled('enabled', canToggle: true, usesNativeFullScreen: true),
  layoutOnly('layoutOnly', canToggle: true),
  startInLayout('startInLayout', initialLayout: true, canToggle: true),
  forced('forced', initialLayout: true),
  disabled('disabled');

  const EmbedFullScreen(
    this.queryValue, {
    this.initialLayout = false,
    this.canToggle = false,
    this.usesNativeFullScreen = false,
  });

  final String queryValue;
  final bool initialLayout, canToggle, usesNativeFullScreen;

  static EmbedFullScreen fromQuery(String? value) => values.firstWhere(
    (mode) => mode.queryValue == value,
    orElse: () => enabled,
  );
}

class Embedding {
  final EmbedHandler? handler;
  final bool save, editable;
  final EmbedFullScreen fullScreen;
  final VoidCallback? onExit, onOpen;
  final String language, theme, fileName;
  final AssetLocation? location;

  bool get isInternal => handler == null;

  Embedding({
    this.save = true,
    this.editable = true,
    this.fullScreen = EmbedFullScreen.enabled,
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
      fullScreen = EmbedFullScreen.fromQuery(query['fullScreen']),
      language = query['language'] ?? 'user',
      theme = query['theme'] ?? '',
      fileName = query['fileName'] ?? '',
      handler = EmbedHandler(),
      onExit = null,
      location = null,
      onOpen = null;
}
