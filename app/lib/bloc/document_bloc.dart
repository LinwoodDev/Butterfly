import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:butterfly/api/file_system/file_system.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../api/full_screen.dart';
import '../cubits/settings.dart';
import '../cubits/transform.dart';
import '../embed/embedding.dart';
import '../models/defaults.dart';
import '../models/viewport.dart';
import '../renderers/renderer.dart';
import '../services/asset.dart';
import '../services/network.dart';

part 'document_state.dart';

enum ConnectionStatus { none, server, client }

class DocumentBloc extends ReplayBloc<DocumentEvent, DocumentState> {
  DocumentBloc(
    CurrentIndexCubit currentIndexCubit,
    SettingsCubit settingsCubit,
    NoteData initial,
    AssetLocation location,
    Renderer<Background> background,
    List<Renderer<PadElement>> renderer, [
    AssetService? assetService,
    DocumentPage? page,
    String? pageName,
  ]) : super(DocumentLoadSuccess(
          initial,
          page: page,
          assetService: assetService,
          networkService: NetworkService(),
          currentIndexCubit: currentIndexCubit,
          location: location,
          settingsCubit: settingsCubit,
          pageName: pageName ?? initial.getPages().firstOrNull ?? 'default',
        )) {
    _init();
  }

  DocumentBloc.error(String message) : super(DocumentLoadFailure(message));

  DocumentBloc.placeholder() : super(const DocumentLoadFailure(''));

  void _init() {
    (state as DocumentLoaded).networkService.setup(this);
    on<PageChanged>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      current.data.setPage(current.page, current.pageName);
      final page = current.data.getPage(event.pageName);
      if (page == null) return;
      current.currentIndexCubit
          .loadElements(current.data, current.assetService, page);
      refresh();
      return _saveState(
        emit,
        current.copyWith(
          page: page,
          pageName: event.pageName,
        ),
        null,
      );
    });
    on<ToolStateChanged>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      await current.currentIndexCubit.updateTool(
          current.data,
          current.page,
          current.assetService,
          event.state ?? current.cameraViewport.tool.element);
    });
    on<ToolOptionChanged>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      return _saveState(
        emit,
        current.copyWith(
          info: current.info.copyWith(
            tool: event.option ?? current.info.tool,
          ),
        ),
      );
    });
    on<ElementsCreated>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      final renderers =
          event.elements.map((e) => Renderer.fromInstance(e)).toList();
      return _saveState(
          emit,
          current.copyWith(
              page: current.page.copyWith(
                  content: (List.from(current.page.content)
                    ..addAll(renderers.map((e) => e.element))))),
          renderers);
    }, transformer: sequential());
    on<ElementsChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        final data = current.data;
        final assetService = current.assetService;
        final page = current.page;
        var renderers = current.renderers;
        renderers = List<Renderer<PadElement>>.from(renderers);
        for (final entry in event.elements.entries) {
          final index = entry.key;
          final current = entry.value.map((e) => Renderer.fromInstance(e));
          await Future.wait(
              current.map((e) async => e.setup(data, assetService, page)));
          renderers[index].dispose();
          renderers.removeAt(index);
          renderers.insertAll(index, current);
        }
        return _saveState(
            emit,
            current.copyWith(
              page: current.page
                  .copyWith(content: renderers.map((e) => e.element).toList()),
            ),
            null);
      }
    }, transformer: sequential());
    on<ElementsArranged>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final content = List<PadElement>.from(current.page.content);
      final renderers = List<Renderer<PadElement>>.from(current.renderers);
      final transform = current.transformCubit.state;
      for (final index in event.elements) {
        final element = content.removeAt(index);
        var newIndex = index;
        var newRendererIndex =
            renderers.indexWhere((e) => e.element == element);
        final renderer =
            newRendererIndex >= 0 ? renderers.removeAt(newRendererIndex) : null;
        if (event.arrangement == Arrangement.front) {
          newIndex = content.length - 1;
          newRendererIndex = renderers.length - 1;
        } else if (event.arrangement == Arrangement.back) {
          newIndex = 0;
          newRendererIndex = 0;
        } else {
          final rect = renderer?.rect;
          if (rect != null) {
            final hits = (await rayCastRect(rect, this, transform))
                .map((e) => e.element)
                .toList();
            final hitIndex = hits.indexOf(renderer!.element);
            if (hitIndex != -1) {
              if (event.arrangement == Arrangement.backward && hitIndex != 0) {
                newIndex = content.indexOf(hits[hitIndex - 1]);
              } else if (event.arrangement == Arrangement.forward &&
                  hitIndex != hits.length - 1) {
                newIndex = content.indexOf(hits[hitIndex + 1]) + 1;
              }
              if (newIndex >= 0) {
                final element = content[newIndex];
                newRendererIndex =
                    renderers.indexWhere((e) => e.element == element);
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
      current.currentIndexCubit.unbake(
        unbakedElements: renderers,
      );
      final newPage = current.page.copyWith(content: content);
      return _saveState(
          emit,
          current.copyWith(
            page: newPage,
          ),
          null);
    });
    on<ElementsRemoved>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      if (event.elements.isEmpty) return;
      final page = current.page;
      final renderers = current.renderers;
      final newContent = page.content
          .whereIndexed((index, element) => !event.elements.contains(index))
          .toList();
      current.currentIndexCubit.unbake(
        unbakedElements: renderers.where((renderer) {
          if (newContent.contains(renderer.element)) return false;
          renderer.dispose();
          return true;
        }).toList(),
      );
      final newPage = page.copyWith(content: newContent);
      // Remove unused assets
      final unusedAssets = <String>{};
      event.elements.whereType<SourcedElement>().forEach((element) {
        final uri = Uri.tryParse(element.source);
        if (uri?.scheme == '' && !newPage.usesSource(element.source)) {
          unusedAssets.add(element.source);
        }
      });
      for (var asset in unusedAssets) {
        current.data.removeAsset(asset);
      }

      await _saveState(emit, current.copyWith(page: newPage), null);
    }, transformer: sequential());
    on<DocumentDescriptionChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        return _saveState(
          emit,
          current.copyWith(
            metadata: current.metadata.copyWith(
              name: event.name ?? current.metadata.name,
              description: event.description ?? current.metadata.description,
            ),
          ),
        );
      }
    });
    on<PainterCreated>((event, emit) async {
      final current = state;
      if (current is DocumentLoadSuccess) {
        if (!(current.embedding?.editable ?? true)) return;
        return _saveState(
                emit,
                current.copyWith(
                    info: current.info.copyWith(
                        painters: List.from(current.info.painters)
                          ..add(event.painter))))
            .then((value) {
          current.currentIndexCubit
              .changePainter(this, current.info.painters.length, null, true);
        });
      }
    });
    on<PaintersChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        final oldPainters = current.info.painters;
        final painters = List<Painter>.from(oldPainters);
        for (final entry in event.painters.entries) {
          painters[entry.key] = entry.value;
        }
        await _saveState(emit,
            current.copyWith(info: current.info.copyWith(painters: painters)));
        final updatedCurrent = event.painters.entries.firstWhereOrNull(
            (element) =>
                oldPainters[element.key] ==
                current.currentIndexCubit.state.handler.data);
        if (updatedCurrent != null) {
          current.currentIndexCubit.updatePainter(this, updatedCurrent.value);
        }
        final updatedTempCurrent = event.painters.entries.firstWhereOrNull(
            (element) =>
                oldPainters[element.key] ==
                current.currentIndexCubit.state.temporaryHandler?.data);
        if (updatedTempCurrent != null) {
          current.currentIndexCubit
              .updateTemporaryPainter(this, updatedTempCurrent.value);
        }
      }
    });
    on<PaintersRemoved>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        final cubit = current.currentIndexCubit;
        return _saveState(
                emit,
                current.copyWith(
                    info: current.info.copyWith(
                        painters: current.info.painters
                            .whereIndexed(
                                (index, _) => !event.painters.contains(index))
                            .toList())))
            .then((value) {
          cubit.updateIndex(this);
        });
      }
    });
    on<PainterReordered>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        var painters = List<Painter>.from(current.info.painters);
        var oldIndex = event.oldIndex;
        var newIndex = event.newIndex;
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        final item = painters.removeAt(oldIndex);
        painters.insert(newIndex, item);
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
        return _saveState(
            emit,
            current.copyWith(
              info: current.info.copyWith(painters: painters),
            ));
      }
    });
    on<DocumentBackgroundChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        final Renderer<Background> background =
            Renderer.fromInstance(event.background);
        await background.setup(
            current.data, current.assetService, current.page);
        await _saveState(
            emit,
            current.copyWith(
                page: current.page.copyWith(
              background: event.background,
            )));
        current.currentIndexCubit.unbake(background: background);
      }
    });
    on<WaypointCreated>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        return _saveState(
            emit,
            current.copyWith(
                page: current.page.copyWith(
                    waypoints: List<Waypoint>.from(current.page.waypoints)
                      ..add(event.waypoint))));
      }
    });
    on<WaypointRemoved>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        return _saveState(
            emit,
            current.copyWith(
                page: current.page.copyWith(
                    waypoints: List<Waypoint>.from(current.page.waypoints)
                      ..removeAt(event.index))));
      }
    });

    on<LayerRenamed>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        final content = List<PadElement>.from(current.page.content)
            .map((e) =>
                e.layer == event.oldName ? e.copyWith(layer: event.newName) : e)
            .toList();
        final renderer = content.map((e) => Renderer.fromInstance(e)).toList();
        await Future.wait(renderer.map((e) async =>
            await e.setup(current.data, current.assetService, current.page)));
        await _saveState(
            emit,
            current.copyWith(
                page: current.page.copyWith(content: content),
                currentLayer: current.currentLayer == event.oldName
                    ? event.newName
                    : current.currentLayer),
            null);
        current.currentIndexCubit.unbake(unbakedElements: renderer);
      }
    });

    on<LayerRemoved>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        final renderers = await Future.wait(
            List<Renderer<PadElement>>.from(current.renderers).map((e) async {
          if (e.element.layer == event.name) {
            var renderer = Renderer.fromInstance(e.element.copyWith(layer: ''));
            await renderer.setup(
                current.data, current.assetService, current.page);
            return renderer;
          }
          return e;
        }));
        final content = <PadElement>[];
        for (var element in current.page.content) {
          if (element.layer == event.name) {
            content.add(element.copyWith(layer: ''));
          } else {
            content.add(element);
          }
        }
        await _saveState(
            emit,
            current.copyWith(page: current.page.copyWith(content: content)),
            null);
        current.currentIndexCubit.unbake(unbakedElements: renderers);
      }
    });

    on<LayerElementsRemoved>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        final renderers = current.renderers
            .where((e) => e.element.layer != event.name)
            .toList();
        await _saveState(
            emit,
            current.copyWith(
              page: current.page.copyWith(
                content: List<PadElement>.from(current.page.content)
                    .where((e) => e.layer != event.name)
                    .toList(),
              ),
            ),
            null);
        current.currentIndexCubit.unbake(unbakedElements: renderers);
      }
    });

    on<LayerVisibilityChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        var invisibleLayers = List<String>.from(current.invisibleLayers);
        var isVisible = current.isLayerVisible(event.name);
        if (isVisible) {
          invisibleLayers.add(event.name);
        } else {
          invisibleLayers.remove(event.name);
        }
        return _saveState(
            emit, current.copyWith(invisibleLayers: invisibleLayers), null);
      }
    });

    on<CurrentLayerChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        return _saveState(
            emit,
            current.copyWith(
              currentLayer: event.name,
            ));
      }
    });

    on<ElementsLayerChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        var content = List<PadElement>.from(current.page.content);
        for (var element in event.elements) {
          content[element] = content[element].copyWith(layer: event.layer);
        }
        final renderer = content.map((e) => Renderer.fromInstance(e)).toList();
        await Future.wait(renderer.map((e) async =>
            await e.setup(current.data, current.assetService, current.page)));
        await _saveState(
            emit,
            current.copyWith(
              page: current.page.copyWith(
                content: content,
              ),
            ),
            null);
        current.currentIndexCubit.unbake(unbakedElements: renderer);
      }
    });
    on<TemplateCreated>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final data = current.saveData();
      final render = await current.currentIndexCubit.render(
          current.data, current.page, current.info,
          width: kThumbnailWidth.toDouble(),
          height: kThumbnailHeight.toDouble());
      final thumbnail = render?.buffer.asUint8List();
      final settings = current.settingsCubit.state;
      final remote = settings.getRemote(event.remote);
      TemplateFileSystem.fromPlatform(remote: remote)
          .createTemplate(data.createTemplate(
        thumbnail: thumbnail,
      ));

      if (event.deleteDocument) {
        current.currentIndexCubit.setSaveState(
            location:
                AssetLocation(remote: remote?.identifier ?? '', path: ''));
      }
    });
    on<DocumentPathChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      current.currentIndexCubit.setSaveState(
          location:
              AssetLocation(remote: current.location.remote, path: event.path));
    });
    on<AreasCreated>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final currentDocument = current.page.copyWith(
          areas: List<Area>.from(current.page.areas)..addAll(event.areas));
      _saveState(emit, current.copyWith(page: currentDocument));
      for (var element in current.renderers) {
        final needRepaint = await Future.wait(event.areas.map<Future<bool>>(
            (area) async => await element.onAreaUpdate(currentDocument, area)));
        if (needRepaint.any((element) => element)) {
          _repaint(emit);
        }
      }
    });
    on<AreasRemoved>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      final areas = List<Area>.from(current.page.areas)
        ..removeWhere((e) => event.areas.contains(e.name));
      final currentDocument = current.page.copyWith(areas: areas);
      for (var element in current.renderers) {
        if (areas.contains(element.area) &&
            await element.onAreaUpdate(currentDocument, null)) {
          _repaint(emit);
        }
      }
      _saveState(emit, current.copyWith(page: currentDocument));
    });
    on<AreaChanged>((event, emit) async {
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
      emit(current.copyWith(page: currentDocument));
      for (var element in current.renderers) {
        if (element.area?.name == event.name) {
          if (await element.onAreaUpdate(currentDocument, event.area)) {
            _repaint(emit);
          }
        }
      }
    });
    on<ExportPresetCreated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (current.info.getExportPreset(event.name) != null) return;
      final preset = ExportPreset(name: event.name, areas: event.areas);
      var currentInfo = current.info;
      currentInfo = currentInfo.copyWith(
          exportPresets: List<ExportPreset>.from(currentInfo.exportPresets)
            ..add(preset));
      _saveState(emit, current.copyWith(info: currentInfo));
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
      _saveState(emit, current.copyWith(info: currentInfo));
    });
    on<ExportPresetRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      var currentInfo = current.info;
      currentInfo = currentInfo.copyWith(
          exportPresets: currentInfo.exportPresets
              .where((element) => element.name != event.name)
              .toList());
      _saveState(emit, current.copyWith(info: currentInfo));
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
      event.pack.name = name;
      current.data.setPack(event.pack);
      _saveState(emit);
    });
    on<PackUpdated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      current.data.setPack(event.pack);
      _saveState(emit);
    });
    on<PackRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      current.data.removePack(event.name);
      _saveState(emit);
    });
    on<AnimationAdded>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      if (current.page.getAnimation(event.animation.name) != null) return;
      final currentDocument = current.page.copyWith(
          animations: List<AnimationTrack>.from(current.page.animations)
            ..add(event.animation));
      _saveState(emit, current.copyWith(page: currentDocument));
    });
    on<AnimationUpdated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      final currentDocument = current.page.copyWith(
          animations: current.page.animations.map((e) {
        if (e.name == event.animation.name) {
          return event.animation;
        }
        return e;
      }).toList());
      _saveState(emit, current.copyWith(page: currentDocument));
    });
    on<AnimationRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      final currentDocument = current.page.copyWith(
          animations: current.page.animations
              .where((element) => element.name != event.name)
              .toList());
      _saveState(emit, current.copyWith(page: currentDocument));
    });
    on<DocumentSaved>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      current.currentIndexCubit
          .setSaveState(saved: SaveState.saved, location: event.location);
    });
    on<PresentationModeEntered>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      current.currentIndexCubit.fetchHandler<PresentationHandler>()?.stop(this);
      emit(DocumentPresentationState(
        this,
        current,
        event.track,
        event.fullScreen,
        networkService: current.networkService,
        assetService: current.assetService,
        pageName: current.pageName,
        page: current.page,
        metadata: current.metadata,
      ));
    });
    on<PresentationModeExited>((event, emit) {
      final current = state;
      if (current is! DocumentPresentationState) return;
      current.handler.dispose(this);
      emit(current.oldState);
      setFullScreen(current.fullScreen);
    });
    on<PresentationTick>((event, emit) {
      final current = state;
      if (current is! DocumentPresentationState) return;
      emit(current.copyWith(frame: event.tick));
    });
  }

  Future<void> _saveState(Emitter<DocumentState> emit,
      [DocumentLoadSuccess? current,
      List<Renderer<PadElement>>? unbakedElements = const []]) async {
    if (state is! DocumentLoadSuccess) return;
    current ??= state as DocumentLoadSuccess;
    final cameraViewport = current.cameraViewport;
    var elements = cameraViewport.unbakedElements;
    if (unbakedElements != null) {
      for (var renderer in unbakedElements) {
        await renderer.setup(current.data, current.assetService, current.page);
      }
      elements = List<Renderer<PadElement>>.from(elements)
        ..addAll(unbakedElements);
    }
    emit(current);

    if (unbakedElements == null) {
      current.currentIndexCubit.unbake(
          unbakedElements: List<Renderer<PadElement>>.from(elements)
            ..addAll(cameraViewport.bakedElements));
    } else {
      current.currentIndexCubit.withUnbaked(elements);
    }

    current.currentIndexCubit.setSaveState(saved: SaveState.unsaved);
    if (current.embedding != null) {
      return;
    }
    AssetLocation? path = current.location;
    if (current.hasAutosave()) {
      current.currentIndexCubit.setSaveState(saved: SaveState.saving);
      path = await current.save();
      current.currentIndexCubit
          .setSaveState(saved: SaveState.saved, location: path);
    }
  }

  void _repaint(Emitter<DocumentState> emit) {
    final current = state;
    if (current is! DocumentLoadSuccess) return;
    current.currentIndexCubit.unbake();
  }

  void refresh() {
    final current = state;
    if (current is! DocumentLoadSuccess) return;
    current.currentIndexCubit.refresh(
        current.data, current.assetService, current.page, current.info);
  }

  Future<void> bake(
      {Size? viewportSize, double? pixelRatio, bool reset = false}) async {
    final current = state;
    if (current is! DocumentLoadSuccess) return;
    return current.bake(
        viewportSize: viewportSize, pixelRatio: pixelRatio, reset: reset);
  }

  Future<void> load() async {
    final current = state;
    if (current is! DocumentLoadSuccess) return;
    final currentIndexCubit = current.currentIndexCubit;
    final document = current.data;
    final page = current.page;
    final assetService = current.assetService;
    currentIndexCubit.setSaveState(saved: SaveState.saved);
    final background = Renderer.fromInstance(page.background);
    await background.setup(document, assetService, page);
    final tool = ToolRenderer(const ToolState());
    await tool.setup(document, assetService, page);
    currentIndexCubit.unbake(background: background, tool: tool);
    currentIndexCubit.loadElements(document, assetService, page);
    currentIndexCubit.init(this);
  }
}
