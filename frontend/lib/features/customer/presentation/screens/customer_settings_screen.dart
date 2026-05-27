import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../features/shared/presentation/widgets/delete_account_dialog.dart';
import '../../../../features/shared/presentation/widgets/logout_dialog.dart';
import '../widgets/customer_bottom_nav_bar.dart';

class CustomerSettingsScreen extends ConsumerStatefulWidget {
  const CustomerSettingsScreen({super.key});

  @override
  ConsumerState<CustomerSettingsScreen> createState() => _CustomerSettingsScreenState();
}

class _CustomerSettingsScreenState extends ConsumerState<CustomerSettingsScreen> {
  bool _darkMode = false;

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
                    Row(
                      children: [
                        Text(
                          'Settings',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),

                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(AppRadii.md),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 84,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.neutral,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: const Icon(
                              Icons.person_outline_rounded,
                              size: 52,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Name',
                                style: AppTextStyles.titleSmall.copyWith(
                                  fontSize: 20,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'youremail@gmail.com',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textBody,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    _SectionLabel(title: 'Account Settings'), 
                    const SizedBox(height: 12),
                    _SettingsCard(
                      children: [
                        _SettingsTile(
                          icon: Icons.person_outline_rounded,
                          title: 'Profile Information',
                          subtitle: 'Update your name, phone, and address',
                          onTap: () =>
                              context.push(AppRoutes.customerProfileEdit),
                        ),
                        const _Divider(),
                        _SettingsTile(
                          icon: Icons.lock_outline_rounded,
                          title: 'Change Password',
                          onTap: () =>
                              context.push(AppRoutes.changePassword),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    _SectionLabel(title: 'Preferences'),
                    const SizedBox(height: 12),
                    _SettingsCard(
                      children: [
                        _SettingsSwitchTile(
                          title: 'Dark Mode',
                          subtitle: 'Switch to a darker theme',
                          value: _darkMode,
                          // TODO: implement dark mode toggle
                          onChanged: (val) =>
                              setState(() => _darkMode = val),
                        ),
                        const _Divider(),
                        _SettingsTile(
                          icon: Icons.notifications_none_rounded,
                          title: 'Notification Settings',
                          subtitle: 'Manage email and push alerts',
                          onTap: () => context.push(AppRoutes.notifications),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    _SectionLabel(title: 'Legal & Support'),
                    const SizedBox(height: 12),
                    _SettingsCard(
                      children: [
                        _SettingsTile(
                          icon: Icons.help_outline_rounded,
                          title: 'Help Center',
                          // TODO: add help center screen
                          onTap: () {},
                        ),
                        const _Divider(),
                        _SettingsTile(
                          icon: Icons.description_outlined,
                          title: 'Terms of Service',
                          onTap: () => context.push(AppRoutes.termsAndPolicy),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton.icon(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => LogoutDialog(
                            onLogout: () => ref.read(authProvider.notifier).logout(),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          backgroundColor: AppColors.surface,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadii.sm),
                          ),
                        ),
                        icon: const Icon(Icons.logout_rounded, size: 18),
                        label: Text(
                          'LOGOUT',
                          style: AppTextStyles.titleSmall.copyWith(
                            fontSize: 14,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton.icon(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => DeleteAccountDialog(
                           onDelete: () => ref.read(authProvider.notifier).deleteAccount(),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.danger,
                          backgroundColor: AppColors.surface,
                          side: const BorderSide(color: Color(0xFFF2B8B5)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadii.sm),
                          ),
                        ),
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          size: 18,
                        ),
                        label: Text(
                          'DELETE ACCOUNT',
                          style: AppTextStyles.titleSmall.copyWith(
                            fontSize: 14,
                            color: AppColors.danger,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomerBottomNavBar(
              currentIndex: 3,
              onTap: (index) {
                switch (index) {
                  case 0: context.push(AppRoutes.customerDashboard);
                    break;
                  case 1: context.push(AppRoutes.customerRequests);
                    break;
                  case 2: context.push(AppRoutes.customerProfessionalsList);
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.sm),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Column(children: children),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, color: AppColors.border);
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titleSmall.copyWith(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 13,
                        color: AppColors.textBody,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSwitchTile extends StatelessWidget {
  const _SettingsSwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Row(
        children: [
          const Icon(
            Icons.dark_mode_outlined,
            color: AppColors.primary,
            size: 22,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 13,
                      color: AppColors.textBody,
                    ),
                  ),
                ],
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