import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity> registerCustomer({
    required String name,
    required String email,
    required String password,
  });

  Future<UserEntity> registerProfessional({
    required String name,
    required String email,
    required String password,
    required String profession,
    String? bio,
    String? location,
    int? experienceYears,
    double? serviceRate,
    String? educationLevel,
  });

  Future<void> logout();
  Future<void> deleteAccount();
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  Future<UserEntity?> getCurrentUser();
}