import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String  id;
  final String  userId;
  final String  title;
  final String  body;
  final String  type;     
  final String? requestId;
  final bool    isRead;
  final String  createdAt;

  const NotificationEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    this.requestId,
    required this.isRead,
    required this.createdAt,
  });

  bool get isNewApplication => type == 'new_application';
  bool get isHired  => type == 'hired';

  @override
  List<Object?> get props => [id, isRead];
}