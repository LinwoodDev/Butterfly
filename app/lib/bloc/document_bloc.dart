import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../api/full_screen.dart';
import '../cubits/settings.dart';
import '../cubits/transform.dart';
import '../embed/embedding.dart';
import '../models/viewport.dart';
import '../renderers/renderer.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends ReplayBloc<DocumentEvent, DocumentState> {
  DocumentBloc(
    CurrentIndexCubit currentIndexCubit,
    SettingsCubit settingsCubit,
    AppDocument initial,
    AssetLocation location,
    Renderer<Background> background,
    List<Renderer<PadElement>> renderer,
  ) : super(DocumentLoadSuccess(
          initial,
          currentIndexCubit: currentIndexCubit,
          location: location,
          settingsCubit: settingsCubit,
        )) {
    _init();
  }

  DocumentBloc.error(String message) : super(DocumentLoadFailure(message));

  DocumentBloc.placeholder() : super(const DocumentLoadFailure(''));

  void _init() {
    on<DocumentUpdated>((event, emit) async {
      final current = state;
      if (current is DocumentLoadSuccess) {
        emit(current.copyWith(
          document: event.document,
        ));
        clearHistory();
        await load();
      }
    });
    on<ToolChanged>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      await current.currentIndexCubit.updateTool(
          current.document,
          event.state ??
              current.cameraViewport.tool?.element ??
              const ToolState());
      return _saveDocument(
        emit,
        current.copyWith(
          document: current.document.copyWith(
            tool: event.option ?? current.document.tool,
          ),
        ),
      );
    });
    on<ElementsCreated>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      if ((event.elements?.isEmpty ?? true) &&
          (event.renderers?.isEmpty ?? true)) return;
      final renderers = event.renderers ??
          event.elements?.map((e) => Renderer.fromInstance(e)).toList();
      if (renderers == null) return;
      return _saveDocument(
          emit,
          current.copyWith(
              document: current.document.copyWith(
                  content: (List.from(current.document.content)
                    ..addAll(renderers.map((e) => e.element))))),
          renderers);
    }, transformer: sequential());
    on<ElementsReplaced>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        var renderers = current.renderers;
        renderers = List<Renderer<PadElement>>.from(renderers);
        event.replacedElements.forEach((index, element) {
          final current = element.map((e) => Renderer.fromInstance(e));
          if (index == null) {
            renderers.addAll(current);
          } else {
            renderers[index].dispose();
            renderers.removeAt(index);
            renderers.insertAll(index, current);
          }
        });
        return _saveDocument(
            emit,
            current.copyWith(
              document: current.document
                  .copyWith(content: renderers.map((e) => e.element).toList()),
            ),
            null);
      }
    }, transformer: sequential());
    on<ElementsChanged>((event, emit) async {
      final current = state;
      if (current is DocumentLoadSuccess) {
        if (!(current.embedding?.editable ?? true)) return;
        final renderers = <Renderer<PadElement>>[];
        Renderer<PadElement>? oldRenderer, newRenderer;
        for (var renderer in current.renderers) {
          final updated = event.changedElements[renderer.element];
          if (updated != null) {
            for (var element in updated) {
              newRenderer = Renderer.fromInstance(element);
              await newRenderer.setup(current.document);
              oldRenderer = renderer;
              oldRenderer.dispose();
              renderers.add(newRenderer);
            }
          } else {
            renderers.add(renderer);
          }
        }
        current.currentIndexCubit.unbake(unbakedElements: renderers);
        if (oldRenderer == null || newRenderer == null) return;
        if (await current.currentIndexCubit
            .getHandler()
            .onRendererUpdated(current.document, oldRenderer, newRenderer)) {
          refresh();
        }
        final document = current.document;
        await _saveDocument(
            emit,
            current.copyWith(
              document: document.copyWith(
                content: List<PadElement>.from(document.content).expand((e) {
                  final updated = event.changedElements[e];
                  if (updated != null) {
                    return updated;
                  } else {
                    return [e];
                  }
                }).toList(),
              ),
            ),
            null);
      }
    }, transformer: sequential());
    on<ElementsRemoved>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        if (event.elements.isEmpty ||
            !current.document.content
                .any((element) => event.elements.contains(element))) return;
        final document = current.document;
        final renderers = current.renderers;
        current.currentIndexCubit.unbake(
          unbakedElements: renderers.where((element) {
            final remaining = !event.elements.contains(
              element.element,
            );
            if (!remaining) element.dispose();
            return remaining;
          }).toList(),
        );
        await _saveDocument(
            emit,
            current.copyWith(
                document: document.copyWith(
                    content: List.from(document.content)
                      ..removeWhere(
                          (element) => event.elements.contains(element)))),
            null);
      }
    }, transformer: sequential());
    on<DocumentDescriptorChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        return _saveDocument(
            emit,
            current.copyWith(
                document: current.document.copyWith(
                    name: event.name ?? current.document.name,
                    description:
                        event.description ?? current.document.description)));
      }
    });
    on<PainterCreated>((event, emit) async {
      final current = state;
      if (current is DocumentLoadSuccess) {
        if (!(current.embedding?.editable ?? true)) return;
        return _saveDocument(
                emit,
                current.copyWith(
                    document: current.document.copyWith(
                        painters: List.from(current.document.painters)
                          ..add(event.painter))))
            .then((value) {
          current.currentIndexCubit.changePainter(
              this, current.document.painters.length, null, true);
        });
      }
    });
    on<PaintersChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        await _saveDocument(
            emit,
            current.copyWith(
                document: current.document.copyWith(
                    painters:
                        List<Painter>.from(current.document.painters).map((e) {
              final updated = event.updatedPainters[e];
              if (updated != null) {
                return updated;
              } else {
                return e;
              }
            }).toList())));
        final updatedCurrent =
            event.updatedPainters[current.currentIndexCubit.state.handler.data];
        if (updatedCurrent != null) {
          current.currentIndexCubit.updatePainter(this, updatedCurrent);
        }
        final updatedTempCurrent = event.updatedPainters[
            current.currentIndexCubit.state.temporaryHandler?.data];
        if (updatedTempCurrent != null) {
          current.currentIndexCubit
              .updateTemporaryPainter(this, updatedTempCurrent);
        }
      }
    });
    on<PaintersRemoved>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        final cubit = current.currentIndexCubit;
        return _saveDocument(
                emit,
                current.copyWith(
                    document: current.document.copyWith(
                        painters: List.from(current.document.painters)
                          ..removeWhere(
                              (element) => event.painters.contains(element)))))
            .then((value) {
          cubit.updateIndex(this);
        });
      }
    });
    on<PainterReordered>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        var painters = List<Painter>.from(current.document.painters);
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
        return _saveDocument(
            emit,
            current.copyWith(
              document: current.document.copyWith(painters: painters),
            ));
      }
    });
    on<DocumentBackgroundChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        final Renderer<Background> background =
            Renderer.fromInstance(event.background);
        await background.setup(current.document);
        await _saveDocument(
            emit,
            current.copyWith(
                document: current.document.copyWith(
              background: event.background,
            )));
        current.currentIndexCubit.unbake(background: background);
      }
    });
    on<WaypointCreated>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        return _saveDocument(
                emit,
                current.copyWith(
                    document: current.document.copyWith(
                        waypoints:
                            List<Waypoint>.from(current.document.waypoints)
                              ..add(event.waypoint))))
            .then((value) {
          final handler = current.currentIndexCubit.getHandler();
          if (handler is WaypointHandler) refresh();
        });
      }
    });
    on<WaypointRemoved>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        return _saveDocument(
                emit,
                current.copyWith(
                    document: current.document.copyWith(
                        waypoints:
                            List<Waypoint>.from(current.document.waypoints)
                              ..removeAt(event.index))))
            .then((value) {
          final handler = current.currentIndexCubit.getHandler();
          if (handler is WaypointHandler) refresh();
        });
      }
    });

    on<LayerRenamed>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        final content = List<PadElement>.from(current.document.content)
            .map((e) =>
                e.layer == event.oldName ? e.copyWith(layer: event.newName) : e)
            .toList();
        final renderer = content.map((e) => Renderer.fromInstance(e)).toList();
        await Future.wait(
            renderer.map((e) async => await e.setup(current.document)));
        await _saveDocument(
            emit,
            current.copyWith(
                document: current.document.copyWith(content: content)),
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
            await renderer.setup(current.document);
            return renderer;
          }
          return e;
        }));
        final content = <PadElement>[];
        for (var element in current.document.content) {
          if (element.layer == event.name) {
            content.add(element.copyWith(layer: ''));
          } else {
            content.add(element);
          }
        }
        await _saveDocument(
            emit,
            current.copyWith(
                document: current.document.copyWith(content: content)),
            null);
        current.currentIndexCubit.unbake(unbakedElements: renderers);
      }
    });

    on<LayerElementsDeleted>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        final renderers = current.renderers
            .where((e) => e.element.layer != event.name)
            .toList();
        await _saveDocument(
            emit,
            current.copyWith(
              document: current.document.copyWith(
                content: List<PadElement>.from(current.document.content)
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
        return _saveDocument(
            emit, current.copyWith(invisibleLayers: invisibleLayers), null);
      }
    });

    on<CurrentLayerChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        return _saveDocument(
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
        var content = List<PadElement>.from(current.document.content);
        for (var element in event.elements) {
          var i = current.document.content.indexOf(element);
          if (i != -1) {
            content[i] = element.copyWith(layer: event.layer);
          }
        }
        final renderer = content.map((e) => Renderer.fromInstance(e)).toList();
        await Future.wait(
            renderer.map((e) async => await e.setup(current.document)));
        await _saveDocument(
            emit,
            current.copyWith(
              document: current.document.copyWith(
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
      final render = await current.currentIndexCubit.render(current.document,
          width: kThumbnailWidth.toDouble(),
          height: kThumbnailHeight.toDouble());
      final uri = render == null
          ? ''
          : UriData.fromBytes(render.buffer.asUint8List(),
                  mimeType: 'image/png')
              .toString();
      final settings = current.settingsCubit.state;
      final remote = settings.getRemote(event.remote);
      TemplateFileSystem.fromPlatform(remote: remote).createTemplate(
        DocumentTemplate(
          directory: event.directory,
          document: current.document.copyWith(thumbnail: uri),
        ),
      );

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
          location: AssetLocation(
              remote: current.location.remote, path: event.location));
    });
    on<AreasCreated>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final currentDocument = current.document.copyWith(
          areas: List<Area>.from(current.document.areas)..addAll(event.areas));
      _saveDocument(emit, current.copyWith(document: currentDocument));
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
      final areas = List<Area>.from(current.document.areas)
        ..removeWhere((e) => event.areas.contains(e.name));
      final currentDocument = current.document.copyWith(areas: areas);
      for (var element in current.renderers) {
        if (areas.contains(element.area) &&
            await element.onAreaUpdate(currentDocument, null)) {
          _repaint(emit);
        }
      }
      _saveDocument(emit, current.copyWith(document: currentDocument));
    });
    on<AreaChanged>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      final areas = current.document.areas.map((e) {
        if (e.name == event.name) {
          return event.area;
        }
        return e;
      }).toList();
      final currentDocument = current.document.copyWith(areas: areas);
      emit(current.copyWith(document: currentDocument));
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
      if (current.document.getExportPreset(event.name) != null) return;
      final preset = ExportPreset(name: event.name, areas: event.areas);
      var currentDocument = current.document;
      currentDocument = currentDocument.copyWith(
          exportPresets: List<ExportPreset>.from(currentDocument.exportPresets)
            ..add(preset));
      _saveDocument(emit, current.copyWith(document: currentDocument));
    });
    on<ExportPresetUpdated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      var currentDocument = current.document;
      final presets = currentDocument.exportPresets.map((e) {
        if (e.name == event.name) {
          return e.copyWith(areas: event.areas);
        }
        return e;
      }).toList();
      currentDocument = currentDocument.copyWith(exportPresets: presets);
      _saveDocument(emit, current.copyWith(document: currentDocument));
    });
    on<ExportPresetRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      var currentDocument = current.document;
      currentDocument = currentDocument.copyWith(
          exportPresets: currentDocument.exportPresets
              .where((element) => element.name != event.name)
              .toList());
      _saveDocument(emit, current.copyWith(document: currentDocument));
    });
    on<CurrentAreaChanged>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      emit(current.copyWith(currentAreaName: event.area));
    });
    on<DocumentPackAdded>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      var name = event.pack.name;
      var i = 1;
      while (current.document.packs.any((element) => element.name == name)) {
        name = '${event.pack.name} ($i)';
        i++;
      }
      final pack = event.pack.copyWith(name: name);
      final currentDocument = current.document.copyWith(
          packs: List<ButterflyPack>.from(current.document.packs)..add(pack));
      _saveDocument(emit, current.copyWith(document: currentDocument));
    });
    on<DocumentPackUpdated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      final currentDocument = current.document.copyWith(
          packs: current.document.packs
              .map((e) => e.name == event.pack.name ? event.pack : e)
              .toList());
      _saveDocument(emit, current.copyWith(document: currentDocument));
    });
    on<DocumentPackRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      final currentDocument = current.document.copyWith(
          packs: current.document.packs
              .where((element) => element.name != event.pack)
              .toList());
      _saveDocument(emit, current.copyWith(document: currentDocument));
    });
    on<DocumentAnimationAdded>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      if (current.document.getAnimation(event.animation.name) != null) return;
      final currentDocument = current.document.copyWith(
          animations: List<AnimationTrack>.from(current.document.animations)
            ..add(event.animation));
      _saveDocument(emit, current.copyWith(document: currentDocument));
    });
    on<DocumentAnimationUpdated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      final currentDocument = current.document.copyWith(
          animations: current.document.animations.map((e) {
        if (e.name == event.animation.name) {
          return event.animation;
        }
        return e;
      }).toList());
      _saveDocument(emit, current.copyWith(document: currentDocument));
    });
    on<DocumentAnimationRemoved>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      final currentDocument = current.document.copyWith(
          animations: current.document.animations
              .where((element) => element.name != event.animation)
              .toList());
      _saveDocument(emit, current.copyWith(document: currentDocument));
    });
    on<DocumentSaved>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      current.currentIndexCubit
          .setSaveState(saved: true, location: event.location);
    });
    on<PresentationModeEntered>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      current.currentIndexCubit.fetchHandler<PresentationHandler>()?.stop(this);
      emit(DocumentPresentationState(
          this, current, event.track, event.fullScreen));
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

  Future<void> _saveDocument(
      Emitter<DocumentState> emit, DocumentLoadSuccess current,
      [List<Renderer<PadElement>>? unbakedElements = const []]) async {
    final cameraViewport = current.cameraViewport;
    var elements = cameraViewport.unbakedElements;
    if (unbakedElements != null) {
      for (var renderer in unbakedElements) {
        await renderer.setup(current.document);
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

    current.currentIndexCubit.setSaveState(saved: false);
    if (current.embedding != null) {
      return;
    }
    AssetLocation? path = current.location;
    if (current.hasAutosave()) {
      path = await current.save();
      current.currentIndexCubit.setSaveState(saved: true, location: path);
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
    current.currentIndexCubit.refresh(current.document);
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
    final document = current.document;
    currentIndexCubit.setSaveState(saved: true);
    final background = Renderer.fromInstance(document.background);
    await background.setup(document);
    final tool = ToolRenderer(const ToolState());
    await tool.setup(document);
    final renderers =
        document.content.map((e) => Renderer.fromInstance(e)).toList();
    await Future.wait(renderers.map((e) async => await e.setup(document)));
    currentIndexCubit.unbake(
        background: background, tool: tool, unbakedElements: renderers);
    currentIndexCubit.changePainter(this, 0);
  }
}
