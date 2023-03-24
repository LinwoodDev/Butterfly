import 'package:butterfly/api/file_system.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';

class WebDocumentFileSystem extends DocumentFileSystem {
  @override
  Future<AppDocumentDirectory> createDirectory(String path) {
    // TODO: implement createDirectory
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAsset(String path) {
    // TODO: implement deleteAsset
    throw UnimplementedError();
  }

  @override
  Future<AppDocumentEntity?> getAsset(String path) {
    // TODO: implement getAsset
    throw UnimplementedError();
  }

  @override
  Future<bool> hasAsset(String path) {
    // TODO: implement hasAsset
    throw UnimplementedError();
  }

  @override
  Future<AppDocumentFile> updateFile(String path, List<int> data) {
    // TODO: implement updateFile
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

class WebPackFileSystem extends PackFileSystem {
  @override
  Future<void> deletePack(String name) {
    throw UnimplementedError();
  }

  @override
  Future<ButterflyPack?> getPack(String name) {
    throw UnimplementedError();
  }

  @override
  Future<List<ButterflyPack>> getPacks() {
    throw UnimplementedError();
  }

  @override
  Future<bool> hasPack(String name) {
    throw UnimplementedError();
  }

  @override
  Future<void> updatePack(ButterflyPack pack) {
    throw UnimplementedError();
  }
}
