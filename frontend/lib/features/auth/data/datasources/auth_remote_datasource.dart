import 'dart:convert';
import '../../domain/auth_failure.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final res = await ApiClient.post(
      '/auth/login',
      {'email': email, 'password': password},
      auth: false,
    );
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200) {
      return UserModel.fromJson(
        body['user'] as Map<String, dynamic>,
        token: body['token'] as String,
      );
    }
    if (res.statusCode == 401) throw const InvalidCredentialsFailure();
    throw ServerFailure(body['message'] as String? ?? 'Server error');
  }

  Future<UserModel> registerCustomer({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final res = await ApiClient.post(
      '/auth/register/customer',
      {'name': name, 'email': email, 'password': password, 'confirmPassword': confirmPassword},
      auth: false,
    );
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 201) {
      return UserModel.fromJson(
        body['user'] as Map<String, dynamic>,
        token: body['token'] as String,
      );
    }
    if (res.statusCode == 409) throw const EmailAlreadyInUseFailure();
    throw ServerFailure(body['message'] as String? ?? 'Server error');
  }

  Future<UserModel> registerProfessional({
    required String name,
    required String email,
    required String password,
    required String profession,
    String? bio,
    String? location,
    int? experienceYears,
    double? serviceRate,
    String? educationLevel,
    String? photoBase64,
  }) async {
    final res = await ApiClient.post('/auth/register/professional',
      {
        'name': name, 'email': email,
        'password': password, 'profession': profession,
        if (bio != null)              'bio': bio,
        if (location != null)         'location': location,
        if (experienceYears != null)  'experience_years': experienceYears,
        if (serviceRate != null)      'service_rate': serviceRate,
        if (educationLevel != null)   'education_level': educationLevel,
        if (photoBase64 != null)      'photo_base64': photoBase64,
      },
      auth: false,);
      
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 201) {
      return UserModel.fromJson(
        body['user'] as Map<String, dynamic>,
        token: body['token'] as String,
      );
    }
    if (res.statusCode == 409) throw const EmailAlreadyInUseFailure();
    throw ServerFailure(body['message'] as String? ?? 'Server error');
  }

  Future<void> deleteAccount() async {
    final res  = await ApiClient.delete('/auth/account');
    if (res.statusCode != 200) {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      throw ServerFailure(body['message'] as String? ?? 'Failed to delete account');
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final res = await ApiClient.put('/auth/change-password', {
      'currentPassword': currentPassword,
      'newPassword':     newPassword,
      'confirmNewPassword': confirmNewPassword,
    });
    if (res.statusCode != 200) {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      throw ServerFailure(body['message'] as String? ?? 'Failed to change password');
    }
  }

Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final res = await ApiClient.post('/auth/reset-password', {
      'email':           email,
      'newPassword':     newPassword,
      'confirmPassword': confirmPassword,
    }, auth: false);
    if (res.statusCode != 200) {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      throw ServerFailure(body['message'] as String? ?? 'Reset failed');
    }
  }


Future<UserModel> updateProfile({
  required String name,
  required String email,
  String? location,
  String? photoBase64,
}) async {
  final res = await ApiClient.put('/auth/me', {
    'name':  name,
    'email': email,
    if (location != null)     'location':     location,
    if (photoBase64 != null)  'photo_base64': photoBase64,
  });
  final body = jsonDecode(res.body) as Map<String, dynamic>;
  if (res.statusCode == 200) {
    return UserModel.fromJson(
      body['user'] as Map<String, dynamic>,
      token: await _getStoredToken(),
    );
  }
  if (res.statusCode == 409) throw const EmailAlreadyInUseFailure();
  throw ServerFailure(body['message'] as String? ?? 'Server error');
}

Future<String?> _getStoredToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
 }
 
}