import 'dart:convert';
import 'dart:typed_data';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/helpers/element.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_sysapi/lw_sysapi.dart';

class ExportService {
  final DocumentBloc? bloc;
  final BuildContext context;

  ExportService(this.context, [this.bloc]);

  DocumentLoadSuccess? _getState() => bloc?.state is DocumentLoadSuccess
      ? (bloc?.state as DocumentLoadSuccess)
      : null;
  NoteData? _getDocument() => _getState()?.data;
  CurrentIndexCubit? get currentIndexCubit => _getState()?.currentIndexCubit;

  bool isExportable(PadElement element) => getExportInfo(element) != null;

  (String, String, String)? getExportInfo(PadElement element) =>
      switch (element) {
        ImageElement _ => ('image/png', 'png', ''),
        SvgElement _ => ('image/svg', 'svg', ''),
        MarkdownElement _ => ('text/markdown', 'md', ''),
        _ => null,
      };

  Future<void> export(PadElement element) async {
    final info = getExportInfo(element);
    if (info == null) return;
    final data = await getData(element);
    if (data == null) return;
    final (mimeType, fileExtension, uniformTypeIdentifier) = info;
    return exportFile(
      context: context,
      bytes: data,
      fileExtension: fileExtension,
      mimeType: mimeType,
      uniformTypeIdentifier: uniformTypeIdentifier,
      fileName: 'output',
      label: AppLocalizations.of(context).export,
    );
  }

  Future<Uint8List?> getData(PadElement element) async {
    final document = _getDocument();
    if (document == null) return null;
    Uint8List? fromString(String? value) => utf8.encode(value ?? '');
    return switch (element) {
      ImageElement e => e.getData(document),
      SvgElement e => e.getData(document),
      MarkdownElement e => fromString(e.text),
      _ => null,
    };
  }
}
