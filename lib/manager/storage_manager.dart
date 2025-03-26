import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:in_classe/extension_function/int_extensions.dart';
import 'package:tuple/tuple.dart';

/// The [folder] of a collection.
enum Collection {
  none(''),
  teams('Teams'),
  news('News');

  final String folder;

  const Collection(this.folder);
}

class FileSizeException implements Exception {
  final String message;

  const FileSizeException(int maxFileSize)
      : message = "Il file non può essere più grande di ${maxFileSize ~/ 1024 ~/ 1024} MB";
}

class StorageManager {
  static const int maxFileSize = 10 * 1024 * 1024;
  static final StorageManager _instance = StorageManager._();

  factory StorageManager() => _instance;

  StorageManager._();

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Map<String, Tuple2<int, String>> cachedURLs = {};
  static const urlExpiresIn = 30 * 60;

  /// Request a public URL for the [file] inside the [collection], if not in already cache.
  Future<String> fetchUrl(Collection collection, String file) async {
    final path = '${collection.folder}/$file';
    // Check if the cache already contains a non expired URL for this file
    if (cachedURLs.containsKey(path) &&
        cachedURLs[path]!.item1.elapsedTime.inSeconds <= urlExpiresIn) {
      print(
          '📙 I\'ve fetched the URL for `$path` from the cache. Expires in ${urlExpiresIn - cachedURLs[path]!.item1.elapsedTime.inSeconds} sec');
      return cachedURLs[path]!.item2;
    } else {
      final url = await _storage.ref().child("${collection.folder}/$file").getDownloadURL();
      cachedURLs[path] = Tuple2(DateTime.now().millisecondsSinceEpoch, url);
      return url;
    }
  }

  /// Uploads a [file] to the public [collection], returning its filename if no errors occur.
  Future<String?> uploadFile(Collection collection, File file) async {
    if (await file.length() > maxFileSize) {
      throw FileSizeException(maxFileSize);
    }
    try {
      final filename =
          '${DateTime.now().toIso8601String()}_${Random().nextInt(10e3.toInt())}${path.extension(file.path)}';
      final ref = _storage.ref().child("${collection.folder}/$filename");
      await ref.putFile(file);
      print('⬆️ Uploaded successfully: $filename');
      return filename;
    } catch (e) {
      print('⛔ Error uploading file: $e');
    }
    return null;
  }
}
