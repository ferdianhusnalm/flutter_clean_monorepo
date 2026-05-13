// packages/core_storage/lib/src/database/app_database.dart
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@singleton
class AppDatabase {
  static const int _version = 1;
  static const String _dbName = 'app.db';

  Database? _db;

  Future<Database> get database async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _version,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create tables
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id          TEXT PRIMARY KEY,
        name        TEXT NOT NULL,
        email       TEXT NOT NULL,
        created_at  INTEGER NOT NULL,
        updated_at  INTEGER NOT NULL
      )
    ''');

    // Add more tables here during initial creation
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle incremental migrations
    if (oldVersion < 2) {
      // await db.execute('ALTER TABLE users ADD COLUMN avatar TEXT');
    }
  }

  Future<void> close() async => _db?.close();
}
