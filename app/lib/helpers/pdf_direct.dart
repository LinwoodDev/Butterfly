import 'dart:math';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

const kPdfDirectEditSessionKey = 'pdfDirectEditSession';
const kPdfDirectSourceAbsoluteKey = 'pdfDirectSourceAbsolute';
const kPdfDirectSourceUriKey = 'pdfDirectSourceUri';
const kPdfDirectOriginalPageKey = 'pdfDirectOriginalPage';

const _kNightModeMatrix = <double>[
  -0.82,
  0,
  0,
  0,
  249,
  0,
  -0.82,
  0,
  0,
  249,
  0,
  0,
  -0.82,
  0,
  249,
  0,
  0,
  0,
  1,
  0,
];

const _kInvertModeMatrix = <double>[
  -1,
  0,
  0,
  0,
  255,
  0,
  -1,
  0,
  0,
  255,
  0,
  0,
  -1,
  0,
  255,
  0,
  0,
  0,
  1,
  0,
];

extension PdfDirectDocumentInfoX on DocumentInfo {
  bool get isDirectPdfSession => extra[kPdfDirectEditSessionKey] == true;

  bool get isDirectPdfSourceAbsolute =>
      extra[kPdfDirectSourceAbsoluteKey] == true;

  String? get directPdfSourceUri {
    final value = extra[kPdfDirectSourceUriKey];
    if (value is String && value.isNotEmpty) {
      return value;
    }
    return null;
  }
}

extension PdfDirectDocumentStateX on DocumentLoaded {
  bool get isDirectPdfSession => info.isDirectPdfSession;

  bool get isDirectPdfSourceAbsolute => info.isDirectPdfSourceAbsolute;

  String? get directPdfSourceUri => info.directPdfSourceUri;

  bool get isDirectPdfSourceContentUri =>
      isContentUriPath(directPdfSourceUri ?? '');

  List<AreaPreset> getDirectPdfAreaPresets() {
    final pageNames = data.getPages(true);
    return pageNames
        .map((pageName) {
          final currentPage = pageName == this.pageName
              ? page
              : data.getPage(pageName);
          final area = currentPage?.areas.firstWhereOrNull(
            (element) => element.isInitial,
          );
          final resolvedArea =
              area ?? _resolvePageArea(currentPage, fallbackName: pageName);
          if (resolvedArea == null || currentPage == null) {
            return null;
          }
          return AreaPreset(
            name: resolvedArea.name,
            area: resolvedArea,
            page: pageName,
          );
        })
        .nonNulls
        .toList();
  }
}

bool isContentUriPath(String path) => path.startsWith('content://');

bool canSaveDirectPdfInPlace(DocumentLoaded state) =>
    state.isDirectPdfSourceContentUri || state.location.path.isNotEmpty;

Area? _resolvePageArea(DocumentPage? page, {required String fallbackName}) {
  if (page == null) return null;
  final pdf = page.content.whereType<PdfElement>().firstOrNull;
  if (pdf != null) {
    return Area(
      name: fallbackName,
      width: pdf.width,
      height: pdf.height,
      position: Point(pdf.position.x, pdf.position.y),
      isInitial: true,
    );
  }
  return null;
}

bool shouldForceDirectPdfSaveOnExit(DocumentLoaded state) =>
    state.isDirectPdfSession &&
    canSaveDirectPdfInPlace(state) &&
    state.settingsCubit.state.pdfDirectEditSaveOnExit;

Future<void> saveDocumentBeforeExit(DocumentBloc bloc) async {
  final state = bloc.state;
  if (state is DocumentLoaded &&
      state.isDirectPdfSession &&
      (!state.settingsCubit.state.pdfDirectEditSaveOnExit ||
          !canSaveDirectPdfInPlace(state))) {
    return;
  }
  await bloc.save(force: state is DocumentLoaded && state.isDirectPdfSession);
}

Widget applyPdfToneMode(Widget child, PdfPageToneMode mode) => switch (mode) {
  PdfPageToneMode.normal => child,
  PdfPageToneMode.night => ColorFiltered(
    colorFilter: const ColorFilter.matrix(_kNightModeMatrix),
    child: child,
  ),
  PdfPageToneMode.eyeProtection => ColorFiltered(
    colorFilter: const ColorFilter.mode(Color(0xFFE8F1D8), BlendMode.modulate),
    child: child,
  ),
  PdfPageToneMode.sepia => ColorFiltered(
    colorFilter: const ColorFilter.mode(Color(0xFFF4E6C3), BlendMode.modulate),
    child: child,
  ),
  PdfPageToneMode.invert => ColorFiltered(
    colorFilter: const ColorFilter.matrix(_kInvertModeMatrix),
    child: child,
  ),
};
