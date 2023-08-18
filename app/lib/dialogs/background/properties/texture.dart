part of '../dialog.dart';

class _TextureBackgroundPropertiesView extends StatefulWidget {
  final TextureBackground value;
  final ValueChanged<TextureBackground> onChanged;

  const _TextureBackgroundPropertiesView({
    required this.value,
    required this.onChanged,
  });

  @override
  State<_TextureBackgroundPropertiesView> createState() =>
      _TextureBackgroundPropertiesViewState();
}

class _TextureBackgroundPropertiesViewState
    extends State<_TextureBackgroundPropertiesView> {
  int? currentExpansionOpened = 0;

  @override
  void didUpdateWidget(covariant _TextureBackgroundPropertiesView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ColorField(
          title: Text(AppLocalizations.of(context).color),
          value: Color(widget.value.texture.boxColor),
          onChanged: (value) => widget
              .onChanged(widget.value.copyWith.texture(boxColor: value.value)),
        ),
        const SizedBox(height: 16),
        ExpansionPanelList(
            expansionCallback: (int item, bool status) {
              setState(() {
                currentExpansionOpened = !status ? item : null;
              });
            },
            children: [
              ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: currentExpansionOpened == 0,
                  headerBuilder: (context, isExpanded) => ListTile(
                        title: Text(AppLocalizations.of(context).horizontal,
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      ColorField(
                        value: Color(widget.value.texture.boxXColor),
                        title: Text(AppLocalizations.of(context).color),
                        onChanged: (value) => widget.onChanged(widget
                            .value.copyWith
                            .texture(boxXColor: value.value)),
                      ),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(
                              widget.value.copyWith.texture(boxWidth: value)),
                          header: Text(AppLocalizations.of(context).width,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.texture.boxWidth,
                          min: 0,
                          max: 100),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(widget
                              .value.copyWith
                              .texture(boxXCount: value.round())),
                          header: Text(AppLocalizations.of(context).count,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.texture.boxXCount.toDouble(),
                          fractionDigits: 0,
                          min: 0,
                          max: 100),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(
                              widget.value.copyWith.texture(boxXSpace: value)),
                          header: Text(AppLocalizations.of(context).space,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.texture.boxXSpace,
                          min: 0,
                          max: 100),
                    ]),
                  )),
              ExpansionPanel(
                  canTapOnHeader: true,
                  isExpanded: currentExpansionOpened == 1,
                  headerBuilder: (context, isExpanded) => ListTile(
                        title: Text(AppLocalizations.of(context).vertical,
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      ColorField(
                        title: Text(AppLocalizations.of(context).color),
                        value: Color(widget.value.texture.boxYColor),
                        onChanged: (value) => widget.onChanged(widget
                            .value.copyWith
                            .texture(boxYColor: value.value)),
                      ),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(
                              widget.value.copyWith.texture(boxHeight: value)),
                          header: Text(AppLocalizations.of(context).width,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.texture.boxHeight,
                          min: 0,
                          max: 100),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(widget
                              .value.copyWith
                              .texture(boxYCount: value.round())),
                          header: Text(AppLocalizations.of(context).count,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.texture.boxYCount.toDouble(),
                          fractionDigits: 0,
                          min: 0,
                          max: 100),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(
                              widget.value.copyWith.texture(boxYSpace: value)),
                          header: Text(AppLocalizations.of(context).space,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.texture.boxYSpace,
                          min: 0,
                          max: 100),
                    ]),
                  )),
            ]),
      ],
    );
  }
}
