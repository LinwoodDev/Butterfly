part of '../dialog.dart';

class _MotifBackgroundPropertiesView extends StatefulWidget {
  final MotifBackground value;
  final ValueChanged<MotifBackground> onChanged;

  const _MotifBackgroundPropertiesView({
    required this.value,
    required this.onChanged,
  });

  @override
  State<_MotifBackgroundPropertiesView> createState() =>
      _MotifBackgroundPropertiesViewState();
}

class _MotifBackgroundPropertiesViewState
    extends State<_MotifBackgroundPropertiesView> {
  int? currentExpansionOpened = 0;

  @override
  void didUpdateWidget(covariant _MotifBackgroundPropertiesView oldWidget) {
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
          value: Color(widget.value.motif.boxColor),
          onChanged: (value) => widget
              .onChanged(widget.value.copyWith.motif(boxColor: value.value)),
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
                        value: Color(widget.value.motif.boxXColor),
                        title: Text(AppLocalizations.of(context).color),
                        onChanged: (value) => widget.onChanged(widget
                            .value.copyWith
                            .motif(boxXColor: value.value)),
                      ),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(
                              widget.value.copyWith.motif(boxWidth: value)),
                          header: Text(AppLocalizations.of(context).width,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.motif.boxWidth,
                          min: 0,
                          max: 100),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(widget
                              .value.copyWith
                              .motif(boxXCount: value.round())),
                          header: Text(AppLocalizations.of(context).count,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.motif.boxXCount.toDouble(),
                          fractionDigits: 0,
                          min: 0,
                          max: 100),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(
                              widget.value.copyWith.motif(boxXSpace: value)),
                          header: Text(AppLocalizations.of(context).space,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.motif.boxXSpace,
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
                        value: Color(widget.value.motif.boxYColor),
                        onChanged: (value) => widget.onChanged(widget
                            .value.copyWith
                            .motif(boxYColor: value.value)),
                      ),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(
                              widget.value.copyWith.motif(boxHeight: value)),
                          header: Text(AppLocalizations.of(context).width,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.motif.boxHeight,
                          min: 0,
                          max: 100),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(widget
                              .value.copyWith
                              .motif(boxYCount: value.round())),
                          header: Text(AppLocalizations.of(context).count,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.motif.boxYCount.toDouble(),
                          fractionDigits: 0,
                          min: 0,
                          max: 100),
                      const SizedBox(height: 16),
                      ExactSlider(
                          onChanged: (value) => widget.onChanged(
                              widget.value.copyWith.motif(boxYSpace: value)),
                          header: Text(AppLocalizations.of(context).space,
                              style: Theme.of(context).textTheme.titleLarge),
                          value: widget.value.motif.boxYSpace,
                          min: 0,
                          max: 100),
                    ]),
                  )),
            ]),
      ],
    );
  }
}
