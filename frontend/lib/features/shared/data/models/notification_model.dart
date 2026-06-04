import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.body,
    required super.type,
    super.requestId,
    required super.isRead,
    required super.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> j) =>
      NotificationModel(
        id:        j['id']         as String,
        userId:    j['user_id']    as String,
        title:     j['title']      as String,
        body:      j['body']       as String,
        type:      j['type']       as String,
        requestId: j['request_id'] as String?,
        isRead:    (j['is_read'] as int? ?? 0) == 1,
        createdAt: j['created_at'] as String,
      );

  factory NotificationModel.fromDb(Map<String, dynamic> m) =>
      NotificationModel(
        id:        m['id']         as String,
        userId:    m['user_id']    as String,
        title:     m['title']      as String,
        body:      m['body']       as String,
        type:      m['type']       as String,
        requestId: m['request_id'] as String?,
        isRead:    (m['is_read'] as int? ?? 0) == 1,
        createdAt: m['created_at'] as String,
      );

  Map<String, dynamic> toDb() => {
    'id':         id,
    'user_id':    userId,
    'title':      title,
    'body':       body,
    'type':       type,
    'request_id': requestId,
    'is_read':    isRead ? 1 : 0,
    'created_at': createdAt,
  };
}