import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

const _previewWidth = 72.0;
const _previewHeight = 48.0;
const _previewQuality = 2.0;

@visibleForTesting
Rect resolvePagePreviewBounds(
  DocumentPage page,
  Iterable<Rect?> contentBounds, {
  Area? area,
}) {
  Area? preferredArea = area;
  if (preferredArea == null) {
    for (final candidate in page.areas) {
      if (candidate.isInitial) {
        preferredArea = candidate;
        break;
      }
    }
  }
  if (preferredArea != null && !preferredArea.rect.isEmpty) {
    return preferredArea.rect;
  }

  Rect? result;
  for (final bounds in contentBounds) {
    if (bounds == null || bounds.isEmpty) continue;
    result = result?.expandToInclude(bounds) ?? bounds;
  }
  if (result == null || result.isEmpty) {
    return const Rect.fromLTWH(0, 0, _previewWidth, _previewHeight);
  }
  final padding = max(result.width, result.height) * 0.04;
  return result.inflate(padding);
}

Rect _fitPreviewAspectRatio(Rect bounds) {
  final targetRatio = _previewWidth / _previewHeight;
  final boundsRatio = bounds.width / bounds.height;
  if (boundsRatio > targetRatio) {
    return Rect.fromCenter(
      center: bounds.center,
      width: bounds.width,
      height: bounds.width / targetRatio,
    );
  }
  return Rect.fromCenter(
    center: bounds.center,
    width: bounds.height * targetRatio,
    height: bounds.height,
  );
}

class _PreviewKey {
  const _PreviewKey({
    required this.documentIdentity,
    required this.page,
    required this.info,
    required this.areaRect,
  });

  final int documentIdentity;
  final DocumentPage page;
  final DocumentInfo info;
  final Rect? areaRect;

  @override
  bool operator ==(Object other) =>
      other is _PreviewKey &&
      other.documentIdentity == documentIdentity &&
      other.page == page &&
      other.info == info &&
      other.areaRect == areaRect;

  @override
  int get hashCode => Object.hash(documentIdentity, page, info, areaRect);
}

class _PreviewTask {
  const _PreviewTask(this.key, this.loader, this.completer);

  final _PreviewKey key;
  final Future<Uint8List?> Function() loader;
  final Completer<Uint8List?> completer;
}

class _DocumentPagePreviewCache {
  static const _maximumEntries = 96;
  static const _maximumConcurrentLoads = 2;

  final LinkedHashMap<_PreviewKey, Future<Uint8List?>> _entries =
      LinkedHashMap();
  final Queue<_PreviewTask> _pending = Queue();
  int _activeLoads = 0;

  Future<Uint8List?> get(
    _PreviewKey key,
    Future<Uint8List?> Function() loader,
  ) {
    final cached = _entries.remove(key);
    if (cached != null) {
      _entries[key] = cached;
      return cached;
    }

    final completer = Completer<Uint8List?>();
    final future = completer.future;
    _entries[key] = future;
    _pending.add(_PreviewTask(key, loader, completer));
    while (_entries.length > _maximumEntries) {
      _entries.remove(_entries.keys.first);
    }
    _pump();
    return future;
  }

  void _pump() {
    while (_activeLoads < _maximumConcurrentLoads && _pending.isNotEmpty) {
      final task = _pending.removeFirst();
      _activeLoads++;
      () async {
        try {
          final result = await task.loader();
          if (!task.completer.isCompleted) task.completer.complete(result);
        } catch (_) {
          _entries.remove(task.key);
          if (!task.completer.isCompleted) task.completer.complete(null);
        } finally {
          _activeLoads--;
          _pump();
        }
      }();
    }
  }
}

final _previewCache = _DocumentPagePreviewCache();

class DocumentPagePreview extends StatelessWidget {
  const DocumentPagePreview({
    required this.state,
    required this.pageName,
    required this.page,
    this.area,
    super.key,
  });

  final DocumentLoadSuccess state;
  final String pageName;
  final DocumentPage page;
  final Area? area;

  Future<Uint8List?> _render(EditorController controller) async {
    final viewport = await CameraViewport.build(
      controller.transformCubit,
      state.data,
      state.assetService,
      page,
    );
    final renderers = viewport.unbakedElements;
    final bounds = _fitPreviewAspectRatio(
      resolvePagePreviewBounds(
        page,
        renderers.map((renderer) => renderer.expandedRect),
        area: area,
      ),
    );
    final scale = min(
      _previewWidth / bounds.width,
      _previewHeight / bounds.height,
    );
    final previewState = pageName == state.pageName
        ? state
        : state.copyWith(
            page: page,
            pageName: pageName,
            currentAreaName: '',
            invisibleLayers: const {},
          );

    try {
      final data = await controller.rendererCubit.render(
        controller,
        state.data,
        page,
        state.info,
        ImageExportOptions(
          width: _previewWidth,
          height: _previewHeight,
          quality: _previewQuality,
          x: bounds.left,
          y: bounds.top,
          scale: scale,
        ),
        cameraViewport: viewport,
        docState: previewState,
      );
      if (data == null) return null;
      return Uint8List.fromList(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      );
    } finally {
      for (final renderer in viewport.backgrounds) {
        renderer.dispose();
      }
      for (final renderer in viewport.unbakedElements) {
        renderer.dispose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<DocumentBloc>().editorController;
    final key = _PreviewKey(
      documentIdentity: identityHashCode(state.data),
      page: page,
      info: state.info,
      areaRect: area?.rect,
    );
    final future = _previewCache.get(key, () => _render(controller));
    final colorScheme = ColorScheme.of(context);

    return Semantics(
      image: true,
      label: AppLocalizations.of(context).preview,
      child: Container(
        width: _previewWidth,
        height: _previewHeight,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: FutureBuilder<Uint8List?>(
          future: future,
          builder: (context, snapshot) {
            final bytes = snapshot.data;
            if (bytes != null) {
              return Image.memory(
                bytes,
                fit: BoxFit.contain,
                gaplessPlayback: true,
                filterQuality: FilterQuality.low,
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: PhosphorIcon(
                  PhosphorIconsLight.image,
                  size: 18,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              );
            }
            return PhosphorIcon(
              PhosphorIconsLight.image,
              size: 18,
              color: colorScheme.onSurfaceVariant,
            );
          },
        ),
      ),
    );
  }
}
