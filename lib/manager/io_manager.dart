import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_classe/extension_function/context_extensions.dart';
import 'package:in_classe/manager/database_manager.dart';

import '../constant/palette.dart';
import '../interfaces/json_serializable.dart';
import 'package:http/http.dart' as http;


enum CollectionType {
  object(''),
  timestamp('_timestamp'),
  uid('_uids');

  final String path;

  const CollectionType(this.path);
}

class IOManager {
  static final IOManager _instance = IOManager._();

  factory IOManager() => _instance;

  IOManager._();

  static String getPath(Type T, {CollectionType collectionType = CollectionType.object}) =>
      DatabaseManager.collections[T]!.replaceAll('/', '') + collectionType.path;

  late final SharedPreferences prefs;
  final Map<Type, Future<bool> Function(SharedPreferences, String, dynamic)> _setMethods = {
    String: (sp, key, value) => sp.setString(key, value),
    int: (sp, key, value) => sp.setInt(key, value),
    bool: (sp, key, value) => sp.setBool(key, value),
    double: (sp, key, value) => sp.setDouble(key, value),
    List<String>: (sp, key, value) => sp.setStringList(key, value),
  };
  final Map<Type, Function(SharedPreferences, String)> _getMethods = {
    String: (sp, key) => sp.getString(key),
    int: (sp, key) => sp.getInt(key),
    bool: (sp, key) => sp.getBool(key),
    double: (sp, key) => sp.getDouble(key),
    List<String>: (sp, key) => sp.getStringList(key),
  };
  final Map<String, Object?> _cache = {};

  /// Note: this must be called before using the IOManager
  init() async => prefs = await SharedPreferences.getInstance();

  // Simple Key/Value entries ==============================================================================
  /// Set/Update an entry both on disc and in the cache
  set<T>(String key, T value) {
    _cache[key] = value;
    _setMethods[T]!(prefs, key, value);
  }

  /// Retrieve an entry from disk. This can be called intensively, as a cache is used.
  T? get<T>(String key) => _cache[key] ?? (_getMethods[T] ?? (sp, key) => sp.get(key))(prefs, key);

  remove(String key) async {
    _cache.remove(key);
    await prefs.remove(key);
  }

  removeAll(List<String> keys) async {
    for (var key in keys) {
      await remove(key);
    }
  }

  removeCollection(Type T) =>
      removeAll([getPath(T), getPath(T, collectionType: CollectionType.timestamp)]);

  // Object Serialization/Deserialization ==================================================================
  serializeObjects<T extends JSONSerializable>(List<T> objects, [Type? t]) async {
    await set(getPath(t??T), jsonEncode(objects.map((e) => e.toJSON()).toList()));
    await set(getPath(t??T, collectionType: CollectionType.timestamp),
        DateTime.now().millisecondsSinceEpoch);
    await set(getPath(t??T, collectionType: CollectionType.uid),
        objects.map((e) => (e as JSONSerializable).uid!).toList());
  }

  Future<List<T>> deserializeObjects<T extends JSONSerializable>() async {
    final List<T> objs = jsonDecode(get<String>(getPath(T)) ?? '')
        .map((e) => JSONSerializable.modelFactories[T]!(e) as T)
        .toList()
        .cast<T>();
    final uids = get<List<String>>(getPath(T, collectionType: CollectionType.uid)) ?? [];
    for (var (i, e) in objs.indexed) e.uid = uids[i];
    return objs;
  }

  /// Check that the device is connected to the Internet
  Future<bool> hasInternetConnection(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse('https://clients3.google.com/generate_204'));
      if (response.statusCode == 204) return true;
    } catch (_) {}
    context.snackbar('Connessione internet assente!', backgroundColor: Palette.error);
    return false;
  }
}
