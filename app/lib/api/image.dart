import 'package:image/image.dart' as img;

img.Image Function(img.Image) updateImageBackground([
  img.ColorRgb8? background,
]) => (image) {
  if (image.numChannels != 4) return image;
  final imageBg = img.Image(width: image.width, height: image.height);
  img.fill(imageBg, color: background ?? img.ColorRgb8(255, 255, 255));
  return img.compositeImage(imageBg, image);
};
