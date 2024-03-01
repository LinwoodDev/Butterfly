import 'dart:ui' as ui;

import 'package:butterfly_api/butterfly_api.dart';

import '../helpers/element.dart';

class AssetService {
  final NoteData document;
  final Map<String, ui.Image> _images = {};

  AssetService(this.document);

  Future<ui.Image?> getImage(String path, [NoteData? document]) async {
    if (_images.containsKey(path)) {
      return _images[path]!.clone();
    }
    document ??= this.document;
    var data = await getDataFromSource(document, path);
    if (data == null) return null;
    final codec = await ui.instantiateImageCodec(data);
    final frameInfo = await codec.getNextFrame();
    final image = frameInfo.image;
    _images[path] = image;
    return image.clone();
  }

  void dispose() {
    _images.keys.toList().forEach(invalidateImage);
    _images.clear();
  }

  void invalidateImage(String path) {
    try {
      _images[path]?.dispose();
    } catch (_) {}
    _images.remove(path);
  }
}
