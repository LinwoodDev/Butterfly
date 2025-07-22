import 'dart:async';
import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
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

class DocumentBloc extends ReplayBloc<DocumentEvent, DocumentState> {
  DocumentBloc(
    ButterflyFileSystem fileSystem,
    CurrentIndexCubit currentIndexCubit,
    WindowCubit windowCubit,
    NoteData initial,
    AssetLocation location,
    List<Renderer<PadElement>> renderer, [
    AssetService? assetService,
    DocumentPage? page,
    String? pageName,
    bool absolute = false,
  ]) : super(
         DocumentLoadSuccess(
           initial,
           page: page,
           assetService: assetService,
           windowCubit: windowCubit,
           currentIndexCubit: currentIndexCubit,
           location: location,
           fileSystem: fileSystem,
           pageName: pageName ?? initial.getPages().firstOrNull ?? 'default',
         ),
       ) {
    _init();
  }

  DocumentBloc.error(
    ButterflyFileSystem fileSystem,
    WindowCubit windowCubit,
    String message, [
    StackTrace? stackTrace,
  ]) : super(
         DocumentLoadFailure(
           fileSystem: fileSystem,
           windowCubit: windowCubit,
           message: message,
           stackTrace: stackTrace,
         ),
       );

  DocumentBloc.placeholder(
    ButterflyFileSystem fileSystem,
    WindowCubit windowCubit,
  ) : super(
        DocumentLoadFailure(
          fileSystem: fileSystem,
          windowCubit: windowCubit,
          message: '',
        ),
      );

  void _init() {
    on<PageAdded>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final page =
          event.page ?? DocumentPage(backgrounds: current.page.backgrounds);
      final data = current.data.setPage(current.page, current.pageName);
      final (newData, pageName) = data.addPage(page, event.index);
      _saveState(
        emit,
        state: current.copyWith(data: newData, page: page, pageName: pageName),
        reset: true,
      );
    });
    on<PageChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final data = current.data.setPage(current.page, current.pageName);
      final page = data.getPage(event.pageName);
      if (page == null) return;
      _saveState(
        emit,
        state: current.copyWith(
          page: page,
          data: data,
          pageName: event.pageName,
        ),
        reset: true,
      );
    });
    on<PageReordered>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final newData = current.data.reorderPage(event.page, event.newIndex);
      _saveState(emit, state: current.copyWith(data: newData));
    });
    on<PageRenamed>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final newData = current.data.renamePage(event.oldName, event.newName);
      _saveState(
        emit,
        state: current.copyWith(
          data: newData,
          pageName: current.pageName == event.oldName
              ? event.newName
              : current.pageName,
        ),
      );
    });
    on<PageRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final newData = current.data.removePage(event.page);
      _saveState(emit, state: current.copyWith(data: newData));
    });
    on<ThumbnailCaptured>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final newData = current.data.setThumbnail(event.data);
      _saveState(emit, state: current.copyWith(data: newData));
    });
    on<ElementsCreated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      var data = current.data;
      String importImage(String source, String fileExtension) {
        final uri = Uri.tryParse(source);
        final uriData = uri?.data;
        if (uriData == null) {
          if ((uri?.isScheme('file') ?? false) || !(uri?.hasScheme ?? true)) {
            data = data.undoDelete(uri!.path);
          }
          return source;
        }
        final result = data.importImage(
          uriData.contentAsBytes(),
          fileExtension,
        );
        data = result.$1;
        return Uri.file(result.$2, windows: false).toString();
      }

      final elements = event.elements
          .map(
            (e) => switch (e) {
              ImageElement e => e.copyWith(
                source: importImage(e.source, 'png'),
              ),
              SvgElement e => e.copyWith(source: importImage(e.source, 'svg')),
              _ => e,
            },
          )
          .map((e) => e.copyWith(id: e.id ?? createUniqueId()))
          .toList();
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
        shouldRefresh: () => current.currentIndexCubit
            .getHandler()
            .onRenderersCreated(current.page, renderers),
      );
    });
    on<ElementsChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      final cubit = current.currentIndexCubit;
      final renderers = <Renderer<PadElement>>[];
      final selected = cubit.state.selection?.selected.toList();
      final page = current.page;
      final oldRenderers = current.renderers;
      final elements = event.elements.map(
        (key, value) => MapEntry(
          key,
          value.map((e) => e.copyWith(id: createUniqueId())).toList(),
        ),
      );
      final replacedRenderers =
          <Renderer<PadElement>, List<Renderer<PadElement>>>{};
      for (final renderer in oldRenderers) {
        final id = renderer.element.id;
        final updated = elements[id];
        if (updated != null) {
          renderer.dispose();
          final updatedRenderers = <Renderer<PadElement>>[];
          for (var element in updated) {
            final newRenderer = Renderer.fromInstance(
              element,
              current.currentLayer,
            );
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
      cubit.changeSelection(Selection.fromList(selected), false);
      _saveState(
        emit,
        state: current.copyWith(page: newPage),
        replacedElements: renderers,
        shouldRefresh: () => replacedRenderers.entries
            .map(
              (element) => cubit.getHandler().onRendererUpdated(
                page,
                element.key,
                element.value,
              ),
            )
            .toList()
            .any((e) => e),
      );
    }, transformer: sequential());
    on<ElementsArranged>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final renderers = List<Renderer<PadElement>>.from(current.renderers);
      final newPage = await current.page.mapLayersAsync((e) async {
        final content = List<PadElement>.from(e.content);
        for (final id in event.elements) {
          final index = content.indexWhere((element) => element.id == id);
          final element = content.removeAt(index);
          var newIndex = index;
          var newRendererIndex = renderers.indexWhere(
            (e) => e.element == element,
          );
          final renderer = newRendererIndex >= 0
              ? renderers.removeAt(newRendererIndex)
              : null;
          if (event.arrangement == Arrangement.front) {
            newIndex = content.length - 1;
            newRendererIndex = renderers.length - 1;
          } else if (event.arrangement == Arrangement.back) {
            newIndex = 0;
            newRendererIndex = 0;
          } else {
            final rect = renderer?.rect;
            if (rect != null) {
              final hits = (await rayCastRect(
                rect,
                full: false,
              )).map((e) => e.element).toList();
              final hitIndex = hits.indexOf(renderer!.element);
              if (hitIndex != -1) {
                if (event.arrangement == Arrangement.backward &&
                    hitIndex != 0) {
                  newIndex = content.indexOf(hits[hitIndex - 1]);
                } else if (event.arrangement == Arrangement.forward &&
                    hitIndex != hits.length - 1) {
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
            }
          }
          if (newIndex >= 0) {
            content.insert(newIndex, element);
          } else {
            content.add(element);
          }
          if (renderer != null) {
            if (newRendererIndex >= 0) {
              renderers.insert(newRendererIndex, renderer);
            } else {
              renderers.add(renderer);
            }
          }
        }
        return e.copyWith(content: content);
      });
      current.currentIndexCubit.unbake(unbakedElements: renderers);
      _saveState(emit, state: current.copyWith(page: newPage), unbake: true);
    });
    on<ElementsRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      if (event.elements.isEmpty) return;
      final newPage = current.page.mapLayers(
        (e) => e.copyWith(
          content: e.content
              .where((element) => !event.elements.contains(element.id))
              .toList(),
        ),
      );
      current.currentIndexCubit.removeSelection(event.elements);
      // Remove unused assets
      final unusedAssets = <String>{};
      event.elements.whereType<SourcedElement>().forEach((element) {
        final uri = Uri.tryParse(element.source);
        if (uri?.scheme == '' && !newPage.usesSource(element.source)) {
          unusedAssets.add(element.source);
        }
      });
      final data = current.data.removeAssets(unusedAssets.toList());
      _saveState(
        emit,
        state: current.copyWith(page: newPage, data: data),
        reset: true,
      );
    }, transformer: sequential());
    on<DocumentDescriptionChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
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
      if (!(current.embedding?.editable ?? true)) return;
      _saveState(
        emit,
        state: current.copyWith(
          info: current.info.copyWith(
            tools: List.from(current.info.tools)..add(event.tool),
          ),
        ),
      );
    });
    on<ToolsChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      final oldTools = current.info.tools;
      var selection = current.currentIndexCubit.state.selection;
      _saveState(
        emit,
        state: current.copyWith(
          info: current.info.copyWith(
            tools: List<Tool>.from(current.info.tools).mapIndexed((i, e) {
              final updated = event.tools[i];
              if (updated != null) {
                var newSelection = selection?.remove(e);
                if (newSelection != selection && selection != null) {
                  if (newSelection == null) {
                    newSelection = Selection.from(updated);
                  } else {
                    newSelection.insert(updated);
                  }
                  selection = newSelection;
                }
                return updated;
              } else {
                return e;
              }
            }).toList(),
          ),
        ),
      );
      final updatedCurrent = event.tools.entries.firstWhereOrNull(
        (element) =>
            oldTools[element.key] ==
            current.currentIndexCubit.state.handler.data,
      );
      if (updatedCurrent != null) {
        current.currentIndexCubit.updateTool(this, updatedCurrent.value);
      }
      current.currentIndexCubit.updateTogglingTools(this, event.tools);
      final updatedTempCurrent = event.tools.entries.firstWhereOrNull(
        (element) =>
            oldTools[element.key] ==
            current.currentIndexCubit.state.temporaryHandler?.data,
      );
      if (updatedTempCurrent != null) {
        current.currentIndexCubit.updateTemporaryTool(
          this,
          updatedTempCurrent.value,
        );
      }
      if (selection != null) {
        current.currentIndexCubit.changeSelection(selection);
      }
    });
    on<ToolsRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      _saveState(
        emit,
        state: current.copyWith(
          info: current.info.copyWith(
            tools: current.info.tools
                .whereIndexed((index, _) => !event.tools.contains(index))
                .toList(),
          ),
        ),
        updateIndex: true,
      );
    });
    on<ToolReordered>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      var tools = List<Tool>.from(current.info.tools);
      var oldIndex = event.oldIndex;
      var newIndex = event.newIndex;
      if (oldIndex >= tools.length || newIndex > tools.length) return;
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = tools.removeAt(oldIndex);
      tools.insert(newIndex, item);
      final cubit = current.currentIndexCubit;
      var nextCurrentIndex = cubit.state.index;
      if (nextCurrentIndex != null) {
        if (nextCurrentIndex == oldIndex) {
          nextCurrentIndex = newIndex;
        } else if (nextCurrentIndex > oldIndex &&
            nextCurrentIndex <= newIndex) {
          nextCurrentIndex -= 1;
        } else if (nextCurrentIndex < oldIndex &&
            nextCurrentIndex >= newIndex) {
          nextCurrentIndex += 1;
        }
        cubit.changeIndex(nextCurrentIndex);
      }
      _saveState(
        emit,
        state: current.copyWith(info: current.info.copyWith(tools: tools)),
      );
    });
    on<DocumentBackgroundsChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
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
        }
      });
      final data = current.data.removeAssets(unusedAssets.toList());
      _saveState(
        emit,
        state: current.copyWith(page: newPage, data: data),
        backgrounds: backgrounds,
      );
    });
    on<WaypointCreated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
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
      if (!(current.embedding?.editable ?? true)) return;
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
    on<WaypointRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
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
      if (!(current.embedding?.editable ?? true)) return;
      final waypoints = List<Waypoint>.from(current.page.waypoints);
      final waypoint = waypoints.firstWhereOrNull(
        (element) => element.name == event.name,
      );
      if (waypoint == null) return;
      waypoints.remove(waypoint);
      waypoints.insert(event.newIndex, waypoint);
      final currentDocument = current.page.copyWith(waypoints: waypoints);
      _saveState(emit, state: current.copyWith(page: currentDocument));
    });

    on<CollectionRenamed>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
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
      if (!(current.embedding?.editable ?? true)) return;
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
      emit(current.copyWith(invisibleLayers: invisibleLayers));
      current.currentIndexCubit.unbake();
    });

    on<LayerCreated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
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
    });

    on<LayerChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
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

    on<LayerRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      return _saveState(
        emit,
        state: current.copyWith(
          page: current.page.copyWith(
            layers: current.page.layers.where((e) => e.id != event.id).toList(),
          ),
        ),
      );
    });

    on<LayersMerged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      if (event.layers.length < 2) return;
      final layers = current.page.layers;
      final mainLayer = event.layers.first;
      final mainLayerIndex = layers.indexWhere(
        (element) => element.id == mainLayer,
      );
      final mergedLayers = event.layers.skip(1).toList()
        ..sort(
          (a, b) => layers
              .indexWhere((e) => e.id == a)
              .compareTo(layers.indexWhere((e) => e.id == b)),
        );
      final belowLayers = mergedLayers.where(
        (element) => layers.indexWhere((e) => e.id == element) < mainLayerIndex,
      );
      final aboveLayers = mergedLayers.where(
        (element) => layers.indexWhere((e) => e.id == element) > mainLayerIndex,
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
          .where((e) => event.duplicate || !mergedLayers.contains(e.id))
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
    });

    on<CurrentLayerChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      emit(current.copyWith(currentLayer: event.name));
    });

    on<CurrentCollectionChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      emit(current.copyWith(currentCollection: event.name));
    });

    on<ElementsCollectionChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
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
    on<AreasCreated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final areas = event.areas.map((e) {
        var name = e.name;
        var count = 1;
        while (current.page.areas.any((element) => element.name == name)) {
          name = '${e.name} (${count++})';
        }
        return e.copyWith(name: name);
      }).toList();
      var shouldRepaint = false;
      for (var element in current.renderers) {
        final needRepaint = areas.any(
          (area) => element.onAreaUpdate(current.data, current.page, area),
        );
        if (needRepaint) {
          shouldRepaint = true;
        }
      }
      final currentDocument = current.page.copyWith(
        areas: [...current.page.areas, ...areas],
      );
      return _saveState(
        emit,
        state: current.copyWith(page: currentDocument),
        shouldRefresh: () => true,
        reset: shouldRepaint,
      );
    });
    on<AreasRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      final areas = List<Area>.from(current.page.areas)
        ..removeWhere((e) => event.areas.contains(e.name));
      final currentPage = current.page.copyWith(areas: areas);
      var shouldRepaint = false;
      for (var element in current.renderers) {
        if (areas.contains(element.area) &&
            element.onAreaUpdate(current.data, currentPage, null)) {
          shouldRepaint = true;
        }
      }
      _saveState(
        emit,
        state: current.copyWith(page: currentPage),
        shouldRefresh: () => true,
        reset: shouldRepaint,
      );
    });
    on<AreaChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      final areas = current.page.areas.map((e) {
        if (e.name == event.name) {
          return event.area;
        }
        return e;
      }).toList();
      final currentDocument = current.page.copyWith(areas: areas);
      final shouldRepaint = current.renderers.any(
        (element) =>
            element.area?.name == event.name &&
            element.onAreaUpdate(current.data, currentDocument, event.area),
      );
      _saveState(
        emit,
        state: current.copyWith(page: currentDocument),
        reset: shouldRepaint,
      );
    });
    on<AreaReordered>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      final areas = List<Area>.from(current.page.areas);
      final area = areas.firstWhereOrNull(
        (element) => element.name == event.name,
      );
      if (area == null) return;
      areas.remove(area);
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
      if (!(current.embedding?.editable ?? true)) return;
      emit(current.copyWith(currentAreaName: event.name));
      current.bake();
    });
    on<PackAdded>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      var name = event.pack.name ?? '';
      var i = 1;
      while (current.data.getPack(name) != null) {
        name = '${event.pack.name} ($i)';
        i++;
      }
      final pack = event.pack.setName(name);
      _saveState(
        emit,
        state: current.copyWith(data: current.data.setPack(pack)),
      );
    });
    on<PackUpdated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      _saveState(
        emit,
        state: current.copyWith(data: current.data.setPack(event.pack)),
      );
    });
    on<PackRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      _saveState(
        emit,
        state: current.copyWith(data: current.data.removePack(event.name)),
      );
    });
    on<AnimationAdded>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
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
      if (!(current.embedding?.editable ?? true)) return;
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
      if (!(current.embedding?.editable ?? true)) return;
      final currentDocument = current.page.copyWith(
        animations: current.page.animations
            .where((element) => element.name != event.name)
            .toList(),
      );
      _saveState(emit, state: current.copyWith(page: currentDocument));
    });
    on<DocumentSaved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      current.currentIndexCubit.setSaveState(
        saved: SaveState.saved,
        location: event.location,
      );
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
      );
      current.currentIndexCubit.updateHandler(this, newState.handler);
      emit(newState);
    });
    on<PresentationModeExited>((event, emit) {
      final current = state;
      if (current is! DocumentPresentationState) return;
      emit(current.oldState);
      current.currentIndexCubit.changeTool(this);
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
      current.assetService.invalidateImage(event.path);
      final shouldRepaint = current.renderers.any(
        (e) => e.onAssetUpdate(
          current.data,
          current.assetService,
          current.page,
          event.path,
        ),
      );
      _saveState(
        emit,
        state: current.copyWith(data: data),
        reset: shouldRepaint,
      );
    });
    on<ElementsLayerConverted>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final layer = current.getLayer();
      final elements = layer.content
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
        state: state.copyWith(page: page, data: data, metadata: metadata),
        resetAll: true,
      );
    });
  }

  @override
  void onTransition(
    covariant Transition<ReplayEvent, DocumentState> transition,
  ) {
    if (transition.event is! DocumentEvent) {
      state.networkingService?.testForInits(transition.nextState);
    }
    super.onTransition(transition);
  }

  void _saveState(
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
  }) {
    if (this.state is! DocumentLoadSuccess && state == null) return;
    if (resetAll != null) {
      reset = resetAll;
      unbake = resetAll;
    }
    state ??= this.state as DocumentLoadSuccess;
    emit(state);
    state.currentIndexCubit.stateChanged(
      state,
      this,
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
      state.networkingService?.onEvent(event);
    }
  }

  Future<void> refresh() async {
    final current = state;
    if (current is! DocumentLoadSuccess) return;
    return current.currentIndexCubit.refresh(current);
  }

  Future<void> bake({
    Size? viewportSize,
    double? pixelRatio,
    bool reset = false,
  }) async {
    final current = state;
    if (current is! DocumentLoaded) return;
    return current.bake(
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
    if (current is! DocumentLoaded) return Future.value();
    return current.delayedBake(
      viewportSize: viewportSize,
      pixelRatio: pixelRatio,
      reset: reset,
      testTransform: testTransform,
    );
  }

  Future<void> load() async {
    final current = state;
    if (current is! DocumentLoaded) return;
    final cubit = current.currentIndexCubit;
    if (!current.location.isEmpty) {
      cubit.setSaveState(saved: SaveState.saved, isCreating: false);
    } else {
      cubit.setSaveState(isCreating: true);
    }
    cubit.loadElements(current);
    cubit.init(this);
  }

  Future<void> createTemplate(
    String? remote, {
    String? directory,
    String? name,
  }) async {
    final current = state;
    if (current is! DocumentLoadSuccess) return;
    final data = await current.saveData();
    final render = await current.currentIndexCubit.render(
      current.data,
      current.page,
      current.info,
      ImageExportOptions(
        width: kThumbnailWidth.toDouble(),
        height: kThumbnailHeight.toDouble(),
      ),
    );
    final thumbnail = render?.buffer.asUint8List();
    final settings = current.settingsCubit.state;
    final remoteStorage = settings.getRemote(remote);
    current.fileSystem
        .buildTemplateSystem(remoteStorage)
        .createFile(
          name ?? '',
          data.createTemplate(
            name: name,
            thumbnail: thumbnail,
            directory: directory,
          ),
        );
  }

  void dispose() {
    final current = state;
    if (current is! DocumentLoaded) return;
    current.currentIndexCubit.dispose();
    state.assetService?.dispose();
  }

  Future<void> save() {
    final current = state;
    if (current is! DocumentLoadSuccess) return Future.value();
    return current.save();
  }

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
  }) async {
    return rayCastRect(
      Rect.fromCircle(center: globalPosition, radius: radius),
      transform: transform,
      useCollection: useCollection,
      useLayer: useLayer,
    );
  }

  Future<Set<Renderer<PadElement>>> rayCastRect(
    Rect rect, {
    CameraTransform? transform,
    bool useCollection = false,
    bool useLayer = false,
    bool? full,
  }) async {
    final state = this.state;
    if (state is! DocumentLoadSuccess) return {};
    transform ??= state.currentIndexCubit.state.transformCubit.state;
    final renderers = state.cameraViewport.visibleElements;
    full ??= state.currentIndexCubit.state.utilities.fullSelection;
    return compute(
      _executeRayCast,
      _RayCastParams(
        state.invisibleLayers,
        renderers.map((e) => _SmallRenderer.fromRenderer(e)).toList(),
        rect,
        transform.size,
        useCollection ? state.currentCollection : null,
        useLayer ? state.currentLayer : null,
        full,
      ),
    ).then((value) => value.map((e) => renderers[e]).toSet());
  }

  Future<Set<Renderer<PadElement>>> rayCastPolygon(
    List<Offset> points, {
    CameraTransform? transform,
    bool useCollection = false,
    bool useLayer = false,
    bool? full,
  }) async {
    final state = this.state;
    if (state is! DocumentLoadSuccess) return {};
    final renderers = state.cameraViewport.visibleElements;
    transform ??= state.currentIndexCubit.state.transformCubit.state;
    full ??= state.currentIndexCubit.state.utilities.fullSelection;
    return compute(
      _executeRayCastPolygon,
      _RayCastPolygonParams(
        state.invisibleLayers,
        renderers.map((e) => _SmallRenderer.fromRenderer(e)).toList(),
        points,
        transform.size,
        useCollection ? state.currentCollection : null,
        useLayer ? state.currentLayer : null,
        full,
      ),
    ).then((value) => value.map((e) => renderers[e]).toSet());
  }

  void sendUndo() {
    if (!(state.networkingService?.sendUndo() ?? false)) {
      undo();
    }
  }

  void sendRedo() {
    if (!(state.networkingService?.sendRedo() ?? false)) {
      redo();
    }
  }
}

typedef HitRequest = bool Function(Offset position, [double radius]);

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
  final bool full;

  const _RayCastParams(
    this.invisibleLayers,
    this.renderers,
    this.rect,
    this.size,
    this.collection,
    this.layer,
    this.full,
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
            e.value.hitCalc.hit(rect, full: params.full) &&
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
  final bool full;

  const _RayCastPolygonParams(
    this.invisibleLayers,
    this.renderers,
    this.polygon,
    this.size,
    this.collection,
    this.layer,
    this.full,
  );
}

Set<int> _executeRayCastPolygon(_RayCastPolygonParams params) {
  return params.renderers
      .asMap()
      .entries
      .where((e) => !params.invisibleLayers.contains(e.value.layer))
      .where(
        (e) =>
            e.value.hitCalc.hitPolygon(params.polygon, full: params.full) &&
            (params.collection == null ||
                e.value.element.collection == params.collection) &&
            (params.layer == null || e.value.layer == params.layer),
      )
      .map((e) => e.key)
      .toSet();
}
