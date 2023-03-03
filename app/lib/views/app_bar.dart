import 'dart:convert';

import 'package:butterfly/actions/change_path.dart';
import 'package:butterfly/actions/svg_export.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/views/edit.dart';
import 'package:butterfly/visualizer/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../actions/packs.dart';
import '../actions/pdf_export.dart';
import '../actions/save.dart';
import '../actions/settings.dart';
import '../api/full_screen.dart';
import '../bloc/document_bloc.dart';
import '../cubits/transform.dart';
import '../embed/action.dart';
import '../main.dart';
import 'window.dart';

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
      if (!kIsWeb &&
          isWindow() &&
          !context.read<SettingsCubit>().state.nativeWindowTitleBar) {
        windowManager.popUpWindowMenu();
      }
    }, onLongPress: () {
      if (!kIsWeb &&
          isWindow() &&
          !context.read<SettingsCubit>().state.nativeWindowTitleBar) {
        windowManager.popUpWindowMenu();
      }
    }, child: LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = MediaQuery.of(context).size.width < kMobileWidth;
        return AppBar(
            toolbarHeight: _height,
            leading: _MainPopupMenu(
              viewportKey: viewportKey,
            ),
            title: BlocBuilder<CurrentIndexCubit, CurrentIndex>(
                builder: (context, currentIndex) =>
                    BlocBuilder<DocumentBloc, DocumentState>(
                        buildWhen: (previous, current) {
                      if (previous is! DocumentLoadSuccess &&
                          current is DocumentLoadSuccess) {
                        return true;
                      }
                      if (previous is! DocumentLoadSuccess ||
                          current is! DocumentLoadSuccess) {
                        return true;
                      }
                      return previous.currentAreaName !=
                              current.currentAreaName ||
                          previous.hasAutosave() != current.hasAutosave();
                    }, builder: (context, state) {
                      final title = Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child:
                                StatefulBuilder(builder: (context, setState) {
                              final area = state is DocumentLoadSuccess
                                  ? state.currentArea
                                  : null;
                              final areaName = state is DocumentLoadSuccess
                                  ? state.currentAreaName
                                  : null;
                              _nameController.text =
                                  state is DocumentLoadSuccess
                                      ? state.document.name
                                      : '';
                              _areaController.text = area?.name ?? '';
                              Widget title = Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Focus(
                                      onFocusChange: (hasFocus) {
                                        if (hasFocus) {
                                          // Add cursor to end of text
                                          if (area == null) {
                                            _nameController.selection =
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        affinity: TextAffinity
                                                            .downstream,
                                                        offset: _nameController
                                                            .text.length));
                                          } else {
                                            _areaController.selection =
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        affinity: TextAffinity
                                                            .downstream,
                                                        offset: _areaController
                                                            .text.length));
                                          }
                                        }
                                      },
                                      child: TextField(
                                        controller: area == null
                                            ? _nameController
                                            : _areaController,
                                        textAlign: TextAlign.center,
                                        style: area == null
                                            ? Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                            : Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                        onChanged: (value) {
                                          if (area == null ||
                                              areaName == null) {
                                            bloc.add(DocumentDescriptorChanged(
                                                name: value));
                                          } else {
                                            bloc.add(AreaChanged(
                                              areaName,
                                              area.copyWith(name: value),
                                            ));
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: AppLocalizations.of(context)
                                              .untitled,
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          hintStyle: area == null
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                              : Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium,
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    if (currentIndex.location.path != '' &&
                                        area == null)
                                      Text(
                                        ((currentIndex.location.absolute &&
                                                    currentIndex
                                                        .location.path.isEmpty)
                                                ? currentIndex.location.fileType
                                                    ?.getLocalizedName(context)
                                                : currentIndex
                                                    .location.identifier) ??
                                            AppLocalizations.of(context)
                                                .document,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              decoration:
                                                  currentIndex.location.absolute
                                                      ? TextDecoration.underline
                                                      : TextDecoration.none,
                                            ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                  ]);
                              return title;
                            })),
                            if (state is DocumentLoadSuccess) ...[
                              if (!state.hasAutosave())
                                IconButton(
                                  icon: state.saved
                                      ? const Icon(PhosphorIcons.floppyDiskFill)
                                      : const Icon(
                                          PhosphorIcons.floppyDiskLight),
                                  tooltip: AppLocalizations.of(context).save,
                                  onPressed: () {
                                    Actions.maybeInvoke<SaveIntent>(
                                        context, SaveIntent(context));
                                  },
                                ),
                              if (state.location.absolute)
                                IconButton(
                                    icon:
                                        Icon(state.location.fileType.getIcon()),
                                    tooltip:
                                        AppLocalizations.of(context).export,
                                    onPressed: () =>
                                        context.read<ImportService>().export())
                            ],
                            const SizedBox(width: 8),
                            if (!isMobile)
                              const Flexible(
                                  child: EditToolbar(
                                isMobile: false,
                              )),
                          ]);
                      if (!kIsWeb &&
                          isWindow() &&
                          !context
                              .read<SettingsCubit>()
                              .state
                              .nativeWindowTitleBar) {
                        return DragToMoveArea(child: title);
                      }
                      return title;
                    })),
            actions: [
              BlocBuilder<DocumentBloc, DocumentState>(
                builder: (context, state) => Row(
                  children: [
                    if (!kIsWeb && isWindow()) ...[
                      const WindowButtons(
                        divider: true,
                      )
                    ]
                  ],
                ),
              )
            ]);
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

      return MenuAnchor(
        menuChildren: [
          SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                            bloc.bake(
                                viewportSize: size,
                                pixelRatio:
                                    MediaQuery.of(context).devicePixelRatio);
                          }
                        }

                        return Row(
                          children: [
                            IconButton(
                                icon: const Icon(
                                    PhosphorIcons.magnifyingGlassMinusLight),
                                tooltip: AppLocalizations.of(context).zoomOut,
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
                                tooltip: AppLocalizations.of(context).resetZoom,
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
                                tooltip: AppLocalizations.of(context).zoomIn,
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
                                constraints:
                                    const BoxConstraints(minWidth: 100),
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
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.center,
                                      labelText:
                                          AppLocalizations.of(context).zoom),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              )),
          if (state.location.path != '' && state.embedding == null) ...[
            MenuItemButton(
              leadingIcon: const Icon(PhosphorIcons.folderLight),
              shortcut:
                  const SingleActivator(LogicalKeyboardKey.keyS, alt: true),
              onPressed: () {
                Actions.maybeInvoke<ChangePathIntent>(
                    context, ChangePathIntent(context));
              },
              child: Text(AppLocalizations.of(context).changeDocumentPath),
            ),
          ],
          MenuItemButton(
            leadingIcon: const Icon(PhosphorIcons.packageLight),
            shortcut:
                const SingleActivator(LogicalKeyboardKey.keyP, control: true),
            onPressed: () {
              Actions.maybeInvoke<PacksIntent>(context, PacksIntent(context));
            },
            child: Text(AppLocalizations.of(context).packs),
          ),
          const PopupMenuDivider(),
          if (state.embedding == null) ...[
            MenuItemButton(
              leadingIcon: const Icon(PhosphorIcons.filePlusLight),
              shortcut:
                  const SingleActivator(LogicalKeyboardKey.keyN, control: true),
              onPressed: () {
                Actions.maybeInvoke<NewIntent>(context, NewIntent(context));
              },
              child: Text(AppLocalizations.of(context).newContent),
            ),
            MenuItemButton(
              leadingIcon: const Icon(PhosphorIcons.fileLight),
              shortcut: const SingleActivator(LogicalKeyboardKey.keyN,
                  shift: true, control: true),
              onPressed: () {
                Actions.maybeInvoke<NewIntent>(
                    context, NewIntent(context, fromTemplate: true));
              },
              child: Text(AppLocalizations.of(context).templates),
            ),
            MenuItemButton(
              leadingIcon: const Icon(PhosphorIcons.folderOpenLight),
              shortcut:
                  const SingleActivator(LogicalKeyboardKey.keyO, control: true),
              onPressed: () {
                Actions.maybeInvoke<OpenIntent>(context, OpenIntent(context));
              },
              child: Text(AppLocalizations.of(context).open),
            ),
            SubmenuButton(
              leadingIcon: const Icon(PhosphorIcons.folderNotchOpenLight),
              menuChildren: [
                ...context
                    .read<SettingsCubit>()
                    .state
                    .history
                    .map((location) => MenuItemButton(
                          onPressed: () {
                            final lastLocation = state.location;
                            if (lastLocation == location) {
                              return;
                            }
                            if (location.remote != '') {
                              final uri = Uri(pathSegments: [
                                '',
                                'remote',
                                Uri.encodeComponent(location.remote),
                                ...location.pathWithoutLeadingSlash
                                    .split('/')
                                    .map((e) => Uri.encodeComponent(e)),
                              ]).toString();

                              GoRouter.of(context).push(uri);
                              return;
                            }
                            GoRouter.of(context).push(Uri(
                              pathSegments: [
                                '',
                                'local',
                                ...location.pathWithoutLeadingSlash
                                    .split('/')
                                    .map((e) => Uri.encodeComponent(e)),
                              ],
                            ).toString());
                          },
                          child: Text(location.identifier),
                        )),
              ],
              child: Text(AppLocalizations.of(context).recentFiles),
            ),
            MenuItemButton(
              leadingIcon: const Icon(PhosphorIcons.arrowSquareInLight),
              shortcut:
                  const SingleActivator(LogicalKeyboardKey.keyI, control: true),
              onPressed: () {
                Actions.maybeInvoke<ImportIntent>(
                    context, ImportIntent(context));
              },
              child: Text(AppLocalizations.of(context).import),
            ),
            SubmenuButton(
              menuChildren: [
                MenuItemButton(
                  leadingIcon: const Icon(PhosphorIcons.sunLight),
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyE,
                      alt: true, control: true),
                  onPressed: () async {
                    Actions.maybeInvoke<SvgExportIntent>(
                        context, SvgExportIntent(context));
                  },
                  child: Text(AppLocalizations.of(context).svg),
                ),
                MenuItemButton(
                  leadingIcon: const Icon(PhosphorIcons.databaseLight),
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.keyE,
                    control: true,
                  ),
                  onPressed: () async {
                    Actions.maybeInvoke<ExportIntent>(
                        context, ExportIntent(context));
                  },
                  child: Text(AppLocalizations.of(context).data),
                ),
                MenuItemButton(
                  leadingIcon: const Icon(PhosphorIcons.imageLight),
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.keyE,
                    shift: true,
                    control: true,
                  ),
                  onPressed: () {
                    Actions.maybeInvoke<ImageExportIntent>(
                        context, ImageExportIntent(context));
                  },
                  child: Text(AppLocalizations.of(context).image),
                ),
                MenuItemButton(
                  leadingIcon: const Icon(PhosphorIcons.filePdfLight),
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.keyE,
                    shift: true,
                    alt: true,
                    control: true,
                  ),
                  onPressed: () {
                    Actions.maybeInvoke<PdfExportIntent>(
                        context, PdfExportIntent(context));
                  },
                  child: Text(AppLocalizations.of(context).pdf),
                ),
              ],
              leadingIcon: const Icon(PhosphorIcons.exportLight),
              child: Text(AppLocalizations.of(context).export),
            ),
          ],
          const Divider(),
          if (state.embedding == null && (kIsWeb || !isWindow())) ...[
            MenuItemButton(
              leadingIcon: const Icon(PhosphorIcons.arrowsOutLight),
              shortcut: const SingleActivator(LogicalKeyboardKey.f11),
              onPressed: () async {
                setFullScreen(!(await isFullScreen()));
              },
              child: Text(AppLocalizations.of(context).fullScreen),
            ),
          ],
          if (state.embedding == null) ...[
            MenuItemButton(
              leadingIcon: const Icon(PhosphorIcons.gearLight),
              shortcut: const SingleActivator(LogicalKeyboardKey.keyS,
                  alt: true, control: true),
              onPressed: () {
                Actions.maybeInvoke<SettingsIntent>(
                    context, SettingsIntent(context));
              },
              child: Text(AppLocalizations.of(context).settings),
            ),
          ] else ...[
            MenuItemButton(
              leadingIcon: const Icon(PhosphorIcons.doorLight),
              child: Text(AppLocalizations.of(context).exit),
              onPressed: () {
                sendEmbedMessage(
                    'exit',
                    json.encode(
                        const DocumentJsonConverter().toJson(state.document)));
              },
            ),
          ],
        ],
        style: MenuStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        builder:
            (BuildContext context, MenuController controller, Widget? child) =>
                IconButton(
          icon: Image.asset(
            'images/logo.png',
          ),
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
        ),
      );
    });
  }
}
