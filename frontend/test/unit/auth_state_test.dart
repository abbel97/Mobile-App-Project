import 'package:flutter_test/flutter_test.dart';
import 'package:home_tweak/features/auth/domain/entities/user_entity.dart';
import 'package:home_tweak/features/auth/presentation/providers/auth_notifier.dart';

void main() {
  const customer = UserEntity(
    id: '1', name: 'Test Customer',
    email: 'customer@test.com', role: 'customer',
    createdAt: '2024-01-01',
  );
  const professional = UserEntity(
    id: '2', name: 'Test Pro',
    email: 'pro@test.com', role: 'professional',
    createdAt: '2024-01-01',
  );

  group('AuthState — initial values', () {
    test('unauthenticated by default', () {
      const state = AuthState();
      expect(state.isAuthenticated, false);
      expect(state.isLoading,       false);
      expect(state.isInitialized,   false);
      expect(state.error,           isNull);
    });
  });

  group('AuthState — role getters', () {
    test('isCustomer true for customer role', () {
      final state = AuthState(user: customer);
      expect(state.isCustomer,     true);
      expect(state.isProfessional, false);
    });

    test('isProfessional true for professional role', () {
      final state = AuthState(user: professional);
      expect(state.isProfessional, true);
      expect(state.isCustomer,     false);
    });
  });

  group('AuthState — copyWith', () {
    test('clearError sets error to null', () {
      const state = AuthState(error: 'Network failure');
      final result = state.copyWith(clearError: true);
      expect(result.error, isNull);
    });

    test('clearUser removes authenticated user', () {
      final state = AuthState(user: customer);
      final result = state.copyWith(clearUser: true);
      expect(result.user,            isNull);
      expect(result.isAuthenticated, false);
    });

    test('preserves unmodified fields', () {
      const state = AuthState(isLoading: true);
      final result = state.copyWith(error: 'oops');
      expect(result.isLoading, true);
      expect(result.error,     'oops');
    });
  });
}