part of '../selection.dart';

class SvgElementSelection extends ElementSelection<SvgElement> {
  SvgElementSelection(super.selected);

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
          final data = element.data;
          if (!kIsWeb &&
              (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
            var path = await FilePicker.platform.saveFile(
              type: FileType.custom,
              allowedExtensions: ['svg'],
              fileName: 'export.svg',
              dialogTitle: localization.export,
            );
            if (path != null) {
              var file = File(path);
              if (!(await file.exists())) {
                file.create(recursive: true);
              }
              await file.writeAsString(data);
            }
          } else {
            openSvg(data);
          }
        },
      ),
    ];
  }

  @override
  Selection insert(element) {
    if (element is Renderer<SvgElement>) {
      return SvgElementSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.sunFill : PhosphorIcons.sunLight;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.svg;
}
