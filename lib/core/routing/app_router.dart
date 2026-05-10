import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/change_password_screen.dart';
import '../../features/auth/presentation/screens/customer_register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_scren.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/professional_register_screen.dart';
import '../../features/customer/presentation/screens/customer_dashboard_screen.dart';
import '../../features/customer/presentation/screens/customer_edit_profile_sreen.dart';
import '../../features/customer/presentation/screens/customer_settings_screen.dart';
import '../../features/customer/presentation/screens/edit_request_screen.dart';
import '../../features/customer/presentation/screens/recent_requests_screen.dart';
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

class AppRouter {
	const AppRouter._();

	static final GoRouter router = GoRouter(
		initialLocation: AppRoutes.splash,
		routes: [
			GoRoute(
				path: AppRoutes.splash,
				builder: (context, state) => const SplashScreen(),
			),
			GoRoute(
				path: AppRoutes.home,
				builder: (context, state) => const HomeScreen(),
			),
			GoRoute(
				path: AppRoutes.login,
				builder: (context, state) => const LoginScreen(),
			),
			GoRoute(
				path: AppRoutes.customerRegister,
				builder: (context, state) => const CustomerRegisterScreen(),
			),
			GoRoute(
				path: AppRoutes.professionalRegister,
				builder: (context, state) => const ProfessionalRegisterScreen(),
			),
			GoRoute(
				path: AppRoutes.forgotPassword,
				builder: (context, state) => const ForgotPasswordScreen(),
			),
			GoRoute(
				path: AppRoutes.changePassword,
				builder: (context, state) => const ChangePasswordScreen(),
			),
			GoRoute(
				path: AppRoutes.customerDashboard,
				builder: (context, state) => const CustomerDashboardScreen(),
			),
			GoRoute(
				path: AppRoutes.customerRequests,
				builder: (context, state) => const RecentRequestsScreen(),
			),
			GoRoute(
				path: AppRoutes.customerRequestEdit,
				builder: (context, state) => const EditRequestScreen(),
			),
			GoRoute(
				path: AppRoutes.customerProfileEdit,
				builder: (context, state) => const CustomerEditProfileScreen(),
			),
			GoRoute(
				path: AppRoutes.customerSettings,
				builder: (context, state) => const CustomerSettingsScreen(),
			),
			GoRoute(
				path: AppRoutes.professionalDashboard,
				builder: (context, state) => const ProfessionalDashboardScreen(),
			),
			GoRoute(
				path: AppRoutes.jobs,
				builder: (context, state) => const JobsScreen(),
			),
			GoRoute(
				path: AppRoutes.acceptedJobs,
				builder: (context, state) => const AcceptedJobsScreen(),
			),
			GoRoute(
				path: AppRoutes.jobDetails,
				builder: (context, state) {
          final jobID = state.pathParameters['jobId']!;
          return JobDetailsScreen(jobId: jobID);
        },
			),
			GoRoute(
				path: AppRoutes.professionalProfileEdit,
				builder: (context, state) => const ProfessionalEditScreen(),
			),
			GoRoute(
				path: AppRoutes.professionalSettings,
				builder: (context, state) => const ProfessionalSettingsScreen(),
			),
			GoRoute(
				path: AppRoutes.professionalsList,
				builder: (context, state) => const ProfessionalsListScreen(),
			),
			GoRoute(
				path: AppRoutes.professionalProfileDetail,
				builder: (context, state) {
          final professionalId = state.pathParameters['professionalId']!;
          return ProfessionalProfileDetailScreen(professionalId: professionalId);
        },
			),
			GoRoute(
				path: AppRoutes.notifications,
				builder: (context, state) => const NotificationScreen(),
			),
			GoRoute(
				path: AppRoutes.termsAndPolicy,
				builder: (context, state) => const TermsAndPolicyScreen(),
			),
		],
	);
}
