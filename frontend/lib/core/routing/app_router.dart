import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_notifier.dart';
import '../../features/auth/presentation/screens/change_password_screen.dart';
import '../../features/auth/presentation/screens/customer_register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/professional_register_screen.dart';
import '../../features/customer/presentation/screens/customer_dashboard_screen.dart';
import '../../features/customer/presentation/screens/customer_edit_profile_screen.dart';
import '../../features/customer/presentation/screens/customer_settings_screen.dart';
import '../../features/customer/presentation/screens/edit_request_screen.dart';
import '../../features/customer/presentation/screens/recent_requests_screen.dart';
import '../../features/customer/presentation/screens/request_submission_screen.dart';
import '../../features/professional/presentation/screens/accepted_jobs_screen.dart';
import '../../features/professional/presentation/screens/job_details_screen.dart';
import '../../features/professional/presentation/screens/jobs_screen.dart';
import '../../features/professional/presentation/screens/professional_dashboard_screen.dart';
import '../../features/professional/presentation/screens/professional_edit_screen.dart';
import '../../features/professional/presentation/screens/professional_settings_screen.dart';
import '../../features/shared/presentation/screens/home_screen.dart';
import '../../features/shared/presentation/screens/notification_screen.dart';
import '../../features/shared/presentation/screens/professional_profile_detail_screen.dart';
import '../../features/shared/presentation/screens/professionals_list_screen.dart';
import '../../features/shared/presentation/screens/terms_and_policy_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import 'app_routes.dart';

// Bridges Riverpod state to GoRouter's ChangeNotifier listener
class _AuthListenable extends ChangeNotifier {
  _AuthListenable(Ref ref) {
    ref.listen<AuthState>(authProvider, (context, state) => notifyListeners());
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: _AuthListenable(ref),
    redirect: (context, state) {
      final auth = ref.read(authProvider);
      final location = state.uri.toString();

      // Still loading persisted user — let splash handle it
      if (location == AppRoutes.splash) return null;

      final isAuth   = auth.isAuthenticated;
      final isCust   = auth.isCustomer;
      final isProf   = auth.isProfessional;

      // Unauthenticated trying to reach protected routes
      if (!isAuth &&
          (location.startsWith('/customer') ||
           location.startsWith('/professional'))) {
        return AppRoutes.home;
      }

      // Role-based authorization
      if (isAuth && isCust && location.startsWith('/professional')) {
        return AppRoutes.customerDashboard;
      }
      if (isAuth && isProf && location.startsWith('/customer')) {
        return AppRoutes.professionalDashboard;
      }

      // Already logged in, No auth screens
      if (isAuth &&
          (location == AppRoutes.home ||
           location == AppRoutes.login ||
           location == AppRoutes.customerRegister ||
           location == AppRoutes.professionalRegister)) {
        return isCust ? AppRoutes.customerDashboard : AppRoutes.professionalDashboard;
      }

      return null;
    },
    errorBuilder: (context, state) => const Scaffold(
      body: Center(child: Text('Page not found')),
    ),
    routes: [
      GoRoute(path: AppRoutes.splash,
          builder: (context, state) => const SplashScreen()),
      GoRoute(path: AppRoutes.home,
          builder: (context, state) => const HomeScreen()),
      GoRoute(path: AppRoutes.login,
          builder: (context, state) => const LoginScreen()),
      GoRoute(path: AppRoutes.customerRegister,
          builder: (context, state) => const CustomerRegisterScreen()),
      GoRoute(path: AppRoutes.professionalRegister,
          builder: (context, state) => const ProfessionalRegisterScreen()),
      GoRoute(path: AppRoutes.forgotPassword,
          builder: (context, state) => const ForgotPasswordScreen()),
      GoRoute(path: AppRoutes.changePassword,
          builder: (context, state) => const ChangePasswordScreen()),
      GoRoute(path: AppRoutes.customerDashboard,
          builder: (context, state) => const CustomerDashboardScreen()),
      GoRoute(path: AppRoutes.customerRequestSubmit,
          builder: (context, state) => const RequestSubmissionScreen()),
      GoRoute(path: AppRoutes.customerRequests,
          builder: (context, state) => const RecentRequestsScreen()),
        GoRoute(path: AppRoutes.customerProfessionalsList,
          builder: (context, state) => const ProfessionalsListScreen()),
      GoRoute(
        path: AppRoutes.customerRequestEdit,
        builder: (context, state) => EditRequestScreen(
          requestId: state.pathParameters['requestId']!,
        ),
      ),
      GoRoute(path: AppRoutes.customerProfileEdit,
          builder: (context, state) => const CustomerEditProfileScreen()),
      GoRoute(path: AppRoutes.customerSettings,
          builder: (context, state) => const CustomerSettingsScreen()),
      GoRoute(path: AppRoutes.professionalDashboard,
          builder: (context, state) => const ProfessionalDashboardScreen()),
      GoRoute(path: AppRoutes.jobs,
          builder: (context, state) => const JobsScreen()),
      GoRoute(path: AppRoutes.acceptedJobs,
          builder: (context, state) => const AcceptedJobsScreen()),
      GoRoute(
        path: AppRoutes.jobDetails,
        builder: (context, state) => JobDetailsScreen(
          jobId: state.pathParameters['jobId']!,
        ),
      ),
      GoRoute(path: AppRoutes.professionalProfileEdit,
          builder: (context, state) => const ProfessionalEditScreen()),
      GoRoute(path: AppRoutes.professionalSettings,
          builder: (context, state) => const ProfessionalSettingsScreen()),
      GoRoute(path: AppRoutes.professionalsList,
          builder: (context, state) => const ProfessionalsListScreen()),
      GoRoute(
        path: AppRoutes.professionalProfileDetail,
        builder: (context, state) => ProfessionalProfileDetailScreen(
          professionalId: state.pathParameters['professionalId']!,
        ),
      ),
      GoRoute(path: AppRoutes.notifications,
          builder: (context, state) => const NotificationScreen()),
      GoRoute(path: AppRoutes.termsAndPolicy,
          builder: (context, state) => const TermsAndPolicyScreen()),
    ],
  );
});