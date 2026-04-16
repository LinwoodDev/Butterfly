import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';

String? getGlobalToolStrokeWidthKey(Tool tool) => switch (tool) {
  PenTool() => 'pen',
  EraserTool() => 'eraser',
  PathEraserTool() => 'pathEraser',
  LaserTool() => 'laser',
  ShapeTool() => 'shape',
  PolygonTool() => 'polygon',
  _ => null,
};

double? getToolStrokeWidthValue(Tool tool) => switch (tool) {
  PenTool() => tool.property.strokeWidth,
  EraserTool() => tool.strokeWidth,
  PathEraserTool() => tool.strokeWidth,
  LaserTool() => tool.strokeWidth,
  ShapeTool() => tool.property.strokeWidth,
  PolygonTool() => tool.property.strokeWidth,
  _ => null,
};

Tool _applyGlobalStrokeWidth(Tool tool, Map<String, double> widths) {
  final key = getGlobalToolStrokeWidthKey(tool);
  final strokeWidth = key == null ? null : widths[key];
  if (strokeWidth == null) return tool;
  return switch (tool) {
    PenTool() => tool.copyWith(
      property: tool.property.copyWith(strokeWidth: strokeWidth),
    ),
    EraserTool() => tool.copyWith(strokeWidth: strokeWidth),
    PathEraserTool() => tool.copyWith(strokeWidth: strokeWidth),
    LaserTool() => tool.copyWith(strokeWidth: strokeWidth),
    ShapeTool() => tool.copyWith(
      property: tool.property.copyWith(strokeWidth: strokeWidth),
    ),
    PolygonTool() => tool.copyWith(
      property: tool.property.copyWith(strokeWidth: strokeWidth),
    ),
    _ => tool,
  };
}

ZoomBoxTool sanitizeGlobalZoomBoxTool(ZoomBoxTool tool) =>
    tool.copyWith(id: null, name: '', displayIcon: '');

ZoomBoxTool mergeAutomaticGlobalZoomBoxTool(
  ZoomBoxTool tool, [
  ZoomBoxTool? previous,
]) {
  final base = previous ?? ZoomBoxTool();
  return base.copyWith(
    id: null,
    name: '',
    displayIcon: '',
    zoomFactor: tool.zoomFactor,
    boxLeft: tool.boxLeft,
    boxTop: tool.boxTop,
    boxWidth: tool.boxWidth,
    boxHeight: tool.boxHeight,
    autoAdvance: tool.autoAdvance,
    autoAdvanceTriggerFraction: tool.autoAdvanceTriggerFraction,
    autoAdvancePauseSeconds: tool.autoAdvancePauseSeconds,
    targetLeft: tool.targetLeft,
    targetTop: tool.targetTop,
    locked: tool.locked,
    docked: tool.docked,
    targetWidthScale: tool.targetWidthScale,
    targetHeightScale: tool.targetHeightScale,
  );
}

Tool _applyGlobalZoomBoxDefaults(Tool tool, ZoomBoxTool? globalZoomBoxTool) {
  if (globalZoomBoxTool == null || tool is! ZoomBoxTool) return tool;
  return tool.copyWith(
    zoomFactor: globalZoomBoxTool.zoomFactor,
    boxLeft: globalZoomBoxTool.boxLeft,
    boxTop: globalZoomBoxTool.boxTop,
    boxWidth: globalZoomBoxTool.boxWidth,
    boxHeight: globalZoomBoxTool.boxHeight,
    autoAdvance: globalZoomBoxTool.autoAdvance,
    autoAdvanceTriggerFraction: globalZoomBoxTool.autoAdvanceTriggerFraction,
    autoAdvancePauseSeconds: globalZoomBoxTool.autoAdvancePauseSeconds,
    targetLeft: globalZoomBoxTool.targetLeft,
    targetTop: globalZoomBoxTool.targetTop,
    locked: globalZoomBoxTool.locked,
    docked: globalZoomBoxTool.docked,
    targetWidthScale: globalZoomBoxTool.targetWidthScale,
    targetHeightScale: globalZoomBoxTool.targetHeightScale,
  );
}

extension GlobalToolDefaults on ButterflySettings {
  Tool applyGlobalToolDefaults(Tool tool) {
    var next = _applyGlobalZoomBoxDefaults(tool, globalZoomBoxTool);
    if (persistToolSizeGlobally) {
      next = _applyGlobalStrokeWidth(next, globalToolStrokeWidths);
    }
    return next;
  }

  List<Tool> applyGlobalToolDefaultsToTools(Iterable<Tool> tools) {
    var sawZoomBox = false;
    final next = <Tool>[];
    for (final tool in tools) {
      if (tool is ZoomBoxTool) {
        if (sawZoomBox) continue;
        sawZoomBox = true;
      }
      next.add(applyGlobalToolDefaults(tool));
    }
    return next;
  }

  NoteData applyGlobalToolDefaultsToDocument(NoteData document) {
    final info = document.getInfo();
    if (info == null) return document;
    return document.setInfo(
      info.copyWith(tools: applyGlobalToolDefaultsToTools(info.tools)),
    );
  }
}

Future<void> syncGlobalToolStrokeWidths(
  SettingsCubit cubit,
  Iterable<Tool> tools,
) async {
  final settings = cubit.state;
  if (!settings.persistToolSizeGlobally) return;
  final next = Map<String, double>.from(settings.globalToolStrokeWidths);
  var changed = false;
  for (final tool in tools) {
    final key = getGlobalToolStrokeWidthKey(tool);
    final strokeWidth = getToolStrokeWidthValue(tool);
    if (key == null || strokeWidth == null) continue;
    if (next[key] == strokeWidth) continue;
    next[key] = strokeWidth;
    changed = true;
  }
  if (!changed) return;
  await cubit.changeGlobalToolStrokeWidths(next);
}

Future<void> syncGlobalZoomBoxTool(
  SettingsCubit cubit,
  Iterable<Tool> tools,
) async {
  final zoomBoxTool = tools.whereType<ZoomBoxTool>().firstOrNull;
  if (zoomBoxTool == null) return;
  final sanitized = mergeAutomaticGlobalZoomBoxTool(
    zoomBoxTool,
    cubit.state.globalZoomBoxTool,
  );
  if (cubit.state.globalZoomBoxTool == sanitized) return;
  await cubit.changeGlobalZoomBoxTool(sanitized);
}
