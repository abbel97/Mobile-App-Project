import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repositories_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../../../core/errors/failure.dart';

 
class AuthState {
  final UserEntity? user;
  final bool isLoading;
  final String? error;
  final bool isInitialized;
  final bool isSuccess;

  const AuthState({
    this.user, 
    this.isLoading = false, 
    this.error, 
    this.isInitialized = false,
    this.isSuccess = false,
  });

  bool get isAuthenticated  => user != null;
  bool get isCustomer       => user?.role == 'customer';
  bool get isProfessional   => user?.role == 'professional';

  AuthState copyWith({
    UserEntity? user,
    bool? isLoading,
    String? error,
    bool? isInitialized,
    bool? isSuccess,
    bool clearUser  = false,
    bool clearError = false,
    bool clearSuccess = false,
  }) =>
      AuthState(
        user:      clearUser  ? null : user ?? this.user,
        isLoading: isLoading ?? this.isLoading,
        error:     clearError ? null : error ?? this.error,
        isInitialized: isInitialized ?? this.isInitialized,
        isSuccess: clearSuccess ? false : isSuccess ?? this.isSuccess,
      );
    
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepositoryImpl _repo;

  AuthNotifier(this._repo) : super(const AuthState()) {
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    try {
      final user = await _repo.getCurrentUser();
      if (mounted) state = state.copyWith(user: user, isInitialized: true);
    } catch (_) {
      if (mounted) state = state.copyWith(isInitialized: true);
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final user = await _repo.login(email: email, password: password);
      state = state.copyWith(user: user, isLoading: false);
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Something went wrong');
    }
  }
  
void clearError()   => state = state.copyWith(clearError: true);
void clearSuccess() => state = state.copyWith(clearSuccess: true);

  Future<bool> registerCustomer({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final user = await _repo.registerCustomer(
        name: name, email: email, password: password, confirmPassword: confirmPassword,
        persistSession: false,
      );
      await _repo.logout();
      state = state.copyWith(clearUser: true, isLoading: false);
      // ignore: unnecessary_null_comparison
      return user != null;
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Something went wrong');
    }
    return false;
  }

  Future<bool> registerProfessional({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String profession,
    String? bio,
    String? location,
    int? experienceYears,
    double? serviceRate,
    String? educationLevel,
    String? photoBase64,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final user = await _repo.registerProfessional(
        name: name, email: email, password: password, confirmPassword: confirmPassword,
        profession: profession, bio: bio, location: location,
        experienceYears: experienceYears, serviceRate: serviceRate,
        educationLevel: educationLevel,
        photoBase64: photoBase64,
        persistSession: false,
      );
      await _repo.logout();
      state = state.copyWith(clearUser: true, isLoading: false);
      // ignore: unnecessary_null_comparison
      return user != null;
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Something went wrong');
    }
    return false;
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const AuthState();
  }

  Future<void> deleteAccount() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repo.deleteAccount();
      state = const AuthState();
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Failed to delete account');
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repo.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );
      state = state.copyWith(isLoading: false);
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Failed to change password');
    }
  }

Future<void> updateProfile({
  required String name,
  required String email,
  String? location,
  String? photoBase64,
}) async {
  state = state.copyWith(isLoading: true, clearError: true);
  try {
    final user = await _repo.updateProfile(
      name: name, email: email,
      location: location, photoBase64: photoBase64,
    );
    state = state.copyWith(user: user, isLoading: false, isSuccess: true);
  } on Failure catch (e) {
    state = state.copyWith(isLoading: false, error: e.message);
  } catch (_) {
    state = state.copyWith(isLoading: false, error: 'Failed to update profile');
  } 
 }
}

//Providers 
final authRepositoryProvider = Provider<AuthRepositoryImpl>(
  (_) => AuthRepositoryImpl(),
);

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});

