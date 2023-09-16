part of '../dialog.dart';

class _TextureBackgroundPropertiesView extends StatelessWidget {
  final TextureBackground value;
  final ValueChanged<TextureBackground> onChanged;

  const _TextureBackgroundPropertiesView({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextureView(
      value: value.texture,
      onChanged: (texture) => onChanged(value.copyWith(texture: texture)),
    );
  }
}
