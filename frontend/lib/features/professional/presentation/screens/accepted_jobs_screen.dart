import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';
import '../../../customer/presentation/providers/service_request_notifier.dart';

class AcceptedJobsScreen extends ConsumerWidget {
  const AcceptedJobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth    = ref.watch(authProvider);
    final srState = ref.watch(serviceRequestProvider);
    final myJobs  = srState.requests
        .where((r) => r.acceptedBy == auth.user?.id)
        .toList();

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
                    const SizedBox(height: 12),
                    
                    IconButton(
                              onPressed: () => context.pop(),
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                color: AppColors.primary,
                              ),
                            ),
                    Text('My Applications',
                        style: AppTextStyles.headline2.copyWith(
                            fontSize: 30, color: AppColors.textPrimary)),
                    const SizedBox(height: 8),
                    Text('Jobs you\'ve applied for',
                        style: AppTextStyles.bodyMedium
                            .copyWith(color: AppColors.textBody)),
                    const SizedBox(height: 24),

                    if (srState.isLoading && myJobs.isEmpty)
                      const Center(child: CircularProgressIndicator())
                    else if (myJobs.isEmpty)
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            const Icon(Icons.work_outline_rounded,
                                size: 56, color: AppColors.textMuted),
                            const SizedBox(height: 16),
                            Text('No applications yet',
                                style: AppTextStyles.titleMedium
                                    .copyWith(color: AppColors.textMuted)),
                            const SizedBox(height: 8),
                            Text('Jobs you apply for will appear here',
                                style: AppTextStyles.bodyMedium
                                    .copyWith(color: AppColors.textMuted)),
                          ],
                        ),
                      )
                    else
                      ...myJobs.map((job) => _AppliedJobCard(
                            title:      job.title,
                            profession: job.profession,
                            location:   job.location,
                            status:     job.isConfirmed ? 'HIRED' : 'PENDING',
                            statusColor: job.isConfirmed ? AppColors.success : const Color(0xFFF5B800),
                            createdAt:  job.createdAt.substring(0, 10),
                            onTap: () =>
                                context.push(AppRoutes.jobDetailsPath(job.id)),
                          )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppliedJobCard extends StatelessWidget {
  final String title;
  final String profession;
  final String location;
  final String status;
  final Color  statusColor;
  final String createdAt;
  final VoidCallback onTap;

  const _AppliedJobCard({
    required this.title,
    required this.profession,
    required this.location,
    required this.status,
    required this.statusColor,
    required this.createdAt,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border(left: BorderSide(color: statusColor, width: 4)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AppTextStyles.titleSmall.copyWith(
                          fontSize: 17, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text(profession,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.secondary)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.place_outlined,
                          size: 13, color: AppColors.tertiary),
                      const SizedBox(width: 4),
                      Text(location,
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.textMuted)),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(status,
                      style: AppTextStyles.labelMedium
                          .copyWith(color: statusColor, fontSize: 10)),
                ),
                const SizedBox(height: 6),
                Text(createdAt,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textMuted, fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}