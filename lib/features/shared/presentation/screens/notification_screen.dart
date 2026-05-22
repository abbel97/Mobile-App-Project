import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/top_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _pushNotifications = true;
  bool _emailAlerts = true;
  bool _smsUpdates = false;
  bool _securityNotifications = true;
  bool _billingAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TopBar(
        title: 'Notification',
        onBack: () => context.pop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -10,
                      top: -10,
                      child: Icon(
                        Icons.notifications_outlined,
                        size: 110,
                        color: AppColors.surface.withValues(alpha: 0.08),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Communication\nPreferences',
                          style: AppTextStyles.titleLarge.copyWith(
                            color: AppColors.surface,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Customize how and when you receive updates about your services and account status.',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.surface.withValues(alpha: 0.72),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              _SectionHeader(title: 'Job Updates'),  //add fontsize for the title
              const SizedBox(height: 14),
              _ToggleGroup(
                items: [
                  _ToggleItem(
                    icon: Icons.phone_android_outlined,
                    title: 'Push Notifications',
                    subtitle: 'Real-time status changes for active jobs',
                    value: _pushNotifications,
                    onChanged: (val) =>
                        setState(() => _pushNotifications = val),
                  ),
                  _ToggleItem(
                    icon: Icons.mail_outline_rounded,
                    title: 'Email Alerts',
                    subtitle: 'Detailed job reports and receipts',
                    value: _emailAlerts,
                    onChanged: (val) => setState(() => _emailAlerts = val),
                  ),
                  _ToggleItem(
                    icon: Icons.chat_bubble_outline_rounded,
                    title: 'SMS Updates',
                    subtitle: 'Service arrival notifications',
                    value: _smsUpdates,
                    onChanged: (val) => setState(() => _smsUpdates = val),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // ── Account Alerts ──────────────────────────
              _SectionHeader(title: 'Account Alerts'),
              const SizedBox(height: 14),
              _ToggleGroup(
                items: [
                  _ToggleItem(
                    icon: Icons.shield_outlined,
                    title: 'Security Notifications',
                    subtitle: 'Login attempts and password changes',
                    value: _securityNotifications,
                    onChanged: (val) =>
                        setState(() => _securityNotifications = val),
                  ),
                  _ToggleItem(
                    icon: Icons.receipt_long_outlined,
                    title: 'Billing Alerts',
                    subtitle: 'Payment confirmation and invoices',
                    value: _billingAlerts,
                    onChanged: (val) => setState(() => _billingAlerts = val),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // ── Marketing ───────────────────────────────
              _SectionHeader(title: 'Marketing'),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.local_offer_outlined,
                            color: AppColors.secondary, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          'Special Offers',
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Receive occasional discounts and seasonal maintenance reminders via email.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textBody,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.border),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadii.sm),
                          ),
                        ),
                        child: Text(
                          'Manage Subscription',
                          style: AppTextStyles.button.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'Settings are automatically saved when toggled.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Section header with left accent bar ─────────────────
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

// ── Group of toggle rows in a single card ───────────────
class _ToggleGroup extends StatelessWidget {
  const _ToggleGroup({required this.items});
  final List<_ToggleItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            items[i],
            if (i < items.length - 1)
              const Divider(height: 1, color: AppColors.border),
          ],
        ],
      ),
    );
  }
}

// ── Individual toggle row ────────────────────────────────
class _ToggleItem extends StatelessWidget {
  const _ToggleItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.neutral,
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textBody,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}