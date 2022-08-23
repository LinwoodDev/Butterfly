import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/template.dart';
import 'package:flutter/material.dart';

class WebDocumentFileSystem extends DocumentFileSystem {
  @override
  Future<AppDocumentDirectory> createDirectory(String name) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAsset(String path) {
    throw UnimplementedError();
  }

  @override
  Future<AppDocumentAsset?> getAsset(String path) {
    throw UnimplementedError();
  }

  @override
  Future<bool> hasAsset(String path) {
    throw UnimplementedError();
  }

  @override
  Future<AppDocumentFile> importDocument(AppDocument document,
      {String path = '/'}) {
    throw UnimplementedError();
  }

  @override
  Future<AppDocumentFile> updateDocument(String path, AppDocument document) {
    throw UnimplementedError();
  }
}

class WebTemplateFileSystem extends TemplateFileSystem {
  @override
  Future<bool> createDefault(BuildContext context, {bool force = false}) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTemplate(String name) {
    throw UnimplementedError();
  }

  @override
  Future<DocumentTemplate?> getTemplate(String name) {
    throw UnimplementedError();
  }

  @override
  Future<List<DocumentTemplate>> getTemplates() {
    throw UnimplementedError();
  }

  @override
  Future<bool> hasTemplate(String name) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTemplate(DocumentTemplate template) {
    throw UnimplementedError();
  }
}
