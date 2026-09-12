// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:butterfly/visualizer/element.dart';
import 'package:butterfly/visualizer/icon.dart';
import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension ToolCategoryVisualizer on ToolCategory {
  PhosphorIconData icon({bool filled = false}) => switch (this) {
    .normal =>
      filled ? PhosphorIconsFill.paintBrush : PhosphorIconsLight.paintBrush,
    .import =>
      filled
          ? PhosphorIconsFill.arrowSquareIn
          : PhosphorIconsLight.arrowSquareIn,
    .surface => filled ? PhosphorIconsFill.monitor : PhosphorIconsLight.monitor,
    .action => filled ? PhosphorIconsFill.play : PhosphorIconsLight.play,
    .view => filled ? PhosphorIconsFill.eye : PhosphorIconsLight.eye,
  };

  String getLocalizedName(BuildContext context) => switch (this) {
    .normal => AppLocalizations.of(context).normal,
    .import => AppLocalizations.of(context).import,
    .surface => AppLocalizations.of(context).surface,
    .action => AppLocalizations.of(context).action,
    .view => AppLocalizations.of(context).view,
  };
}

extension BarcodeTypeVisualizer on BarcodeType {
  String getLocalizedName(BuildContext context) => switch (this) {
    .qrCode => AppLocalizations.of(context).qrCode,
    .dataMatrix => AppLocalizations.of(context).dataMatrix,
    .code128 => AppLocalizations.of(context).code128,
  };

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    .qrCode => filled ? PhosphorIconsFill.qrCode : PhosphorIconsLight.qrCode,
    .dataMatrix => filled ? PhosphorIconsFill.scan : PhosphorIconsLight.scan,
    .code128 => filled ? PhosphorIconsFill.barcode : PhosphorIconsLight.barcode,
  };
}

extension SelectModeVisualizer on SelectMode {
  String getLocalizedName(BuildContext context) => switch (this) {
    .rectangle => AppLocalizations.of(context).rectangle,
    .lasso => AppLocalizations.of(context).lasso,
  };

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    .rectangle =>
      filled ? PhosphorIconsFill.selection : PhosphorIconsLight.selection,
    .lasso => filled ? PhosphorIconsFill.lasso : PhosphorIconsLight.lasso,
  };
}

extension EraserModeVisualizer on EraserMode {
  String getLocalizedName(BuildContext context) => switch (this) {
    .stroke => AppLocalizations.of(context).stroke,
    .path => AppLocalizations.of(context).path,
  };

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    .stroke => filled ? PhosphorIconsFill.eraser : PhosphorIconsLight.eraser,
    .path => filled ? PhosphorIconsFill.path : PhosphorIconsLight.path,
  };
}

extension Axis2DVisualizer on Axis2D {
  String getLocalizedName(BuildContext context) => switch (this) {
    .horizontal => AppLocalizations.of(context).horizontal,
    .vertical => AppLocalizations.of(context).vertical,
  };

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    .horizontal =>
      filled
          ? PhosphorIconsFill.splitHorizontal
          : PhosphorIconsLight.splitHorizontal,
    .vertical =>
      filled
          ? PhosphorIconsFill.splitVertical
          : PhosphorIconsLight.splitVertical,
  };
}

extension ToolVisualizer on Tool {
  String getDisplay(BuildContext context) {
    if (name.trim().isEmpty) return getLocalizedName(context);
    return name;
  }

  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return switch (this) {
      HandTool() => loc.hand,
      SelectTool() => loc.select,
      ImportTool() => loc.import,
      UndoTool() => loc.undo,
      RedoTool() => loc.redo,
      LabelTool() => loc.label,
      PenTool() => loc.pen,
      EraserTool() => loc.eraser,
      CollectionTool() => loc.collection,
      AreaTool() => loc.area,
      LaserTool() => loc.laser,
      ShapeTool() => loc.shape,
      TableTool() => loc.table,
      SpacerTool() => loc.spacer,
      StampTool() => loc.stamp,
      TextureTool() => loc.texture,
      PresentationTool() => loc.presentation,
      FullScreenTool() => LeapLocalizations.of(context).fullScreen,
      AssetTool e => e.importType.getLocalizedName(context),
      EyeDropperTool() => loc.eyeDropper,
      ExportTool() => loc.export,
      GridTool() => loc.grid,
      RulerTool() => loc.ruler,
      BarcodeTool() => loc.barcode,
      PolygonTool() => loc.polygon,
    };
  }

  String getLocalizedCaption(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return switch (this) {
      SpacerTool e => e.axis.getLocalizedName(context),
      SelectTool e => e.mode.getLocalizedName(context),
      EraserTool e => e.mode.getLocalizedName(context),
      ExportTool e => switch (e.options) {
        ImageExportOptions() => loc.image,
        SvgExportOptions() => loc.svg,
      },
      ShapeTool e => e.property.shape.getLocalizedName(context),
      BarcodeTool e => e.barcodeType.getLocalizedName(context),
      _ => '',
    };
  }

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    HandTool() => filled ? PhosphorIconsFill.hand : PhosphorIconsLight.hand,
    SelectTool tool =>
      tool.mode == .lasso
          ? (filled ? PhosphorIconsFill.lasso : PhosphorIconsLight.lasso)
          : (filled
                ? PhosphorIconsFill.selection
                : PhosphorIconsLight.selection),
    ImportTool() =>
      filled
          ? PhosphorIconsFill.arrowSquareIn
          : PhosphorIconsLight.arrowSquareIn,
    UndoTool() =>
      filled
          ? PhosphorIconsFill.arrowCounterClockwise
          : PhosphorIconsLight.arrowCounterClockwise,
    RedoTool() =>
      filled
          ? PhosphorIconsFill.arrowClockwise
          : PhosphorIconsLight.arrowClockwise,
    LabelTool tool =>
      tool.mode == .markdown
          ? (filled ? PhosphorIconsFill.textbox : PhosphorIconsLight.textbox)
          : (filled ? PhosphorIconsFill.textT : PhosphorIconsLight.textT),
    PenTool tool => DisplayIcons.from(tool, filled: filled),
    EraserTool tool => tool.mode.icon(filled: filled),
    CollectionTool() =>
      filled ? PhosphorIconsFill.folder : PhosphorIconsLight.folder,
    AreaTool() =>
      filled ? PhosphorIconsFill.monitor : PhosphorIconsLight.monitor,
    LaserTool() =>
      filled ? PhosphorIconsFill.cursor : PhosphorIconsLight.cursor,
    ShapeTool tool => tool.property.shape.icon(filled: filled),
    TableTool() => filled ? PhosphorIconsFill.table : PhosphorIconsLight.table,
    SpacerTool tool =>
      tool.axis == .horizontal
          ? (filled
                ? PhosphorIconsFill.splitHorizontal
                : PhosphorIconsLight.splitHorizontal)
          : (filled
                ? PhosphorIconsFill.splitVertical
                : PhosphorIconsLight.splitVertical),
    StampTool() => filled ? PhosphorIconsFill.stamp : PhosphorIconsLight.stamp,
    TextureTool tool => tool.texture.icon(filled: filled),
    PresentationTool() =>
      filled ? PhosphorIconsFill.presentation : PhosphorIconsLight.presentation,
    FullScreenTool() =>
      filled ? PhosphorIconsFill.arrowsOut : PhosphorIconsLight.arrowsOut,
    AssetTool tool => tool.importType.icon(filled: filled),
    EyeDropperTool() =>
      filled ? PhosphorIconsFill.eyedropper : PhosphorIconsLight.eyedropper,
    ExportTool() =>
      filled ? PhosphorIconsFill.export : PhosphorIconsLight.export,
    GridTool() =>
      filled ? PhosphorIconsFill.gridFour : PhosphorIconsLight.gridFour,
    RulerTool() => filled ? PhosphorIconsFill.ruler : PhosphorIconsLight.ruler,
    BarcodeTool tool => tool.barcodeType.icon(filled: filled),
    PolygonTool() =>
      filled ? PhosphorIconsFill.polygon : PhosphorIconsLight.polygon,
  };

  List<String> get help {
    final page = switch (this) {
      RedoTool() => 'redo',
      UndoTool() => 'undo',
      PenTool() => 'pen',
      LaserTool() => 'laser',
      ShapeTool() => 'shape',
      TableTool() => null,
      StampTool() => 'stamp',
      EraserTool e => switch (e.mode) {
        .stroke => 'eraser',
        .path => 'path_eraser',
      },
      LabelTool() => 'label',
      AreaTool() => 'area',
      HandTool() => 'hand',
      SelectTool() => 'select',
      TextureTool() => 'texture',
      CollectionTool() => 'collection',
      PresentationTool() => 'presentation',
      FullScreenTool() => 'full_screen',
      ImportTool() => null,
      SpacerTool() => 'spacer',
      AssetTool() => null,
      ExportTool() => null,
      EyeDropperTool() => 'eye_dropper',
      GridTool() => 'grid',
      RulerTool() => 'ruler',
      BarcodeTool() => 'barcode',
      PolygonTool() => 'polygon',
    };
    if (page == null) return [];
    return ['tools', page];
  }

  bool isAction() {
    return switch (this) {
      ImportTool() => true,
      UndoTool() => true,
      RedoTool() => true,
      FullScreenTool() => true,
      ExportTool() => true,
      CollectionTool() => true,
      EyeDropperTool() => true,
      _ => false,
    };
  }
}

extension ImportTypeVisualizer on ImportType {
  String getLocalizedName(BuildContext context) => switch (this) {
    .file => AppLocalizations.of(context).import,
    .oneNote => 'OneNote',
    .document => AppLocalizations.of(context).document,
    .image => AppLocalizations.of(context).image,
    .pdf => AppLocalizations.of(context).pdf,
    .svg => AppLocalizations.of(context).svg,
    .svgText => AppLocalizations.of(context).svgText,
    .camera => AppLocalizations.of(context).camera,
    .markdown => AppLocalizations.of(context).markdown,
    .xopp => 'Xournal++',
  };

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    .file =>
      filled ? PhosphorIconsFill.fileArrowUp : PhosphorIconsLight.fileArrowUp,
    .oneNote || ImportType.xopp =>
      filled ? PhosphorIconsFill.notebook : PhosphorIconsLight.notebook,
    .document =>
      filled ? PhosphorIconsFill.fileText : PhosphorIconsLight.fileText,
    .image => filled ? PhosphorIconsFill.image : PhosphorIconsLight.image,
    .pdf => filled ? PhosphorIconsFill.filePdf : PhosphorIconsLight.filePdf,
    .svg => filled ? PhosphorIconsFill.fileSvg : PhosphorIconsLight.fileSvg,
    .svgText => filled ? PhosphorIconsFill.article : PhosphorIconsLight.article,
    .camera => filled ? PhosphorIconsFill.camera : PhosphorIconsLight.camera,
    .markdown =>
      filled ? PhosphorIconsFill.textbox : PhosphorIconsLight.textbox,
  };

  Future<bool> isAvailable() async {
    return switch (this) {
      .camera =>
        kIsWeb || Platform.isWindows || Platform.isAndroid || Platform.isIOS,
      _ => true,
    };
  }
}
