import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:tv_test/model/persistent_object.dart';

class DatabaseManager {
  static final DatabaseManager _singleton = DatabaseManager._();
  static DatabaseManager get instance => _singleton;
  Completer<Database> _dbOpenCompleter;

  DatabaseManager._();

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }

    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'main.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter.complete(database);
  }

  Future insert(PersistentObject object) async {
    final store = intMapStoreFactory.store(object.store);
    await store.add(await this.database, object.toJson());
  }

  Future insertMany(String storeName, List<Map<String, dynamic>> list) async {
    final store = intMapStoreFactory.store(storeName);
    var db = await this.database;

    db.transaction((txn) async {
      await store.addAll(txn, list);
    });
  }

  Future insertOrUpdate(PersistentObject object) async {
    final store = intMapStoreFactory.store(object.store);
    final finder = Finder(filter: Filter.equals('_id', object.id));

    final recordSnapshots =
        await store.find(await this.database, finder: finder);

    if (recordSnapshots.length == 0) {
      return this.insert(object);
    } else {
      return this.update(object);
    }
  }

  Future insertIfDoesNotExists(object) async {
    final store = intMapStoreFactory.store(object.store);
    final finder = Finder(filter: Filter.equals('id', object.showId));
    final recordSnapshots =
        await store.find(await this.database, finder: finder);

    if (recordSnapshots.isNotEmpty) {
      return false;
    }

    await this.insert(object);
    return true;
  }

  Future delete(object) async {
    final store = intMapStoreFactory.store(object.store);
    final finder = Finder(filter: Filter.equals('id', object.showId));

    await store.delete(
      await this.database,
      finder: finder,
    );
  }

  Future update(object) async {
    final store = intMapStoreFactory.store(object.store);
    final finder = Finder(filter: Filter.equals('_id', object.id));
    return store.update(
      await this.database,
      object.toJson(),
      finder: finder,
    );
  }

  Future<Map> find(String storeName, Filter filter) async {
    final store = intMapStoreFactory.store(storeName);
    final recordSnapshots =
        await store.find(await this.database, finder: Finder(filter: filter));

    return recordSnapshots.length > 0
        ? Map<String, dynamic>.from(recordSnapshots.first.value)
        : null;
  }

  Future<List> getAll(String storeName) async {
    final store = intMapStoreFactory.store(storeName);

    final recordSnapshots = await store.find(
      await this.database,
    );

    return recordSnapshots.map((snapshot) {
      var item = Map<String, dynamic>.from(snapshot.value);
      item.putIfAbsent('id', () => snapshot.key);
      return item;
    }).toList();
  }

  Future<List> getWhere(String storeName, Filter filter) async {
    final store = intMapStoreFactory.store(storeName);
    final finder = Finder(filter: filter);

    final recordSnapshots =
        await store.find(await this.database, finder: finder);

    return recordSnapshots.map((snapshot) {
      var item = Map<String, dynamic>.from(snapshot.value);
      item.putIfAbsent('id', () => snapshot.key);
      return item;
    }).toList();
  }

  Future clear(String storeName) async {
    final store = intMapStoreFactory.store(storeName);
    await store.delete(await this.database);
  }

  Future clearWhere(String storeName, Filter filter) async {
    final store = intMapStoreFactory.store(storeName);
    final finder = Finder(filter: filter);

    return store.delete(await this.database, finder: finder);
  }
}
