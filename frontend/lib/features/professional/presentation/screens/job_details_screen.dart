import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/green_buttons.dart';
import '../../../customer/presentation/providers/service_request_notifier.dart';

class JobDetailsScreen extends ConsumerWidget {
  final String jobId;
  const JobDetailsScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final state   = ref.watch(serviceRequestProvider);
  final matches = state.requests.where((r) => r.id == jobId).toList();

  if (state.isLoading && matches.isEmpty) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }

    if (matches.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text('Job not found',
              style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textMuted)),
        ),
      );
    }

  final request = matches.first;

  ref.listen<ServiceRequestState>(serviceRequestProvider, (_, next) {
    if (next.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Job accepted!'),
        backgroundColor: AppColors.success,
      ));
      ref.read(serviceRequestProvider.notifier).clearSuccess();
      context.push(AppRoutes.acceptedJobs);
    }
    if (next.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(next.error!), backgroundColor: AppColors.danger));
      ref.read(serviceRequestProvider.notifier).clearError();
    }
  });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              'Job Details',
                              style: AppTextStyles.titleMedium.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.neutral,
                            borderRadius: BorderRadius.circular(AppRadii.sm),
                          ),  
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // badge
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'SERVICE REQUEST',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.secondary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(request.title,
                        style: AppTextStyles.headline2.copyWith(
                            fontSize: 34,
                            color: AppColors.textPrimary,
                            height: 1.1)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded,
                            size: 14, color: AppColors.tertiary),
                        const SizedBox(width: 6),
                        Text(
                          'Submitted ${request.createdAt.substring(0, 10)}',
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Location card
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadii.md),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CUSTOMER NAME',
                              style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColors.textMuted, fontSize: 10)
                                    ),
                          const SizedBox(height: 6),
                            Text(request.customerName ?? 'Customer Name',
                              style: AppTextStyles.titleSmall
                                  .copyWith(color: AppColors.textPrimary)),
                          const SizedBox(height: 6),
                           Text('PROFESSION',
                              style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColors.textMuted, fontSize: 10)),
                          const SizedBox(height: 6),
                          Text(request.profession,
                              style: AppTextStyles.titleSmall
                                  .copyWith(color: AppColors.textPrimary)),
                          const SizedBox(height: 14),
                          Text('LOCATION',
                              style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColors.textMuted, fontSize: 10)),
                          const SizedBox(height: 6),
                          Text(request.location,
                              style: AppTextStyles.titleSmall
                                  .copyWith(color: AppColors.textPrimary)),
                          const SizedBox(height: 14),
                          Text('URGENCY',
                              style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColors.textMuted, fontSize: 10)),
                          const SizedBox(height: 6),
                          Text(request.urgency.toUpperCase(),
                              style: AppTextStyles.titleSmall.copyWith(
                                  color: AppColors.secondary)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    //Description
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                color: AppColors.primary, width: 4)),
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Detailed Description',
                              style: AppTextStyles.titleMedium
                                  .copyWith(color: AppColors.primary)),
                          const SizedBox(height: 12),
                          Text(request.description,
                              style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textBody, height: 1.6)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (request.photoBase64 != null && request.photoBase64!.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadii.sm),
                        child: Image.memory(
                          base64Decode(request.photoBase64!),
                          height: 180, width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.neutral,
                          borderRadius: BorderRadius.circular(AppRadii.sm),
                        ),
                        child: const Center(child: Text('No photo attached',
                            style: TextStyle(color: AppColors.textMuted))),
                      ),
                  ],
                ),
              ),
            ),

            // Accept Bar
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GreenButton(
                      label: state.isLoading ? 'Applying...' : 'Apply Job',
                      height: 52,
                      onPressed: state.isLoading
                            ? null
                            : () async {
                                await ref
                                    .read(serviceRequestProvider.notifier)
                                    .applyRequest(jobId);
                                if (!context.mounted) return;
                               
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => _JobAppliedDialog(
                                    onClose: () {
                                      Navigator.of(context).pop();
                                      context.go(AppRoutes.jobs);
                                },
                              ),
                            );
                          },
                      ),
                    ),
                  const SizedBox(width: 12),
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadii.sm),
                      border: Border.all(color: AppColors.border),
                    ),
                   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JobAppliedDialog extends StatelessWidget {
  final VoidCallback onClose;
  const _JobAppliedDialog({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg)),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72, height: 72,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_outline_rounded,
                  color: AppColors.success, size: 38),
            ),
            const SizedBox(height: 20),
            Text('Application Submitted!',
                style: AppTextStyles.titleMedium
                    .copyWith(color: AppColors.textPrimary),
                textAlign: TextAlign.center),
            const SizedBox(height: 12),
            Text(
              "You'll receive a notification if the customer selects you for this job.",
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textBody),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onClose,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.sm)),
                ),
                child: Text('Back to Jobs',
                    style: AppTextStyles.button
                        .copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}