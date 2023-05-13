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
        title: Text(AppLocalizations.of(context).export),
        leading: const PhosphorIcon(PhosphorIconsLight.export),
        onTap: () async {
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
  IconGetter get icon => PhosphorIcons.sun;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).svg;
}
