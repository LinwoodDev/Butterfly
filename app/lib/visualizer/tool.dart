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
    ToolCategory.normal =>
      filled ? PhosphorIconsFill.paintBrush : PhosphorIconsLight.paintBrush,
    ToolCategory.import =>
      filled
          ? PhosphorIconsFill.arrowSquareIn
          : PhosphorIconsLight.arrowSquareIn,
    ToolCategory.surface =>
      filled ? PhosphorIconsFill.monitor : PhosphorIconsLight.monitor,
    ToolCategory.action =>
      filled ? PhosphorIconsFill.play : PhosphorIconsLight.play,
    ToolCategory.view =>
      filled ? PhosphorIconsFill.eye : PhosphorIconsLight.eye,
  };

  String getLocalizedName(BuildContext context) => switch (this) {
    ToolCategory.normal => AppLocalizations.of(context).normal,
    ToolCategory.import => AppLocalizations.of(context).import,
    ToolCategory.surface => AppLocalizations.of(context).surface,
    ToolCategory.action => AppLocalizations.of(context).action,
    ToolCategory.view => AppLocalizations.of(context).view,
  };
}

extension BarcodeTypeVisualizer on BarcodeType {
  String getLocalizedName(BuildContext context) => switch (this) {
    BarcodeType.qrCode => AppLocalizations.of(context).qrCode,
    BarcodeType.dataMatrix => AppLocalizations.of(context).dataMatrix,
    BarcodeType.code128 => AppLocalizations.of(context).code128,
  };

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    BarcodeType.qrCode =>
      filled ? PhosphorIconsFill.qrCode : PhosphorIconsLight.qrCode,
    BarcodeType.dataMatrix =>
      filled ? PhosphorIconsFill.scan : PhosphorIconsLight.scan,
    BarcodeType.code128 =>
      filled ? PhosphorIconsFill.barcode : PhosphorIconsLight.barcode,
  };
}

extension SelectModeVisualizer on SelectMode {
  String getLocalizedName(BuildContext context) => switch (this) {
    SelectMode.rectangle => AppLocalizations.of(context).rectangle,
    SelectMode.lasso => AppLocalizations.of(context).lasso,
  };

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    SelectMode.rectangle =>
      filled ? PhosphorIconsFill.selection : PhosphorIconsLight.selection,
    SelectMode.lasso =>
      filled ? PhosphorIconsFill.lasso : PhosphorIconsLight.lasso,
  };
}

extension EraserModeVisualizer on EraserMode {
  String getLocalizedName(BuildContext context) => switch (this) {
    EraserMode.stroke => AppLocalizations.of(context).stroke,
    EraserMode.path => AppLocalizations.of(context).path,
  };

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    EraserMode.stroke =>
      filled ? PhosphorIconsFill.eraser : PhosphorIconsLight.eraser,
    EraserMode.path =>
      filled ? PhosphorIconsFill.path : PhosphorIconsLight.path,
  };
}

extension Axis2DVisualizer on Axis2D {
  String getLocalizedName(BuildContext context) => switch (this) {
    Axis2D.horizontal => AppLocalizations.of(context).horizontal,
    Axis2D.vertical => AppLocalizations.of(context).vertical,
  };

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    Axis2D.horizontal =>
      filled
          ? PhosphorIconsFill.splitHorizontal
          : PhosphorIconsLight.splitHorizontal,
    Axis2D.vertical =>
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
      tool.mode == SelectMode.lasso
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
      tool.mode == LabelMode.markdown
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
      tool.axis == Axis2D.horizontal
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
        EraserMode.stroke => 'eraser',
        EraserMode.path => 'path_eraser',
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
    ImportType.file => AppLocalizations.of(context).import,
    ImportType.oneNote => 'OneNote',
    ImportType.document => AppLocalizations.of(context).document,
    ImportType.image => AppLocalizations.of(context).image,
    ImportType.pdf => AppLocalizations.of(context).pdf,
    ImportType.svg => AppLocalizations.of(context).svg,
    ImportType.svgText => AppLocalizations.of(context).svgText,
    ImportType.camera => AppLocalizations.of(context).camera,
    ImportType.markdown => AppLocalizations.of(context).markdown,
    ImportType.xopp => 'Xournal++',
  };

  PhosphorIconData icon({bool filled = false}) => switch (this) {
    ImportType.file =>
      filled ? PhosphorIconsFill.fileArrowUp : PhosphorIconsLight.fileArrowUp,
    ImportType.oneNote || ImportType.xopp =>
      filled ? PhosphorIconsFill.notebook : PhosphorIconsLight.notebook,
    ImportType.document =>
      filled ? PhosphorIconsFill.fileText : PhosphorIconsLight.fileText,
    ImportType.image =>
      filled ? PhosphorIconsFill.image : PhosphorIconsLight.image,
    ImportType.pdf =>
      filled ? PhosphorIconsFill.filePdf : PhosphorIconsLight.filePdf,
    ImportType.svg =>
      filled ? PhosphorIconsFill.fileSvg : PhosphorIconsLight.fileSvg,
    ImportType.svgText =>
      filled ? PhosphorIconsFill.article : PhosphorIconsLight.article,
    ImportType.camera =>
      filled ? PhosphorIconsFill.camera : PhosphorIconsLight.camera,
    ImportType.markdown =>
      filled ? PhosphorIconsFill.textbox : PhosphorIconsLight.textbox,
  };

  Future<bool> isAvailable() async {
    return switch (this) {
      ImportType.camera =>
        kIsWeb || Platform.isWindows || Platform.isAndroid || Platform.isIOS,
      _ => true,
    };
  }
}
