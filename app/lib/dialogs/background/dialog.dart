import 'package:butterfly/api/open_help.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/models/backgrounds/box.dart';
import 'package:butterfly/widgets/exact_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../color_pick.dart';

class BackgroundDialog extends StatelessWidget {
  const BackgroundDialog({Key? key}) : super(key: key);

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

              return Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
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
                  body: Padding(
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
                                    message: template.getLocalizedName(context),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
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
                                                          : Colors.transparent),
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
                                    message: template.getLocalizedName(context),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
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
                                                          : Colors.transparent),
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
                                const Divider(),
                                if (background is BoxBackground) ...[
                                  ListTile(
                                      onTap: () async {
                                        var value = await showDialog(
                                            context: context,
                                            builder: (_) => BlocProvider.value(
                                                  value: BlocProvider.of<
                                                      DocumentBloc>(context),
                                                  child: ColorPickerDialog(
                                                      defaultColor:
                                                          background!.boxColor),
                                                ));
                                        if (value != null) {
                                          setState(() => background =
                                              background!.copyWith(
                                                  boxColor: value as Color));
                                        }
                                      },
                                      leading: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: background!.boxColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(32))),
                                      ),
                                      title: Text(
                                          AppLocalizations.of(context)!.color)),
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
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .horizontal,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6),
                                                  ],
                                                ),
                                            body: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(children: [
                                                ListTile(
                                                    leading: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: background!
                                                              .boxXColor,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          32))),
                                                    ),
                                                    onTap: () async {
                                                      var value =
                                                          await showDialog(
                                                              context: context,
                                                              builder: (ctx) =>
                                                                  BlocProvider
                                                                      .value(
                                                                    value: BlocProvider.of<
                                                                            DocumentBloc>(
                                                                        context),
                                                                    child: ColorPickerDialog(
                                                                        defaultColor:
                                                                            background!.boxXColor),
                                                                  ));
                                                      if (value != null) {
                                                        setState(() => background =
                                                            background!.copyWith(
                                                                boxXColor: value
                                                                    as Color));
                                                      }
                                                    },
                                                    title: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .color)),
                                                const SizedBox(height: 16),
                                                ExactSlider(
                                                    onChanged: (value) {
                                                      background =
                                                          background?.copyWith(
                                                              boxWidth: value);
                                                    },
                                                    header: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .width,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge),
                                                    value: background!.boxWidth,
                                                    min: 0,
                                                    max: 100),
                                                const SizedBox(height: 16),
                                                ExactSlider(
                                                    onChanged: (value) =>
                                                        background = background
                                                            ?.copyWith(
                                                                boxXCount: value
                                                                    .round()),
                                                    header: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .count,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge),
                                                    value: background!.boxXCount
                                                        .toDouble(),
                                                    fractionDigits: 0,
                                                    min: 0,
                                                    max: 100),
                                                const SizedBox(height: 16),
                                                ExactSlider(
                                                    onChanged: (value) =>
                                                        background = background
                                                            ?.copyWith(
                                                                boxXSpace:
                                                                    value),
                                                    header: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .space,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge),
                                                    value:
                                                        background!.boxXSpace,
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
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .vertical,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6),
                                                  ],
                                                ),
                                            body: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(children: [
                                                ListTile(
                                                    leading: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: background!
                                                              .boxYColor,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          32))),
                                                    ),
                                                    onTap: () async {
                                                      var value =
                                                          await showDialog(
                                                              context: context,
                                                              builder: (ctx) =>
                                                                  BlocProvider
                                                                      .value(
                                                                    value: BlocProvider.of<
                                                                            DocumentBloc>(
                                                                        context),
                                                                    child: ColorPickerDialog(
                                                                        defaultColor:
                                                                            background!.boxYColor),
                                                                  ));
                                                      if (value != null) {
                                                        setState(() => background =
                                                            background!.copyWith(
                                                                boxYColor: value
                                                                    as Color));
                                                      }
                                                    },
                                                    title: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .color)),
                                                const SizedBox(height: 16),
                                                ExactSlider(
                                                    onChanged: (value) {
                                                      background =
                                                          background?.copyWith(
                                                              boxHeight: value);
                                                    },
                                                    header: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .width,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge),
                                                    value:
                                                        background!.boxHeight,
                                                    min: 0,
                                                    max: 100),
                                                const SizedBox(height: 16),
                                                ExactSlider(
                                                    onChanged: (value) =>
                                                        background = background
                                                            ?.copyWith(
                                                                boxYCount: value
                                                                    .round()),
                                                    header: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .count,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge),
                                                    value: background!.boxYCount
                                                        .toDouble(),
                                                    fractionDigits: 0,
                                                    min: 0,
                                                    max: 100),
                                                const SizedBox(height: 16),
                                                ExactSlider(
                                                    onChanged: (value) =>
                                                        background = background
                                                            ?.copyWith(
                                                                boxYSpace:
                                                                    value),
                                                    header: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .space,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge),
                                                    value:
                                                        background!.boxYSpace,
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
                                child:
                                    Text(AppLocalizations.of(context)!.cancel),
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
                  ));
            })));
  }
}
