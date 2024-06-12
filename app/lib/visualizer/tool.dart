// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:butterfly/visualizer/element.dart';
import 'package:butterfly/visualizer/icon.dart';
import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_models.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension ToolVisualizer on Tool {
  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return switch (this) {
      HandTool _ => loc.hand,
      SelectTool _ => loc.select,
      ImportTool _ => loc.import,
      UndoTool _ => loc.undo,
      RedoTool _ => loc.redo,
      LabelTool _ => loc.label,
      PenTool _ => loc.pen,
      EraserTool _ => loc.eraser,
      PathEraserTool _ => loc.pathEraser,
      LayerTool _ => loc.layer,
      AreaTool _ => loc.area,
      LaserTool _ => loc.laser,
      ShapeTool _ => loc.shape,
      SpacerTool _ => loc.spacer,
      StampTool _ => loc.stamp,
      TextureTool _ => loc.texture,
      PresentationTool _ => loc.presentation,
      FullScreenTool _ => loc.fullScreen,
      AssetTool e => e.importType.getLocalizedName(context),
      EyeDropperTool _ => loc.eyeDropper,
      ExportTool _ => loc.export,
    };
  }

  String getLocalizedCaption(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return switch (this) {
      SpacerTool e =>
        e.axis == Axis2D.horizontal ? loc.horizontal : loc.vertical,
      SelectTool e => e.mode == SelectMode.lasso ? loc.lasso : loc.rectangle,
      ExportTool e => switch (e.options) {
          ImageExportOptions _ => loc.image,
          SvgExportOptions _ => loc.svg
        },
      _ => '',
    };
  }

  IconGetter get icon => switch (this) {
        HandTool _ => PhosphorIcons.hand,
        SelectTool tool => tool.mode == SelectMode.lasso
            ? PhosphorIcons.lasso
            : PhosphorIcons.selection,
        ImportTool _ => PhosphorIcons.arrowSquareIn,
        UndoTool _ => PhosphorIcons.arrowCounterClockwise,
        RedoTool _ => PhosphorIcons.arrowClockwise,
        LabelTool tool => tool.mode == LabelMode.markdown
            ? PhosphorIcons.textbox
            : PhosphorIcons.textT,
        PenTool tool => DisplayIcons.from(tool),
        EraserTool _ => PhosphorIcons.eraser,
        PathEraserTool _ => PhosphorIcons.path,
        LayerTool _ => PhosphorIcons.squaresFour,
        AreaTool _ => PhosphorIcons.monitor,
        LaserTool _ => PhosphorIcons.cursor,
        ShapeTool tool => tool.property.shape.icon,
        SpacerTool tool => tool.axis == Axis2D.horizontal
            ? PhosphorIcons.splitHorizontal
            : PhosphorIcons.splitVertical,
        StampTool _ => PhosphorIcons.stamp,
        TextureTool tool => tool.texture.icon,
        PresentationTool _ => PhosphorIcons.presentation,
        FullScreenTool _ => PhosphorIcons.arrowsOut,
        AssetTool tool => tool.importType.icon,
        EyeDropperTool _ => PhosphorIcons.eyedropper,
        ExportTool _ => PhosphorIcons.export,
      };

  List<String> get help {
    final page = switch (this) {
      RedoTool _ => 'redo',
      UndoTool _ => 'undo',
      PenTool _ => 'pen',
      LaserTool _ => 'laser',
      ShapeTool _ => 'shape',
      StampTool _ => 'stamp',
      EraserTool _ => 'eraser',
      PathEraserTool _ => 'path_eraser',
      LabelTool _ => 'label',
      AreaTool _ => 'area',
      HandTool _ => 'hand',
      SelectTool _ => 'select',
      TextureTool _ => 'texture',
      LayerTool _ => 'layer',
      PresentationTool _ => 'presentation',
      FullScreenTool _ => 'full_screen',
      ImportTool _ => null,
      SpacerTool _ => 'spacer',
      AssetTool _ => null,
      ExportTool _ => null,
      // TODO: Create eyedropper docs page
      EyeDropperTool _ => null,
    };
    if (page == null) return [];
    return ['tools', page];
  }

  bool isAction() {
    return switch (this) {
      ImportTool _ => true,
      UndoTool _ => true,
      RedoTool _ => true,
      FullScreenTool _ => true,
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
        ImportType.camera => AppLocalizations.of(context).camera,
        ImportType.markdown => AppLocalizations.of(context).markdown,
        ImportType.xopp => 'Xournal++',
      };

  IconGetter get icon => switch (this) {
        ImportType.document => PhosphorIcons.fileText,
        ImportType.image => PhosphorIcons.image,
        ImportType.pdf => PhosphorIcons.filePdf,
        ImportType.svg => PhosphorIcons.fileSvg,
        ImportType.camera => PhosphorIcons.camera,
        ImportType.markdown => PhosphorIcons.textbox,
        ImportType.xopp => PhosphorIcons.notebook,
      };

  Future<bool> isAvailable() async {
    final androidVersion = !kIsWeb && Platform.isAndroid
        ? (await DeviceInfoPlugin().androidInfo).version.sdkInt
        : 0;
    return switch (this) {
      ImportType.camera => kIsWeb ||
          Platform.isWindows ||
          (Platform.isAndroid && androidVersion >= 21) ||
          Platform.isIOS,
      _ => true,
    };
  }
}
