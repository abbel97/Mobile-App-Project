import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/top_bar.dart';
import '../providers/auth_notifier.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (prev, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error!), backgroundColor: AppColors.danger));
        ref.read(authProvider.notifier).clearError();
      }
      // Show success if loading went false with no error
      if ((prev?.isLoading ?? false) && !next.isLoading && next.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Password changed successfully'),
          backgroundColor: AppColors.success,
        ));
        context.pop();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TopBar(
        title: 'Change Password',
        onBack: () => context.pop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Set a new password',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Use at least 8 characters and keep it secure.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textBody,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Current Password',
                      hintText: 'Current Password',
                      controller: _currentPasswordController,
                      prefix: const Icon(Icons.lock_outline_rounded),
                      obscureText: true,
                    ),
                    const SizedBox(height: 14),
                    CustomTextField(
                      label: 'New Password',
                      hintText: 'New Password',
                      controller: _newPasswordController,
                      prefix: const Icon(Icons.lock_reset_rounded),
                      obscureText: true,
                    ),
                    const SizedBox(height: 14),
                    CustomTextField(
                      label: 'Confirm Password',
                      hintText: 'Confirm Password',
                      controller: _confirmPasswordController,
                      prefix: const Icon(Icons.verified_user_outlined),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
              label: 'Update Password',
              height: 52,
              trailing: auth.isLoading
                  ? const SizedBox(
                      width: 18, height: 18,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : null,
              onPressed: auth.isLoading ? null : () {
                final currentPassword = _currentPasswordController.text;
                final newPassword = _newPasswordController.text;
                final confirmPassword = _confirmPasswordController.text;
                if (currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('All password fields are required'),
                    backgroundColor: AppColors.danger,
                  ));
                  return;
                }
                if (newPassword != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('New passwords do not match'),
                    backgroundColor: AppColors.danger,
                  ));
                  return;
                }
                ref.read(authProvider.notifier).changePassword(
                  currentPassword: currentPassword,
                  newPassword: newPassword,
                  confirmNewPassword: confirmPassword,
                );
              },
            ),

              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () => context.pop(),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.surface,
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.sm),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: AppTextStyles.button.copyWith(color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}