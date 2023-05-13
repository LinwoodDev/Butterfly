import 'package:butterfly/api/file_system.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';

class WebDocumentFileSystem extends DocumentFileSystem {
  @override
  Future<AppDocumentDirectory> createDirectory(String path) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAsset(String path) {
    throw UnimplementedError();
  }

  @override
  Future<AppDocumentEntity?> getAsset(String path) {
    throw UnimplementedError();
  }

  @override
  Future<bool> hasAsset(String path) {
    throw UnimplementedError();
  }

  @override
  Future<AppDocumentFile> updateFile(String path, List<int> data) {
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
  Future<NoteData?> getTemplate(String name) {
    throw UnimplementedError();
  }

  @override
  Future<List<NoteData>> getTemplates() {
    throw UnimplementedError();
  }

  @override
  Future<bool> hasTemplate(String name) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTemplate(NoteData template) {
    throw UnimplementedError();
  }
}

class WebPackFileSystem extends PackFileSystem {
  @override
  Future<void> deletePack(String name) {
    throw UnimplementedError();
  }

  @override
  Future<NoteData?> getPack(String name) {
    throw UnimplementedError();
  }

  @override
  Future<List<NoteData>> getPacks() {
    throw UnimplementedError();
  }

  @override
  Future<bool> hasPack(String name) {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePack(NoteData pack) {
    throw UnimplementedError();
  }

  @override
  Future<bool> createDefault(BuildContext context, {bool force = false}) {
    throw UnimplementedError();
  }
}
