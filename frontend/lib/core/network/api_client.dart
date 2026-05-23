import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  // Android emulator → 10.0.2.2  |  iOS simulator → localhost
  static const String _base = 'http://10.0.2.2:3000/api';

  static Future<String?> _token() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<Map<String, String>> _headers({bool auth = true}) async {
    final h = {'Content-Type': 'application/json'};
    if (auth) {
      final t = await _token();
      if (t != null) h['Authorization'] = 'Bearer $t';
    }
    return h;
  }

  static Future<http.Response> get(String path) async =>
      http.get(Uri.parse('$_base$path'), headers: await _headers());

  static Future<http.Response> post(
    String path,
    Map<String, dynamic> body, {
    bool auth = true,
  }) async =>
      http.post(
        Uri.parse('$_base$path'),
        headers: await _headers(auth: auth),
        body: jsonEncode(body),
      );

  static Future<http.Response> put(
    String path,
    Map<String, dynamic> body,
  ) async =>
      http.put(
        Uri.parse('$_base$path'),
        headers: await _headers(),
        body: jsonEncode(body),
      );

  static Future<http.Response> delete(String path) async =>
      http.delete(Uri.parse('$_base$path'), headers: await _headers());
}