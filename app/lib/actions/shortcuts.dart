import 'package:keybinder/keybinder.dart';
import 'package:butterfly/actions/background.dart';
import 'package:butterfly/actions/change_path.dart';
import 'package:butterfly/actions/change_tool.dart';
import 'package:butterfly/actions/exit.dart';
import 'package:butterfly/actions/export.dart';
import 'package:butterfly/actions/full_screen.dart';
import 'package:butterfly/actions/hide_ui.dart';
import 'package:butterfly/actions/image_export.dart';
import 'package:butterfly/actions/new.dart';
import 'package:butterfly/actions/next.dart';
import 'package:butterfly/actions/packs.dart';
import 'package:butterfly/actions/paste.dart';
import 'package:butterfly/actions/pdf_export.dart';
import 'package:butterfly/actions/previous.dart';
import 'package:butterfly/actions/redo.dart';
import 'package:butterfly/actions/save.dart';
import 'package:butterfly/actions/select.dart';
import 'package:butterfly/actions/settings.dart';
import 'package:butterfly/actions/svg_export.dart';
import 'package:butterfly/actions/undo.dart';
import 'package:butterfly/actions/zoom.dart';
import 'package:butterfly/widgets/search.dart';
import 'package:butterfly/services/keybinder_store.dart';

export 'package:butterfly/actions/background.dart';
export 'package:butterfly/actions/change_path.dart';
export 'package:butterfly/actions/change_tool.dart';
export 'package:butterfly/actions/exit.dart';
export 'package:butterfly/actions/export.dart';
export 'package:butterfly/actions/full_screen.dart';
export 'package:butterfly/actions/hide_ui.dart';
export 'package:butterfly/actions/image_export.dart';
export 'package:butterfly/actions/new.dart';
export 'package:butterfly/actions/next.dart';
export 'package:butterfly/actions/packs.dart';
export 'package:butterfly/actions/paste.dart';
export 'package:butterfly/actions/pdf_export.dart';
export 'package:butterfly/actions/previous.dart';
export 'package:butterfly/actions/redo.dart';
export 'package:butterfly/actions/save.dart';
export 'package:butterfly/actions/select.dart';
export 'package:butterfly/actions/settings.dart';
export 'package:butterfly/actions/svg_export.dart';
export 'package:butterfly/actions/undo.dart';
export 'package:butterfly/actions/zoom.dart';
export 'package:butterfly/widgets/search.dart';

import 'package:flutter/widgets.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

extension ShortcutDefinitionLocalization on ShortcutDefinition {
  String getLocalizedName(BuildContext context) {
    if (id.startsWith('tool_')) {
      final num = int.tryParse(id.split('_').last);
      if (num != null) {
        return AppLocalizations.of(context).toolNumber(num + 1);
      }
    }

    return switch (this) {
      newShortcut => AppLocalizations.of(context).newNote,
      newFromTemplateShortcut => AppLocalizations.of(
        context,
      ).newFromTemplateShortcut,
      exportShortcut => AppLocalizations.of(context).export,
      exportTextShortcut => AppLocalizations.of(context).exportAsTextShortcut,
      imageExportShortcut => AppLocalizations.of(context).exportAsImageShortcut,
      pdfExportShortcut => AppLocalizations.of(context).exportAsPdfShortcut,
      svgExportShortcut => AppLocalizations.of(context).exportAsSvgShortcut,
      packsShortcut => AppLocalizations.of(context).packs,
      settingsShortcut => AppLocalizations.of(context).settings,
      exitShortcut => AppLocalizations.of(context).exit,
      searchShortcut => AppLocalizations.of(context).search,
      undoShortcut => AppLocalizations.of(context).undo,
      redoShortcut => AppLocalizations.of(context).redo,
      backgroundShortcut => AppLocalizations.of(context).background,
      saveShortcut => AppLocalizations.of(context).save,
      changePathShortcut => AppLocalizations.of(context).changePathShortcut,
      zoomInShortcut => AppLocalizations.of(context).zoomIn,
      zoomOutShortcut => AppLocalizations.of(context).zoomOut,
      fullScreenShortcut => AppLocalizations.of(context).fullScreenShortcut,
      hideUIShortcut => AppLocalizations.of(context).hideUI,
      nextShortcut => AppLocalizations.of(context).nextSlide,
      previousShortcut => AppLocalizations.of(context).previousSlide,
      selectAllShortcut => AppLocalizations.of(context).selectAll,
      pasteShortcut => AppLocalizations.of(context).paste,
      _ => id,
    };
  }
}

final keybinder = Keybinder(
  store: SharedPreferencesKeybinderStore(),
  definitions: [
    undoShortcut,
    redoShortcut,
    newShortcut,
    newFromTemplateShortcut,
    backgroundShortcut,
    exitShortcut,
    fullScreenShortcut,
    hideUIShortcut,
    nextShortcut,
    previousShortcut,
    selectAllShortcut,
    searchShortcut,
    exportShortcut,
    exportTextShortcut,
    imageExportShortcut,
    pdfExportShortcut,
    svgExportShortcut,
    settingsShortcut,
    changePathShortcut,
    saveShortcut,
    packsShortcut,
    zoomInShortcut,
    zoomOutShortcut,
    pasteShortcut,
    ...changeToolShortcuts,
  ],
);
