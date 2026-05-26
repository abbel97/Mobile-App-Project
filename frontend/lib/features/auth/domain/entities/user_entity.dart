import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role;
  final String createdAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  bool get isCustomer     => role == 'customer';
  bool get isProfessional => role == 'professional';

  @override
  List<Object?> get props => [id, email, role];
}