part of 'dialog.dart';

class _GeneralBackgroundPropertiesView extends StatefulWidget {
  final ValueChanged<Background> onChanged;

  const _GeneralBackgroundPropertiesView({required this.onChanged});

  @override
  State<_GeneralBackgroundPropertiesView> createState() =>
      _GeneralBackgroundPropertiesViewState();
}

class _GeneralBackgroundPropertiesViewState
    extends State<_GeneralBackgroundPropertiesView> {
  bool _showDark = false;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _showDark = Theme.of(context).brightness == Brightness.dark;
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final patterns = PatternTemplate.values.where((element) {
      if (_showDark) {
        return element.background == PatternBackground.dark;
      } else {
        return element.background != PatternBackground.dark;
      }
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SegmentedButton<bool>(
            segments: [
              ButtonSegment(
                value: false,
                label: Text(AppLocalizations.of(context).lightTheme),
                icon: const Icon(PhosphorIconsLight.sun),
              ),
              ButtonSegment(
                value: true,
                label: Text(AppLocalizations.of(context).darkTheme),
                icon: const Icon(PhosphorIconsLight.moon),
              ),
            ],
            selected: {_showDark},
            onSelectionChanged: (newSelection) {
              setState(() {
                _showDark = newSelection.first;
              });
            },
          ),
        ),
        Expanded(
          child: GridView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1.1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            children: [
              ...patterns.map((template) {
                return _BackgroundCard(
                  title: template.getLocalizedName(context),
                  image: AssetImage(template.asset),
                  onTap: () {
                    var created = template.create();
                    widget.onChanged(Background.texture(texture: created));
                  },
                );
              }),
              _BackgroundCard(
                title: AppLocalizations.of(context).image,
                icon: const Icon(PhosphorIconsLight.image, size: 48),
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
                    widget.onChanged(
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
              _BackgroundCard(
                title: AppLocalizations.of(context).svg,
                icon: const Icon(
                  PhosphorIconsLight.fileSvg,
                  textDirection: TextDirection.ltr,
                  size: 48,
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
                    widget.onChanged(
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
        ),
      ],
    );
  }
}

class _BackgroundCard extends StatelessWidget {
  final String title;
  final ImageProvider? image;
  final Widget? icon;
  final VoidCallback onTap;

  const _BackgroundCard({
    required this.title,
    this.image,
    this.icon,
    required this.onTap,
  }) : assert(image != null || icon != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: kThumbnailRatio,
              child: image != null
                  ? Image(image: image!, fit: BoxFit.cover)
                  : Center(child: icon),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
