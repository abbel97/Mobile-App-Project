import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/green_buttons.dart';
import '../widgets/professional_bottom_nav_bar.dart';
import '../../../customer/presentation/providers/service_request_notifier.dart';

class JobsScreen extends ConsumerWidget {
  const JobsScreen({super.key});

  @override
    Widget build(BuildContext context, WidgetRef ref) {
      final state = ref.watch(serviceRequestProvider);
      final pending = state.requests.where((r) => r.isPending).toList();
   
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
                    //Inline header
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          'Jobs',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.primary,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Check recent posted\njobs',
                      style: AppTextStyles.headline2.copyWith(
                        fontSize: 32,
                        height: 1.05,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 22),
                  
                      if (state.isLoading && pending.isEmpty)
                         const Center(child: CircularProgressIndicator())
                      else if (pending.isEmpty)
                        Center(
                          child: Text('No jobs available',
                              style: AppTextStyles.bodyMedium
                                  .copyWith(color: AppColors.textMuted)),
                        )
                      else
                        ...pending.map((r) => _JobCard(
                          category:    r.profession.toUpperCase(),
                          location:    r.location,
                          title:       r.title,
                          description: r.description,
                          onAccept: () => context.push(AppRoutes.jobDetailsPath(r.id)),
                        )),
                  ],
                ),
              ),
            ),
            ProfessionalBottomNavBar(
              currentIndex: 1,
              onTap: (index) {
                switch (index) {
                  case 0: context.push(AppRoutes.professionalDashboard);
                    break;
                  case 2: context.push(AppRoutes.professionalsList);
                    break;
                  case 3: context.push(AppRoutes.professionalSettings);
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

class _JobCard extends StatelessWidget {
  const _JobCard({
    required this.category,
    required this.location,
    required this.title,
    required this.description,
    this.onAccept,
  });

  final String category;
  final String location;
  final String title;
  final String description;
  final VoidCallback? onAccept;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                category,
                style: AppTextStyles.labelMedium.copyWith(
                  letterSpacing: 2.2,
                  fontSize: 10,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(width: 10),
              const Text('•', style: TextStyle(color: AppColors.tertiary)),
              const SizedBox(width: 10),
              const Icon(
                Icons.place_outlined,
                size: 14,
                color: AppColors.tertiary,
              ),
              const SizedBox(width: 4),
              Text(
                location,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textBody,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.titleLarge.copyWith(
              fontSize: 22,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 14,
              color: AppColors.textBody,
            ),
          ),
          const SizedBox(height: 22),
          GreenButton(label: 'Apply', onPressed: onAccept),
        ],
      ),
    );
  }
}