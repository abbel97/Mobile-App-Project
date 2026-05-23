import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> get database async {
    _db ??= await _init();
    return _db!;
  }

  static Future<Database> _init() async {
    final path = join(await getDatabasesPath(), 'home_tweak.db');
    return openDatabase(path, version: 1, onCreate: _createTables);
  }

  static Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id         TEXT PRIMARY KEY,
        name       TEXT NOT NULL,
        email      TEXT NOT NULL UNIQUE,
        role       TEXT NOT NULL,
        token      TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS service_requests (
        id          TEXT PRIMARY KEY,
        title       TEXT NOT NULL,
        description TEXT NOT NULL,
        profession  TEXT NOT NULL,
        location    TEXT NOT NULL,
        status      TEXT NOT NULL,
        urgency     TEXT NOT NULL,
        customer_id TEXT NOT NULL,
        created_at  TEXT NOT NULL,
        updated_at  TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS professionals (
        id               TEXT PRIMARY KEY,
        user_id          TEXT NOT NULL UNIQUE,
        name             TEXT NOT NULL,
        email            TEXT NOT NULL,
        profession       TEXT NOT NULL,
        bio              TEXT,
        location         TEXT,
        experience_years INTEGER,
        service_rate     REAL,
        education_level  TEXT,
        created_at       TEXT NOT NULL,
        updated_at       TEXT NOT NULL
      )
    ''');
  }

  static Future<void> clearAll() async {
    final db = await database;
    await db.delete('service_requests');
    await db.delete('professionals');
    await db.delete('users');
  }
}