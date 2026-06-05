import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';
import '../../../professional/presentation/providers/professional_notifier.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../features/shared/presentation/widgets/delete_account_dialog.dart';
import '../../../../features/shared/presentation/widgets/logout_dialog.dart';
import '../widgets/professional_bottom_nav_bar.dart';
import '../../../../core/widgets/profile_image_picker.dart';

class ProfessionalSettingsScreen extends ConsumerStatefulWidget {
  const ProfessionalSettingsScreen({super.key});

  @override
  ConsumerState<ProfessionalSettingsScreen> createState() =>
      _ProfessionalSettingsScreenState();
}

class _ProfessionalSettingsScreenState
    extends ConsumerState<ProfessionalSettingsScreen> {
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(professionalProvider.notifier).loadMyProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final profile = ref.watch(professionalProvider).myProfile;
    final name = auth.user?.name.trim().isNotEmpty == true
        ? auth.user!.name.trim()
        : 'Professional User';
    final email = auth.user?.email.trim().isNotEmpty == true
        ? auth.user!.email.trim()
        : 'No email';

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
                    const SizedBox(height: 24),

                    Center(
                      child: Column(
                        children: [
                          profileImageWidget(
                            base64Image: profile?.photoBase64 ?? auth.user?.photoBase64,
                            size: 90,
                            round: true,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            profile?.name ?? name,
                            style: AppTextStyles.titleLarge.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            profile?.email ?? email,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textBody,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => context.push(AppRoutes.professionalProfileEdit),
                            child: Text(
                              'EDIT PROFILE  >',
                              style: AppTextStyles.titleSmall.copyWith(
                                fontSize: 14,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    //Preferences
                    _sectionLabel('PREFERENCES'),
                    const SizedBox(height: 12),
                    _SettingsCard(
                      children: [
                        _SettingsTile(
                          icon: Icons.notifications_none_rounded,
                          title: 'Notification Settings',
                          subtitle: 'Push, Email, and SMS',
                          onTap: () => context.push(AppRoutes.controlAndAlerts),
                        ),
                        const _Divider(),
                        _SettingsSwitchTile(
                          title: 'Dark Mode',
                          subtitle: '',
                          value: _darkMode,
                          // TODO
                          onChanged: (val) =>
                              setState(() => _darkMode = val),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Account
                    _sectionLabel('ACCOUNT'),
                    const SizedBox(height: 12),
                    _SettingsCard(
                      children: [
                        _SettingsTile(
                          icon: Icons.lock_outline_rounded,
                          title: 'Change Password',
                          subtitle: 'Make sure you are secured',
                          onTap: () => context.push(AppRoutes.changePassword),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Legal
                    _sectionLabel('LEGAL'),
                    const SizedBox(height: 12),
                    _SettingsCard(
                      children: [
                        _SettingsTile(
                          icon: Icons.help_outline_rounded,
                          title: 'Help Center',
                          subtitle: '',
                          onTap: () {
                            // TODO: add help center screen
                          },
                        ),
                        const _Divider(),
                        _SettingsTile(
                          icon: Icons.description_outlined,
                          title: 'Terms of Service',
                          subtitle: '',
                          onTap: () => context.push(AppRoutes.termsAndPolicy),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Logout
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

                    // Delete Account
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
            ProfessionalBottomNavBar(
              currentIndex: 3,
              onTap: (index) {
                switch (index) {
                  case 0: context.go(AppRoutes.professionalDashboard);
                    break;
                  case 1: context.go(AppRoutes.jobs);
                    break;
                  case 2: context.go(AppRoutes.professionalsList);
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textMuted,
              fontSize: 12,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.border)),
      ],
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
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
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
            const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
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
            activeThumbColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}