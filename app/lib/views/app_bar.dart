import 'dart:math';

import 'package:butterfly/actions/background.dart';
import 'package:butterfly/actions/change_path.dart';
import 'package:butterfly/actions/settings.dart';
import 'package:butterfly/actions/svg_export.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/collaboration/dialog.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/services/network.dart';
import 'package:butterfly/views/edit.dart';
import 'package:butterfly/visualizer/asset.dart';
import 'package:butterfly/widgets/search.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:networker/networker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../actions/export.dart';
import '../actions/image_export.dart';
import '../actions/new.dart';
import '../actions/packs.dart';
import '../actions/pdf_export.dart';
import '../actions/save.dart';
import '../bloc/document_bloc.dart';
import '../cubits/settings.dart';
import '../embed/action.dart';
import 'navigator/view.dart';

class PadAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey viewportKey;
  final ToolbarSize size;
  final bool showTools;
  final SearchController searchController;
  final EdgeInsets? padding;
  final bool inView;

  PadAppBar({
    super.key,
    required this.viewportKey,
    required this.size,
    required this.searchController,
    this.showTools = true,
    this.inView = false,
    this.padding,
  });

  late final windowTitleBar = _buildWindowTitleBar(padding);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(child: windowTitleBar);
  }

  WindowTitleBar _buildWindowTitleBar(EdgeInsets? padding) =>
      WindowTitleBar<SettingsCubit, ButterflySettings>(
        leadingWidth: 60,
        height: max(70, showTools ? size.size + 20 : 0),
        titleIgnorePointer: false,
        inView: inView,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isLarge =
                  MediaQuery.of(context).size.width < LeapBreakpoints.expanded;
              return _MainPopupMenu(
                viewportKey: viewportKey,
                isLarge: isLarge,
                padding: padding,
              );
            },
          ),
        ),
        title: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile =
                MediaQuery.of(context).size.width < LeapBreakpoints.compact;
            return _AppBarTitle(
              isMobile: isMobile,
              searchController: searchController,
            );
          },
        ),
      );

  @override
  Size get preferredSize => windowTitleBar.preferredSize;
}

class _AppBarTitle extends StatefulWidget {
  final SearchController searchController;

  const _AppBarTitle({required this.isMobile, required this.searchController});

  final bool isMobile;

  @override
  State<_AppBarTitle> createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<_AppBarTitle> {
  final TextEditingController _nameController = TextEditingController(),
      _areaController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _areaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
      buildWhen: (previous, current) =>
          previous.location != current.location ||
          previous.saved != current.saved ||
          previous.isCreating != current.isCreating ||
          previous.isSaveDelayed != current.isSaveDelayed,
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
              return previous.currentAreaName != current.currentAreaName ||
                  previous.hasAutosave() != current.hasAutosave() ||
                  previous.metadata != current.metadata ||
                  previous.networkingService.isActive !=
                      current.networkingService.isActive;
            },
            builder: (context, state) {
              final area = state is DocumentLoadSuccess
                  ? state.currentArea
                  : null;
              final areaName = state is DocumentLoadSuccess
                  ? state.currentAreaName
                  : null;
              if (state is DocumentLoaded &&
                  state.metadata.name != _nameController.text) {
                _nameController.text = state.metadata.name;
              }
              _areaController.text = area?.name ?? '';
              return BlocBuilder<SettingsCubit, ButterflySettings>(
                buildWhen: (previous, current) =>
                    previous.flags != current.flags ||
                    previous.showSaveButton != current.showSaveButton,
                builder: (context, settings) => LayoutBuilder(
                  builder: (context, constraints) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: min(300.0, constraints.maxWidth - 16),
                        ),
                        child: _buildAppBar(
                          state,
                          area,
                          areaName,
                          bloc,
                          currentIndex,
                          context,
                          settings,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (!widget.isMobile)
                        Flexible(
                          child: BlocBuilder<SettingsCubit, ButterflySettings>(
                            buildWhen: (previous, current) =>
                                previous.toolbarPosition !=
                                    current.toolbarPosition ||
                                previous.toolbarRows != current.toolbarRows,
                            builder: (context, settings) => Stack(
                              children: [
                                const WindowFreeSpace<
                                  SettingsCubit,
                                  ButterflySettings
                                >(),
                                settings.isInline
                                    ? const Align(
                                        alignment: Alignment.centerRight,
                                        child: EditToolbar(isMobile: false),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }

  Widget _buildAppBar(
    DocumentState state,
    Area? area,
    String? areaName,
    DocumentBloc bloc,
    CurrentIndex currentIndex,
    BuildContext context,
    ButterflySettings settings,
  ) => Row(
    children: [
      Flexible(
        child: StreamBuilder<NetworkState?>(
          stream: state.networkingService?.stream,
          builder: (context, snapshot) {
            return StatefulBuilder(
              builder: (context, setState) {
                String toFilePath(String name) {
                  if (state is! DocumentLoaded) return name;
                  final location = state.location;
                  return state.fileSystem
                      .buildDocumentSystem(settings.getRemote(location.remote))
                      .convertNameToFileSystem(
                        name: name,
                        suffix: '.bfly',
                        directory: location.parent,
                      );
                }

                Future<void> submit(String? value) async {
                  value ??= area == null
                      ? _nameController.text
                      : _areaController.text;
                  if (area == null || areaName == null) {
                    final cubit = context.read<CurrentIndexCubit>();
                    final fileSystem = context.read<ButterflyFileSystem>();
                    final location = cubit.state.location;
                    final documentSystem = fileSystem.buildDocumentSystem(
                      settings.getRemote(location.remote),
                    );
                    if (!location.isEmpty) {
                      await documentSystem.deleteAsset(location.path);
                      await fileSystem.settingsCubit.removeRecentHistory(
                        location,
                      );
                    }
                    if (state is DocumentLoadSuccess &&
                        currentIndex.isCreating) {
                      await state.save(
                        location: location.copyWith(path: toFilePath(value)),
                        force: true,
                      );
                    }
                    bloc.add(DocumentDescriptionChanged(name: value));
                  } else {
                    bloc.add(AreaChanged(areaName, area.copyWith(name: value)));
                  }
                }

                Widget title = Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Focus(
                      child: TextFormField(
                        controller: area == null
                            ? _nameController
                            : _areaController,
                        onFieldSubmitted: submit,
                        onSaved: submit,
                        readOnly: state.embedding?.editable == false,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: AppLocalizations.of(context).untitled,
                        ),
                      ),
                    ),
                    if (snapshot.data?.connection is NetworkerClient) ...[
                      Text(
                        AppLocalizations.of(context).collaboration,
                        style: TextTheme.of(context).bodySmall,
                      ),
                    ] else
                      ListenableBuilder(
                        listenable: _nameController,
                        builder: (context, child) {
                          final currentNameFilePath = toFilePath(
                            _nameController.text,
                          );
                          var showCurrentNameFilePath =
                              currentIndex.isCreating &&
                              currentNameFilePath != currentIndex.location.path;
                          if (currentIndex.location.isEmpty && area == null) {
                            return SizedBox();
                          }
                          return Tooltip(
                            message: currentIndex.location.identifier,
                            child: Text(
                              showCurrentNameFilePath
                                  ? currentNameFilePath
                                  : ((currentIndex.absolute &&
                                                currentIndex
                                                    .location
                                                    .path
                                                    .isEmpty)
                                            ? currentIndex.location.fileType
                                                  ?.getLocalizedName(context)
                                            : currentIndex
                                                  .location
                                                  .pathWithoutLeadingSlash) ??
                                        AppLocalizations.of(context).document,
                              style: TextTheme.of(context).bodySmall?.copyWith(
                                fontStyle: showCurrentNameFilePath
                                    ? FontStyle.italic
                                    : FontStyle.normal,
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                );
                return title;
              },
            );
          },
        ),
      ),
      const SizedBox(width: 8),
      if (state is DocumentLoadSuccess) ...[
        if ((!state.hasAutosave() || settings.showSaveButton) &&
            state.embedding?.save != false)
          SizedBox(
            width: 42,
            child: Builder(
              builder: (context) {
                Widget icon = PhosphorIcon(switch (currentIndex.saved) {
                  SaveState.saving => PhosphorIconsLight.download,
                  _ when currentIndex.isSaveDelayed => PhosphorIconsLight.clock,
                  SaveState.saved => PhosphorIconsFill.floppyDisk,
                  SaveState.unsaved ||
                  SaveState.absoluteRead => PhosphorIconsLight.floppyDisk,
                });
                String tooltip = switch (currentIndex.saved) {
                  SaveState.saving => AppLocalizations.of(context).saving,
                  _ when currentIndex.isSaveDelayed => AppLocalizations.of(
                    context,
                  ).saveDelayed,
                  SaveState.saved => AppLocalizations.of(context).saved,
                  SaveState.unsaved => AppLocalizations.of(context).unsaved,
                  SaveState.absoluteRead => AppLocalizations.of(
                    context,
                  ).readOnly,
                };
                return IconButton(
                  icon: icon,
                  tooltip: tooltip,
                  onPressed: () {
                    Actions.maybeInvoke<SaveIntent>(
                      context,
                      SaveIntent(context),
                    );
                  },
                );
              },
            ),
          ),
        if (state.currentAreaName.isNotEmpty)
          IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.signOut),
            tooltip: AppLocalizations.of(context).exitArea,
            onPressed: () {
              context.read<DocumentBloc>().add(const CurrentAreaChanged(''));
            },
          ),
        if (state.absolute)
          IconButton(
            icon: PhosphorIcon(
              state.location.fileType.icon(PhosphorIconsStyle.light),
            ),
            tooltip: AppLocalizations.of(context).export,
            onPressed: () => context.read<ImportService>().export(),
          ),
        SearchButton(controller: widget.searchController),
        if (state.location.path != '' && state.embedding == null) ...[
          IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.folder),
            onPressed: () {
              Actions.maybeInvoke<ChangePathIntent>(
                context,
                ChangePathIntent(context),
              );
            },
            tooltip: AppLocalizations.of(context).changeDocumentPath,
          ),
        ],
      ],
    ],
  );
}

class _MainPopupMenu extends StatelessWidget {
  final GlobalKey viewportKey;
  final bool isLarge;
  final EdgeInsets? padding;

  const _MainPopupMenu({
    required this.viewportKey,
    required this.isLarge,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CurrentIndexCubit>();
    final windowCubit = context.read<WindowCubit>();
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      buildWhen: (previous, current) =>
          previous.navigationRail != current.navigationRail ||
          previous.flags != current.flags,
      builder: (context, settings) {
        final state = context.read<CurrentIndexCubit>().state;
        final size = MediaQuery.sizeOf(context);
        final currentX =
            (context.findRenderObject() as RenderBox?)
                ?.localToGlobal(Offset.zero)
                .dx ??
            0;
        return MenuAnchor(
          menuChildren: [
            if (state.embedding == null) ...[
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.house),
                child: Text(AppLocalizations.of(context).home),
                onPressed: () async {
                  final router = GoRouter.of(context);
                  final bloc = context.read<DocumentBloc>();
                  await bloc.save();
                  if (router.canPop()) {
                    router.pop();
                  } else {
                    router.go('/');
                  }
                },
              ),
              if (MediaQuery.of(context).size.width <
                      LeapBreakpoints.expanded ||
                  !settings.navigationRail)
                ...NavigatorPage.values.map(
                  (e) => MenuItemButton(
                    leadingIcon: PhosphorIcon(e.icon(PhosphorIconsStyle.light)),
                    child: Text(e.getLocalizedName(context)),
                    onPressed: () {
                      cubit.setNavigatorPage(e);
                      final bloc = context.read<DocumentBloc>();
                      final transformCubit = context.read<TransformCubit>();
                      showDialog(
                        context: context,
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(value: bloc),
                            BlocProvider.value(value: cubit),
                            BlocProvider.value(value: transformCubit),
                          ],
                          child: DocumentNavigator(asDialog: true),
                        ),
                      );
                    },
                  ),
                ),
              const Divider(),
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.image),
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyB,
                  control: true,
                ),
                onPressed: () {
                  Actions.maybeInvoke<BackgroundIntent>(
                    context,
                    BackgroundIntent(context),
                  );
                },
                child: Text(AppLocalizations.of(context).background),
              ),
              SubmenuButton(
                menuChildren: [
                  MenuItemButton(
                    leadingIcon: const PhosphorIcon(PhosphorIconsLight.archive),
                    shortcut: const SingleActivator(
                      LogicalKeyboardKey.keyE,
                      control: true,
                    ),
                    onPressed: () async {
                      Actions.maybeInvoke<ExportIntent>(
                        context,
                        ExportIntent(context),
                      );
                    },
                    child: Text(AppLocalizations.of(context).packagedFile),
                  ),
                  MenuItemButton(
                    leadingIcon: const PhosphorIcon(PhosphorIconsLight.file),
                    shortcut: const SingleActivator(
                      LogicalKeyboardKey.keyE,
                      control: true,
                      shift: true,
                    ),
                    onPressed: () async {
                      Actions.maybeInvoke<ExportIntent>(
                        context,
                        ExportIntent(context, isText: true),
                      );
                    },
                    child: Text(AppLocalizations.of(context).rawFile),
                  ),
                  MenuItemButton(
                    leadingIcon: const PhosphorIcon(PhosphorIconsLight.fileSvg),
                    shortcut: const SingleActivator(
                      LogicalKeyboardKey.keyE,
                      alt: true,
                      control: true,
                    ),
                    onPressed: () async {
                      Actions.maybeInvoke<SvgExportIntent>(
                        context,
                        SvgExportIntent(context),
                      );
                    },
                    child: Text(AppLocalizations.of(context).svg),
                  ),
                  MenuItemButton(
                    leadingIcon: const PhosphorIcon(
                      PhosphorIconsLight.fileImage,
                    ),
                    shortcut: const SingleActivator(
                      LogicalKeyboardKey.keyE,
                      alt: true,
                      control: true,
                      shift: true,
                    ),
                    onPressed: () {
                      Actions.maybeInvoke<ImageExportIntent>(
                        context,
                        ImageExportIntent(context),
                      );
                    },
                    child: Text(AppLocalizations.of(context).image),
                  ),
                  MenuItemButton(
                    leadingIcon: const PhosphorIcon(PhosphorIconsLight.filePdf),
                    shortcut: const SingleActivator(
                      LogicalKeyboardKey.keyP,
                      shift: true,
                      control: true,
                    ),
                    onPressed: () {
                      Actions.maybeInvoke<PdfExportIntent>(
                        context,
                        PdfExportIntent(context),
                      );
                    },
                    child: Text(AppLocalizations.of(context).pdf),
                  ),
                  MenuItemButton(
                    leadingIcon: const PhosphorIcon(PhosphorIconsLight.printer),
                    shortcut: const SingleActivator(
                      LogicalKeyboardKey.keyP,
                      control: true,
                    ),
                    onPressed: () {
                      Actions.maybeInvoke<PdfExportIntent>(
                        context,
                        PdfExportIntent(context, true),
                      );
                    },
                    child: Text(AppLocalizations.of(context).print),
                  ),
                  /*MenuItemButton(
                      leadingIcon: const PhosphorIcon(PhosphorIconsLight.notebook),
                      onPressed: () => exportXopp(context),
                      child: const Text('Xournal++'),
                    ),*/
                ],
                leadingIcon: const PhosphorIcon(
                  PhosphorIconsLight.paperPlaneRight,
                ),
                child: Text(AppLocalizations.of(context).export),
              ),
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.package),
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyP,
                  control: true,
                  alt: true,
                ),
                onPressed: () {
                  Actions.maybeInvoke<PacksIntent>(
                    context,
                    PacksIntent(context),
                  );
                },
                child: Text(AppLocalizations.of(context).packs),
              ),
              const Divider(),
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.filePlus),
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyN,
                  control: true,
                ),
                onPressed: () {
                  Actions.maybeInvoke<NewIntent>(context, NewIntent(context));
                },
                child: Text(AppLocalizations.of(context).newContent),
              ),
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.file),
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyN,
                  shift: true,
                  control: true,
                ),
                onPressed: () {
                  Actions.maybeInvoke<NewIntent>(
                    context,
                    NewIntent(context, fromTemplate: true),
                  );
                },
                child: Text(AppLocalizations.of(context).templates),
              ),
              SubmenuButton(
                menuChildren: settings.history
                    .map(
                      (e) => MenuItemButton(
                        child: Text(e.identifier),
                        onPressed: () => openFile(context, true, e),
                      ),
                    )
                    .toList(),
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.clock),
                child: Text(AppLocalizations.of(context).recentFiles),
              ),
            ],
            if (state.embedding == null) ...[
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.gear),
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyS,
                  alt: true,
                  control: true,
                ),
                onPressed: () => openSettings(context),
                child: Text(AppLocalizations.of(context).settings),
              ),
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.eyeSlash),
                shortcut: const SingleActivator(LogicalKeyboardKey.f12),
                onPressed: () {
                  context.read<CurrentIndexCubit>().enterTouchHideUI();
                },
                child: Text(AppLocalizations.of(context).hideUI),
              ),
              BlocBuilder<WindowCubit, WindowState>(
                buildWhen: (previous, current) =>
                    previous.fullScreen != current.fullScreen,
                builder: (context, windowState) => MenuItemButton(
                  leadingIcon: windowState.fullScreen
                      ? const PhosphorIcon(PhosphorIconsLight.arrowsIn)
                      : const PhosphorIcon(PhosphorIconsLight.arrowsOut),
                  shortcut: const SingleActivator(LogicalKeyboardKey.f11),
                  onPressed: () async {
                    windowCubit.toggleFullScreen();
                  },
                  child: Text(LeapLocalizations.of(context).fullScreen),
                ),
              ),
            ],
            if (state.embedding == null && settings.hasFlag('collaboration'))
              BlocBuilder<NetworkingService, NetworkState?>(
                bloc: state.networkingService,
                builder: (_, state) {
                  final isOpen = state?.connection.isOpen ?? false;
                  return MenuItemButton(
                    leadingIcon: isOpen
                        ? Icon(
                            PhosphorIconsFill.users,
                            color: ColorScheme.of(context).primary,
                          )
                        : Icon(PhosphorIconsLight.users),
                    onPressed: () => showCollaborationDialog(context),
                    child: Text(
                      AppLocalizations.of(context).collaboration,
                      style: TextStyle(
                        color: isOpen ? ColorScheme.of(context).primary : null,
                      ),
                    ),
                  );
                },
              ),
            if (state.embedding?.onOpen != null) ...[
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.folder),
                onPressed: state.embedding?.onOpen,
                child: Text(AppLocalizations.of(context).open),
              ),
            ],
            if (state.embedding != null) ...[
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.door),
                child: Text(AppLocalizations.of(context).exit),
                onPressed: () {
                  final embedding = state.embedding!;
                  if (embedding.isInternal) {
                    embedding.onExit?.call();
                    return;
                  }
                  sendEmbedMessage(
                    'exit',
                    context.read<DocumentBloc>().state.saveBytes(),
                  );
                },
              ),
            ],
          ],
          style: MenuStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            maximumSize: WidgetStateProperty.all(
              Size(
                min(size.width - 32, 300),
                size.height - 70 - (padding?.bottom ?? 0) * 1.5 - currentX * 2,
              ),
            ),
          ),
          builder: (context, controller, child) => Align(
            child: AspectRatio(
              aspectRatio: 1,
              child: IconButton(
                icon: Image.asset('images/logo.png'),
                style: IconButton.styleFrom(
                  backgroundColor: controller.isOpen
                      ? ColorScheme.of(context).surfaceContainerHighest
                      : null,
                ),
                tooltip: AppLocalizations.of(context).actions,
                onPressed: controller.toggle,
              ),
            ),
          ),
        );
      },
    );
  }
}
