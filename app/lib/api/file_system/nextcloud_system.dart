import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

/// Defines a class to handle file system operations on NextCloud.
class NextCloudFileSystem {
  final String baseUrl;
  final String username;
  final String password;
  late Dio _dio;

  /// Constructor for the class, sets up Dio for HTTP requests.
  NextCloudFileSystem(
      {required this.baseUrl, required this.username, required this.password}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Authorization':
            "Basic ${base64Encode(utf8.encode("$username:$password"))}",
      },
    ));
  }

  /// Checks if a folder exists on the NextCloud server.
  Future<bool> folderExists(String path) async {
    try {
      // Check if the folder exists
      var response = await _dio.head(path);

      // If the status code is 200, the folder exists
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Exception details:\n $e');
      return false;
    }
  }

  /// Creates a folder on the NextCloud server if it does not exist.
  Future createFolder(String path) async {
    if (await folderExists(path) == true) {
      return;
    }
    try {
      var response = await _dio.request(
        path,
        options: Options(
          method: 'MKCOL',
        ),
      );

      if (response.statusCode == 201) {
        print("Folder created successfully");
      } else {
        print("Failed to create folder");
      }
    } catch (e) {
      print('Exception details:\n $e');
    }
  }

  /// Uploads a file to NextCloud.
  Future uploadFile(String path, String filename, File file) async {
    if (await folderExists(path) == false) {
      createFolder(path);
    }
    try {
      List<int> fileBytes = file.readAsBytesSync();

      var response = await _dio.put(
        path + filename,
        data: Stream.fromIterable(fileBytes.map((e) => [e])),
        options: Options(
          headers: {
            Headers.contentLengthHeader: fileBytes.length, // set content-length
            Headers.contentTypeHeader:
                'application/octet-stream', // set content-type
          },
        ),
      );

      if (response.statusCode == 201) {
        print("File uploaded successfully");
      } else {
        print("Failed to upload file");
      }
    } catch (e) {
      print('Exception details:\n $e');
    }
  }

  /// Synchronizes files from the local directory to the remote one on NextCloud.
  Future syncFile(String localPath, String remotePath) async {
    if (await hasFileChanged(localPath, remotePath) == true) {
      return;
    }
    var dir = Directory(localPath);

    if (!dir.existsSync()) {
      print("La directory locale non esiste");
      return;
    }

    var files = dir.listSync(recursive: false);
    for (var file in files) {
      if (file is File) {
        var filename = path.basename(file.path);
        await uploadFile(remotePath, filename, file);
      }
    }
  }

  /// Calculates the SHA-256 checksum of a file.
  String calculateChecksum(File file) {
    var bytes = file.readAsBytesSync();
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Determines if a file has changed by comparing checksums.
  Future<bool> hasFileChanged(String path, String previousChecksum) async {
    var file = File(path);

    if (!file.existsSync()) {
      print("Il file non esiste");
      return false;
    }

    String currentChecksum = calculateChecksum(file);

    if (currentChecksum != previousChecksum) {
      return true;
    } else {
      return false;
    }
  }
}
