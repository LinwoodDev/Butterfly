part of 'dialog.dart';

class _GeneralBackgroundPropertiesView extends StatelessWidget {
  final ValueChanged<Background> onChanged;

  const _GeneralBackgroundPropertiesView({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...[
          PatternTemplate.values.where(
            (element) => element.background != PatternBackground.dark,
          ),
          PatternTemplate.values.where(
            (element) => element.background == PatternBackground.dark,
          ),
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
                  onChanged(Background.texture(texture: created));
                },
              );
            }).toList(),
          ),
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
                final (result, _) = await importFile(context, [
                  AssetFileType.image,
                ]);
                if (result == null) return;
                final dataPath = Uri.dataFromBytes(result).toString();
                final codec = await ui.instantiateImageCodec(result);
                try {
                  final frame = await codec.getNextFrame();
                  final image = frame.image;
                  final width = image.width.toDouble(),
                      height = image.height.toDouble();
                  image.dispose();
                  onChanged(
                    ImageBackground(
                      source: dataPath,
                      width: width,
                      height: height,
                    ),
                  );
                } finally {
                  codec.dispose();
                }
              },
            ),
            BoxTile(
              title: Text(AppLocalizations.of(context).svg),
              icon: const Icon(
                PhosphorIconsLight.fileSvg,
                textDirection: TextDirection.ltr,
              ),
              onTap: () async {
                final state = context.read<DocumentBloc>().state;
                if (state is! DocumentLoaded) return;
                final (result, _) = await importFile(context, [
                  AssetFileType.svg,
                ]);
                if (result == null) return;
                final dataPath = Uri.dataFromBytes(result).toString();
                final contentString = String.fromCharCodes(result);
                var info = await vg.loadPicture(
                  SvgStringLoader(contentString),
                  null,
                );
                try {
                  final size = info.size;
                  var height = size.height, width = size.width;
                  if (!height.isFinite) height = 0;
                  if (!width.isFinite) width = 0;
                  onChanged(
                    SvgBackground(
                      source: dataPath,
                      width: width,
                      height: height,
                    ),
                  );
                } finally {
                  info.picture.dispose();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
