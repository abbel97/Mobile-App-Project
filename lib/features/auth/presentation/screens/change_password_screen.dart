import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/primary_button.dart';

class ChangePasswordScreen extends StatefulWidget {
	const ChangePasswordScreen({super.key});

	@override
	State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
	final TextEditingController currentPasswordController = TextEditingController();
	final TextEditingController newPasswordController = TextEditingController();
	final TextEditingController confirmPasswordController = TextEditingController();

	@override
	void dispose() {
		currentPasswordController.dispose();
		newPasswordController.dispose();
		confirmPasswordController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: AppColors.background,
			body: SafeArea(
				child: SingleChildScrollView(
					padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Row(
								children: [
									IconButton(
										onPressed: () => context.pop(),
										icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary),
									),
									Text('Change Password', style: AppTextStyles.titleMedium.copyWith(fontSize: 24, color: AppColors.primary)),
								],
							),
							const SizedBox(height: 14),
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
										Text('Set a new password', style: AppTextStyles.titleLarge.copyWith(fontSize: 26, color: AppColors.textPrimary)),
										const SizedBox(height: 8),
										Text('Use at least 8 characters and keep it secure.', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textBody)),
										const SizedBox(height: 20),
										CustomTextField(label: 'Current Password', hintText: 'Current Password', controller: currentPasswordController, prefix: const Icon(Icons.lock_outline_rounded), obscureText: true),
										const SizedBox(height: 14),
										CustomTextField(label: 'New Password', hintText: 'New Password', controller: newPasswordController, prefix: const Icon(Icons.lock_reset_rounded), obscureText: true),
										const SizedBox(height: 14),
										CustomTextField(label: 'Confirm Password', hintText: 'Confirm Password', controller: confirmPasswordController, prefix: const Icon(Icons.verified_user_outlined), obscureText: true),
									],
								),
							),
							const SizedBox(height: 24),
							PrimaryButton(label: 'Update Password', onPressed: () {}, height: 56),
							const SizedBox(height: 12),
							SizedBox(
								width: double.infinity,
								height: 56,
								child: OutlinedButton(
									onPressed: () => context.pop(),
									style: OutlinedButton.styleFrom(
										backgroundColor: AppColors.surface,
										foregroundColor: AppColors.primary,
										side: const BorderSide(color: AppColors.border),
										shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
									),
									child: const Text('Cancel'),
								),
							),
						],
					),
				),
			),
		);
	}
}