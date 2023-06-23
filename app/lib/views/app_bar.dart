import 'dart:math';

import 'package:butterfly/actions/change_path.dart';
import 'package:butterfly/actions/settings.dart';
import 'package:butterfly/actions/svg_export.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/views/edit.dart';
import 'package:butterfly/visualizer/asset.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../actions/export.dart';
import '../actions/image_export.dart';
import '../actions/new.dart';
import '../actions/packs.dart';
import '../actions/pdf_export.dart';
import '../actions/save.dart';
import '../api/full_screen.dart';
import '../bloc/document_bloc.dart';
import '../cubits/settings.dart';
import '../dialogs/search.dart';
import '../embed/action.dart';
import '../main.dart';
import '../widgets/window.dart';

class PadAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey viewportKey;

  PadAppBar({super.key, required this.viewportKey});

  late final windowTitleBar = _buildWindowTitleBar();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(child: windowTitleBar);
  }

  WindowTitleBar _buildWindowTitleBar() => WindowTitleBar(
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: _MainPopupMenu(
            viewportKey: viewportKey,
          ),
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
            previous.metadata != current.metadata;
      }, builder: (context, state) {
        final area = state is DocumentLoadSuccess ? state.currentArea : null;
        final areaName =
            state is DocumentLoadSuccess ? state.currentAreaName : null;
        if (state is DocumentLoaded &&
            state.metadata.name != _nameController.text) {
          _nameController.text = state.metadata.name;
        }
        _areaController.text = area?.name ?? '';
        return LayoutBuilder(
          builder: (context, constraints) =>
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: min(350.0, constraints.maxWidth - 16)),
              child: Row(
                children: [
                  Flexible(
                    child: StatefulBuilder(builder: (context, setState) {
                      void submit(String? value) {
                        if (value == null) return;
                        if (area == null || areaName == null) {
                          bloc.add(DocumentDescriptorChanged(name: value));
                        } else {
                          bloc.add(AreaChanged(
                            areaName,
                            area.copyWith(name: value),
                          ));
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
                                decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  hintText:
                                      AppLocalizations.of(context).untitled,
                                ),
                              ),
                            ),
                            if (currentIndex.location.path != '' &&
                                area == null)
                              Tooltip(
                                message: currentIndex.location.identifier,
                                child: Text(
                                  ((currentIndex.location.absolute &&
                                              currentIndex
                                                  .location.path.isEmpty)
                                          ? currentIndex.location.fileType
                                              ?.getLocalizedName(context)
                                          : currentIndex.location
                                              .pathWithoutLeadingSlash) ??
                                      AppLocalizations.of(context).document,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              )
                          ]);
                      return title;
                    }),
                  ),
                  if (state is DocumentLoadSuccess) ...[
                    if (!state.hasAutosave())
                      SizedBox(
                        width: 42,
                        child: Builder(builder: (context) {
                          Widget icon;
                          switch (currentIndex.saved) {
                            case SaveState.saved:
                              icon = const Icon(PhosphorIconsFill.floppyDisk);
                              break;
                            case SaveState.unsaved:
                              icon = const Icon(PhosphorIconsLight.floppyDisk);
                              break;
                            case SaveState.saving:
                              icon = const CircularProgressIndicator();
                              break;
                          }
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
                              .add(const CurrentAreaChanged.exit());
                        },
                      ),
                    if (state.location.absolute)
                      IconButton(
                          icon: PhosphorIcon(state.location.fileType.getIcon()),
                          tooltip: AppLocalizations.of(context).export,
                          onPressed: () =>
                              context.read<ImportService>().export()),
                    IconButton(
                      icon: const PhosphorIcon(
                          PhosphorIconsLight.magnifyingGlass),
                      tooltip: AppLocalizations.of(context).search,
                      onPressed: () {
                        final bloc = context.read<DocumentBloc>();
                        showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                            value: bloc,
                            child: const SearchDialog(),
                          ),
                        );
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
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (!isMobile)
              const Flexible(
                  child: EditToolbar(
                isMobile: false,
              )),
          ]),
        );
      }),
    );
  }
}

class _MainPopupMenu extends StatelessWidget {
  final GlobalKey viewportKey;

  const _MainPopupMenu({required this.viewportKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      if (state is! DocumentLoadSuccess) return const SizedBox();

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
            MenuItemButton(
              leadingIcon: const PhosphorIcon(PhosphorIconsLight.compass),
              child: Text(AppLocalizations.of(context).navigator),
              onPressed: () {
                if (MediaQuery.of(context).size.width >= kLargeWidth) {
                  final settingsCubit = context.read<SettingsCubit>();
                  settingsCubit.changeNavigatorEnabled(
                      !settingsCubit.state.navigatorEnabled);
                } else {
                  Scaffold.of(context).openDrawer();
                }
              },
            ),
            const Divider(),
            SubmenuButton(
              menuChildren: [
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.sun),
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyE,
                      alt: true, control: true),
                  onPressed: () async {
                    Actions.maybeInvoke<SvgExportIntent>(
                        context, SvgExportIntent(context));
                  },
                  child: Text(AppLocalizations.of(context).svg),
                ),
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.database),
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
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.image),
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
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.filePdf),
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
              leadingIcon:
                  const PhosphorIcon(PhosphorIconsLight.paperPlaneRight),
              child: Text(AppLocalizations.of(context).export),
            ),
            MenuItemButton(
              leadingIcon: const PhosphorIcon(PhosphorIconsLight.package),
              shortcut:
                  const SingleActivator(LogicalKeyboardKey.keyP, control: true),
              onPressed: () {
                Actions.maybeInvoke<PacksIntent>(context, PacksIntent(context));
              },
              child: Text(AppLocalizations.of(context).packs),
            ),
            const PopupMenuDivider(),
            MenuItemButton(
              leadingIcon: const PhosphorIcon(PhosphorIconsLight.filePlus),
              shortcut:
                  const SingleActivator(LogicalKeyboardKey.keyN, control: true),
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
          if (state.embedding == null && (kIsWeb || !isWindow)) ...[
            MenuItemButton(
              leadingIcon: const PhosphorIcon(PhosphorIconsLight.arrowsOut),
              shortcut: const SingleActivator(LogicalKeyboardKey.f11),
              onPressed: () async {
                setFullScreen(!(await isFullScreen()));
              },
              child: Text(AppLocalizations.of(context).fullScreen),
            ),
          ],
          if (state.embedding != null) ...[
            MenuItemButton(
              leadingIcon: const PhosphorIcon(PhosphorIconsLight.door),
              child: Text(AppLocalizations.of(context).exit),
              onPressed: () {
                sendEmbedMessage('exit', state.saveData().save());
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
                Align(
          child: AspectRatio(
            aspectRatio: 1,
            child: IconButton(
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
          ),
        ),
      );
    });
  }
}
