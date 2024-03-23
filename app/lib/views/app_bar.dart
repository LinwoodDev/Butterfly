import 'dart:math';

import 'package:butterfly/actions/change_path.dart';
import 'package:butterfly/actions/search.dart';
import 'package:butterfly/actions/settings.dart';
import 'package:butterfly/actions/svg_export.dart';
import 'package:butterfly/api/file_system/file_system.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/dialogs/collaboration/dialog.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/services/network.dart';
import 'package:butterfly/views/edit.dart';
import 'package:butterfly/visualizer/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
import '../main.dart';
import '../widgets/window.dart';
import 'navigator/view.dart';

class PadAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey viewportKey;
  final ToolbarSize size;

  PadAppBar({super.key, required this.viewportKey, required this.size});

  late final windowTitleBar = _buildWindowTitleBar();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(child: windowTitleBar);
  }

  WindowTitleBar _buildWindowTitleBar() => WindowTitleBar(
        leadingWidth: 60,
        height: max(70, size.size + 20),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: LayoutBuilder(builder: (context, constraints) {
            final isLarge = MediaQuery.of(context).size.width < kLargeWidth;
            return _MainPopupMenu(
              viewportKey: viewportKey,
              isLarge: isLarge,
            );
          }),
        ),
        title: LayoutBuilder(builder: (context, constraints) {
          final isMobile = MediaQuery.of(context).size.width < kMobileWidth;
          return _AppBarTitle(
            isMobile: isMobile,
          );
        }),
      );

  @override
  Size get preferredSize => windowTitleBar.preferredSize;
}

class _AppBarTitle extends StatelessWidget {
  _AppBarTitle({
    required this.isMobile,
  });

  final TextEditingController _nameController = TextEditingController(),
      _areaController = TextEditingController();
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    return BlocBuilder<CurrentIndexCubit, CurrentIndex>(
      buildWhen: (previous, current) =>
          previous.location != current.location ||
          previous.saved != current.saved,
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
      }, builder: (context, state) {
        final area = state is DocumentLoadSuccess ? state.currentArea : null;
        final areaName =
            state is DocumentLoadSuccess ? state.currentAreaName : null;
        if (state is DocumentLoaded &&
            state.metadata.name != _nameController.text) {
          _nameController.text = state.metadata.name;
        }
        _areaController.text = area?.name ?? '';
        return BlocBuilder<SettingsCubit, ButterflySettings>(
          buildWhen: (previous, current) => previous.flags != current.flags,
          builder: (context, settings) => LayoutBuilder(
            builder: (context, constraints) =>
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: min(300.0, constraints.maxWidth - 16)),
                child: Row(
                  children: [
                    Flexible(
                      child: StreamBuilder<NetworkingState?>(
                          stream: state.networkingService?.stream,
                          builder: (context, snapshot) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              Future<void> submit(String? value) async {
                                if (value == null) return;
                                if (area == null || areaName == null) {
                                  final cubit =
                                      context.read<CurrentIndexCubit>();
                                  final settings =
                                      context.read<SettingsCubit>().state;
                                  final location = cubit.state.location;
                                  final fileSystem =
                                      DocumentFileSystem.fromPlatform(
                                          remote: settings
                                              .getRemote(location.remote));

                                  await fileSystem.deleteAsset(location.path);
                                  if (state is DocumentLoadSuccess) {
                                    await state.save(location.copyWith(
                                      path:
                                          '${location.parent}/${fileSystem.convertNameToFile(value)}.bfly',
                                    ));
                                  }
                                  bloc.add(
                                      DocumentDescriptionChanged(name: value));
                                } else {
                                  bloc.add(AreaChanged(
                                    areaName,
                                    area.copyWith(name: value),
                                  ));
                                }
                              }

                              Widget title = Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Focus(
                                      child: TextFormField(
                                        controller: area == null
                                            ? _nameController
                                            : _areaController,
                                        onFieldSubmitted: submit,
                                        onSaved: submit,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          hintText: AppLocalizations.of(context)
                                              .untitled,
                                        ),
                                      ),
                                    ),
                                    if (snapshot.data?.$1
                                        is NetworkerClient) ...[
                                      Text(
                                        AppLocalizations.of(context)
                                            .collaboration,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ] else if (currentIndex.location.path !=
                                            '' &&
                                        area == null)
                                      Tooltip(
                                        message:
                                            currentIndex.location.identifier,
                                        child: Text(
                                          ((currentIndex.location.absolute &&
                                                      currentIndex.location.path
                                                          .isEmpty)
                                                  ? currentIndex
                                                      .location.fileType
                                                      ?.getLocalizedName(
                                                          context)
                                                  : currentIndex.location
                                                      .pathWithoutLeadingSlash) ??
                                              AppLocalizations.of(context)
                                                  .document,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      )
                                  ]);
                              return title;
                            });
                          }),
                    ),
                    const SizedBox(width: 8),
                    if (state is DocumentLoadSuccess) ...[
                      if (!state.hasAutosave())
                        SizedBox(
                          width: 42,
                          child: Builder(builder: (context) {
                            Widget icon =
                                PhosphorIcon(switch (currentIndex.saved) {
                              SaveState.saved => PhosphorIconsFill.floppyDisk,
                              SaveState.unsaved =>
                                PhosphorIconsLight.floppyDisk,
                              SaveState.saving =>
                                PhosphorIconsDuotone.floppyDisk,
                            });
                            return IconButton(
                              icon: icon,
                              tooltip: AppLocalizations.of(context).save,
                              onPressed: () {
                                Actions.maybeInvoke<SaveIntent>(
                                    context, SaveIntent(context));
                              },
                            );
                          }),
                        ),
                      if (state.currentAreaName.isNotEmpty)
                        IconButton(
                          icon: const PhosphorIcon(PhosphorIconsLight.door),
                          tooltip: AppLocalizations.of(context).exit,
                          onPressed: () {
                            context
                                .read<DocumentBloc>()
                                .add(const CurrentAreaChanged(''));
                          },
                        ),
                      if (state.location.absolute)
                        IconButton(
                            icon: PhosphorIcon(state.location.fileType
                                .icon(PhosphorIconsStyle.light)),
                            tooltip: AppLocalizations.of(context).export,
                            onPressed: () =>
                                context.read<ImportService>().export()),
                      IconButton(
                        icon: const PhosphorIcon(
                            PhosphorIconsLight.magnifyingGlass),
                        tooltip: AppLocalizations.of(context).search,
                        onPressed: () {
                          Actions.maybeInvoke<SearchIntent>(
                              context, SearchIntent(context));
                        },
                      ),
                      if (state.location.path != '' &&
                          state.embedding == null) ...[
                        IconButton(
                          icon: const PhosphorIcon(PhosphorIconsLight.folder),
                          onPressed: () {
                            Actions.maybeInvoke<ChangePathIntent>(
                                context, ChangePathIntent(context));
                          },
                          tooltip:
                              AppLocalizations.of(context).changeDocumentPath,
                        ),
                      ],
                      if (settings.flags.contains('collaboration') && !kIsWeb)
                        StreamBuilder<NetworkingState?>(
                            stream: state.networkingService.stream,
                            builder: (context, snapshot) => IconButton(
                                  icon: const PhosphorIcon(
                                      PhosphorIconsLight.shareNetwork),
                                  onPressed: () =>
                                      showCollaborationDialog(context),
                                  tooltip: AppLocalizations.of(context)
                                      .collaboration,
                                  isSelected: snapshot.data != null,
                                  selectedIcon: PhosphorIcon(
                                    PhosphorIconsFill.shareNetwork,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                )),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (!isMobile)
                Flexible(
                    child: BlocBuilder<SettingsCubit, ButterflySettings>(
                  buildWhen: (previous, current) =>
                      previous.toolbarPosition != current.toolbarPosition,
                  builder: (context, settings) => Stack(
                    children: [
                      const WindowFreeSpace(),
                      settings.toolbarPosition == ToolbarPosition.top
                          ? const Align(
                              alignment: Alignment.centerRight,
                              child: EditToolbar(
                                isMobile: false,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                )),
            ]),
          ),
        );
      }),
    );
  }
}

class _MainPopupMenu extends StatelessWidget {
  final GlobalKey viewportKey;
  final bool isLarge;

  const _MainPopupMenu({required this.viewportKey, required this.isLarge});

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    return BlocBuilder<SettingsCubit, ButterflySettings>(
        buildWhen: (previous, current) =>
            previous.navigationRail != current.navigationRail,
        builder: (context, settings) {
          final state = context.read<CurrentIndexCubit>().state;

          return MenuAnchor(
            menuChildren: [
              if (state.embedding == null) ...[
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.house),
                  child: Text(AppLocalizations.of(context).home),
                  onPressed: () {
                    final router = GoRouter.of(context);
                    if (router.canPop()) {
                      router.pop();
                    } else {
                      router.go('/');
                    }
                  },
                ),
                if (MediaQuery.of(context).size.width < kLargeWidth ||
                    !settings.navigationRail)
                  ...NavigatorPage.values.map(
                    (e) => MenuItemButton(
                      leadingIcon:
                          PhosphorIcon(e.icon(PhosphorIconsStyle.light)),
                      child: Text(e.getLocalizedName(context)),
                      onPressed: () {
                        settingsCubit.setNavigatorPage(e);
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                const Divider(),
                SubmenuButton(
                  menuChildren: [
                    MenuItemButton(
                      leadingIcon: const PhosphorIcon(PhosphorIconsLight.file),
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.keyE,
                        control: true,
                      ),
                      onPressed: () async {
                        Actions.maybeInvoke<ExportIntent>(
                            context, ExportIntent(context));
                      },
                      child: Text(AppLocalizations.of(context).document),
                    ),
                    MenuItemButton(
                      leadingIcon:
                          const PhosphorIcon(PhosphorIconsLight.fileSvg),
                      shortcut: const SingleActivator(LogicalKeyboardKey.keyE,
                          alt: true, control: true),
                      onPressed: () async {
                        Actions.maybeInvoke<SvgExportIntent>(
                            context, SvgExportIntent(context));
                      },
                      child: Text(AppLocalizations.of(context).svg),
                    ),
                    MenuItemButton(
                      leadingIcon:
                          const PhosphorIcon(PhosphorIconsLight.fileImage),
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
                      leadingIcon:
                          const PhosphorIcon(PhosphorIconsLight.filePdf),
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
                    MenuItemButton(
                      leadingIcon:
                          const PhosphorIcon(PhosphorIconsLight.printer),
                      shortcut: const SingleActivator(
                        LogicalKeyboardKey.keyP,
                        control: true,
                      ),
                      onPressed: () {
                        Actions.maybeInvoke<PdfExportIntent>(
                            context, PdfExportIntent(context, true));
                      },
                      child: Text(AppLocalizations.of(context).print),
                    ),
                    /*MenuItemButton(
                      leadingIcon: const PhosphorIcon(PhosphorIconsLight.notebook),
                      onPressed: () => exportXopp(context),
                      child: const Text('Xournal++'),
                    ),*/
                  ],
                  leadingIcon:
                      const PhosphorIcon(PhosphorIconsLight.paperPlaneRight),
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
                        context, PacksIntent(context));
                  },
                  child: Text(AppLocalizations.of(context).packs),
                ),
                const Divider(),
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.filePlus),
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyN,
                      control: true),
                  onPressed: () {
                    Actions.maybeInvoke<NewIntent>(context, NewIntent(context));
                  },
                  child: Text(AppLocalizations.of(context).newContent),
                ),
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.file),
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyN,
                      shift: true, control: true),
                  onPressed: () {
                    Actions.maybeInvoke<NewIntent>(
                        context, NewIntent(context, fromTemplate: true));
                  },
                  child: Text(AppLocalizations.of(context).templates),
                ),
                SubmenuButton(
                  menuChildren: settings.history
                      .map((e) => MenuItemButton(
                            child: Text(e.identifier),
                            onPressed: () => openFile(context, true, e),
                          ))
                      .toList(),
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.clock),
                  child: Text(AppLocalizations.of(context).recentFiles),
                ),
              ],
              if (state.embedding == null) ...[
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.gear),
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyS,
                      alt: true, control: true),
                  onPressed: () => openSettings(context),
                  child: Text(AppLocalizations.of(context).settings),
                ),
              ],
              if (state.embedding == null) ...[
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.eyeSlash),
                  shortcut: const SingleActivator(LogicalKeyboardKey.f12),
                  onPressed: () {
                    context.read<CurrentIndexCubit>().enterTouchHideUI();
                  },
                  child: Text(AppLocalizations.of(context).hideUI),
                ),
                BlocBuilder<SettingsCubit, ButterflySettings>(
                    buildWhen: (previous, current) =>
                        previous.fullScreen != current.fullScreen,
                    builder: (context, settings) => MenuItemButton(
                          leadingIcon: settings.fullScreen
                              ? const PhosphorIcon(PhosphorIconsLight.arrowsIn)
                              : const PhosphorIcon(
                                  PhosphorIconsLight.arrowsOut),
                          shortcut:
                              const SingleActivator(LogicalKeyboardKey.f11),
                          onPressed: () async {
                            settingsCubit.toggleFullScreen();
                          },
                          child: Text(AppLocalizations.of(context).fullScreen),
                        )),
              ],
              if (state.embedding != null) ...[
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.door),
                  child: Text(AppLocalizations.of(context).exit),
                  onPressed: () {
                    sendEmbedMessage(
                        'exit', context.read<DocumentBloc>().state.saveBytes());
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
            builder: (context, controller, child) => Align(
              child: AspectRatio(
                aspectRatio: 1,
                child: IconButton(
                  icon: Image.asset(
                    'images/logo.png',
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: controller.isOpen
                        ? Theme.of(context).colorScheme.surfaceVariant
                        : null,
                  ),
                  tooltip: AppLocalizations.of(context).actions,
                  onPressed: controller.toggle,
                ),
              ),
            ),
          );
        });
  }
}
