// ignore_for_file: avoid_print, prefer_single_quotes

import 'dart:io';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';

final _credentials = ClientId("<client-id>", "<client-secret>");
const _scopes = [drive.DriveApi.driveFileScope];

class GoogleDriveFileSystem {
  late drive.DriveApi _driveApi;

  /// Method to initialize the Drive client
  Future<void> init() async {
    var client = await _authenticate();
    _driveApi = drive.DriveApi(client);
  }

  Future<AutoRefreshingAuthClient> _authenticate() async {
    return await clientViaUserConsent(_credentials, _scopes, (url) {
      print("Go to this URL to authorize:");
      print("  => $url");
    });
  }

  Future<bool> folderExists(String folderName) async {
    try {
      var response = await _driveApi.files.list(
        q: "name='$folderName' and mimeType='application/vnd.google-apps.folder'",
      );
      return response.files?.isNotEmpty ?? false;
    } catch (e) {
      print('Exception details:\n $e');
      return false;
    }
  }

  Future<String?> createFolder(String folderName) async {
    if (await folderExists(folderName)) return null;

    var folder = drive.File()
      ..name = folderName
      ..mimeType = "application/vnd.google-apps.folder";

    try {
      var result = await _driveApi.files.create(folder);
      print("Folder Created Successfully: ${result.id}");
      return result.id;
    } catch (e) {
      print('Exception details:\n $e');
      return null;
    }
  }

  Future uploadFile(String folderId, File file) async {
    var fileToUpload = drive.File()..parents = [folderId]..name = file.path;
    var media = drive.Media(file.openRead(), file.lengthSync());

    try {
      var response = await _driveApi.files.create(fileToUpload, uploadMedia: media);
      print("File uploaded successfully: ${response.id}");
    } catch (e) {
      print('Exception details:\n $e');
    }
  }

  Future syncFile(String localPath, String remoteFolderName) async {
    var dir = Directory(localPath);
    if (!dir.existsSync()) {
      print("The local directory does not existe");
      return;
    }

    var folderId = await createFolder(remoteFolderName);
    if (folderId == null) {
      print("The remote folder could not be created or found.");
      return;
    }

    var files = dir.listSync(recursive: false);
    for (var file in files) {
      if (file is File) {
        await uploadFile(folderId, file);
      }
    }
  }
}
