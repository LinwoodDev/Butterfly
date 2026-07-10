import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/async.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../cubits/settings.dart';
import '../cubits/transform.dart';
import '../embed/embedding.dart';
import '../models/defaults.dart';
import '../models/viewport.dart';
import '../renderers/renderer.dart';
import '../selections/selection.dart';
import '../services/asset.dart';
import '../services/network.dart';

part 'document_state.dart';

enum ConnectionStatus { none, server, client }

typedef ImportAssetSyncOptions = (
  NoteData data,
  List<PadElement> elements, {
  SendPort? onInvalidate,
  Map<String, String>? alreadyImported,
  Map<String, Uint8List>? assets,
});
(NoteData, List<PadElement>) _importAssetsSync(ImportAssetSyncOptions options) {
  return importAssets((
    options.$1,
    options.$2,
    onInvalidate: options.onInvalidate != null
        ? (source) => options.onInvalidate!.send(source)
        : null,
    alreadyImported: options.alreadyImported,
    assets: options.assets,
  ));
}

Future<(NoteData, List<PadElement>)> importAssetsAsync(
  NoteData data,
  List<PadElement> elements, {
  void Function(String source)? onInvalidate,
  Map<String, String>? alreadyImported,
  Map<String, Uint8List>? assets,
}) async {
  ReceivePort? port;
  StreamSubscription? subscription;
  try {
    final hasHeavyElements = elements.any((e) => e is SourcedElement);
    if (kIsWeb || !hasHeavyElements) {
      return importAssets((
        data,
        elements,
        onInvalidate: onInvalidate,
        alreadyImported: alreadyImported,
        assets: assets,
      ));
    }
    if (onInvalidate != null) {
      port = ReceivePort();
      subscription = port.listen((message) {
        if (message is String) {
          onInvalidate(message);
        }
      });
    }
    return await compute(_importAssetsSync, (
      data,
      elements,
      onInvalidate: port?.sendPort,
      alreadyImported: alreadyImported,
      assets: assets,
    ));
  } finally {
    await subscription?.cancel();
    port?.close();
  }
}

List<Renderer<PadElement>> orderRenderersByPage(
  DocumentPage page,
  Iterable<Renderer<PadElement>> renderers,
) {
  final renderersById = {
    for (final renderer in renderers)
      if (renderer.element.id != null)
        (renderer.element.id, renderer.layer): renderer,
  };
  return page.layers
      .expand(
        (layer) => layer.content.map(
          (element) => renderersById[(element.id, layer.id)],
        ),
      )
      .nonNulls
      .toList();
}

Selection? _updateSelection(
  Selection? selection,
  dynamic oldElement,
  dynamic newElement,
) {
  var newSelection = selection?.remove(oldElement);
  if (newSelection != selection && selection != null) {
    if (newSelection == null) {
      newSelection = Selection.from(newElement);
    } else {
      newSelection = newSelection.insert(newElement);
    }
  }
  return newSelection;
}

String getInitialArea(DocumentPage? page) {
  return page?.areas.firstWhereOrNull((e) => e.isInitial)?.name ?? '';
}

Area _createDuplicatedArea(Area area, List<Area> existingAreas) {
  final baseName = area.name.isEmpty ? 'Area' : area.name;
  final existingNames = existingAreas.map((e) => e.name).toSet();
  var name = baseName;
  var count = 1;
  while (existingNames.contains(name)) {
    name = '$baseName (${count++})';
  }
  return area.copyWith(name: name);
}

class DocumentBloc extends ReplayBloc<DocumentEvent, DocumentState> {
  final _historyReloadRunner = CoalescedAsyncRunner(
    delay: const Duration(milliseconds: 50),
  );
  EditorController? _editorController;
  AssetService? _assetService;

  EditorController get editorController => _editorController!;
  TransformCubit get transformCubit => editorController.transformCubit;
  NetworkingService? get networkingService =>
      _editorController?.networkingService;
  Embedding? get embedding => _editorController?.saveCubit.state.embedding;

  factory DocumentBloc(
    ButterflyFileSystem fileSystem,
    EditorController editorController,
    WindowCubit windowCubit,
    NoteData initial,
    AssetLocation location, [
    AssetService? assetService,
    DocumentPage? page,
    String? pageName,
    bool absolute = false,
    String? currentLayer,
    String? currentCollection,
    Set<String>? invisibleLayers,
  ]) {
    final resolvedAssetService = assetService ?? AssetService();
    editorController.saveCubit.setSaveState(
      location: location,
      absolute: absolute,
    );
    return DocumentBloc._(
      fileSystem,
      editorController,
      windowCubit,
      initial,
      resolvedAssetService,
      page,
      pageName,
      absolute,
      currentLayer,
      currentCollection,
      invisibleLayers,
    );
  }

  DocumentBloc._(
    ButterflyFileSystem fileSystem,
    EditorController editorController,
    WindowCubit windowCubit,
    NoteData initial,
    AssetService assetService, [
    DocumentPage? page,
    String? pageName,
    bool absolute = false,
    String? currentLayer,
    String? currentCollection,
    Set<String>? invisibleLayers,
  ]) : _editorController = editorController,
       _assetService = assetService,
       super(
         DocumentLoadSuccess(
           initial,
           page: page,
           assetService: assetService,
           windowCubit: windowCubit,
           absolute: absolute,
           fileSystem: fileSystem,
           pageName: pageName ?? initial.getPages(true).firstOrNull ?? '',
           currentLayer: currentLayer,
           currentCollection: currentCollection ?? '',
           invisibleLayers: invisibleLayers ?? const {},
         ),
       ) {
    _init();
  }

  DocumentBloc.error(
    ButterflyFileSystem fileSystem,
    EditorController editorController,
    WindowCubit windowCubit,
    String message, [
    StackTrace? stackTrace,
  ]) : _editorController = editorController,
       _assetService = null,
       super(
         DocumentLoadFailure(
           fileSystem: fileSystem,
           windowCubit: windowCubit,
           message: message,
           stackTrace: stackTrace,
         ),
       );

  DocumentBloc.placeholder(
    ButterflyFileSystem fileSystem,
    EditorController editorController,
    WindowCubit windowCubit,
  ) : _editorController = editorController,
      _assetService = null,
      super(
        DocumentLoadFailure(
          fileSystem: fileSystem,
          windowCubit: windowCubit,
          message: '',
        ),
      );

  void _init() {
    on<PagesAdded>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      var data = current.data;
      data = data.setPage(current.page, current.pageName).$1;
      Map<String, String> imported = {};
      String? pageName;
      DocumentPage? page;
      for (final details in event.pages) {
        final initialArea = details.initialArea;
        page =
            details.page ??
            DocumentPage(
              backgrounds: current.page.backgrounds,
              areas: initialArea != null
                  ? [
                      Area(
                        name: initialArea.name,
                        width: initialArea.width,
                        height: initialArea.height,
                        position: const Point(0, 0),
                        isInitial: true,
                      ),
                    ]
                  : const [],
            );
        final layers = await Future.wait(
          page.layers.map((layer) async {
            List<PadElement> elements;
            (data, elements) = await importAssetsAsync(
              data,
              layer.content,
              alreadyImported: imported,
              onInvalidate: current.assetService.invalidate,
            );
            return layer.copyWith(content: elements);
          }),
        );
        page = page.copyWith(layers: layers);
        (data, pageName) = data.addPage(
          page,
          details.name,
          index: details.index,
          addNumber: details.addNumber,
        );
      }
      _saveState(
        emit,
        state: current.copyWith(
          data: data,
          page: page,
          pageName: pageName,
          currentAreaName: getInitialArea(page),
        ),
        reset: true,
      );
    });
    on<PageChanged>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      current.assetService.dispose();
      final data = current.data.setPage(current.page, current.pageName).$1;
      final page = data.getPage(event.pageName);
      if (page == null) return;
      await _saveState(
        emit,
        state: current.copyWith(
          page: page,
          data: data,
          pageName: event.pageName,
          currentAreaName: getInitialArea(page),
        ),
        reset: true,
      );
      editorController.editorSessionCubit?.updatePage(event.pageName);
    });
    on<PageReordered>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      var newPageName = current.pageName;
      final newData = current.data.reorderPage(event.page, event.newIndex, (
        oldName,
        newName,
      ) {
        if (newPageName == oldName) {
          newPageName = newName;
        }
      });
      _saveState(
        emit,
        state: current.copyWith(data: newData, pageName: newPageName),
      );
    });
    on<PageRenamed>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final (newData, newPageName) = current.data.renamePage(
        event.oldName,
        event.newName,
      );
      final updatedCurrentPageName = current.pageName == event.oldName
          ? newPageName
          : current.pageName;
      _saveState(
        emit,
        state: current.copyWith(
          data: newData,
          pageName: updatedCurrentPageName,
        ),
      );
    });
    on<PageRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final newData = current.data.removePage(event.page);

      String newPageName = current.pageName;
      DocumentPage? newPage = current.page;
      String? currentAreaName = current.currentAreaName;
      bool pageChanged = false;

      if (current.pageName == event.page) {
        pageChanged = true;
        final remainingPages = newData.getPages(true);
        if (remainingPages.isNotEmpty) {
          newPageName = remainingPages.first;
          newPage = newData.getPage(newPageName);
          currentAreaName = getInitialArea(newPage);
        } else {
          newPageName = '';
          newPage = DocumentPage();
          currentAreaName = '';
        }
      }

      _saveState(
        emit,
        state: current.copyWith(
          data: newData,
          pageName: newPageName,
          page: newPage,
          currentAreaName: currentAreaName,
        ),
        reset: pageChanged,
      );
    });
    on<ThumbnailCaptured>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final newData = current.data.setThumbnail(event.data);
      _saveState(emit, state: current.copyWith(data: newData));
    });
    on<ElementsCreated>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      final assetService = current.assetService;
      final (data, elements) = await importAssetsAsync(
        current.data,
        event.elements
            .map((e) => e.copyWith(id: e.id ?? createUniqueId()))
            .toList(),
        onInvalidate: assetService.invalidate,
        assets: event.assets,
      );
      final renderers = elements
          .map((e) => Renderer.fromInstance(e, current.currentLayer))
          .toList();
      if (renderers.isEmpty) return;
      _saveState(
        emit,
        state: current.copyWith(
          data: data,
          page: current.mapLayer(
            (e) => e.copyWith(content: [...e.content, ...elements]),
          ),
        ),
        addedElements: renderers,
        shouldRefresh: () => editorController.toolCubit
            .getHandler(
              editable:
                  editorController.saveCubit.state.embedding?.editable != false,
            )
            .onRenderersCreated(current.page, renderers),
      );
    });
    on<ElementsChanged>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      final cubit = editorController;
      final renderers = <Renderer<PadElement>>[];
      final selected = cubit.toolCubit.state.selection?.selected.toList();
      final page = current.page;
      final oldRenderers = cubit.rendererCubit.renderers;
      var data = current.data;
      final imported = <String, String>{};
      final elements = <String, List<PadElement>>{};
      for (final entry in event.elements.entries) {
        final sourceElements = entry.value
            .map((e) => e.copyWith(id: e.id ?? createUniqueId()))
            .toList();
        List<PadElement> importedElements;
        (data, importedElements) = await importAssetsAsync(
          data,
          sourceElements,
          alreadyImported: imported,
          onInvalidate: current.assetService.invalidate,
        );
        elements[entry.key] = importedElements;
      }
      final replacedRenderers =
          <Renderer<PadElement>, List<Renderer<PadElement>>>{};
      for (final renderer in oldRenderers) {
        final id = renderer.element.id;
        final updated = elements[id];
        if (updated != null) {
          renderer.dispose();
          final updatedRenderers = <Renderer<PadElement>>[];
          for (var element in updated) {
            final newRenderer = Renderer.fromInstance(element, renderer.layer);
            renderers.add(newRenderer);
            updatedRenderers.add(newRenderer);
            final exists = selected?.remove(renderer);
            if (exists == true) {
              selected?.add(newRenderer);
            }
          }
          replacedRenderers[renderer] = updatedRenderers;
        } else {
          renderers.add(renderer);
        }
      }
      final newPage = current.page.mapLayers(
        (e) => e.copyWith(
          content: e.content.expand((e) {
            final updated = elements[e.id];
            if (updated != null) {
              return updated;
            }
            return [e];
          }).toList(),
        ),
      );

      final unusedAssets = <String>{};
      for (final renderer in oldRenderers) {
        final id = renderer.element.id;
        final updated = elements[id];
        if (updated != null) {
          final oldElement = renderer.element;
          if (oldElement is SourcedElement) {
            final source = (oldElement as SourcedElement).source;
            final uri = Uri.tryParse(source);
            if (uri?.scheme == '' && !newPage.usesSource(source)) {
              unusedAssets.add(source);
              current.assetService.invalidate(source);
            }
          }
        }
      }
      data = data.removeAssets(unusedAssets.toList());

      cubit.toolCubit.changeSelection(Selection.fromList(selected), false);
      return _saveState(
        emit,
        state: current.copyWith(page: newPage, data: data),
        replacedElements: orderRenderersByPage(newPage, renderers),
        shouldRefresh: () => replacedRenderers.entries
            .map(
              (element) => cubit.toolCubit
                  .getHandler(
                    editable:
                        cubit.saveCubit.state.embedding?.editable != false,
                  )
                  .onRendererUpdated(page, element.key, element.value),
            )
            .toList()
            .any((e) => e),
      );
    }, transformer: sequential());
    on<ElementsArranged>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final renderers = List<Renderer<PadElement>>.from(
        editorController.rendererCubit.renderers,
      );
      void insertElement(
        List<PadElement> content,
        PadElement element,
        int index,
      ) {
        if (index >= 0) {
          content.insert(index, element);
        } else {
          content.add(element);
        }
      }

      void insertRenderer(Renderer<PadElement>? renderer, int index) {
        if (renderer == null) return;
        if (index >= 0) {
          renderers.insert(index, renderer);
        } else {
          renderers.add(renderer);
        }
      }

      if (event.arrangement == Arrangement.front ||
          event.arrangement == Arrangement.back) {
        final moveToFront = event.arrangement == Arrangement.front;
        final newPage = current.page.mapLayers((e) {
          final content = List<PadElement>.from(e.content);
          for (final id in event.elements) {
            final index = content.indexWhere((element) => element.id == id);
            if (index == -1) continue;
            final element = content.removeAt(index);
            var newRendererIndex = renderers.indexWhere(
              (e) => e.element == element,
            );
            final renderer = newRendererIndex >= 0
                ? renderers.removeAt(newRendererIndex)
                : null;
            final newIndex = moveToFront ? content.length : 0;
            newRendererIndex = moveToFront ? renderers.length : 0;
            insertElement(content, element, newIndex);
            insertRenderer(renderer, newRendererIndex);
          }
          return e.copyWith(content: content);
        });
        return _saveState(
          emit,
          state: current.copyWith(page: newPage),
          replacedElements: renderers,
        );
      }

      final newPage = await current.page.mapLayersAsync((e) async {
        final content = List<PadElement>.from(e.content);
        for (final id in event.elements) {
          final index = content.indexWhere((element) => element.id == id);
          if (index == -1) continue;
          final element = content.removeAt(index);
          var newIndex = index;
          var newRendererIndex = renderers.indexWhere(
            (e) => e.element == element,
          );
          final renderer = newRendererIndex >= 0
              ? renderers.removeAt(newRendererIndex)
              : null;
          final rect = renderer?.rect;
          if (rect != null) {
            final hits = (await rayCastRect(
              rect,
              hitElementMode: HitElementMode.touchAnywhere,
            )).map((e) => e.element).toList();
            final hitIndex = hits.indexOf(renderer!.element);
            if (event.arrangement == Arrangement.backward && hitIndex > 0) {
              newIndex = content.indexOf(hits[hitIndex - 1]);
            } else if (event.arrangement == Arrangement.forward &&
                hitIndex >= 0 &&
                hitIndex < hits.length - 1) {
              newIndex = content.indexOf(hits[hitIndex + 1]) + 1;
            }
            if (newIndex >= 0) {
              final element = newIndex < content.length
                  ? content[newIndex]
                  : null;
              newRendererIndex = element == null
                  ? renderers.length
                  : renderers.indexWhere((e) => e.element == element);
            }
          }
          insertElement(content, element, newIndex);
          insertRenderer(renderer, newRendererIndex);
        }
        return e.copyWith(content: content);
      });
      return _saveState(
        emit,
        state: current.copyWith(page: newPage),
        replacedElements: renderers,
      );
    }, transformer: sequential());
    on<ElementsRemoved>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      if (event.elements.isEmpty) return;
      final newPage = current.page.mapLayers(
        (e) => e.copyWith(
          content: e.content
              .where((element) => !event.elements.contains(element.id))
              .toList(),
        ),
      );
      editorController.toolCubit.removeSelection(event.elements);
      final unusedAssets = <String>{};
      final removedRenderers = editorController.rendererCubit.renderers
          .where((e) => event.elements.contains(e.element.id))
          .toList();
      for (final renderer in removedRenderers) {
        final element = renderer.element;
        if (element is SourcedElement) {
          final source = (element as SourcedElement).source;
          final uri = Uri.tryParse(source);
          if (uri?.scheme == '' && !newPage.usesSource(source)) {
            unusedAssets.add(source);
            current.assetService.invalidate(source);
          }
        }
        renderer.dispose();
      }
      final data = current.data.removeAssets(unusedAssets.toList());
      return _saveState(
        emit,
        state: current.copyWith(page: newPage, data: data),
        replacedElements: editorController.rendererCubit.renderers
            .where((e) => !event.elements.contains(e.element.id))
            .toList(),
      );
    }, transformer: sequential());
    on<DocumentDescriptionChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      _saveState(
        emit,
        state: current.copyWith(
          metadata: current.metadata.copyWith(
            name: event.name ?? current.metadata.name,
            description: event.description ?? current.metadata.description,
          ),
        ),
      );
    });
    on<ToolCreated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      _saveState(
        emit,
        state: current.copyWith(
          info: current.info.copyWith(
            tools: List.from(current.info.tools)
              ..add(event.tool.copyWith(id: event.tool.id ?? createUniqueId())),
          ),
        ),
      );
    });
    on<ToolsChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      var selection = editorController.toolCubit.state.selection;
      final changedTools = event.tools
          .map((e) => e.copyWith(id: e.id ?? createUniqueId()))
          .toList();
      final changedToolsById = {
        for (final tool in changedTools)
          if (tool.id != null) tool.id!: tool,
      };
      Tool? updatedCurrent;
      Tool? updatedTemporary;
      _saveState(
        emit,
        state: current.copyWith(
          info: current.info.copyWith(
            tools: List<Tool>.from(current.info.tools).mapIndexed((
              index,
              tool,
            ) {
              var updated = tool.id == null ? null : changedToolsById[tool.id];
              if (updated == null) {
                final selectionIndex = selection?.selected.indexWhere(
                  (selected) => identical(selected, tool),
                );
                if (selectionIndex != null &&
                    selectionIndex >= 0 &&
                    selectionIndex < changedTools.length) {
                  updated = changedTools[selectionIndex];
                }
              }
              if (updated == null) {
                return tool;
              }
              selection = _updateSelection(selection, tool, updated);
              final currentTool = editorController.toolCubit.state.handler.data;
              if (currentTool is Tool &&
                  (currentTool.id != null && currentTool.id == tool.id ||
                      identical(currentTool, tool) ||
                      editorController.toolCubit.state.index == index)) {
                updatedCurrent = updated;
              }
              final tempHandler =
                  editorController.toolCubit.state.temporaryHandler;
              if (tempHandler != null &&
                  (tempHandler.data.id != null &&
                          tempHandler.data.id == tool.id ||
                      identical(tempHandler.data, tool) ||
                      editorController.toolCubit.state.temporaryIndex ==
                          index)) {
                updatedTemporary = updated;
              }
              return updated;
            }).toList(),
          ),
        ),
      );
      if (updatedCurrent != null) {
        editorController.toolCubit.updateTool(
          editorController,
          this,
          updatedCurrent!,
        );
      }
      editorController.toolCubit.updateTogglingTools(
        editorController,
        this,
        changedTools,
      );
      if (updatedTemporary != null) {
        editorController.toolCubit.updateTemporaryTool(
          editorController,
          this,
          updatedTemporary!,
        );
      }
      if (selection != null) {
        editorController.toolCubit.changeSelection(selection);
      }
    });
    on<ToolsRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      _saveState(
        emit,
        state: current.copyWith(
          info: current.info.copyWith(
            tools: current.info.tools
                .where((element) => !event.tools.contains(element.id))
                .toList(),
          ),
        ),
        updateIndex: true,
      );
    });
    on<ToolsReplaced>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      _saveState(
        emit,
        state: current.copyWith(
          info: current.info.copyWith(
            tools: event.tools
                .map((e) => e.copyWith(id: e.id ?? createUniqueId()))
                .toList(),
          ),
        ),
        updateIndex: true,
      );
    });
    on<ToolReordered>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      var tools = List<Tool>.from(current.info.tools);
      var oldIndex = tools.indexWhere((element) => element.id == event.id);
      if (oldIndex == -1) return;
      var newIndex = event.newIndex;
      if (oldIndex < 0 ||
          newIndex < 0 ||
          oldIndex >= tools.length ||
          newIndex > tools.length) {}
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = tools.removeAt(oldIndex);
      tools.insert(newIndex, item);
      final cubit = editorController;
      var nextToolIndex = cubit.toolCubit.state.index;
      if (nextToolIndex != null) {
        if (nextToolIndex == oldIndex) {
          nextToolIndex = newIndex;
        } else if (nextToolIndex > oldIndex && nextToolIndex <= newIndex) {
          nextToolIndex -= 1;
        } else if (nextToolIndex < oldIndex && nextToolIndex >= newIndex) {
          nextToolIndex += 1;
        }
        cubit.toolCubit.setIndex(nextToolIndex);
      }
      _saveState(
        emit,
        state: current.copyWith(info: current.info.copyWith(tools: tools)),
      );
    });
    on<DocumentBackgroundsChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      final List<Renderer<Background>> backgrounds = event.backgrounds
          .map(Renderer.fromInstance)
          .toList();
      final newPage = current.page.copyWith(backgrounds: event.backgrounds);
      // Remove unused assets
      final unusedAssets = <String>{};
      current.page.backgrounds.whereType<SourcedElement>().forEach((element) {
        final uri = Uri.tryParse(element.source);
        if (uri?.scheme == '' && !newPage.usesSource(element.source)) {
          unusedAssets.add(element.source);
          current.assetService.invalidate(element.source);
        }
      });
      final data = current.data.removeAssets(unusedAssets.toList());
      for (final bg
          in editorController.rendererCubit.state.cameraViewport.backgrounds) {
        bg.dispose();
      }
      _saveState(
        emit,
        state: current.copyWith(page: newPage, data: data),
        backgrounds: backgrounds,
      );
    });
    on<WaypointCreated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      _saveState(
        emit,
        state: current.copyWith(
          page: current.page.copyWith(
            waypoints: List<Waypoint>.from(current.page.waypoints)
              ..add(event.waypoint),
          ),
        ),
      );
    });
    on<WaypointChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      if (current.page.getWaypointByName(event.name) == null) {
        // Waypoint doesn't exist yet, create it instead
        _saveState(
          emit,
          state: current.copyWith(
            page: current.page.copyWith(
              waypoints: List<Waypoint>.from(current.page.waypoints)
                ..add(event.waypoint),
            ),
          ),
        );
      } else {
        _saveState(
          emit,
          state: current.copyWith(
            page: current.page.copyWith(
              waypoints: current.page.waypoints.map((e) {
                if (e.name == event.name) {
                  return event.waypoint;
                }
                return e;
              }).toList(),
            ),
          ),
        );
      }
    });
    on<WaypointRemoved>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      return _saveState(
        emit,
        state: current.copyWith(
          page: current.page.copyWith(
            waypoints: List<Waypoint>.from(current.page.waypoints)
              ..removeWhere((element) => element.name == event.name),
          ),
        ),
      );
    });
    on<WaypointReordered>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      final waypoints = List<Waypoint>.from(current.page.waypoints);
      final waypoint = waypoints.firstWhereOrNull(
        (element) => element.name == event.name,
      );
      if (waypoint == null) return;
      waypoints.remove(waypoint);
      if (event.newIndex < 0 || event.newIndex > waypoints.length) return;
      waypoints.insert(event.newIndex, waypoint);
      final currentDocument = current.page.copyWith(waypoints: waypoints);
      _saveState(emit, state: current.copyWith(page: currentDocument));
    });

    on<CollectionRenamed>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      _saveState(
        emit,
        state: current.copyWith(
          page: current.page.mapLayers(
            (e) => e.copyWith(
              content: List<PadElement>.from(e.content)
                  .map(
                    (e) => e.collection == event.oldName
                        ? e.copyWith(collection: event.newName)
                        : e,
                  )
                  .toList(),
            ),
          ),
          currentCollection: current.currentCollection == event.oldName
              ? event.newName
              : current.currentCollection,
        ),
        reset: true,
        shouldRefresh: () => true,
      );
    });

    on<CollectionElementsRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      _saveState(
        emit,
        state: current.copyWith(
          page: current.page.mapLayers(
            (e) => e.copyWith(
              content: List<PadElement>.from(
                e.content,
              ).where((e) => e.collection != event.name).toList(),
            ),
          ),
          currentCollection: current.currentCollection == event.name
              ? ''
              : current.currentCollection,
        ),
        reset: true,
      );
    });

    on<LayerOrderChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final layers = List<DocumentLayer>.from(current.page.layers);
      final layer = layers.firstWhereOrNull((e) => e.id == event.id);
      if (layer == null) return;
      layers.remove(layer);
      if (event.index < 0 || event.index > layers.length) return;
      layers.insert(event.index, layer);
      final currentDocument = current.page.copyWith(layers: layers);
      _saveState(emit, state: current.copyWith(page: currentDocument));
    });

    on<LayerVisibilityChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final invisibleLayers = Set<String>.from(current.invisibleLayers);
      if (event.visible) {
        invisibleLayers.remove(event.id);
      } else {
        invisibleLayers.add(event.id);
      }
      final newState = current.copyWith(invisibleLayers: invisibleLayers);
      emit(newState);
      editorController.editorSessionCubit?.updateLayer(
        invisibleLayers: invisibleLayers,
      );
      editorController.rendererCubit.unbake(editorController, newState);
    });

    on<LayerCreated>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      return _saveState(
        emit,
        state: current.copyWith(
          page: current.page.copyWith(
            layers: [
              ...current.page.layers,
              DocumentLayer(id: event.id ?? createUniqueId(), name: event.name),
            ],
          ),
        ),
      );
    }, transformer: sequential());

    on<LayerChanged>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      return _saveState(
        emit,
        state: current.copyWith(
          page: current.page.copyWith(
            layers: current.page.layers
                .map(
                  (e) => e.id == event.id
                      ? e.copyWith(name: event.name ?? e.name)
                      : e,
                )
                .toList(),
          ),
        ),
      );
    });

    on<LayerRemoved>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      return _saveState(
        emit,
        state: current.copyWith(
          page: current.page.copyWith(
            layers: current.page.layers.where((e) => e.id != event.id).toList(),
          ),
        ),
      );
    }, transformer: sequential());

    on<LayersMerged>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      final layers = current.page.layers;
      if (event.duplicate) {
        final ids = event.layers.toSet();
        final duplicatedIds = <String, String>{};
        final newLayers = <DocumentLayer>[];
        final addedRenderers = <Renderer<PadElement>>[];
        for (final layer in layers) {
          newLayers.add(layer);
          final id = layer.id;
          if (id == null || !ids.contains(id)) continue;
          final newId = createUniqueId();
          final content = layer.content
              .map((element) => element.copyWith(id: createUniqueId()))
              .toList();
          duplicatedIds[id] = newId;
          newLayers.add(layer.copyWith(id: newId, content: content));
          addedRenderers.addAll(
            content.map((element) => Renderer.fromInstance(element, newId)),
          );
        }
        if (duplicatedIds.isEmpty) return;
        final invisibleLayers = Set<String>.from(current.invisibleLayers);
        for (final entry in duplicatedIds.entries) {
          if (invisibleLayers.contains(entry.key)) {
            invisibleLayers.add(entry.value);
          }
        }
        return _saveState(
          emit,
          state: current.copyWith(
            page: current.page.copyWith(layers: newLayers),
            currentLayer:
                duplicatedIds[current.currentLayer] ??
                duplicatedIds.values.last,
            invisibleLayers: invisibleLayers,
          ),
          addedElements: addedRenderers,
        );
      }
      if (event.layers.length < 2) return;
      final mainLayer = event.layers.first;
      final layerIndexes = {
        for (final entry in layers.asMap().entries) entry.value.id: entry.key,
      };
      final mainLayerIndex = layerIndexes[mainLayer];
      if (mainLayerIndex == null) return;
      final mergedLayers =
          event.layers.skip(1).where(layerIndexes.containsKey).toList()
            ..sort((a, b) => layerIndexes[a]!.compareTo(layerIndexes[b]!));
      final belowLayers = mergedLayers.where(
        (element) => (layerIndexes[element] ?? -1) < mainLayerIndex,
      );
      final aboveLayers = mergedLayers.where(
        (element) => (layerIndexes[element] ?? -1) > mainLayerIndex,
      );
      var layer = current.page.getLayer(mainLayer);
      layer = layer.copyWith(
        content: [
          ...belowLayers.expand((e) => current.page.getLayer(e).content),
          ...layer.content,
          ...aboveLayers.expand((e) => current.page.getLayer(e).content),
        ],
      );
      final newLayers = layers
          .where((e) => !mergedLayers.contains(e.id))
          .map((e) => e.id == mainLayer ? layer : e)
          .toList();
      return _saveState(
        emit,
        state: current.copyWith(
          page: current.page.copyWith(layers: newLayers),
          currentLayer: mergedLayers.contains(current.currentLayer)
              ? mainLayer
              : current.currentLayer,
        ),
      );
    }, transformer: sequential());

    on<CurrentLayerChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      emit(current.copyWith(currentLayer: event.name));
      editorController.editorSessionCubit?.updateLayer(
        currentLayer: event.name,
      );
    });

    on<CurrentCollectionChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      emit(current.copyWith(currentCollection: event.name));
      editorController.editorSessionCubit?.updateLayer(
        currentCollection: event.name,
      );
    });

    on<ElementsCollectionChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      _saveState(
        emit,
        state: current.copyWith(
          page: current.page.mapLayers(
            (e) => e.copyWith(
              content: e.content.map((e) {
                if (event.elements.contains(e.id)) {
                  return e.copyWith(collection: event.collection);
                }
                return e;
              }).toList(),
            ),
          ),
        ),
        reset: true,
      );
    });
    on<AreasCreated>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final areasByPage = groupBy<AreaPreset, String>(
        event.areas,
        (area) => area.page.isEmpty ? current.pageName : area.page,
      );
      var data = current.data;
      var activePage = current.page;
      var shouldRepaint = false;
      for (final entry in areasByPage.entries) {
        final pageName = entry.key;
        final page = pageName == current.pageName
            ? activePage
            : data.getPage(pageName);
        if (page == null) continue;
        final existingNames = page.areas.map((e) => e.name).toSet();
        final areas = entry.value
            .map((preset) {
              final area = preset.area;
              if (area == null) return null;
              final baseName = area.name.isEmpty ? 'Area' : area.name;
              var name = baseName;
              var count = 1;
              while (existingNames.contains(name)) {
                name = '$baseName (${count++})';
              }
              existingNames.add(name);
              return area.copyWith(name: name);
            })
            .nonNulls
            .toList();
        if (areas.isEmpty) continue;
        if (pageName == current.pageName) {
          for (var element in editorController.rendererCubit.renderers) {
            final needRepaint = areas.any(
              (area) => element.onAreaUpdate(data, page, area),
            );
            if (needRepaint) {
              shouldRepaint = true;
            }
          }
        }

        final hasInitial = areas.any((e) => e.isInitial);
        final existingAreas = page.areas.map((e) {
          if (hasInitial && e.isInitial) {
            return e.copyWith(isInitial: false);
          }
          return e;
        }).toList();

        final updatedPage = page.copyWith(areas: [...existingAreas, ...areas]);
        if (pageName == current.pageName) {
          activePage = updatedPage;
        } else {
          data = data.setPage(updatedPage, pageName).$1;
        }
      }
      return _saveState(
        emit,
        state: current.copyWith(data: data, page: activePage),
        shouldRefresh: () => true,
        reset: shouldRepaint,
      );
    }, transformer: sequential());
    on<AreasDuplicated>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      final selectedPages = event.pages.toSet();
      var data = current.data.setPage(current.page, current.pageName).$1;
      var currentPage = current.page;
      var currentPageChanged = false;
      for (final (pageName, realPageName) in data.getPagesWithNames()) {
        if (!selectedPages.contains(pageName) &&
            !selectedPages.contains(realPageName)) {
          continue;
        }
        final page = data.getPage(realPageName);
        if (page == null) continue;
        final duplicatedArea = _createDuplicatedArea(event.area, page.areas);
        final areas = [
          ...page.areas.map((e) {
            if (duplicatedArea.isInitial && e.isInitial) {
              return e.copyWith(isInitial: false);
            }
            return e;
          }),
          duplicatedArea,
        ];
        final updatedPage = page.copyWith(areas: areas);
        data = data.setPage(updatedPage, realPageName).$1;
        if (realPageName == current.pageName) {
          currentPage = updatedPage;
          currentPageChanged = true;
        }
      }
      _saveState(
        emit,
        state: current.copyWith(data: data, page: currentPage),
        shouldRefresh: () => currentPageChanged,
        reset: currentPageChanged,
      );
    }, transformer: sequential());
    on<AreasRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      var data = current.data.setPage(current.page, current.pageName).$1;
      var currentPage = current.page;
      var currentAreaName = current.currentAreaName;
      var currentPageChanged = false;
      var shouldRepaint = false;
      final areasByPage = <String, Set<String>>{};
      for (final area in event.areas) {
        areasByPage.putIfAbsent(area.page, () => {}).add(area.name);
      }
      for (final entry in areasByPage.entries) {
        final page = data.getPage(entry.key);
        if (page == null) continue;
        final areas = List<Area>.from(page.areas)
          ..removeWhere((e) => entry.value.contains(e.name));
        final updatedPage = page.copyWith(areas: areas);
        data = data.setPage(updatedPage, entry.key).$1;
        if (entry.key == current.pageName) {
          currentPage = updatedPage;
          currentPageChanged = true;
          if (entry.value.contains(currentAreaName)) currentAreaName = '';
          for (var element in editorController.rendererCubit.renderers) {
            if (areas.contains(element.area) &&
                element.onAreaUpdate(current.data, currentPage, null)) {
              shouldRepaint = true;
            }
          }
        }
      }
      _saveState(
        emit,
        state: current.copyWith(
          data: data,
          page: currentPage,
          currentAreaName: currentAreaName,
        ),
        shouldRefresh: () => currentPageChanged,
        reset: shouldRepaint,
      );
    });
    on<AreaChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      final oldSelection = editorController.toolCubit.state.selection;
      var selection = oldSelection;
      final hasInitial = event.area.isInitial;
      Area? previousArea;
      final areas = current.page.areas.map((e) {
        if (e.name == event.name) {
          final updated = event.area;
          previousArea = e;
          selection = _updateSelection(selection, e, updated);
          return updated;
        }
        if (hasInitial && e.isInitial) {
          final updated = e.copyWith(isInitial: false);
          selection = _updateSelection(selection, e, updated);
          return updated;
        }
        return e;
      }).toList();
      var currentDocument = current.page.copyWith(areas: areas);
      final oldArea = previousArea;
      final movedElements = <String, PadElement>{};
      if (event.moveContents && oldArea != null) {
        final delta = Offset(
          event.area.position.x - oldArea.position.x,
          event.area.position.y - oldArea.position.y,
        );
        if (delta != Offset.zero) {
          for (final renderer in editorController.rendererCubit.renderers) {
            final id = renderer.element.id;
            final rect = renderer.expandedRect ?? renderer.rect;
            if (id == null || rect == null || !oldArea.rect.overlaps(rect)) {
              continue;
            }
            final transformed = renderer.transform(position: delta);
            if (transformed != null) {
              movedElements[id] = transformed.element;
            }
          }
          if (movedElements.isNotEmpty) {
            currentDocument = currentDocument.mapLayers(
              (layer) => layer.copyWith(
                content: layer.content
                    .map((element) => movedElements[element.id] ?? element)
                    .toList(),
              ),
            );
          }
        }
      }
      final shouldRepaint = editorController.rendererCubit.renderers.any(
        (element) =>
            element.area?.name == event.name &&
            element.onAreaUpdate(current.data, currentDocument, event.area),
      );
      if (selection != null && selection != oldSelection) {
        editorController.toolCubit.changeSelection(selection);
      }
      _saveState(
        emit,
        state: current.copyWith(page: currentDocument),
        reset: shouldRepaint || movedElements.isNotEmpty,
      );
    });
    on<AreaReordered>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      final areas = List<Area>.from(current.page.areas);
      final area = areas.firstWhereOrNull(
        (element) => element.name == event.name,
      );
      if (area == null) return;
      areas.remove(area);
      if (event.newIndex < 0 || event.newIndex > areas.length) return;
      areas.insert(event.newIndex, area);
      final currentDocument = current.page.copyWith(areas: areas);
      _saveState(emit, state: current.copyWith(page: currentDocument));
    });
    on<ExportPresetCreated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (current.info.getExportPreset(event.name) != null) return;
      final preset = ExportPreset(name: event.name, areas: event.areas);
      var currentInfo = current.info;
      currentInfo = currentInfo.copyWith(
        exportPresets: List<ExportPreset>.from(currentInfo.exportPresets)
          ..add(preset),
      );
      _saveState(emit, state: current.copyWith(info: currentInfo));
    });
    on<ExportPresetUpdated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      var currentInfo = current.info;
      final presets = currentInfo.exportPresets.map((e) {
        if (e.name == event.name) {
          return e.copyWith(areas: event.areas);
        }
        return e;
      }).toList();
      currentInfo = currentInfo.copyWith(exportPresets: presets);
      _saveState(emit, state: current.copyWith(info: currentInfo));
    });
    on<ExportPresetRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      var currentInfo = current.info;
      currentInfo = currentInfo.copyWith(
        exportPresets: currentInfo.exportPresets
            .where((element) => element.name != event.name)
            .toList(),
      );
      _saveState(emit, state: current.copyWith(info: currentInfo));
    });
    on<CurrentAreaChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      emit(current.copyWith(currentAreaName: event.name));
      delayedBake();
    });
    on<PackAdded>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      var name = event.pack.name ?? '';
      var i = 1;
      while (current.data.getBundledPack(name) != null) {
        name = '${event.pack.name} ($i)';
        i++;
      }
      final pack = event.pack.setName(name);
      _saveState(
        emit,
        state: current.copyWith(data: current.data.setBundledPack(pack)),
      );
    });
    on<PackUpdated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      _saveState(
        emit,
        state: current.copyWith(data: current.data.setBundledPack(event.pack)),
      );
    });
    on<PackRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      _saveState(
        emit,
        state: current.copyWith(
          data: current.data.removeBundledPack(event.name),
        ),
      );
    });
    on<AnimationAdded>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      if (current.page.getAnimation(event.animation.name) != null) return;
      final currentDocument = current.page.copyWith(
        animations: List<AnimationTrack>.from(current.page.animations)
          ..add(event.animation),
      );
      _saveState(emit, state: current.copyWith(page: currentDocument));
    });
    on<AnimationUpdated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      final currentDocument = current.page.copyWith(
        animations: current.page.animations.map((e) {
          if (e.name == event.name) {
            return event.animation;
          }
          return e;
        }).toList(),
      );
      _saveState(emit, state: current.copyWith(page: currentDocument));
    });
    on<AnimationRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(embedding?.editable ?? true)) return;
      final currentDocument = current.page.copyWith(
        animations: current.page.animations
            .where((element) => element.name != event.name)
            .toList(),
      );
      _saveState(emit, state: current.copyWith(page: currentDocument));
    });
    on<PresentationModeEntered>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final newState = DocumentPresentationState(
        this,
        current,
        event.track,
        event.fullScreen,
        assetService: current.assetService,
        pageName: current.pageName,
        page: current.page,
        metadata: current.metadata,
        fileSystem: current.fileSystem,
        windowCubit: current.windowCubit,
        absolute: current.absolute,
      );
      editorController.toolCubit.updateHandler(
        this,
        editorController.rendererCubit,
        newState.handler,
      );
      emit(newState);
    });
    on<PresentationModeExited>((event, emit) {
      final current = state;
      if (current is! DocumentPresentationState) return;
      emit(current.oldState);
      editorController.toolCubit.changeTool(editorController, this);
      setFullScreen(current.fullScreen);
    });
    on<PresentationTick>((event, emit) {
      final current = state;
      if (current is! DocumentPresentationState) return;
      emit(current.copyWith(frame: event.tick));
    });
    on<AssetUpdated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      var data = current.data;
      if (!validAssetPaths.any((e) => event.path.startsWith('$e/'))) return;
      data = data.setAsset(event.path, Uint8List.fromList(event.data));
      current.assetService.invalidate(event.path);
      final updatedRenderers = editorController.rendererCubit.renderers
          .where(
            (e) => e.onAssetUpdate(
              data,
              current.assetService,
              current.page,
              event.path,
            ),
          )
          .toList();
      editorController.rendererCubit.invalidateRenderers(updatedRenderers);
      _saveState(
        emit,
        state: current.copyWith(data: data),
        reset: updatedRenderers.isNotEmpty,
      );
    });
    on<ElementsLayerConverted>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final elements = current.page.content
          .where((element) => event.elements.contains(element.id))
          .toList();
      final newLayer = DocumentLayer(
        id: createUniqueId(),
        name: event.name,
        content: elements,
      );
      var newPage = current.mapLayer(
        (e) => e.copyWith(
          content: e.content
              .where((element) => !event.elements.contains(element.id))
              .toList(),
        ),
      );
      newPage = newPage.copyWith(layers: [...newPage.layers, newLayer]);
      _saveState(emit, state: current.copyWith(page: newPage), reset: true);
    });
    on<ElementsLayerMoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final elements = current.page.content
          .where((element) => event.elements.contains(element.id))
          .toList();
      var newPage = current.page.mapLayers((e) {
        if (e.id == event.layerId) {
          return e.copyWith(content: [...e.content, ...elements]);
        }
        return e.copyWith(
          content: e.content
              .where((element) => !event.elements.contains(element.id))
              .toList(),
        );
      });
      _saveState(emit, state: current.copyWith(page: newPage), reset: true);
    });
    on<EncryptionChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      var data = current.data;
      final password = event.password;
      data = data.changePassword(password);
      _saveState(emit, state: current.copyWith(data: data));
    });
    on<DocumentRebuilt>((event, emit) {
      var state = this.state;
      if (state is! DocumentLoadSuccess) return;
      final data = NoteData.fromData(event.data);
      final page = data.getPage(state.pageName);
      final metadata = data.getMetadata();
      _saveState(
        emit,
        state: state.copyWith(
          page: page,
          data: data,
          metadata: metadata,
          currentAreaName: getInitialArea(page),
        ),
        resetAll: true,
      );
    });
  }

  @override
  void onTransition(
    covariant Transition<ReplayEvent, DocumentState> transition,
  ) {
    if (transition.event is! DocumentEvent) {
      networkingService?.testForInits(transition.nextState);
    }
    super.onTransition(transition);
  }

  Future<void> _saveState(
    Emitter<DocumentState> emit, {
    DocumentLoadSuccess? state,
    List<Renderer<PadElement>> addedElements = const [],
    List<Renderer<PadElement>>? replacedElements,
    List<Renderer<Background>>? backgrounds,
    bool reset = false,
    bool unbake = false,
    bool? resetAll,
    bool Function()? shouldRefresh,
    bool updateIndex = false,
  }) async {
    if (this.state is! DocumentLoadSuccess && state == null) return;
    if (resetAll != null) {
      reset = resetAll;
      unbake = resetAll;
    }
    final oldState = this.state is DocumentLoadSuccess
        ? this.state as DocumentLoadSuccess
        : null;
    state ??= this.state as DocumentLoadSuccess;
    emit(state);
    return editorController.stateChanged(
      state,
      this,
      oldState: oldState,
      addedElements: addedElements,
      replacedElements: replacedElements,
      backgrounds: backgrounds,
      reset: reset,
      unbake: unbake,
      shouldRefresh: shouldRefresh,
      updateIndex: updateIndex,
    );
  }

  @override
  void onEvent(ReplayEvent event) {
    super.onEvent(event);

    if (event is DocumentEvent) {
      networkingService?.onEvent(event);
    }
  }

  Future<void> refresh({bool allowBake = true}) async {
    final current = state;
    final cubit = _editorController;
    if (current is! DocumentLoadSuccess || cubit == null) return;
    return cubit.toolCubit.refresh(cubit, current, allowBake: allowBake);
  }

  /// Lightweight refresh that only updates foregrounds without rebaking.
  /// Use this when handler internal state changes but document hasn't changed.
  Future<void> refreshForegrounds() async {
    final current = state;
    final cubit = _editorController;
    if (current is! DocumentLoadSuccess || cubit == null) return;
    return cubit.toolCubit.refreshForegrounds(cubit, current);
  }

  /// Ultra-lightweight update for cursor changes only.
  void updateCursor(MouseCursor cursor) {
    _editorController?.toolCubit.setCursor(cursor);
  }

  Future<void> refreshToolbar() =>
      _editorController?.toolCubit.refreshToolbar(this) ?? Future.value();

  Future<void> bake({
    Size? viewportSize,
    double? pixelRatio,
    bool reset = false,
  }) async {
    final current = state;
    final cubit = _editorController;
    if (current is! DocumentLoaded || cubit == null) return;
    return cubit.rendererCubit.bake(
      cubit,
      current,
      viewportSize: viewportSize,
      pixelRatio: pixelRatio,
      reset: reset,
    );
  }

  Future<void> delayedBake({
    Size? viewportSize,
    double? pixelRatio,
    bool reset = false,
    bool testTransform = false,
  }) {
    final current = state;
    final cubit = _editorController;
    if (current is! DocumentLoaded || cubit == null) return Future.value();
    return cubit.rendererCubit.delayedBake(
      cubit,
      current,
      viewportSize: viewportSize,
      pixelRatio: pixelRatio,
      reset: reset,
      testTransform: testTransform,
    );
  }

  void cancelDelayedBake() {
    _editorController?.rendererCubit.cancelDelayedBake();
  }

  Future<void> load() async {
    final current = state;
    final cubit = _editorController;
    if (current is! DocumentLoaded || cubit == null) return;
    if (!cubit.saveCubit.state.location.isEmpty) {
      cubit.saveCubit.setSaveState(
        saved: SaveState.saved,
        isCreating: false,
        keepRead: true,
      );
    } else {
      cubit.saveCubit.setSaveState(isCreating: true);
    }
    await cubit.rendererCubit.loadElements(cubit, current);
    cubit.init(this);
  }

  Future<void> reload() async {
    return _editorController?.reload(this);
  }

  void _scheduleHistoryReload() =>
      unawaited(_historyReloadRunner.schedule(reload));

  Future<void> createTemplate(
    String? remote, {
    String? directory,
    String? name,
    String? fileName,
  }) async {
    final current = state;
    final cubit = _editorController;
    if (current is! DocumentLoadSuccess || cubit == null) return;
    final data = await current.saveData();
    final render = await cubit.rendererCubit.render(
      cubit,
      current.data,
      current.page,
      current.info,
      ImageExportOptions(
        width: kThumbnailWidth.toDouble(),
        height: kThumbnailHeight.toDouble(),
      ),
      docState: current,
    );
    final thumbnail = render?.buffer.asUint8List();
    final settings = current.settingsCubit.state;
    final remoteStorage = settings.getRemote(remote);
    await current.fileSystem
        .buildTemplateSystem(remoteStorage)
        .createFile(
          name ?? '',
          data.createTemplate(
            name: name,
            thumbnail: thumbnail,
            directory: directory,
            fileName: fileName,
          ),
        );
  }

  Future<void> replaceTemplate(
    TemplateFileSystem templateSystem,
    String path,
    FileMetadata metadata,
  ) async {
    final current = state;
    final cubit = _editorController;
    if (current is! DocumentLoadSuccess || cubit == null) return;
    final data = await current.saveData();
    await templateSystem.updateFile(
      path,
      data.createTemplate(
        name: metadata.name,
        description: metadata.description,
        directory: metadata.directory,
        fileName: metadata.fileName,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _historyReloadRunner.disposeAndWait();
    clearHistory();
    final currentState = state;
    final editorController = _editorController;
    final transformCubit = editorController?.transformCubit;
    final assetService = _assetService;
    if (editorController != null && !editorController.isClosed) {
      await editorController.close();
    }
    if (transformCubit != null && !transformCubit.isClosed) {
      await transformCubit.close();
    }
    await assetService?.dispose();
    _editorController = null;
    _assetService = null;
    if (currentState is DocumentLoaded && !isClosed) {
      emit(
        DocumentLoadInProgress(
          fileSystem: currentState.fileSystem,
          windowCubit: currentState.windowCubit,
        ),
      );
    }
    return super.close();
  }

  Future<void> save({
    AssetLocation? location,
    bool force = false,
    bool isAutosave = false,
  }) async => await _editorController?.saveCubit.save(
    this,
    _editorController!.networkingService,
    location: location,
    force: force,
    isAutosave: isAutosave,
    editorSessionCubit: _editorController!.editorSessionCubit,
  );

  bool isInBounds(Offset globalPosition) {
    final state = this.state;
    if (state is! DocumentLoadSuccess) return false;
    final area = state.currentArea;
    if (area == null) return true;
    return area.rect.contains(globalPosition);
  }

  Future<Set<Renderer<PadElement>>> rayCast(
    Offset globalPosition,
    double radius, {
    CameraTransform? transform,
    bool useCollection = false,
    bool useLayer = false,
    HitElementMode? hitElementMode,
  }) async {
    return rayCastRect(
      Rect.fromCircle(center: globalPosition, radius: radius),
      transform: transform,
      useCollection: useCollection,
      useLayer: useLayer,
      hitElementMode: hitElementMode,
    );
  }

  Future<Set<Renderer<PadElement>>> rayCastRect(
    Rect rect, {
    CameraTransform? transform,
    bool useCollection = false,
    bool useLayer = false,
    HitElementMode? hitElementMode,
  }) async {
    final state = this.state;
    final cubit = _editorController;
    if (state is! DocumentLoadSuccess || cubit == null) return {};
    transform ??= cubit.transformCubit.state;
    final renderers = cubit.rendererCubit.state.cameraViewport.visibleElements;
    if (renderers.isEmpty) return {};
    hitElementMode ??= HitElementMode.touchAnywhere;

    final params = _RayCastParams(
      state.invisibleLayers,
      renderers.map((e) => _SmallRenderer.fromRenderer(e)).toList(),
      rect,
      transform.size,
      useCollection ? state.currentCollection : null,
      useLayer ? state.currentLayer : null,
      hitElementMode,
    );

    // Use synchronous execution for small element counts to avoid isolate overhead
    final Set<int> result;
    if (renderers.length < 100) {
      result = _executeRayCast(params);
    } else {
      result = await compute(_executeRayCast, params);
    }
    return result.map((e) => renderers[e]).toSet();
  }

  Future<Set<Renderer<PadElement>>> rayCastPolygon(
    List<Offset> points, {
    CameraTransform? transform,
    bool useCollection = false,
    bool useLayer = false,
    HitElementMode? hitElementMode,
  }) async {
    final state = this.state;
    final cubit = _editorController;
    if (state is! DocumentLoadSuccess || cubit == null) return {};
    final renderers = cubit.rendererCubit.state.cameraViewport.visibleElements;
    if (renderers.isEmpty) return {};
    transform ??= cubit.transformCubit.state;
    hitElementMode ??= HitElementMode.touchAnywhere;

    final params = _RayCastPolygonParams(
      state.invisibleLayers,
      renderers.map((e) => _SmallRenderer.fromRenderer(e)).toList(),
      points,
      transform.size,
      useCollection ? state.currentCollection : null,
      useLayer ? state.currentLayer : null,
      hitElementMode,
    );

    // Use synchronous execution for small element counts to avoid isolate overhead
    final Set<int> result;
    if (renderers.length < 100) {
      result = _executeRayCastPolygon(params);
    } else {
      result = await compute(_executeRayCastPolygon, params);
    }
    return result.map((e) => renderers[e]).toSet();
  }

  void sendUndo() {
    if (!(networkingService?.sendUndo() ?? false)) {
      undo();
      _scheduleHistoryReload();
    }
  }

  void sendRedo() {
    if (!(networkingService?.sendRedo() ?? false)) {
      redo();
      _scheduleHistoryReload();
    }
  }
}

class _SmallRenderer {
  final HitCalculator hitCalc;
  final PadElement element;
  final String? layer;

  _SmallRenderer(this.hitCalc, this.element, this.layer);
  _SmallRenderer.fromRenderer(Renderer renderer)
    : this(renderer.getHitCalculator(), renderer.element, renderer.layer);
}

class _RayCastParams {
  final Set<String> invisibleLayers;
  final List<_SmallRenderer> renderers;
  final Rect rect;
  final double size;
  final String? collection, layer;
  final HitElementMode hitElementMode;

  const _RayCastParams(
    this.invisibleLayers,
    this.renderers,
    this.rect,
    this.size,
    this.collection,
    this.layer,
    this.hitElementMode,
  );
}

Set<int> _executeRayCast(_RayCastParams params) {
  final rect = params.rect.normalized();
  return params.renderers
      .asMap()
      .entries
      .where((e) => !params.invisibleLayers.contains(e.value.layer))
      .where(
        (e) =>
            e.value.hitCalc.hit(rect, hitElementMode: params.hitElementMode) &&
            (params.collection == null ||
                e.value.element.collection == params.collection) &&
            (params.layer == null || e.value.layer == params.layer),
      )
      .map((e) => e.key)
      .toSet();
}

class _RayCastPolygonParams {
  final Set<String> invisibleLayers;
  final List<_SmallRenderer> renderers;
  final List<Offset> polygon;
  final double size;
  final String? collection, layer;
  final HitElementMode hitElementMode;

  const _RayCastPolygonParams(
    this.invisibleLayers,
    this.renderers,
    this.polygon,
    this.size,
    this.collection,
    this.layer,
    this.hitElementMode,
  );
}

Set<int> _executeRayCastPolygon(_RayCastPolygonParams params) {
  return params.renderers
      .asMap()
      .entries
      .where((e) => !params.invisibleLayers.contains(e.value.layer))
      .where(
        (e) =>
            e.value.hitCalc.hitPolygon(
              params.polygon,
              hitElementMode: params.hitElementMode,
            ) &&
            (params.collection == null ||
                e.value.element.collection == params.collection) &&
            (params.layer == null || e.value.layer == params.layer),
      )
      .map((e) => e.key)
      .toSet();
}
