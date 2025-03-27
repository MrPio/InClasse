import 'package:collection/collection.dart';
import 'package:in_classe/extension_function/int_extensions.dart';
import 'package:in_classe/manager/account_manager.dart';
import 'package:in_classe/manager/io_manager.dart';
import 'package:in_classe/model/user.dart';

import '../interfaces/json_serializable.dart';
import 'database_manager.dart';

enum SaveMode { post, put }

class DataManager {
  static final DataManager _instance = DataManager._();

  factory DataManager() => _instance;

  DataManager._();

  static const pageSize = 100;

  final anonymous = User(email: "example@example.com", username: "Anonymous");
  List<User> cachedUsers = [];

  Map<Type, List<JSONSerializable>> get caches => {
        User: cachedUsers,
      };

  Map<Type, int> get cachesTTL => {
        User: 30 * 60,
      };

  /// The functions used to deserialize cache from disk
  Map<Type, Function()> get cacheDeserializers => {
        User: IOManager().deserializeObjects<User>,
      };

  /// The functions used to fetch cache data from db
  Map<Type, Future<List<JSONSerializable>> Function()> get cacheSeeders => {};

  invalidateCache<T>() async => await IOManager().removeCollection(T);

  /// Fetch all the application's needed start data
  /// Note: this shouldn't be called before obtaining the auth
  fetchData() async {
    for (var cache in caches.entries) {
      final cacheTimestampPath = IOManager.getPath(cache.key, collectionType: CollectionType.timestamp);
      final timestamp = IOManager().get<int>(cacheTimestampPath) ?? 0;
      if (timestamp.elapsedTime.inSeconds < cachesTTL[cache.key]!) {
        caches[cache.key]!.clear();
        caches[cache.key]!.addAll(await cacheDeserializers[cache.key]!());
        print('📘 I\'ve read ${caches[cache.key]!.length} ${cache.key}s locally');
      } else {
        await IOManager().removeCollection(cache.key);
        print('❗ The ${cache.key} cache has been invalidated');
        // Seed the cache if a seeder is defined
        if (cacheSeeders.containsKey(cache.key)) {
          caches[cache.key]!.clear();
          caches[cache.key]!.addAll(await cacheSeeders[cache.key]!());
          IOManager().serializeObjects(caches[cache.key]!, cache.key);
          print('⬇️ I\'ve downloaded ${caches[cache.key]!.length} ${cache.key}s');
        }
      }
    }
  }

  /// Load a single object from a given UID
  Future<T> load<T extends JSONSerializable>(String uid, {bool useCache = true}) async {
    if (useCache) {
      if (T.runtimeType == User) {
        // Is current User?
        if (AccountManager().user.uid == uid) return AccountManager().user as T;
      }
      JSONSerializable? obj = caches[T]?.firstWhereOrNull((e) => e.uid == uid);
      if (obj != null) return obj as T;
    }

    // Ask the database for the object and caching it
    T obj = await DatabaseManager().get<T>(DatabaseManager.collections[T]!, uid);
    caches[T]?.removeWhere((e) => e.uid == uid);
    caches[T]!.add(obj);
    // Write cache to disk
    await IOManager().serializeObjects(caches[T]!, T);
    print('📙 I\'ve cached ${caches[T]!.length} ${T}s');
    return obj;
  }

  /// Load a multiple objects from a given list of UIDs
  Future<List<T>> loadList<T extends JSONSerializable>(List<String> uids, {bool useCache = true}) async {
    List<T> objects = [];
    if (useCache) {
      for (var uid in uids) {
        if (T.runtimeType == User) {
          // Is current User?
          if (AccountManager().user.uid == uid) {
            objects.add(AccountManager().user as T);
          }
        }
        JSONSerializable? obj = caches[T]?.firstWhereOrNull((e) => e.uid == uid);
        if (obj != null) objects.add(obj as T);
      }
    }
    final leftovers =
        uids.where((uid) => objects.firstWhereOrNull((obj) => obj.uid == uid) == null).toList();

    // Ask the database for the objects and caching it
    if (leftovers.isNotEmpty) {
      objects.addAll(
          await DatabaseManager().getListFromUIDs<T>(DatabaseManager.collections[T]!, leftovers) ?? []);
      caches[T]!.removeWhere((e) => leftovers.contains(e.uid));
      caches[T]!.addAll(objects);
      // Write cache to disk
      await IOManager().serializeObjects(caches[T]!, T);
      print('📙 Ho scritto su cache ${caches[T]!.length} ${T}s');
    }
    return objects;
  }

  /// Save Model objects
  Future<String?> save<T extends JSONSerializable>(T model, [SaveMode mode = SaveMode.put]) async {
    String path = DatabaseManager.collections[model.runtimeType]!;

    if (mode == SaveMode.put) path += model.uid?.replaceAll('/', ' ') ?? '';

    String? newUID;
    // Query the FirebaseRD
    if (mode == SaveMode.put) {
      DatabaseManager().put(path, model.toJSON());
      // Update cache value
      caches[model.runtimeType]!.removeWhere((e) => e.uid == model.uid);
      caches[model.runtimeType]!.add(model);
      await IOManager().serializeObjects(caches[model.runtimeType]!, model.runtimeType);
    } else {
      caches[model.runtimeType]!.add(model);
      newUID = await DatabaseManager().post(path, model.toJSON());
    }
    return newUID;
  }
}
