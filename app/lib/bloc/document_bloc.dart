import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/models/background.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/painter.dart';
import 'package:butterfly/models/palette.dart';
import 'package:butterfly/models/waypoint.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../cubits/settings.dart';
import '../embed/embedding.dart';
import '../models/area.dart';
import '../models/element.dart';
import '../models/export.dart';
import '../models/property.dart';
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

  void _init() {
    on<DocumentUpdated>((event, emit) async {
      final current = state;
      if (current is DocumentLoadSuccess) {
        _saveDocument(
            emit,
            current.copyWith(
              document: event.document,
            ),
            null);
        clearHistory();
      }
    });
    on<ElementsCreated>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      if (event.elements.isEmpty) return;
      final renderers =
          event.elements.map((e) => Renderer.fromInstance(e)).toList();
      await Future.wait(
          renderers.map((e) async => await e.setup(current.document)));
      return _saveDocument(
          emit,
          current.copyWith(
              document: current.document.copyWith(
                  content: (List.from(current.document.content)
                    ..addAll(event.elements)))),
          renderers);
    });
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
    });
    on<ElementsChanged>((event, emit) async {
      final current = state;
      if (current is DocumentLoadSuccess) {
        if (!(current.embedding?.editable ?? true)) return;
        final renderers = <Renderer<PadElement>>[];
        Renderer<PadElement>? oldRenderer, newRenderer;
        for (var renderer in current.renderers) {
          final updated = event.changedElements[renderer.element];
          if (updated != null) {
            newRenderer = Renderer.fromInstance(updated);
            await newRenderer.setup(current.document);
            oldRenderer = renderer;
            renderers.add(newRenderer);
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
                content: List<PadElement>.from(document.content).map((e) {
                  final updated = event.changedElements[e];
                  if (updated != null) {
                    return updated;
                  } else {
                    return e;
                  }
                }).toList(),
              ),
            ),
            null);
      }
    });
    on<ElementsRemoved>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        if (event.elements.isEmpty ||
            !current.document.content
                .any((element) => event.elements.contains(element))) return;
        final document = current.document;
        final renderers = current.renderers;
        await _saveDocument(
            emit,
            current.copyWith(
                document: document.copyWith(
                    content: List.from(document.content)
                      ..removeWhere(
                          (element) => event.elements.contains(element)))),
            null);
        current.currentIndexCubit.unbake(
          unbakedElements: renderers
              .where((element) => !event.elements.contains(
                    element.element,
                  ))
              .toList(),
        );
      }
    });
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

    on<DocumentPaletteChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        return _saveDocument(
            emit,
            current.copyWith(
                document: current.document.copyWith(palettes: event.palette)));
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
                      ..add(event.painter))));
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
          current.currentIndexCubit.updatePainter(
              current.document, current.currentArea, updatedCurrent);
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
          cubit.updateIndex(current.document);
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
                    waypoints: List<Waypoint>.from(current.document.waypoints)
                      ..add(event.waypoint))));
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
                    waypoints: List<Waypoint>.from(current.document.waypoints)
                      ..removeAt(event.index))));
      }
    });
    on<HandPropertyChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        final current = state as DocumentLoadSuccess;
        if (!(current.embedding?.editable ?? true)) return;
        return _saveDocument(
            emit,
            current.copyWith(
                document:
                    current.document.copyWith(handProperty: event.property)));
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
    on<TemplateCreated>((event, emit) {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final remote = current.getRemoteStorage();
      TemplateFileSystem.fromPlatform(remote: remote)
          .createTemplate(current.document);

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
    on<AreaCreated>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      final currentDocument = current.document.copyWith(
          areas: List<Area>.from(current.document.areas)..add(event.area));
      _saveDocument(emit, current.copyWith(document: currentDocument));
      for (var element in current.renderers) {
        if (await element.onAreaUpdate(currentDocument, event.area)) {
          _repaint(emit);
        }
      }
    });
    on<AreaRemoved>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      final areas = List<Area>.from(current.document.areas);
      final area = areas.removeAt(event.index);
      final currentDocument = current.document.copyWith(areas: areas);
      for (var element in current.renderers) {
        if (element.area == area &&
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
      final areas = List<Area>.from(current.document.areas);
      final area = areas[event.index];
      final currentDocument =
          current.document.copyWith(areas: areas..[event.index] = event.area);
      emit(current.copyWith(document: currentDocument));
      for (var element in current.renderers) {
        if (element.area == area) {
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
      emit(current.copyWith(currentAreaIndex: event.area));
    });
    on<DocumentSaved>((event, emit) async {
      final current = state;
      if (current is! DocumentLoadSuccess) return;
      if (!(current.embedding?.editable ?? true)) return;
      current.currentIndexCubit
          .setSaveState(saved: true, location: event.location);
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
    return current.load();
  }
}
