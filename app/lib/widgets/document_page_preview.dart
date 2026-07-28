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
  _PreviewKey({
    required this.sessionId,
    required this.pageName,
    required DocumentPage page,
    required DocumentInfo info,
    required this.areaRect,
  }) : _page = WeakReference(page),
       _info = WeakReference(info),
       _hashCode = Object.hash(
         sessionId,
         pageName,
         page.hashCode,
         info.hashCode,
         areaRect,
       );

  final int sessionId;
  final String pageName;
  final WeakReference<DocumentPage> _page;
  final WeakReference<DocumentInfo> _info;
  final Rect? areaRect;
  final int _hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! _PreviewKey ||
        other.sessionId != sessionId ||
        other.pageName != pageName ||
        other.areaRect != areaRect) {
      return false;
    }
    final page = _page.target;
    final info = _info.target;
    return page != null &&
        info != null &&
        other._page.target == page &&
        other._info.target == info;
  }

  @override
  int get hashCode => _hashCode;
}

class _PreviewTask {
  _PreviewTask(this.key, this.loader, this.completer);

  final _PreviewKey key;
  final Future<Uint8List?> Function() loader;
  final Completer<Uint8List?> completer;
  bool canceled = false;

  void cancel() {
    canceled = true;
    if (!completer.isCompleted) completer.complete(null);
  }
}

class _DocumentPagePreviewCache {
  static const _maximumEntries = 96;
  static const _maximumConcurrentLoads = 2;

  final LinkedHashMap<_PreviewKey, Future<Uint8List?>> _entries =
      LinkedHashMap();
  final Queue<_PreviewTask> _pending = Queue();
  final Set<_PreviewTask> _active = {};
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
      final evictedKey = _entries.keys.first;
      _entries.remove(evictedKey);
      _cancelTasks((task) => task.key == evictedKey);
    }
    _pump();
    return future;
  }

  void clearSession(int sessionId) {
    _entries.removeWhere((key, _) => key.sessionId == sessionId);
    _cancelTasks((task) => task.key.sessionId == sessionId);
  }

  int countForSession(int sessionId) =>
      _entries.keys.where((key) => key.sessionId == sessionId).length +
      _pending.where((task) => task.key.sessionId == sessionId).length +
      _active.where((task) => task.key.sessionId == sessionId).length;

  void _cancelTasks(bool Function(_PreviewTask task) shouldCancel) {
    final pending = _pending.where(shouldCancel).toList();
    _pending.removeWhere(shouldCancel);
    for (final task in [...pending, ..._active.where(shouldCancel)]) {
      task.cancel();
    }
  }

  void _pump() {
    while (_activeLoads < _maximumConcurrentLoads && _pending.isNotEmpty) {
      final task = _pending.removeFirst();
      _activeLoads++;
      _active.add(task);
      () async {
        try {
          final result = await task.loader();
          if (!task.canceled && !task.completer.isCompleted) {
            task.completer.complete(result);
          }
        } catch (_) {
          if (!task.canceled) {
            _entries.remove(task.key);
            if (!task.completer.isCompleted) task.completer.complete(null);
          }
        } finally {
          _active.remove(task);
          _activeLoads--;
          _pump();
        }
      }();
    }
  }
}

final _previewCache = _DocumentPagePreviewCache();
final Expando<int> _previewSessionIds = Expando('document preview session');
int _nextPreviewSessionId = 0;

int _previewSessionId(DocumentBloc bloc) =>
    _previewSessionIds[bloc] ??= _nextPreviewSessionId++;

void clearDocumentPagePreviewCache(DocumentBloc bloc) {
  final sessionId = _previewSessionIds[bloc];
  if (sessionId != null) _previewCache.clearSession(sessionId);
}

@visibleForTesting
int debugDocumentPagePreviewCacheRetainedCount(DocumentBloc bloc) {
  final sessionId = _previewSessionIds[bloc];
  return sessionId == null ? 0 : _previewCache.countForSession(sessionId);
}

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
    final bloc = context.read<DocumentBloc>();
    final controller = bloc.editorController;
    final key = _PreviewKey(
      sessionId: _previewSessionId(bloc),
      pageName: pageName,
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
