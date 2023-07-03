part of '../dialog.dart';

class _BoxBackgroundPropertiesView extends StatelessWidget {
  final BoxBackground value;
  final ValueChanged<BoxBackground> onChanged;

  const _BoxBackgroundPropertiesView({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    int? currentExpansionOpened = 0;
    return ListView(
      children: [
        ColorField(
          title: Text(AppLocalizations.of(context).color),
          value: Color(value.boxColor),
          onChanged: (value) =>
              onChanged(this.value.copyWith(boxColor: value.value)),
        ),
        const SizedBox(height: 16),
        StatefulBuilder(
            builder: (context, setState) => ExpansionPanelList(
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
                                title: Text(
                                    AppLocalizations.of(context).horizontal,
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                              ),
                          body: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              ColorField(
                                value: Color(value.boxXColor),
                                title: Text(AppLocalizations.of(context).color),
                                onChanged: (value) => onChanged(this
                                    .value
                                    .copyWith(boxXColor: value.value)),
                              ),
                              const SizedBox(height: 16),
                              ExactSlider(
                                  onChanged: (value) => onChanged(
                                      this.value.copyWith(boxWidth: value)),
                                  header: Text(
                                      AppLocalizations.of(context).width,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                  value: value.boxWidth,
                                  min: 0,
                                  max: 100),
                              const SizedBox(height: 16),
                              ExactSlider(
                                  onChanged: (value) => onChanged(this
                                      .value
                                      .copyWith(boxXCount: value.round())),
                                  header: Text(
                                      AppLocalizations.of(context).count,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                  value: value.boxXCount.toDouble(),
                                  fractionDigits: 0,
                                  min: 0,
                                  max: 100),
                              const SizedBox(height: 16),
                              ExactSlider(
                                  onChanged: (value) => onChanged(
                                      this.value.copyWith(boxXSpace: value)),
                                  header: Text(
                                      AppLocalizations.of(context).space,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                  value: value.boxXSpace,
                                  min: 0,
                                  max: 100),
                            ]),
                          )),
                      ExpansionPanel(
                          canTapOnHeader: true,
                          isExpanded: currentExpansionOpened == 1,
                          headerBuilder: (context, isExpanded) => ListTile(
                                title: Text(
                                    AppLocalizations.of(context).vertical,
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                              ),
                          body: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              ColorField(
                                title: Text(AppLocalizations.of(context).color),
                                value: Color(value.boxYColor),
                                onChanged: (value) => onChanged(this
                                    .value
                                    .copyWith(boxYColor: value.value)),
                              ),
                              const SizedBox(height: 16),
                              ExactSlider(
                                  onChanged: (value) => onChanged(
                                      this.value.copyWith(boxHeight: value)),
                                  header: Text(
                                      AppLocalizations.of(context).width,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                  value: value.boxHeight,
                                  min: 0,
                                  max: 100),
                              const SizedBox(height: 16),
                              ExactSlider(
                                  onChanged: (value) => onChanged(this
                                      .value
                                      .copyWith(boxYCount: value.round())),
                                  header: Text(
                                      AppLocalizations.of(context).count,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                  value: value.boxYCount.toDouble(),
                                  fractionDigits: 0,
                                  min: 0,
                                  max: 100),
                              const SizedBox(height: 16),
                              ExactSlider(
                                  onChanged: (value) => onChanged(
                                      this.value.copyWith(boxYSpace: value)),
                                  header: Text(
                                      AppLocalizations.of(context).space,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                  value: value.boxYSpace,
                                  min: 0,
                                  max: 100),
                            ]),
                          )),
                    ])),
      ],
    );
  }
}
