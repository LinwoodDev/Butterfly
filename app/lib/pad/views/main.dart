import 'dart:convert';

import 'package:butterfly/models/document.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/cubits/transform.dart';
import 'package:butterfly/pad/dialogs/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'toolbar.dart';
import 'view.dart';

class ProjectPage extends StatefulWidget {
  final String? id;

  const ProjectPage({Key? key, required this.id}) : super(key: key);
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  // ignore: closeSinks
  DocumentBloc? _bloc;
  final TextEditingController _scaleController = TextEditingController(text: "100");
  @override
  void initState() {
    super.initState();
    if (widget.id == null) {
      Modular.to.navigate("/");
    }
    SharedPreferences.getInstance().then((value) {
      var index = int.tryParse(widget.id ?? "") ?? 0;
      // TODO: Dynamic api version
      const fileVersion = 0;
      setState(() => _bloc = DocumentBloc(
          AppDocument.fromJson(jsonDecode((value.getStringList("documents") ?? [])[index])),
          index,
          fileVersion));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) return const Center(child: CircularProgressIndicator());
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => _bloc!),
          BlocProvider(create: (context) => TransformCubit())
        ],
        child: Scaffold(
            appBar: AppBar(
                title: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                  if (_bloc!.state is DocumentLoadSuccess) {
                    var current = _bloc!.state as DocumentLoadSuccess;
                    return Text(current.document.name);
                  } else {
                    return Text(AppLocalizations.of(context)!.loading);
                  }
                }),
                actions: [
                  IconButton(
                    icon: const Icon(PhosphorIcons.arrowCounterClockwiseLight),
                    tooltip: AppLocalizations.of(context)!.undo,
                    onPressed: () {
                      _bloc?.undo();
                      var state = _bloc?.state;
                      if (state is DocumentLoadSuccess) state.save();
                    },
                  ),
                  IconButton(
                    icon: const Icon(PhosphorIcons.arrowClockwiseLight),
                    tooltip: AppLocalizations.of(context)!.redo,
                    onPressed: () {
                      _bloc?.redo();
                      var state = _bloc?.state;
                      if (state is DocumentLoadSuccess) state.save();
                    },
                  ),
                  IconButton(
                      icon: const Icon(PhosphorIcons.gearLight),
                      tooltip: AppLocalizations.of(context)!.projectSettings,
                      onPressed: () => _showProjectSettings(context)),
                  /*const IconButton(
                      icon: Icon(PhosphorIcons.linkLight),
                      tooltip: "Share (not implemented)",
                      onPressed: null)*/
                ]),
            body: LayoutBuilder(builder: (context, constraints) {
              var isMobile = constraints.maxWidth < 600;
              var toolbar = SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainViewToolbar(bloc: _bloc!),
                    ],
                  ));
              var _toolScrollController = ScrollController();
              Widget toolsSelection =
                  Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Expanded(
                    child: Scrollbar(
                  controller: _toolScrollController,
                  child: SingleChildScrollView(
                      controller: _toolScrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                          if (_bloc!.state is DocumentLoadSuccess) {
                            var current = _bloc!.state as DocumentLoadSuccess;
                            return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                              IconButton(
                                  icon: Icon(current.editMode
                                      ? PhosphorIcons.penLight
                                      : PhosphorIcons.handLight),
                                  tooltip: current.editMode
                                      ? AppLocalizations.of(context)!.edit
                                      : AppLocalizations.of(context)!.view,
                                  onPressed: () {
                                    _bloc!.add(ToolChanged(!current.editMode));
                                  })
                            ]);
                          }
                          return Container();
                        }),
                        const VerticalDivider(),
                        BlocBuilder<TransformCubit, Matrix4>(builder: (context, transform) {
                          var currentScale = transform.up.y;
                          _scaleController.text = (currentScale * 100).toStringAsFixed(2);
                          void setScale(double scale) {
                            scale = scale.clamp(0.25, 5);
                            scale /= currentScale;
                            setState(() => context
                                .read<TransformCubit>()
                                .emit(Matrix4.copy(transform..scale(scale, scale, scale))));
                          }

                          return Row(
                            children: [
                              IconButton(
                                  icon: const Icon(PhosphorIcons.magnifyingGlassMinusLight),
                                  tooltip: AppLocalizations.of(context)!.zoomOut,
                                  onPressed: () {
                                    setScale(currentScale - 0.05);
                                  }),
                              IconButton(
                                  icon: const Icon(PhosphorIcons.magnifyingGlassLight),
                                  tooltip: AppLocalizations.of(context)!.resetZoom,
                                  onPressed: () {
                                    setScale(1);
                                  }),
                              IconButton(
                                  icon: const Icon(PhosphorIcons.magnifyingGlassPlusLight),
                                  tooltip: AppLocalizations.of(context)!.zoomIn,
                                  onPressed: () {
                                    setScale(currentScale + 0.05);
                                  }),
                              const SizedBox(width: 20),
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 100),
                                child: TextField(
                                  controller: _scaleController,
                                  onSubmitted: (value) {
                                    var scale = double.tryParse(value) ?? 100;
                                    scale /= 100;
                                    setScale(scale);
                                  },
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)!.zoom),
                                ),
                              ),
                              if (!isMobile) const VerticalDivider()
                            ],
                          );
                        }),
                      ])),
                )),
                if (!isMobile) toolbar
              ]);
              return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Container(
                  height: 75,
                  color: Theme.of(context).canvasColor,
                  padding: const EdgeInsets.all(12.0),
                  child: toolsSelection,
                ),
                Expanded(child: MainViewViewport(bloc: _bloc!)),
                if (isMobile) Align(alignment: Alignment.center, child: toolbar)
              ]);
            })));
  }

  void _showProjectSettings(bloc) {
    showDialog(context: context, builder: (context) => PadSettingsDialog(bloc: _bloc));
  }
}
