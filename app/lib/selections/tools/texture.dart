part of '../selection.dart';

class TextureToolSelection extends ToolSelection<TextureTool> {
  TextureToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final tool = selected.first;
    void changeTexture(SurfaceTexture texture) => update(
      context,
      selected.map((e) => e.copyWith(texture: texture)).toList(),
    );
    return [
      ...super.buildProperties(context),
      const SizedBox(height: 8),
      ...[
        PatternTemplate.values.where((element) => !element.dark),
        PatternTemplate.values.where((element) => element.dark),
      ].map(
        (e) => Wrap(
          alignment: WrapAlignment.center,
          children: e.map((template) {
            var created = template.create();
            return BoxTile(
              title: Text(
                template.getLocalizedName(context),
                textAlign: TextAlign.center,
              ),
              icon: Image.asset(template.asset, width: 64),
              onTap: () {
                changeTexture(created);
              },
              selected: selected.first.texture == created,
              size: 120,
            );
          }).toList(),
        ),
      ),
      const SizedBox(height: 16),
      SizedBox(
        height: 500,
        child: TextureView(value: tool.texture, onChanged: changeTexture),
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
