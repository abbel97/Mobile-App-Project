import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/database/app_database.dart';
import '../models/user_model.dart';

class AuthLocalDataSource {
  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> saveUser(UserModel user) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, jsonEncode(user.toDb()));
      return;
    }
    final db = await AppDatabase.database;
    await db.insert(
      'users',
      user.toDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<UserModel?> getUser() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_userKey);
      if (raw == null || raw.isEmpty) return null;
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return UserModel.fromDb(map);
    }
    final db = await AppDatabase.database;
    final rows = await db.query('users', limit: 1);
    if (rows.isEmpty) return null;
    return UserModel.fromDb(rows.first);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
    if (kIsWeb) return;
    final db = await AppDatabase.database;
    await db.delete('users');
    await db.delete('service_requests');
    await db.delete('professionals');
  }
}