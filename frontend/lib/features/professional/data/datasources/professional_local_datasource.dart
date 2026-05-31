import 'package:sqflite/sqflite.dart';
import '../../../../core/database/app_database.dart';
import '../models/professional_model.dart';

class ProfessionalLocalDataSource {
  Future<List<ProfessionalModel>> getProfessionals() async {
    final db   = await AppDatabase.database;
    final rows = await db.query('professionals', orderBy: 'created_at DESC');
    return rows.map(ProfessionalModel.fromDb).toList();
  }

  Future<ProfessionalModel?> getProfessional(String id) async {
    final db   = await AppDatabase.database;
    final rows = await db.query(
      'professionals',
      where: 'id = ? OR user_id = ?',
      whereArgs: [id, id],
      limit: 1,
    );
    return rows.isEmpty ? null : ProfessionalModel.fromDb(rows.first);
  }

  Future<ProfessionalModel?> getMyProfile(String userId) async {
    final db   = await AppDatabase.database;
    final rows = await db.query(
      'professionals',
      where: 'user_id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    return rows.isEmpty ? null : ProfessionalModel.fromDb(rows.first);
  }

  Future<void> saveProfessionals(List<ProfessionalModel> list) async {
    final db    = await AppDatabase.database;
    final batch = db.batch();
    for (final p in list) {
      batch.insert('professionals', p.toDb(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<void> saveProfessional(ProfessionalModel p) async {
    final db = await AppDatabase.database;
    await db.insert('professionals', p.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteProfessional(String id) async {
    final db = await AppDatabase.database;
    await db.delete('professionals',
        where: 'id = ? OR user_id = ?', whereArgs: [id, id]);
  }

  Future<void> clearAll() async {
    final db = await AppDatabase.database;
    await db.delete('professionals');
  }
}