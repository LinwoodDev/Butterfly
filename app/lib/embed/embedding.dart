import 'package:butterfly/embed/handler.dart';

class Embedding {
  final EmbedHandler handler = EmbedHandler();
  final bool save, editable;
  final String language, theme;

  Embedding(
      {this.save = true,
      this.editable = true,
      this.language = '',
      this.theme = 'user'});
  Embedding.fromQuery(Map<String, String> query)
      : save = query['save'] != 'false',
        editable = query['editable'] != 'false',
        language = query['language'] ?? 'user',
        theme = query['theme'] ?? '';
}
