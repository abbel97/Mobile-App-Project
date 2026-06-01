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
    return openDatabase(
      path,
      version: 5,           
      onCreate: _createTables,
      onUpgrade: (db, oldV, newV) async {
        if (oldV < 2) {
          try { await db.execute('ALTER TABLE service_requests ADD COLUMN accepted_by TEXT'); } catch (_) {}
        }
        if (oldV < 3) {
          try { await db.execute("ALTER TABLE users ADD COLUMN location TEXT NOT NULL DEFAULT ''"); } catch (_) {}
          try { await db.execute("ALTER TABLE service_requests ADD COLUMN customer_name TEXT NOT NULL DEFAULT ''"); } catch (_) {}
        }
        if (oldV < 4) {  
          try { await db.execute('ALTER TABLE users ADD COLUMN photo_base64 TEXT'); } catch (_) {}
          try { await db.execute('ALTER TABLE professionals ADD COLUMN photo_base64 TEXT'); } catch (_) {}
          try { await db.execute('ALTER TABLE professionals ADD COLUMN skills TEXT'); } catch (_) {}
        }
        if (oldV < 5) {
          try { await db.execute('ALTER TABLE service_requests ADD COLUMN photo_base64 TEXT'); } catch (_) {}
        }
      },
    );
  }

  static Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id           TEXT PRIMARY KEY,
        name         TEXT NOT NULL,
        email        TEXT NOT NULL UNIQUE,
        role         TEXT NOT NULL,
        location     TEXT NOT NULL DEFAULT '',
        photo_base64 TEXT,
        token        TEXT,
        created_at   TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS service_requests (
        id            TEXT PRIMARY KEY,
        title         TEXT NOT NULL,
        description   TEXT NOT NULL,
        profession    TEXT NOT NULL,
        location      TEXT NOT NULL,
        customer_name TEXT NOT NULL DEFAULT '',
        status        TEXT NOT NULL,
        urgency       TEXT NOT NULL,
        customer_id   TEXT NOT NULL,
        accepted_by   TEXT,
        photo_base64  TEXT,
        created_at    TEXT NOT NULL,
        updated_at    TEXT NOT NULL
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
        skills           TEXT,
        photo_base64     TEXT,
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