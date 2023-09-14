part of '../selection.dart';

class TextureToolSelection extends ToolSelection<TextureTool> {
  TextureToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final tool = selected.first;
    return [
      ...super.buildProperties(context),
      TextureView(
        value: tool.texture,
        onChanged: (texture) => update(
          context,
          selected.map((e) => e.copyWith(texture: texture)).toList(),
        ),
      ),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is TextureTool) {
      return TextureToolSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  IconGetter get icon => selected.first.icon;
}
