import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';

import 'package:butterfly/actions/shortcuts.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/input.dart';
import 'package:butterfly/main.dart';
import 'package:butterfly/repositories/document_state.dart';
import 'package:butterfly/services/logger.dart';
import 'package:butterfly/settings/data.dart';
import 'package:butterfly/theme.dart';
import 'package:butterfly/visualizer/connection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:go_router/go_router.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart' show DateFormat;
import 'package:keybinder/keybinder.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:settings_leap/settings_leap.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

part 'pages/behaviors/home.dart';
part 'pages/behaviors/persistence.dart';
part 'pages/connections.dart';
part 'pages/data.dart';
part 'pages/experiments.dart';
part 'pages/general.dart';
part 'pages/inputs.dart';
part 'pages/logs.dart';
part 'pages/personalization.dart';
part 'pages/view.dart';

final settingsTree = SettingsLeapTree<ButterflySettings>({
  'general': _generalSettingsPage,
  'data': _dataSettingsPage,
  'behaviors': _behaviorsSettingsPage,
  'inputs': _inputsSettingsPage,
  'personalization': _personalizationSettingsPage,
  'view': _viewSettingsPage,
  'connections': _connectionsSettingsPage,
  'experiments': _experimentsSettingsPage,
  'logs': _logsSettingsPage,
});

class SettingsPage extends StatelessWidget {
  final bool inView;
  const SettingsPage({super.key, this.inView = false});

  @override
  Widget build(BuildContext context) {
    final child = BlocBuilder<SettingsCubit, ButterflySettings>(
      builder: (context, state) => SettingsLeapView<ButterflySettings>(
        tree: settingsTree,
        state: state,
        title: (context) => AppLocalizations.of(context).settings,
        searchHint: (context) => AppLocalizations.of(context).search,
        isDialog: inView,
        compactWidth: LeapBreakpoints.compact,
        onOpenPage: (context, id, page, focusedId) {
          context.go('/settings/${id.replaceAll('.', '/')}', extra: focusedId);
        },
        closeButton: IconButton.outlined(
          icon: const PhosphorIcon(PhosphorIconsLight.x),
          onPressed: () => Navigator.of(context).maybePop(),
          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
        ),
      ),
    );

    if (inView) return child;

    return Scaffold(
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        title: Text(AppLocalizations.of(context).settings),
        inView: inView,
      ),
      body: child,
    );
  }
}

class SettingsDetailsPage extends StatelessWidget {
  final String id;
  final String? focusedId;
  final bool inView;

  const SettingsDetailsPage({
    super.key,
    required this.id,
    this.focusedId,
    this.inView = false,
  });

  @override
  Widget build(BuildContext context) {
    // Search whole tree for page with id
    SettingsLeapPage<ButterflySettings>? findPage(
      Map<String, SettingsLeapPage<ButterflySettings>> tree,
      String id,
    ) {
      for (final entry in tree.entries) {
        if (entry.key == id) return entry.value;
        final page = findPage(entry.value.children, id);
        if (page != null) return page;
      }
      return null;
    }

    final page = settingsTree.pageById(id) ?? findPage(settingsTree.pages, id);
    if (page == null) {
      return Scaffold(
        appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
          title: Text(AppLocalizations.of(context).settings),
          inView: inView,
        ),
        body: Center(child: Text(AppLocalizations.of(context).error)),
      );
    }
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      builder: (context, state) => SettingsLeapGeneratedPage<ButterflySettings>(
        page: page,
        pageId: id,
        focusedId: focusedId,
        state: state,
        inView: inView,
        cardMargin: settingsCardMargin,
        cardPadding: settingsCardPadding,
        sectionTitlePadding: settingsCardTitlePadding,
      ),
    );
  }
}

PreferredSizeWidget _butterflyAppBar(
  BuildContext context,
  ButterflySettings state,
  bool inView,
  Widget title,
  List<Widget>? actions,
) => WindowTitleBar<SettingsCubit, ButterflySettings>(
  title: title,
  backgroundColor: inView ? Colors.transparent : null,
  inView: inView,
  actions: actions ?? const [],
);
