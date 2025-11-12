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
  IconGetter get icon => switch (this) {
    ToolCategory.normal => PhosphorIcons.paintBrush,
    ToolCategory.import => PhosphorIcons.arrowSquareIn,
    ToolCategory.surface => PhosphorIcons.monitor,
    ToolCategory.action => PhosphorIcons.play,
    ToolCategory.view => PhosphorIcons.eye,
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
  IconGetter get icon => switch (this) {
    BarcodeType.qrCode => PhosphorIcons.qrCode,
    BarcodeType.dataMatrix => PhosphorIcons.scan,
    BarcodeType.code128 => PhosphorIcons.barcode,
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
      PathEraserTool() => loc.pathEraser,
      CollectionTool() => loc.collection,
      AreaTool() => loc.area,
      LaserTool() => loc.laser,
      ShapeTool() => loc.shape,
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
      SpacerTool e =>
        e.axis == Axis2D.horizontal ? loc.horizontal : loc.vertical,
      SelectTool e => e.mode == SelectMode.lasso ? loc.lasso : loc.rectangle,
      ExportTool e => switch (e.options) {
        ImageExportOptions() => loc.image,
        SvgExportOptions() => loc.svg,
      },
      ShapeTool e => e.property.shape.getLocalizedName(context),
      BarcodeTool e => e.barcodeType.getLocalizedName(context),
      _ => '',
    };
  }

  IconGetter get icon => switch (this) {
    HandTool() => PhosphorIcons.hand,
    SelectTool tool =>
      tool.mode == SelectMode.lasso
          ? PhosphorIcons.lasso
          : PhosphorIcons.selection,
    ImportTool() => PhosphorIcons.arrowSquareIn,
    UndoTool() => PhosphorIcons.arrowCounterClockwise,
    RedoTool() => PhosphorIcons.arrowClockwise,
    LabelTool tool =>
      tool.mode == LabelMode.markdown
          ? PhosphorIcons.textbox
          : PhosphorIcons.textT,
    PenTool tool => DisplayIcons.from(tool),
    EraserTool() => PhosphorIcons.eraser,
    PathEraserTool() => PhosphorIcons.path,
    CollectionTool() => PhosphorIcons.folder,
    AreaTool() => PhosphorIcons.monitor,
    LaserTool() => PhosphorIcons.cursor,
    ShapeTool tool => tool.property.shape.icon,
    SpacerTool tool =>
      tool.axis == Axis2D.horizontal
          ? PhosphorIcons.splitHorizontal
          : PhosphorIcons.splitVertical,
    StampTool() => PhosphorIcons.stamp,
    TextureTool tool => tool.texture.icon,
    PresentationTool() => PhosphorIcons.presentation,
    FullScreenTool() => PhosphorIcons.arrowsOut,
    AssetTool tool => tool.importType.icon,
    EyeDropperTool() => PhosphorIcons.eyedropper,
    ExportTool() => PhosphorIcons.export,
    GridTool() => PhosphorIcons.gridFour,
    RulerTool() => PhosphorIcons.ruler,
    BarcodeTool tool => tool.barcodeType.icon,
    PolygonTool() => PhosphorIcons.polygon,
  };

  List<String> get help {
    final page = switch (this) {
      RedoTool() => 'redo',
      UndoTool() => 'undo',
      PenTool() => 'pen',
      LaserTool() => 'laser',
      ShapeTool() => 'shape',
      StampTool() => 'stamp',
      EraserTool() => 'eraser',
      PathEraserTool() => 'path_eraser',
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
    ImportType.document => AppLocalizations.of(context).document,
    ImportType.image => AppLocalizations.of(context).image,
    ImportType.pdf => AppLocalizations.of(context).pdf,
    ImportType.svg => AppLocalizations.of(context).svg,
    ImportType.svgText => AppLocalizations.of(context).svgText,
    ImportType.camera => AppLocalizations.of(context).camera,
    ImportType.markdown => AppLocalizations.of(context).markdown,
    ImportType.xopp => 'Xournal++',
  };

  IconGetter get icon => switch (this) {
    ImportType.document => PhosphorIcons.fileText,
    ImportType.image => PhosphorIcons.image,
    ImportType.pdf => PhosphorIcons.filePdf,
    ImportType.svg => PhosphorIcons.fileSvg,
    ImportType.svgText => PhosphorIcons.article,
    ImportType.camera => PhosphorIcons.camera,
    ImportType.markdown => PhosphorIcons.textbox,
    ImportType.xopp => PhosphorIcons.notebook,
  };

  Future<bool> isAvailable() async {
    return switch (this) {
      ImportType.camera =>
        kIsWeb || Platform.isWindows || Platform.isAndroid || Platform.isIOS,
      _ => true,
    };
  }
}
