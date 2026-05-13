// packages/core_storage/lib/src/database/dao/base_dao.dart
import 'package:sqflite/sqflite.dart';
import '../app_database.dart';

abstract class BaseDao<T> {
  final AppDatabase appDatabase;
  String get tableName;

  BaseDao(this.appDatabase);

  Future<Database> get _db => appDatabase.database;

  // ─── Convert between model and map ──────────────────────────────────────────
  Map<String, dynamic> toMap(T entity);
  T fromMap(Map<String, dynamic> map);

  // ─── CRUD ────────────────────────────────────────────────────────────────────
  Future<int> insert(T entity) async {
    final db = await _db;
    return db.insert(
      tableName,
      toMap(entity),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertAll(List<T> entities) async {
    final db = await _db;
    final batch = db.batch();
    for (final e in entities) {
      batch.insert(
        tableName,
        toMap(e),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    final results = await batch.commit(noResult: false);
    return results.length;
  }

  Future<T?> findById(String id) async {
    final db = await _db;
    final maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }

  Future<List<T>> findAll() async {
    final db = await _db;
    final maps = await db.query(tableName);
    return maps.map(fromMap).toList();
  }

  Future<List<T>> query({
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await _db;
    final maps = await db.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
    return maps.map(fromMap).toList();
  }

  Future<int> update(T entity) async {
    final db = await _db;
    final map = toMap(entity);
    return db.update(tableName, map, where: 'id = ?', whereArgs: [map['id']]);
  }

  Future<int> delete(String id) async {
    final db = await _db;
    return db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    final db = await _db;
    return db.delete(tableName);
  }

  Future<int> count() async {
    final db = await _db;
    final result = await db.rawQuery('SELECT COUNT(*) FROM $tableName');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
