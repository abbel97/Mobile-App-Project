import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_tweak/features/auth/domain/entities/user_entity.dart';
import 'package:home_tweak/features/auth/presentation/providers/auth_notifier.dart';
import 'package:home_tweak/features/customer/presentation/providers/service_request_notifier.dart';

void main() {
  group('AuthNotifier — provider', () {
    test('authProvider creates AuthNotifier instance', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(authProvider.notifier);
      expect(notifier, isA<AuthNotifier>());
    });

    test('initial state is unauthenticated', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(authProvider);
      expect(state.isAuthenticated, false);
      expect(state.isLoading,       false);
    });

    test('clears error via clearError()', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(authProvider.notifier).clearError();
      expect(container.read(authProvider).error, isNull);
    });
  });

  group('AuthNotifier — state transitions', () {
    test('AuthState.copyWith isInitialized transitions correctly', () {
      const initial = AuthState();
      expect(initial.isInitialized, false);

      final initialized = initial.copyWith(isInitialized: true);
      expect(initialized.isInitialized, true);
    });

    test('user assignment makes state authenticated', () {
      const user = UserEntity(
        id: '1', name: 'Test', email: 't@t.com',
        role: 'customer', createdAt: '2026-01-01',
      );
      final state = AuthState(user: user, isInitialized: true);
      expect(state.isAuthenticated, true);
      expect(state.isCustomer,      true);
    });

    test('logout clears user and resets to initial', () {
      const user = UserEntity(
        id: '1', name: 'Test', email: 't@t.com',
        role: 'professional', createdAt: '2026-01-01',
      );
      final loggedIn = AuthState(user: user, isInitialized: true);
      final loggedOut = loggedIn.copyWith(clearUser: true, isInitialized: true);

      expect(loggedOut.isAuthenticated, false);
      expect(loggedOut.isInitialized,   true);
    });
  });

  group('ServiceRequestState — provider', () {
    test('serviceRequestProvider loads without error', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        () => container.read(serviceRequestProvider.notifier),
        returnsNormally,
      );
    });
  });
}