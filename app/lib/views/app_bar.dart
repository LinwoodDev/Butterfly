import 'dart:convert';

import 'package:butterfly/actions/change_path.dart';
import 'package:butterfly/actions/svg_export.dart';
import 'package:butterfly/api/full_screen_stub.dart'
    if (dart.library.io) 'package:butterfly/api/full_screen_io.dart'
    if (dart.library.js) 'package:butterfly/api/full_screen_html.dart';
import 'package:butterfly/api/shortcut_helper.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/edit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:window_manager/window_manager.dart';

import '../actions/export.dart';
import '../actions/image_export.dart';
import '../actions/import.dart';
import '../actions/new.dart';
import '../actions/open.dart';
import '../actions/project.dart';
import '../actions/redo.dart';
import '../actions/save.dart';
import '../actions/settings.dart';
import '../actions/undo.dart';
import '../bloc/document_bloc.dart';
import '../cubits/transform.dart';
import '../embed/action.dart';
import 'main.dart';

class PadAppBar extends StatelessWidget with PreferredSizeWidget {
  static const double _height = 70;
  final GlobalKey viewportKey;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  PadAppBar({super.key, required this.viewportKey});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<DocumentBloc>();
    return GestureDetector(onSecondaryTap: () {
      if (isWindow()) {
        windowManager.popUpWindowMenu();
      }
    }, onLongPress: () {
      if (isWindow()) {
        windowManager.popUpWindowMenu();
      }
    }, child: LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = MediaQuery.of(context).size.width < 800;
        return AppBar(
          toolbarHeight: _height,
          leading: _MainPopupMenu(
            viewportKey: viewportKey,
          ),
          title: BlocBuilder<DocumentBloc, DocumentState>(
              buildWhen: (previous, current) {
            if (current is! DocumentLoadSuccess ||
                previous is! DocumentLoadSuccess) return true;
            return _nameController.text != current.document.name ||
                previous.path != current.path ||
                (current.currentArea != null &&
                    _areaController.text != current.currentArea?.name) ||
                previous.saved != current.saved;
          }, builder: (ctx, state) {
            Widget title;
            if (state is DocumentLoadSuccess) {
              if (_nameController.text != state.document.name) {
                _nameController.text = state.document.name;
              }
              var area = state.currentArea;
              if (_nameController.text != area?.name) {
                _areaController.text = area?.name ?? '';
              }
              title = StatefulBuilder(
                builder: (context, setState) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Focus(
                        onFocusChange: (hasFocus) {
                          if (hasFocus) {
                            // Add cursor to end of text
                            if (area == null) {
                              _nameController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      affinity: TextAffinity.downstream,
                                      offset: _nameController.text.length));
                            } else {
                              _areaController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      affinity: TextAffinity.downstream,
                                      offset: _areaController.text.length));
                            }
                          }
                        },
                        child: TextField(
                          controller:
                              area == null ? _nameController : _areaController,
                          textAlign: TextAlign.center,
                          style: area == null
                              ? Theme.of(context).textTheme.headline6
                              : Theme.of(context).textTheme.headline4,
                          onChanged: (value) {
                            if (area == null) {
                              bloc.add(DocumentDescriptorChanged(name: value));
                            } else {
                              bloc.add(AreaChanged(
                                state.currentAreaIndex,
                                area.copyWith(name: value),
                              ));
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: AppLocalizations.of(context)!.untitled,
                            hintStyle: area == null
                                ? Theme.of(context).textTheme.headline6
                                : Theme.of(context).textTheme.headline4,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (state.path != null && area == null)
                        Text(
                          state.path!,
                          style: Theme.of(ctx).textTheme.caption,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ]),
              );
              if (kIsWeb && (state.embedding?.save ?? true)) {
                title = Row(children: [
                  Expanded(child: title),
                  IconButton(
                    icon: state.saved
                        ? const Icon(PhosphorIcons.floppyDiskFill)
                        : const Icon(PhosphorIcons.floppyDiskLight),
                    tooltip: AppLocalizations.of(context)!.save,
                    onPressed: () {
                      Actions.maybeInvoke<SaveIntent>(
                          context, SaveIntent(context));
                    },
                  ),
                  const SizedBox(width: 8),
                ]);
              }
            } else {
              title = Text(AppLocalizations.of(ctx)!.loading);
            }
            title = Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: title),
                if (!isMobile)
                  Flexible(
                      child: EditToolbar(
                    isMobile: false,
                  )),
              ],
            );
            if (isWindow()) {
              title = DragToMoveArea(
                child: title,
              );
            }
            return SizedBox(height: _height, child: title);
          }),
          actions: [
            if (isWindow()) ...[const VerticalDivider(), const WindowButtons()]
          ],
        );
      },
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(_height);
}

class _MainPopupMenu extends StatelessWidget {
  final TextEditingController _scaleController =
      TextEditingController(text: '100');
  final GlobalKey viewportKey;

  _MainPopupMenu({required this.viewportKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      if (state is! DocumentLoadSuccess) return const SizedBox();
      final bloc = context.read<DocumentBloc>();
      final transformCubit = context.read<TransformCubit>();

      return PopupMenuButton(
        icon: Image.asset(
          'images/logo.png',
        ),
        iconSize: 36,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        itemBuilder: (context) => <PopupMenuEntry>[
          PopupMenuItem(
            enabled: false,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: IconTheme(
              data: Theme.of(context).iconTheme,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(PhosphorIcons.arrowCounterClockwiseLight),
                    tooltip: AppLocalizations.of(context)!.undo,
                    onPressed: !bloc.canUndo
                        ? null
                        : () {
                            Actions.maybeInvoke<UndoIntent>(
                                context, UndoIntent(context));
                          },
                  ),
                  IconButton(
                    icon: const Icon(PhosphorIcons.arrowClockwiseLight),
                    tooltip: AppLocalizations.of(context)!.redo,
                    onPressed: !bloc.canRedo
                        ? null
                        : () {
                            Actions.maybeInvoke<RedoIntent>(
                                context, RedoIntent(context));
                          },
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem(
              enabled: false,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: IconTheme(
                data: Theme.of(context).iconTheme,
                child: BlocBuilder<TransformCubit, CameraTransform>(
                    bloc: transformCubit,
                    builder: (context, transform) {
                      _scaleController.text =
                          (transform.size * 100).toStringAsFixed(0);
                      const zoomConstant = 1 + 0.1;
                      void bake() {
                        var size = viewportKey.currentContext?.size;
                        if (size != null) {
                          bloc.add(ImageBaked(
                              viewportSize: size,
                              cameraTransform: transform,
                              pixelRatio:
                                  MediaQuery.of(context).devicePixelRatio));
                        }
                      }

                      return Row(
                        children: [
                          IconButton(
                              icon: const Icon(
                                  PhosphorIcons.magnifyingGlassMinusLight),
                              tooltip: AppLocalizations.of(context)!.zoomOut,
                              onPressed: () {
                                var viewportSize =
                                    viewportKey.currentContext?.size ??
                                        MediaQuery.of(context).size;
                                transformCubit.zoom(
                                    1 / zoomConstant,
                                    Offset(viewportSize.width / 2,
                                        viewportSize.height / 2));
                                bake();
                              }),
                          IconButton(
                              icon: const Icon(
                                  PhosphorIcons.magnifyingGlassLight),
                              tooltip: AppLocalizations.of(context)!.resetZoom,
                              onPressed: () {
                                var viewportSize =
                                    viewportKey.currentContext?.size ??
                                        MediaQuery.of(context).size;
                                transformCubit.size(
                                    1,
                                    Offset(viewportSize.width / 2,
                                        viewportSize.height / 2));
                                bake();
                              }),
                          IconButton(
                              icon: const Icon(
                                  PhosphorIcons.magnifyingGlassPlusLight),
                              tooltip: AppLocalizations.of(context)!.zoomIn,
                              onPressed: () {
                                var viewportSize =
                                    viewportKey.currentContext?.size ??
                                        MediaQuery.of(context).size;
                                transformCubit.zoom(
                                    zoomConstant,
                                    Offset(viewportSize.width / 2,
                                        viewportSize.height / 2));
                                bake();
                              }),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 100),
                              child: TextField(
                                controller: _scaleController,
                                onSubmitted: (value) {
                                  var viewportSize =
                                      viewportKey.currentContext?.size ??
                                          MediaQuery.of(context).size;
                                  var scale = double.tryParse(value) ?? 100;
                                  scale /= 100;
                                  transformCubit.size(
                                      scale,
                                      Offset(viewportSize.width / 2,
                                          viewportSize.height / 2));
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    filled: true,
                                    labelText:
                                        AppLocalizations.of(context)!.zoom),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              )),
          if (state.path != null && state.embedding == null) ...[
            PopupMenuItem(
              padding: EdgeInsets.zero,
              child: ListTile(
                leading: const Icon(PhosphorIcons.folderLight),
                title: Text(AppLocalizations.of(context)!.changeDocumentPath),
                subtitle: Text(
                    context.getShortcut('S', ctrlKey: false, altKey: true)),
                onTap: () {
                  Navigator.of(context).pop();
                  Actions.maybeInvoke<ChangePathIntent>(
                      context, ChangePathIntent(context));
                },
              ),
            ),
            const PopupMenuDivider(),
          ],
          if (state.embedding == null) ...[
            PopupMenuItem(
                padding: EdgeInsets.zero,
                child: ListTile(
                  leading: const Icon(PhosphorIcons.filePlusLight),
                  title: Text(AppLocalizations.of(context)!.newContent),
                  subtitle: Text(context.getShortcut('N')),
                  onTap: () {
                    Navigator.of(context).pop();
                    Actions.maybeInvoke<NewIntent>(context, NewIntent(context));
                  },
                )),
            PopupMenuItem(
                padding: EdgeInsets.zero,
                child: ListTile(
                  leading: const Icon(PhosphorIcons.fileLight),
                  title: Text(AppLocalizations.of(context)!.templates),
                  subtitle: Text(context.getShortcut('N', shiftKey: true)),
                  onTap: () {
                    Navigator.of(context).pop();
                    Actions.maybeInvoke<NewIntent>(
                        context, NewIntent(context, fromTemplate: true));
                  },
                )),
            PopupMenuItem(
              padding: EdgeInsets.zero,
              child: ListTile(
                  leading: const Icon(PhosphorIcons.folderOpenLight),
                  title: Text(AppLocalizations.of(context)!.open),
                  subtitle: Text(context.getShortcut('O')),
                  trailing: PopupMenuButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    offset: const Offset(60, 0),
                    icon: const Icon(PhosphorIcons.caretRightLight),
                    itemBuilder: (context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        child: Text(AppLocalizations.of(context)!.back),
                      ),
                      const PopupMenuDivider(),
                      ...context
                          .read<SettingsCubit>()
                          .state
                          .recentHistory
                          .map((path) => PopupMenuItem(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  GoRouter.of(context)
                                      .pushNamed('home', queryParams: {
                                    'path': path,
                                  });
                                },
                                child: Text(path),
                              )),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Actions.maybeInvoke<OpenIntent>(
                        context, OpenIntent(context));
                  }),
            ),
            PopupMenuItem(
                padding: EdgeInsets.zero,
                child: ListTile(
                  leading: const Icon(PhosphorIcons.arrowSquareInLight),
                  title: Text(AppLocalizations.of(context)!.import),
                  subtitle: Text(context.getShortcut('I')),
                  onTap: () {
                    Navigator.of(context).pop();
                    Actions.maybeInvoke<ImportIntent>(
                        context, ImportIntent(context));
                  },
                )),
            PopupMenuItem(
                padding: EdgeInsets.zero,
                child: PopupMenuButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    offset: const Offset(285, 0),
                    itemBuilder: (popupContext) => <PopupMenuEntry>[
                          PopupMenuItem(
                              padding: EdgeInsets.zero,
                              child: ListTile(
                                  leading:
                                      const Icon(PhosphorIcons.caretLeftLight),
                                  title:
                                      Text(AppLocalizations.of(context)!.back),
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                  })),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                              padding: EdgeInsets.zero,
                              child: ListTile(
                                  leading: const Icon(PhosphorIcons.sunLight),
                                  title:
                                      Text(AppLocalizations.of(context)!.svg),
                                  subtitle: Text(
                                      context.getShortcut('E', altKey: true)),
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Actions.maybeInvoke<SvgExportIntent>(
                                        context, SvgExportIntent(context));
                                  })),
                          PopupMenuItem(
                              padding: EdgeInsets.zero,
                              child: ListTile(
                                  leading:
                                      const Icon(PhosphorIcons.databaseLight),
                                  title:
                                      Text(AppLocalizations.of(context)!.data),
                                  subtitle: Text(context.getShortcut('E')),
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Actions.maybeInvoke<ExportIntent>(
                                        context, ExportIntent(context));
                                  })),
                          PopupMenuItem(
                              padding: EdgeInsets.zero,
                              child: ListTile(
                                  leading: const Icon(PhosphorIcons.imageLight),
                                  title:
                                      Text(AppLocalizations.of(context)!.image),
                                  subtitle: Text(
                                      context.getShortcut('E', shiftKey: true)),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Actions.maybeInvoke<ImageExportIntent>(
                                        context, ImageExportIntent(context));
                                  })),
                        ],
                    tooltip: '',
                    child: ListTile(
                        mouseCursor: MouseCursor.defer,
                        leading: const Icon(PhosphorIcons.exportLight),
                        trailing: const Icon(PhosphorIcons.caretRightLight),
                        title: Text(AppLocalizations.of(context)!.export)))),
          ],
          PopupMenuItem(
              padding: EdgeInsets.zero,
              child: ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Actions.maybeInvoke<ProjectIntent>(
                        context, ProjectIntent(context));
                  },
                  subtitle: Text(
                      context.getShortcut('S', shiftKey: true, altKey: true)),
                  leading: const Icon(PhosphorIcons.wrenchLight),
                  title: Text(AppLocalizations.of(context)!.projectSettings))),
          const PopupMenuDivider(),
          if (state.embedding == null && (kIsWeb || !isWindow())) ...[
            PopupMenuItem(
                padding: EdgeInsets.zero,
                child: ListTile(
                    leading: const Icon(PhosphorIcons.arrowsOutLight),
                    title: Text(AppLocalizations.of(context)!.fullScreen),
                    subtitle: Text(context.getShortcut('F11', ctrlKey: false)),
                    onTap: () async {
                      Navigator.of(context).pop();
                      setFullScreen(!(await isFullScreen()));
                    })),
          ],
          if (state.embedding == null) ...[
            PopupMenuItem(
                padding: EdgeInsets.zero,
                child: ListTile(
                    leading: const Icon(PhosphorIcons.gearLight),
                    title: Text(AppLocalizations.of(context)!.settings),
                    subtitle: Text(context.getShortcut('S', altKey: true)),
                    onTap: () {
                      Navigator.of(context).pop();
                      Actions.maybeInvoke<SettingsIntent>(
                          context, SettingsIntent(context));
                    })),
          ],
          if (state.embedding != null)
            PopupMenuItem(
                padding: EdgeInsets.zero,
                child: ListTile(
                    leading: const Icon(PhosphorIcons.doorLight),
                    title: Text(AppLocalizations.of(context)!.exit),
                    onTap: () {
                      Navigator.of(context).pop();
                      sendEmbedMessage(
                          'exit', json.encode(state.document.toJson()));
                    })),
        ],
      );
    });
  }
}
