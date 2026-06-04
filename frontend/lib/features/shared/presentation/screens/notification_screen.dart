import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';
import '../../../customer/presentation/providers/service_request_notifier.dart';
import '../providers/notification_provider.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(notificationProvider.notifier).loadNotifications());
  }

  @override
  Widget build(BuildContext context) {
    final notifState = ref.watch(notificationProvider);
    final auth       = ref.watch(authProvider);
    final isCustomer = auth.isCustomer;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_rounded,
                        color: AppColors.primary),
                  ),
                  Text('Messages',
                      style: AppTextStyles.titleMedium
                          .copyWith(color: AppColors.primary)),
                  const Spacer(),
                  if (notifState.unreadCount > 0)
                    TextButton(
                      onPressed: () => ref
                          .read(notificationProvider.notifier)
                          .markAllRead(),
                      child: Text('Mark all read',
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.secondary)),
                    ),
                ],
              ),
            ),

            Expanded(
              child: notifState.isLoading && notifState.notifications.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : notifState.notifications.isEmpty
                      ? _EmptyState(isCustomer: isCustomer)
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                          itemCount: notifState.notifications.length,
                          itemBuilder: (_, i) {
                            final n = notifState.notifications[i];
                            return _NotificationCard(
                              notification: n,
                              isCustomer:   isCustomer,
                              onTap: () {
                                if (!n.isRead) {
                                  ref
                                      .read(notificationProvider.notifier)
                                      .markAsRead(n.id);
                                }
                              },
                              onHire: isCustomer && n.isNewApplication && n.requestId != null
                                  ? () => _showHireDialog(context, ref, n.requestId!)
                                  : null,
                              onReject: isCustomer && n.isNewApplication && n.requestId != null
                                  ? () {
                                      ref
                                          .read(serviceRequestProvider.notifier)
                                          .rejectApplicant(n.requestId!);
                                      ref
                                          .read(notificationProvider.notifier)
                                          .loadNotifications();
                                    }
                                  : null,
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHireDialog(BuildContext context, WidgetRef ref, String requestId) {
    final phoneController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.lg)),
          title: Text('Confirm & Hire',
              style: AppTextStyles.titleMedium
                  .copyWith(color: AppColors.textPrimary)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The professional will receive your contact info so they can reach you.',
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textBody),
              ),
              const SizedBox(height: 18),
              Text('YOUR PHONE NUMBER',
                  style: AppTextStyles.labelLarge
                      .copyWith(color: AppColors.textPrimary, fontSize: 11)),
              const SizedBox(height: 8),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: '+251 9xx xxx xxxx',
                  filled: true,
                  fillColor: AppColors.inputFill,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.sm),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.sm),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel',
                  style: AppTextStyles.button
                      .copyWith(color: AppColors.textMuted)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                ref.read(serviceRequestProvider.notifier).confirmRequest(
                  id:           requestId,
                  customerPhone: phoneController.text.trim(),
                );
                ref.read(notificationProvider.notifier).loadNotifications();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.sm)),
              ),
              child: Text('Confirm Hire',
                  style: AppTextStyles.button
                      .copyWith(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final notification;
  final bool isCustomer;
  final VoidCallback onTap;
  final VoidCallback? onHire;
  final VoidCallback? onReject;

  const _NotificationCard({
    required this.notification,
    required this.isCustomer,
    required this.onTap,
    this.onHire,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final bool unread = !notification.isRead;
    final IconData icon = notification.isHired
        ? Icons.check_circle_outline_rounded
        : notification.isNewApplication
            ? Icons.person_add_alt_1_rounded
            : Icons.notifications_outlined;
    final Color iconColor = notification.isHired
        ? AppColors.success
        : notification.isNewApplication
            ? AppColors.secondary
            : AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: unread
              ? AppColors.primary.withValues(alpha: 0.04)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(
            color: unread ? AppColors.primary.withValues(alpha: 0.2) : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42, height: 42,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadii.sm),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(notification.title,
                                style: AppTextStyles.titleSmall.copyWith(
                                    color: AppColors.textPrimary,
                                    fontSize: 15)),
                          ),
                          if (unread)
                            Container(
                              width: 8, height: 8,
                              decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(notification.body,
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.textBody, height: 1.4)),
                      const SizedBox(height: 6),
                      Text(notification.createdAt.substring(0, 10),
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.textMuted, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),

            if (onHire != null) ...[
              const SizedBox(height: 12),
              const Divider(color: AppColors.border, height: 1),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onReject,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textMuted,
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadii.sm)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Text('Reject',
                          style: AppTextStyles.buttonSmall
                              .copyWith(color: AppColors.textMuted)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: onHire,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadii.sm)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Text('Confirm & Hire',
                          style: AppTextStyles.buttonSmall
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool isCustomer;
  const _EmptyState({required this.isCustomer});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.inbox_outlined,
              size: 64, color: AppColors.textMuted),
          const SizedBox(height: 16),
          Text('No messages yet',
              style: AppTextStyles.titleMedium
                  .copyWith(color: AppColors.textMuted)),
          const SizedBox(height: 8),
          Text(
            isCustomer
                ? 'You\'ll see applications from professionals here'
                : 'You\'ll be notified when a customer hires you',
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}