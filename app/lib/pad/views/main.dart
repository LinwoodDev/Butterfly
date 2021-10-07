import 'dart:convert';

import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/tool.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
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
  // ignore: close_sinks
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
      setState(() => _bloc = DocumentBloc(
          AppDocument.fromJson(jsonDecode((value.getStringList("documents") ?? [])[index])),
          index));
    });
  }

  @override
  Widget build(BuildContext context) {
    var tools = ToolType.values;
    if (_bloc == null) return const Center(child: CircularProgressIndicator());
    return DefaultTabController(
        length: tools.length,
        initialIndex: 1,
        child: BlocProvider(
            create: (_) => _bloc!,
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
                  Widget toolsSelection = Row(
                      mainAxisAlignment:
                          isMobile ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                          if (_bloc!.state is DocumentLoadSuccess) {
                            var current = _bloc!.state as DocumentLoadSuccess;
                            var currentScale = current.transform?.up.y ?? 1;
                            _scaleController.text = (currentScale * 100).toStringAsFixed(2);
                            void setScale(double scale) {
                              scale /= currentScale;
                              setState(() => _bloc!.add(TransformChanged(
                                  Matrix4.copy(current.transform ?? Matrix4.identity()
                                    ..scale(scale, scale, 1)))));
                            }

                            return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child:
                                    Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                                  ...tools.map((e) {
                                    IconData activeIcon, icon;
                                    switch (e) {
                                      case ToolType.view:
                                        icon = PhosphorIcons.handLight;
                                        activeIcon = PhosphorIcons.handFill;
                                        break;
                                      case ToolType.edit:
                                        icon = PhosphorIcons.penLight;
                                        activeIcon = PhosphorIcons.penFill;
                                        break;
                                    }
                                    return IconButton(
                                      icon: Icon(current.currentTool == e ? activeIcon : icon,
                                          size: 26),
                                      color: current.currentTool == e
                                          ? Theme.of(context).colorScheme.primary
                                          : null,
                                      tooltip: e.toString(),
                                      onPressed: () {
                                        _bloc!.add(ToolChanged(e));
                                      },
                                    );
                                  }).toList(),
                                  const VerticalDivider(),
                                  IconButton(
                                      icon: const Icon(PhosphorIcons.magnifyingGlassPlusLight),
                                      tooltip: AppLocalizations.of(context)!.zoomIn,
                                      onPressed: () {
                                        setScale(currentScale + 0.05);
                                      }),
                                  IconButton(
                                      icon: const Icon(PhosphorIcons.magnifyingGlassLight),
                                      tooltip: AppLocalizations.of(context)!.resetZoom,
                                      onPressed: () {
                                        setScale(1);
                                      }),
                                  IconButton(
                                      icon: const Icon(PhosphorIcons.magnifyingGlassMinusLight),
                                      tooltip: AppLocalizations.of(context)!.zoomOut,
                                      onPressed: () {
                                        setScale(currentScale - 0.05);
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
                                ]));
                          } else {
                            return Container();
                          }
                        }),
                        if (!isMobile) Flexible(child: toolbar)
                      ]);
                  if (isMobile) {
                    toolsSelection = SingleChildScrollView(
                        scrollDirection: Axis.horizontal, child: toolsSelection);
                  }
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
                }))));
  }

  void _showProjectSettings(bloc) {
    showDialog(context: context, builder: (context) => PadSettingsDialog(bloc: _bloc));
  }
}
