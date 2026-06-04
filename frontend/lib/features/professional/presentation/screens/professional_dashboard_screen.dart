import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';
import '../../../customer/presentation/providers/service_request_notifier.dart';
import '../widgets/professional_bottom_nav_bar.dart';
import '../../../shared/presentation/providers/notification_provider.dart';

class ProfessionalDashboardScreen extends ConsumerWidget {
  const ProfessionalDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final firstName = _firstName(auth.user?.name);
    final srState = ref.watch(serviceRequestProvider);
    final applied = srState.requests.where((r) => r.acceptedBy == auth.user?.id).length;
    final confirmed = srState.requests.where((r) => r.acceptedBy == auth.user?.id && r.status == 'confirmed').length;
    final unread = ref.watch(notificationProvider).unreadCount;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.neutral,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: const Icon(
                          Icons.architecture_rounded,
                          color: AppColors.primary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                        Text(
                          'Home-Tweak',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.neutral,
                            borderRadius: BorderRadius.circular(AppRadii.md),
                          ),
                        ),
                        const Spacer(),
                          GestureDetector(
                            onTap: () => context.push(AppRoutes.notifications),
                            child: Stack(
                              children: [
                                const Icon(Icons.notifications_outlined,
                                    color: AppColors.primary, size: 26),
                                if (unread > 0)
                                          Positioned(
                                            right: 0, top: 0,
                                            child: Container(
                                              width: 16, height: 16,
                                              decoration: const BoxDecoration(
                                                  color: AppColors.danger, shape: BoxShape.circle),
                                              child: Center(
                                                child: Text(
                                                  unread > 9 ? '9+' : unread.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white, fontSize: 9,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                        
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Hello, $firstName.',
                      style: AppTextStyles.headline2.copyWith(
                        fontSize: 34,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Ready for today's work?",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textBody,
                      ),
                    ),
                    const SizedBox(height: 28),

                    _MetricCard(
                      label: 'APPLIED JOBS',
                      value: applied.toString(),
                      icon: Icons.manage_accounts_rounded,
                      color: Color(0xFF29479A),
                    ),
                    const SizedBox(height: 14),
                    _MetricCard(
                      label: 'ACCEPTED JOBS',
                      value: confirmed.toString(),
                      icon: Icons.check_circle_outline_rounded,
                      color: Color(0xFF0B7B53),
                    ),
                    const SizedBox(height: 34),

                    Row(
                      children: [
                        Text(
                          'Quick Actions',
                          style: AppTextStyles.titleLarge.copyWith(
                            fontSize: 20,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _ActionCard(
                      icon: Icons.manage_search_rounded,
                      title: 'Available Jobs',
                      description: 'Check new requests in your area',
                      titleColor: AppColors.primary,
                      onTap: () => context.push(AppRoutes.jobs),
                    ),
                    const SizedBox(height: 14),
                    _ActionCard(
                      icon: Icons.badge_outlined,
                      title: 'My Jobs',
                      description:
                          'Manage your active schedule and client list',
                      onTap: () => context.push(AppRoutes.acceptedJobs),
                    ),
                    const SizedBox(height: 34),

                   
                    Text(
                      'Your Schedule',
                      style: AppTextStyles.titleLarge.copyWith(
                        fontSize: 20,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _ScheduleCard(
                      accentColor: const Color(0xFF0A6C5B),
                      category: 'PLUMBING',
                      status: 'CONFIRMED',
                      title: 'Kitchen Sink Leak Repair',
                      location: '1244 Bole St, Downtown',
                      onTap: () => context.go(
                        AppRoutes.jobDetailsPath('kitchen-sink'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _ScheduleCard(
                      accentColor: const Color(0xFF29479A),
                      category: 'ELECTRICAL',
                      status: 'PRIORITY',
                      title: 'Smart Thermostat Installation',
                      location: '882 Mexico Roadway',
                      onTap: () => context.go(
                        AppRoutes.jobDetailsPath('thermostat'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _ScheduleCard(
                      accentColor: AppColors.border,
                      category: 'GENERAL',
                      status: 'PENDING',
                      title: 'Furniture Assembly (Bookcase)',
                      location: '22, Megenagna Street',
                      onTap: () => context.go(
                        AppRoutes.jobDetailsPath('bookcase'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ProfessionalBottomNavBar(
              currentIndex: 0,
              onTap: (index) {
                switch (index) {
                  case 1:
                    context.push(AppRoutes.jobs);
                    break;
                  case 2:
                    context.push(AppRoutes.professionalsList);
                    break;
                  case 3:
                    context.push(AppRoutes.professionalSettings);
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

String _firstName(String? name) {
  final value = name?.trim() ?? '';
  if (value.isEmpty) return 'there';
  return value.split(RegExp(r'\s+')).first;
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 144,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: AppColors.neutral.withValues(alpha: 0.85),
            size: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.neutral.withValues(alpha: 0.6),
                  fontSize: 11,
                ),
              ),
              Text(
                value,
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.surface,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.description,
    this.titleColor,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color? titleColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyles.titleSmall.copyWith(
                fontSize: 18,
                color: titleColor ?? AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textBody,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({
    required this.accentColor,
    required this.category,
    required this.status,
    required this.title,
    required this.location,
    this.onTap,
  });

  final Color accentColor;
  final String category;
  final String status;
  final String title;
  final String location;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.sm),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadii.sm),
          border: Border(left: BorderSide(color: accentColor, width: 4)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _StatusPill(
                        label: category,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 8),
                      _StatusPill(label: status, color: accentColor),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: AppTextStyles.titleSmall.copyWith(
                      fontSize: 18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.place_outlined,
                        size: 14,
                        color: AppColors.tertiary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 13,
                            color: AppColors.textBody,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelMedium.copyWith(
          color: color,
          fontSize: 10,
        ),
      ),
    );
  }
}