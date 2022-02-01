import 'dart:ui' as ui;

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/baked_viewport.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/painters/painter.dart';
import 'package:butterfly/models/palette.dart';
import 'package:butterfly/models/properties/hand.dart';
import 'package:butterfly/models/waypoint.dart';
import 'package:butterfly/view_painter.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:replay_bloc/replay_bloc.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends ReplayBloc<DocumentEvent, DocumentState> {
  DocumentBloc(AppDocument initial, String? path)
      : super(DocumentLoadSuccess(initial, path: path)) {
    on<ElementCreated>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(
            current.copyWith(
                document: current.document.copyWith(
                    content: (List.from(current.document.content)
                      ..add(event.element)))),
            List<PadElement>.from(current.elements)..add(event.element));
      }
    });
    on<ElementChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(current.copyWith(
            document: current.document.copyWith(
                content: (List.from(current.document.content)
                  ..[event.index] = event.element)),
            removeBakedViewport: true));
      }
    });
    on<ElementsRemoved>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(current.copyWith(
            removeBakedViewport: true,
            document: current.document.copyWith(
                content: List.from(current.document.content)
                  ..removeWhere(
                      (element) => event.elements.contains(element)))));
      }
    });
    on<DocumentDescriptorChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(current.copyWith(
            document: current.document
                .copyWith(name: event.name, description: event.description)));
      }
    });

    on<DocumentPaletteChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(current.copyWith(
            document: current.document.copyWith(palettes: event.palette)));
      }
    });
    on<CurrentPainterChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        return _saveDocument((state as DocumentLoadSuccess).copyWith(
            currentPainterIndex: event.painter,
            removeCurrentPainterIndex: event.painter == null));
      }
    });
    on<PainterCreated>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(current.copyWith(
            document: current.document.copyWith(
                painters: List.from(current.document.painters)
                  ..add(event.painter))));
      }
    });
    on<PainterChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(current.copyWith(
            document: current.document.copyWith(
                painters: List.from(current.document.painters)
                  ..[event.index] = event.painter)));
      }
    });
    on<PainterRemoved>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(current.copyWith(
            document: current.document.copyWith(
                painters: List.from(current.document.painters)
                  ..removeAt(event.index))));
      }
    });
    on<PainterReordered>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        var painters = List<Painter>.from(current.document.painters);
        var oldIndex = event.oldIndex;
        var newIndex = event.newIndex;
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        final item = painters.removeAt(oldIndex);
        painters.insert(newIndex, item);
        return _saveDocument(current.copyWith(
            document: current.document.copyWith(painters: painters),
            currentPainterIndex: oldIndex == current.currentPainterIndex
                ? newIndex
                : newIndex == current.currentPainterIndex
                    ? oldIndex
                    : current.currentPainterIndex));
      }
    });
    on<DocumentBackgroundChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(current.copyWith(
            document: current.document.copyWith(
                background: event.background,
                removeBackground: event.background == null)));
      }
    });
    on<WaypointCreated>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(current.copyWith(
            document: current.document.copyWith(
                waypoints: List<Waypoint>.from(current.document.waypoints)
                  ..add(event.waypoint))));
      }
    });
    on<WaypointRemoved>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(current.copyWith(
            document: current.document.copyWith(
                waypoints: List<Waypoint>.from(current.document.waypoints)
                  ..removeAt(event.index))));
      }
    });
    on<HandPropertyChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(current.copyWith(
            document: current.document.copyWith(handProperty: event.property)));
      }
    });

    on<LayerRenamed>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(current.copyWith(
            document: current.document.copyWith(
                content: List<PadElement>.from(current.document.content)
                    .map((e) => e.layer == event.oldName
                        ? e.copyWith(layer: event.newName)
                        : e)
                    .toList())));
      }
    });

    on<LayerRemoved>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(current.copyWith(
            removeBakedViewport: true,
            document: current.document.copyWith(
                content: List<PadElement>.from(current.document.content)
                    .where((e) => e.layer == event.name)
                    .map((e) => e.copyWith(layer: ''))
                    .toList())));
      }
    });

    on<LayerElementsDeleted>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(current.copyWith(
            removeBakedViewport: true,
            document: current.document.copyWith(
                content: List<PadElement>.from(current.document.content)
                    .where((e) => e.layer != event.name)
                    .toList())));
      }
    });

    on<LayerVisibilityChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        var invisibleLayers = List<String>.from(current.invisibleLayers);
        var isVisible = current.isLayerVisible(event.name);
        if (isVisible) {
          invisibleLayers.add(event.name);
        } else {
          invisibleLayers.remove(event.name);
        }
        return _saveDocument(
            current.copyWith(
                removeBakedViewport: isVisible,
                invisibleLayers: invisibleLayers),
            isVisible ? null : List<PadElement>.from(current.elements)
              ?..addAll(current.document.content
                  .where((e) => e.layer == event.name)));
      }
    });

    on<CurrentLayerChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        return _saveDocument(current.copyWith(
          currentLayer: event.name,
        ));
      }
    });

    on<ElementsLayerChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        var content = List<PadElement>.from(current.document.content);
        for (var element in event.elements) {
          var i = current.document.content.indexOf(element);
          if (i != -1) {
            content[i] = element.copyWith(layer: event.layer);
          }
        }
        return _saveDocument(current.copyWith(
            document: current.document.copyWith(
          content: content,
        )));
      }
    });
    on<ImageBaked>((event, emit) async {
      var current = state;
      if (current is! DocumentLoadSuccess) return;
      final eq = const ListEquality().equals;

      var elements = current.elements;
      var recorder = ui.PictureRecorder();
      var size = event.viewportSize;
      var canvas = ui.Canvas(recorder);
      var last = current.bakedViewport;
      var invisibleLayers = current.invisibleLayers;
      var reset = last == null ||
          last.width != size.width ||
          last.height != size.height ||
          last.x != event.cameraTransform.position.dx ||
          last.y != event.cameraTransform.position.dy ||
          last.scale != event.cameraTransform.size;
      if (elements.isEmpty && !reset) return;
      if (reset) {
        elements = current.document.content
            .where((element) => !invisibleLayers.contains(element.layer))
            .toList();
      }

      ViewPainter(current.document,
              elements: elements,
              transform: event.cameraTransform,
              bakedViewport: reset ? null : last,
              renderBackground: false)
          .paint(canvas, event.viewportSize);

      var picture = recorder.endRecording();
      var newImage =
          await picture.toImage((size.width).ceil(), (size.height).ceil());
      current = state as DocumentLoadSuccess;
      var currentElements = current.elements;
      if (reset) {
        currentElements = current.document.content
            .where((element) => !invisibleLayers.contains(element.layer))
            .toList();
      }
      if (!eq(elements, currentElements)) return;
      if (last != current.bakedViewport) return;
      await Future.delayed(const Duration(seconds: 1));

      await Future.delayed(const Duration(seconds: 1));

      emit(current.copyWith(
          bakedViewport: BakedViewport(
              height: size.height.round(),
              width: size.width.round(),
              scale: event.cameraTransform.size,
              x: event.cameraTransform.position.dx,
              y: event.cameraTransform.position.dy,
              image: newImage,
              unbakedElements: [])));
    }, transformer: restartable());
    on<ImageUnbaked>((event, emit) {
      var current = state;
      if (current is DocumentLoadSuccess) {
        emit(current.copyWith(removeBakedViewport: true));
      }
    });
  }

  @override
  void onChange(Change<DocumentState> change) {
    // Always call super.onChange with the current change
    super.onChange(change);

    // Custom onChange logic goes here

    var last = change.currentState;
    var current = change.nextState;
    if (last is! DocumentLoadSuccess || current is! DocumentLoadSuccess) return;
    if (last.bakedViewport?.image != current.bakedViewport?.image) {
      last.bakedViewport?.dispose();
    }
  }

  Future<void> _saveDocument(DocumentLoadSuccess current,
      [List<PadElement>? unbakedElements = const []]) async {
    var elements = current.elements;
    if (current.bakedViewport != null && unbakedElements != null) {
      elements = List<PadElement>.from(elements)..addAll(unbakedElements);
    }
    current = current.copyWith(
        document: current.document.copyWith(updatedAt: DateTime.now()),
        removeBakedViewport: unbakedElements == null,
        bakedViewport: unbakedElements == null
            ? current.bakedViewport
            : current.bakedViewport?.withUnbaked(elements));
    if (current.path != null) {
      emit(current);
    }
    var path = await current.save();
    if (current.path == null) {
      emit(current.copyWith(path: path));
    }
  }
}
