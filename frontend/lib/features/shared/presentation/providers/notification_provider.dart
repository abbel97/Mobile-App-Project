//import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/failure.dart';
//import '../../../../core/network/api_client.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';
import '../../data/datasources/notification_local_datasource.dart';
import '../../data/datasources/notification_remote_datasource.dart';
import '../../data/models/notification_model.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationState {
  final List<NotificationEntity> notifications;
  final bool   isLoading;
  final String? error;

  const NotificationState({
    this.notifications = const [],
    this.isLoading     = false,
    this.error,
  });

  int get unreadCount =>
      notifications.where((n) => !n.isRead).length;

  NotificationState copyWith({
    List<NotificationEntity>? notifications,
    bool?   isLoading,
    String? error,
    bool    clearError = false,
  }) =>
      NotificationState(
        notifications: notifications ?? this.notifications,
        isLoading:     isLoading     ?? this.isLoading,
        error:         clearError ? null : error ?? this.error,
      );
}

class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationRemoteDataSource _remote;
  final NotificationLocalDataSource  _local;
  final String? _userId;

  NotificationNotifier(this._remote, this._local, this._userId)
      : super(const NotificationState()) {
    if (_userId != null) loadNotifications();
  }

  Future<void> loadNotifications() async {
    if (_userId == null) return;
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final cached = await _local.getNotifications(_userId);
      if (cached.isNotEmpty) state = state.copyWith(notifications: cached);
      
      final remote = await _remote.getNotifications();
      await _local.saveNotifications(remote);
      state = state.copyWith(notifications: remote, isLoading: false);
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> markAsRead(String id) async {
    if (_userId == null) return;
    await _remote.markAsRead(id);
    await _local.markAsRead(id);
    final updated = state.notifications.map((n) {
      if (n.id == id) {
        return NotificationModel.fromJson({
          'id': n.id, 'user_id': n.userId, 'title': n.title,
          'body': n.body, 'type': n.type, 'request_id': n.requestId,
          'is_read': 1, 'created_at': n.createdAt,
        });
      }
      return n;
    }).toList();
    state = state.copyWith(notifications: updated);
  }

  Future<void> markAllRead() async {
    if (_userId == null) return;
    await _remote.markAllRead();
    await _local.markAllRead(_userId);
    await loadNotifications();
  }
}

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  final userId = ref.watch(authProvider).user?.id;
  return NotificationNotifier(
    NotificationRemoteDataSource(),
    NotificationLocalDataSource(),
    userId,
  );
});