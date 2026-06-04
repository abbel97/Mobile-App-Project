import 'dart:convert';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_client.dart';
import '../models/notification_model.dart';

class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications() async {
    final res = await ApiClient.get('/notifications');
    if (res.statusCode == 200) {
      final list = jsonDecode(res.body) as List;
      return list
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw ServerFailure(_msg(res.body));
  }

  Future<void> markAsRead(String id) async {
    await ApiClient.put('/notifications/$id/read', {});
  }

  Future<void> markAllRead() async {
    await ApiClient.put('/notifications/read-all', {});
  }

  String _msg(String body) {
    try {
      return (jsonDecode(body) as Map<String, dynamic>)['message'] as String? ??
          'Server error';
    } catch (_) { 
      return 'Server error'; 
      }
  }
}