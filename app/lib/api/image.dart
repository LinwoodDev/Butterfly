import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

img.Image Function(img.Image) updateImageBackground([
  img.ColorRgba8? background,
]) => (image) {
  if (image.numChannels != 4) return image;
  final imageBg = img.Image(width: image.width, height: image.height);
  img.fill(imageBg, color: background ?? img.ColorRgb8(255, 255, 255));
  return img.compositeImage(imageBg, image);
};

Future<img.Image> convertFlutterUiToImage(ui.Image uiImage) async {
  final uiBytes = await uiImage.toByteData();

  final image = img.Image.fromBytes(
    width: uiImage.width,
    height: uiImage.height,
    bytes: uiBytes!.buffer,
    numChannels: 4,
  );

  return image;
}

Future<ui.Image> convertImageToFlutterUi(img.Image image) async {
  if (image.format != img.Format.uint8 || image.numChannels != 4) {
    final cmd = img.Command()
      ..image(image)
      ..convert(format: img.Format.uint8, numChannels: 4);
    final rgba8 = await cmd.getImageThread();
    if (rgba8 != null) {
      image = rgba8;
    }
  }

  ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(
    image.toUint8List(),
  );

  ui.ImageDescriptor id = ui.ImageDescriptor.raw(
    buffer,
    height: image.height,
    width: image.width,
    pixelFormat: ui.PixelFormat.rgba8888,
  );

  ui.Codec codec = await id.instantiateCodec(
    targetHeight: image.height,
    targetWidth: image.width,
  );

  ui.FrameInfo fi = await codec.getNextFrame();
  ui.Image uiImage = fi.image;

  return uiImage;
}
