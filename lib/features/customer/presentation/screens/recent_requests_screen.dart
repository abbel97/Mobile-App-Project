import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/customer_bottom_nav_bar.dart';
import '../widgets/delete_request_dialog.dart';

class RecentRequestsScreen extends StatelessWidget {
  const RecentRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const SizedBox(height: 22),
                    Text(
                      'My Requests',
                      style: AppTextStyles.headline2.copyWith(
                        fontSize: 32,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Check your service submissions, track ongoing requests and review completed tasks.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textBody,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _RequestCard(
                      title: 'Modern Villa Expansion -\nPhase II',
                      description:
                          'Structural assessment and blueprint drafting for the north-wing extension project.',
                      status: 'PENDING',
                      dateLabel: 'Submitted Oct 12, 2025',
                      showEdit: true,
                      onEdit: () => context.push(
                       AppRoutes.customerRequestEdit,
                      ),
                      onDelete: () => showDialog(
                        context: context,
                        builder: (_) => DeleteRequestDialog(
                          onDelete: () {
                            // TODO: handle delete
                          },
                        ),
                      ),
                    ),
                    _RequestCard(
                      title: 'Foundation Reinforcement\nConsultation',
                      description:
                          'Request for site inspection regarding minor hairline fractures in basement concrete.',
                      status: 'PENDING',
                      dateLabel: 'Submitted Nov 02, 2023',
                      showEdit: true,
                      onEdit: () => context.push(
                        AppRoutes.customerRequestEditPath('foundation-reinforcement'),
                      ),
                      onDelete: () => showDialog(
                        context: context,
                        builder: (_) => DeleteRequestDialog(
                          onDelete: () {
                            // TODO: handle delete
                          },
                        ),
                      ),
                    ),
                    _RequestCard(
                      title: 'Solar Array Integration -\nRooftop',
                      description:
                          'Installation of 24 high-efficiency photovoltaic panels and smart grid bridge.',
                      status: 'ACCEPTED',
                      dateLabel: 'Accepted Sept 28, 2026',
                      showEdit: false,
                      onDelete: () => showDialog(
                        context: context,
                        builder: (_) => DeleteRequestDialog(
                          onDelete: () {
                            // TODO: handle delete
                          },
                        ),
                      ),
                    ),
                    _RequestCard(
                      title: 'Exterior Refacing\n& Cladding',
                      description:
                          'Replacing cedar shingles with charred Shou Sugi Ban timber siding.',
                      status: 'ACCEPTED',
                      dateLabel: 'Submitted Apr 15, 2026',
                      showEdit: false,
                      onDelete: () => showDialog(
                        context: context,
                        builder: (_) => DeleteRequestDialog(
                          onDelete: () {
                            // TODO: handle delete
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomerBottomNavBar(
              currentIndex: 1,
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.push(AppRoutes.customerDashboard);
                    break;
                  case 2:
                    context.push(AppRoutes.professionalsList);
                    break;
                  case 3:
                    context.push(AppRoutes.customerSettings);
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

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.title,
    required this.description,
    required this.status,
    required this.dateLabel,
    required this.showEdit,
    this.onEdit,
    this.onDelete,
  });

  final String title;
  final String description;
  final String status;
  final String dateLabel;
  final bool showEdit;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final isPending = status == 'PENDING';
    final statusColor =
        isPending ? const Color(0xFFF5B800) : AppColors.tertiary;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.sm),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    fontSize: 18,
                    color: AppColors.primary,
                    height: 1.2,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: statusColor,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (showEdit) ...[
                GestureDetector(
                  onTap: onEdit,
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 18,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 10),
              ],
              GestureDetector(
                onTap: onDelete,
                child: const Icon(
                  Icons.delete_outline_rounded,
                  size: 18,
                  color: AppColors.danger,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            description,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 14,
              color: AppColors.textBody,
            ),
          ),
          const SizedBox(height: 18),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: AppColors.tertiary,
              ),
              const SizedBox(width: 6),
              Text(
                dateLabel,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}