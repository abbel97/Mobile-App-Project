import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? location;
  final String? photoBase64;
  final String createdAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.location,
    this.photoBase64,
    required this.createdAt,
  });

  bool get isCustomer     => role == 'customer';
  bool get isProfessional => role == 'professional';

  @override
  List<Object?> get props => [id, email, role];
}