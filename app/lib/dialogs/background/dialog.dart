import 'package:butterfly/api/open_help.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/widgets/color_field.dart';
import 'package:butterfly/widgets/exact_slider.dart';
import 'package:butterfly/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/background.dart';

class BackgroundDialog extends StatelessWidget {
  const BackgroundDialog({super.key});

  @override
  Widget build(BuildContext context) {
    int? currentExpansionOpened;
    return Dialog(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
            child: BlocBuilder<DocumentBloc, DocumentState>(
                builder: (context, state) {
              if (state is! DocumentLoadSuccess) return Container();
              var background = state.document.background;

              return Column(
                children: [
                  Header(
                    title: Text(AppLocalizations.of(context)!.background),
                    leading: const Icon(PhosphorIcons.imageLight),
                    actions: [
                      IconButton(
                          tooltip: AppLocalizations.of(context)!.help,
                          icon:
                              const Icon(PhosphorIcons.circleWavyQuestionLight),
                          onPressed: () => openHelp(['background', 'intro'])),
                    ],
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: StatefulBuilder(builder: (context, setState) {
                        return Column(
                          children: [
                            Expanded(
                                child: ListView(
                                    clipBehavior: Clip.antiAlias,
                                    children: [
                                  Wrap(
                                      children: BackgroundTemplate.values
                                          .where((element) => !element.dark)
                                          .map((template) {
                                    var created = template.create();
                                    return Tooltip(
                                      message:
                                          template.getLocalizedName(context),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Material(
                                          child: Ink.image(
                                            width: 100,
                                            height: 100,
                                            image: AssetImage(template.asset),
                                            child: InkWell(
                                              onTap: () {
                                                setState(
                                                    () => background = created);
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 5,
                                                        color: created ==
                                                                background
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .primary
                                                            : Colors
                                                                .transparent),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList()),
                                  const SizedBox(height: 8),
                                  Wrap(
                                      children: BackgroundTemplate.values
                                          .where((element) => element.dark)
                                          .map((template) {
                                    var created = template.create();
                                    return Tooltip(
                                      message:
                                          template.getLocalizedName(context),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Material(
                                          child: Ink.image(
                                            width: 100,
                                            height: 100,
                                            image: AssetImage(template.asset),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              onTap: () {
                                                setState(
                                                    () => background = created);
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 5,
                                                        color: created ==
                                                                background
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .primary
                                                            : Colors
                                                                .transparent),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList()),
                                  if (background is BoxBackground) ...[
                                    const SizedBox(height: 8),
                                    const Divider(),
                                    ColorField(
                                      title: Text(
                                          AppLocalizations.of(context)!.color),
                                      value: Color((background as BoxBackground)
                                          .boxColor),
                                      onChanged: (value) => setState(() =>
                                          background = (background
                                                  as BoxBackground)
                                              .copyWith(boxColor: value.value)),
                                    ),
                                    const SizedBox(height: 16),
                                    ExpansionPanelList(
                                        expansionCallback:
                                            (int item, bool status) {
                                          setState(() {
                                            currentExpansionOpened =
                                                !status ? item : null;
                                          });
                                        },
                                        children: [
                                          ExpansionPanel(
                                              canTapOnHeader: true,
                                              isExpanded:
                                                  currentExpansionOpened == 0,
                                              headerBuilder: (context,
                                                      isExpanded) =>
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .horizontal,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6),
                                                    ],
                                                  ),
                                              body: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(children: [
                                                  ColorField(
                                                    value: Color((background
                                                            as BoxBackground)
                                                        .boxXColor),
                                                    title: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .color),
                                                    onChanged: (value) => setState(() =>
                                                        background = (background
                                                                as BoxBackground)
                                                            .copyWith(
                                                                boxXColor: value
                                                                    .value)),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  ExactSlider(
                                                      onChanged: (value) {
                                                        background = (background
                                                                as BoxBackground)
                                                            .copyWith(
                                                                boxWidth:
                                                                    value);
                                                      },
                                                      header: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .width,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge),
                                                      value: (background
                                                              as BoxBackground)
                                                          .boxWidth,
                                                      min: 0,
                                                      max: 100),
                                                  const SizedBox(height: 16),
                                                  ExactSlider(
                                                      onChanged: (value) =>
                                                          background = (background
                                                                  as BoxBackground)
                                                              .copyWith(
                                                                  boxXCount: value
                                                                      .round()),
                                                      header: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .count,
                                                          style: Theme
                                                                  .of(context)
                                                              .textTheme
                                                              .titleLarge),
                                                      value: (background
                                                              as BoxBackground)
                                                          .boxXCount
                                                          .toDouble(),
                                                      fractionDigits: 0,
                                                      min: 0,
                                                      max: 100),
                                                  const SizedBox(height: 16),
                                                  ExactSlider(
                                                      onChanged: (value) =>
                                                          background = (background
                                                                  as BoxBackground)
                                                              .copyWith(
                                                                  boxXSpace:
                                                                      value),
                                                      header: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .space,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge),
                                                      value: (background
                                                              as BoxBackground)
                                                          .boxXSpace,
                                                      min: 0,
                                                      max: 100),
                                                ]),
                                              )),
                                          ExpansionPanel(
                                              canTapOnHeader: true,
                                              isExpanded:
                                                  currentExpansionOpened == 1,
                                              headerBuilder: (context,
                                                      isExpanded) =>
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .vertical,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6),
                                                    ],
                                                  ),
                                              body: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(children: [
                                                  ColorField(
                                                    title: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .color),
                                                    value: Color((background
                                                            as BoxBackground)
                                                        .boxYColor),
                                                    onChanged: (value) => setState(() =>
                                                        background = (background
                                                                as BoxBackground)
                                                            .copyWith(
                                                                boxYColor: value
                                                                    .value)),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  ExactSlider(
                                                      onChanged: (value) {
                                                        background = (background
                                                                as BoxBackground)
                                                            .copyWith(
                                                                boxHeight:
                                                                    value);
                                                      },
                                                      header: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .width,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge),
                                                      value: (background
                                                              as BoxBackground)
                                                          .boxHeight,
                                                      min: 0,
                                                      max: 100),
                                                  const SizedBox(height: 16),
                                                  ExactSlider(
                                                      onChanged: (value) =>
                                                          background = (background
                                                                  as BoxBackground)
                                                              .copyWith(
                                                                  boxYCount: value
                                                                      .round()),
                                                      header: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .count,
                                                          style: Theme
                                                                  .of(context)
                                                              .textTheme
                                                              .titleLarge),
                                                      value: (background
                                                              as BoxBackground)
                                                          .boxYCount
                                                          .toDouble(),
                                                      fractionDigits: 0,
                                                      min: 0,
                                                      max: 100),
                                                  const SizedBox(height: 16),
                                                  ExactSlider(
                                                      onChanged: (value) =>
                                                          background = (background
                                                                  as BoxBackground)
                                                              .copyWith(
                                                                  boxYSpace:
                                                                      value),
                                                      header: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .space,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge),
                                                      value: (background
                                                              as BoxBackground)
                                                          .boxYSpace,
                                                      min: 0,
                                                      max: 100),
                                                ]),
                                              )),
                                        ]),
                                  ],
                                ])),
                            const Divider(),
                            Row(
                              children: [
                                Expanded(child: Container()),
                                TextButton(
                                  child: Text(
                                      AppLocalizations.of(context)!.cancel),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                ElevatedButton(
                                  child: Text(AppLocalizations.of(context)!.ok),
                                  onPressed: () {
                                    context.read<DocumentBloc>().add(
                                        DocumentBackgroundChanged(background));
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            )
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              );
            })));
  }
}
