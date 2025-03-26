import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:in_classe/model/edition.dart';
import 'package:in_classe/model/match.dart';
import 'package:in_classe/model/player.dart';
import 'package:in_classe/model/team.dart';
import 'package:in_classe/model/user.dart';

import '../interfaces/json_serializable.dart';
import '../model/news.dart';

class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager._();

  factory DatabaseManager() => _instance;

  DatabaseManager._();

  static const collections = {
    Edition: 'editions/',
    Match: 'matches/',
    Player: 'players/',
    Team: 'teams/',
    User: 'users/',
    News: 'news/',
  };
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  var paginateKeys = HashMap<String, String?>();

  /// Get an identifiable object from the given location
  Future<T> get<T extends JSONSerializable>(String collection, String uid) async =>
      (JSONSerializable.modelFactories[T]!((await _database.doc(collection + uid).get()).data()) as T)
        ..uid = uid;

  /// Get a list of documents and paginate it
  Future<List<T>?> getList<T extends JSONSerializable>(String collection, {pageSize = 30}) async {
    final lastKey = paginateKeys[collection];
    if (paginateKeys.containsKey(collection) && lastKey == null) return null;

    var query = _database.collection(collection).orderBy(FieldPath.documentId);
    if (lastKey != null) {
      query = query.startAfter([lastKey]);
    }
    final dataSnapshot = await query.limit(pageSize).get();

    paginateKeys[collection] = dataSnapshot.docs.isNotEmpty ? dataSnapshot.docs.last.id : null;

    return dataSnapshot.docs
        .map((e) => (JSONSerializable.modelFactories[T]!(e.data())..uid = e.id))
        .toList()
        .cast<T>();
  }

  /// Get all the identifiable documents corresponding to the given UIDs
  Future<List<T>?> getListFromUIDs<T extends JSONSerializable>(
      String collection, List<String> uids) async {
    final dataSnapshot =
        await _database.collection(collection).where(FieldPath.documentId, whereIn: uids).get();
    return dataSnapshot.docs
        .map((e) => (JSONSerializable.modelFactories[T]!(e.data()) as T)..uid = e.id)
        .toList()
        .cast<T>();
  }

  /// Put an object to a given location
  Future<void> put(String path, dynamic object) async => _database.doc(path).set(object);

  /// Push given object in a new child on the giving location. Returns the created key
  Future<String?> post(String collection, dynamic object) async {
    final node = _database.collection(collection).doc();
    await node.set(object);
    return node.id;
  }

  /// Delete all the documents under a given collection
  deleteCollection<T>() async {
    final collectionReference = _database.collection(collections[T]!);
    final querySnapshot = await collectionReference.get();
    final batch = _database.batch();
    for (var doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
