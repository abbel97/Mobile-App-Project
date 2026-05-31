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
    required String confirmPassword,
    bool persistSession = true,
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
    bool persistSession = true,
  });

  Future<void> logout();
  Future<void> deleteAccount();
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  });
  Future<UserEntity> updateProfile({
    required String name,
    required String email,
    String? location,
    String? photoBase64,
  });
  Future<UserEntity?> getCurrentUser();
}