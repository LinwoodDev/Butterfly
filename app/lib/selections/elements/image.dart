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
      MenuItemButton(
        leadingIcon: const PhosphorIcon(PhosphorIconsLight.export),
        onPressed: () async {
          final localization = AppLocalizations.of(context);
          final state = context.read<DocumentBloc>().state;
          if (state is! DocumentLoaded) {
            return;
          }
          final data = await element.getData(state.data);
          if (data == null) {
            return;
          }
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
              await file.writeAsBytes(data);
            }
          } else {
            openImage(data);
          }
        },
        child: Text(AppLocalizations.of(context).export),
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
  IconGetter get icon => PhosphorIcons.image;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).image;
}
