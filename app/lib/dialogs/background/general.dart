part of 'dialog.dart';

class _GeneralBackgroundPropertiesView extends StatelessWidget {
  final Background? value;
  final ValueChanged<Background> onChanged;

  const _GeneralBackgroundPropertiesView({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
                  icon: Image.asset(
                    template.asset,
                    width: 64,
                  ),
                  onTap: () {
                    onChanged(Background.texture(texture: created));
                  },
                  selected: (value is TextureBackground &&
                      ((value as TextureBackground).texture == created)),
                  size: 120,
                );
              }).toList()),
        ),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            BoxTile(
              title: Text(AppLocalizations.of(context).image),
              icon: const Icon(PhosphorIconsLight.image),
              onTap: () async {
                final state = context.read<DocumentBloc>().state;
                if (state is! DocumentLoaded) return;
                final (result, _) = await importFile(
                  context,
                  [AssetFileType.image],
                );
                if (result == null) return;
                final dataPath = Uri.dataFromBytes(result).toString();
                final codec = await ui.instantiateImageCodec(result);
                final frame = await codec.getNextFrame();
                final image = frame.image;
                final width = image.width.toDouble(),
                    height = image.height.toDouble();
                image.dispose();
                onChanged(ImageBackground(
                  source: dataPath,
                  width: width,
                  height: height,
                ));
              },
              selected: value is ImageBackground,
              size: 120,
            ),
            /*BoxTile(
              title: Text(AppLocalizations.of(context).svg),
              icon: const Icon(PhosphorIconsLight.fileSvg),
              onTap: () async {
                final state = context.read<DocumentBloc>().state;
                if (state is! DocumentLoaded) return;
                final files = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['svg'],
                    allowMultiple: false,
                    withData: true);
                if (files?.files.isEmpty ?? true) return;
                final e = files!.files.first;
                var content = e.bytes ?? Uint8List(0);
                if (!kIsWeb) {
                  content = await File(e.path ?? '').readAsBytes();
                }
                final assetPath = state.data.addImage(content, 'svg');
                final dataPath =
                    Uri.file(assetPath, windows: false).toString();
                final contentString = String.fromCharCodes(content);
                var info = await vg.loadPicture(
                    SvgStringLoader(contentString), null);
                final size = info.size;
                var height = size.height, width = size.width;
                if (!height.isFinite) height = 0;
                if (!width.isFinite) width = 0;
                onChanged(SvgBackground(
                  source: dataPath,
                  width: width,
                  height: height,
                ));
              },
              selected: value is SvgBackground,
              size: 120,
            ),*/
          ],
        ),
      ],
    );
  }
}
