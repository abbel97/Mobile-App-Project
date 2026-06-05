import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/database/app_database.dart';
import '../models/service_request_model.dart';

class ServiceRequestLocalDataSource {
  Future<List<ServiceRequestModel>> getRequests() async {
    if (kIsWeb) return [];
    final db   = await AppDatabase.database;
    final rows = await db.query('service_requests', orderBy: 'created_at DESC');
    return rows.map(ServiceRequestModel.fromDb).toList();
  }

  Future<void> saveRequests(List<ServiceRequestModel> requests) async {
    if (kIsWeb) return;
    final db    = await AppDatabase.database;
    final batch = db.batch();
    for (final r in requests) {
      batch.insert('service_requests', r.toDb(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<void> saveRequest(ServiceRequestModel request) async {
    if (kIsWeb) return;
    final db = await AppDatabase.database;
    await db.insert('service_requests', request.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteRequest(String id) async {
    if (kIsWeb) return;
    final db = await AppDatabase.database;
    await db.delete('service_requests', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearAll() async {
    if (kIsWeb) return;
    final db = await AppDatabase.database;
    await db.delete('service_requests');
  }
}