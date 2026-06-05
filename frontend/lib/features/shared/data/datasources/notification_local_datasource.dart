import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/database/app_database.dart';
import '../models/notification_model.dart';

class NotificationLocalDataSource {
  Future<List<NotificationModel>> getNotifications(String userId) async {
    if (kIsWeb) return [];
    final db   = await AppDatabase.database;
    final rows = await db.query(
      'notifications',
      where:   'user_id = ?',
      whereArgs: [userId],
      orderBy: 'created_at DESC',
    );
    return rows.map(NotificationModel.fromDb).toList();
  }

  Future<void> saveNotifications(List<NotificationModel> list) async {
    if (kIsWeb) return;
    final db    = await AppDatabase.database;
    final batch = db.batch();
    for (final n in list) {
      batch.insert('notifications', n.toDb(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<void> markAsRead(String id) async {
    if (kIsWeb) return;
    final db = await AppDatabase.database;
    await db.update('notifications', {'is_read': 1},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<void> markAllRead(String userId) async {
    if (kIsWeb) return;
    final db = await AppDatabase.database;
    await db.update('notifications', {'is_read': 1},
        where: 'user_id = ?', whereArgs: [userId]);
  }

  Future<void> clearAll(String userId) async {
    if (kIsWeb) return;
    final db = await AppDatabase.database;
    await db.delete('notifications', where: 'user_id = ?', whereArgs: [userId]);
  }
}