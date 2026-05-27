import 'package:equatable/equatable.dart';

class ServiceRequestEntity extends Equatable {
  final String  id;
  final String  title;
  final String  description;
  final String  profession;
  final String  location;
  final String  status;
  final String  urgency;
  final String  customerId;
  final String? acceptedBy;
  final String  createdAt;
  final String  updatedAt;

  const ServiceRequestEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.profession,
    required this.location,
    required this.status,
    required this.urgency,
    required this.customerId,
    this.acceptedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isPending  => status == 'pending';
  bool get isAccepted => status == 'accepted';

  @override
  List<Object?> get props => [id, status];
}