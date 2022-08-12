part of '../selection.dart';

class ImageElementSelection extends ElementSelection<ImageElement> {
  ImageElementSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final element = selected.first.element;
    return [
      ...super.buildProperties(context),
      ConstraintsView(
        enableScaled: true,
        initialConstraints: element.constraints,
        onChanged: (constraints) => updateElements(context,
            elements.map((e) => e.copyWith(constraints: constraints)).toList()),
      ),
      ListTile(
        title: Text(AppLocalizations.of(context)!.export),
        leading: const Icon(PhosphorIcons.exportLight),
        onTap: () async {
          final localization = AppLocalizations.of(context)!;
          final data = element.pixels;
          if (!kIsWeb &&
              (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
            var path = await FilePicker.platform.saveFile(
              type: FileType.image,
              fileName: 'export.png',
              dialogTitle: localization.export,
            );
            if (path != null) {
              var file = File(path);
              if (!(await file.exists())) {
                file.create(recursive: true);
              }
              await file.writeAsBytes(data.buffer.asUint8List());
            }
          } else {
            openImage(data.buffer.asUint8List());
          }
        },
      ),
    ];
  }

  @override
  Selection insert(element) {
    if (element is Renderer<ImageElement>) {
      return ImageElementSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.imageFill : PhosphorIcons.imageLight;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.image;
}
