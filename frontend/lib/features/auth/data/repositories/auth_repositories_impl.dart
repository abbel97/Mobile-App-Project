import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource  _local;

  AuthRepositoryImpl()
      : _remote = AuthRemoteDataSource(),
        _local  = AuthLocalDataSource();

  Future<UserEntity> _saveAndReturn(UserModel user) async {
    await _local.saveToken(user.token!);
    await _local.saveUser(user);
    return user;
  }

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final user = await _remote.login(email: email, password: password);
    return _saveAndReturn(user);
  }

  @override
  Future<UserEntity> registerCustomer({ 
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final user = await _remote.registerCustomer(
      name: name, email: email, password: password, confirmPassword: confirmPassword,
    );
    return _saveAndReturn(user);
  }

  @override
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
  }) async {
    final user = await _remote.registerProfessional(
      name: name, email: email, password: password,
      profession: profession, bio: bio, location: location,
      experienceYears: experienceYears, serviceRate: serviceRate,
      educationLevel: educationLevel,
    );
    return _saveAndReturn(user);
  }

  @override
  Future<void> logout() => _local.clearAll();

  @override
  Future<void> deleteAccount() async {
    await _remote.deleteAccount();
    await _local.clearAll();
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) => _remote.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

  @override
  Future<UserEntity?> getCurrentUser() => _local.getUser();
}