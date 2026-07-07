import 'package:butterfly/actions/next_page.dart';
import 'package:butterfly/actions/previous_page.dart';
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
import 'package:butterfly/actions/toggle_presentation.dart';
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
export 'package:butterfly/actions/next_page.dart';
export 'package:butterfly/actions/packs.dart';
export 'package:butterfly/actions/paste.dart';
export 'package:butterfly/actions/pdf_export.dart';
export 'package:butterfly/actions/previous.dart';
export 'package:butterfly/actions/previous_page.dart';
export 'package:butterfly/actions/redo.dart';
export 'package:butterfly/actions/save.dart';
export 'package:butterfly/actions/select.dart';
export 'package:butterfly/actions/settings.dart';
export 'package:butterfly/actions/svg_export.dart';
export 'package:butterfly/actions/toggle_presentation.dart';
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
    final loc = AppLocalizations.of(context);

    return switch (this) {
      newShortcut => loc.newNote,
      newFromTemplateShortcut => loc.newFromTemplateShortcut,
      exportShortcut => loc.export,
      exportTextShortcut => loc.exportAsTextShortcut,
      imageExportShortcut => loc.exportAsImageShortcut,
      pdfExportShortcut => loc.exportAsPdfShortcut,
      svgExportShortcut => loc.exportAsSvgShortcut,
      packsShortcut => loc.packs,
      settingsShortcut => loc.settings,
      exitShortcut => loc.exit,
      searchShortcut => loc.search,
      undoShortcut => loc.undo,
      redoShortcut => loc.redo,
      backgroundShortcut => loc.background,
      saveShortcut => loc.save,
      changePathShortcut => loc.changePathShortcut,
      zoomInShortcut => loc.zoomIn,
      zoomOutShortcut => loc.zoomOut,
      fullScreenShortcut => loc.fullScreenShortcut,
      hideUIShortcut => loc.hideUI,
      nextShortcut => loc.nextSlide,
      previousShortcut => loc.previousSlide,
      nextPageShortcut => loc.nextPage,
      previousPageShortcut => loc.previousPage,
      togglePresentationShortcut => loc.pausePresentation,
      selectAllShortcut => loc.selectAll,
      pasteShortcut => loc.paste,
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
    nextPageShortcut,
    previousPageShortcut,
    togglePresentationShortcut,
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
