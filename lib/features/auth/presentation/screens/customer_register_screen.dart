import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/auth_social_button.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/primary_button.dart';

class CustomerRegisterScreen extends StatelessWidget {
	const CustomerRegisterScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: SafeArea(
				child: SingleChildScrollView(
					padding: AppSpacing.screenPadding.copyWith(top: 34, bottom: 28),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Center(
								child: Column(
									children: [
										Text('HOME-TWEAK', style: AppTextStyles.titleMedium.copyWith(fontSize: 40)),
										const SizedBox(height: 8),
										Container(width: 84, height: 5, color: AppColors.success),
									],
								),
							),
							const SizedBox(height: 42),
							Text('Welcome!', style: AppTextStyles.headline2),
							const SizedBox(height: 12),
							Text(
								'Create your account to start managing your\nhome transformations.',
								style: AppTextStyles.bodyMedium,
							),
							const SizedBox(height: 36),
							const CustomTextField(label: 'FULL NAME', hintText: 'Your Name'),
							const SizedBox(height: 24),
							const CustomTextField(
								label: 'EMAIL ADDRESS',
								hintText: 'youremail@gmail.com',
								keyboardType: TextInputType.emailAddress,
							),
							const SizedBox(height: 24),
							const CustomTextField(label: 'PASSWORD', hintText: '........', obscureText: true),
							const SizedBox(height: 30),
							PrimaryButton(
								label: 'Sign Up',
								trailing: const Icon(Icons.arrow_forward, size: 18),
								onPressed: () => context.go(AppRoutes.customerDashboard),
							),
							const SizedBox(height: 48),
							Row(
								children: [
									const Expanded(child: Divider(color: AppColors.border)),
									Padding(
										padding: const EdgeInsets.symmetric(horizontal: 14),
										child: Text('OR SIGN UP WITH', style: AppTextStyles.labelMedium),
									),
									const Expanded(child: Divider(color: AppColors.border)),
								],
							),
							const SizedBox(height: 18),
							Row(
								children: const [
									AuthSocialButton(label: 'GOOGLE', icon: Icons.g_mobiledata),
									SizedBox(width: 12),
									AuthSocialButton(label: 'APPLE', icon: Icons.apple),
								],
							),
							const SizedBox(height: 84),
							Center(
								child: RichText(
									text: TextSpan(
										style: AppTextStyles.bodyMedium.copyWith(fontSize: 34),
										children: [
											const TextSpan(text: 'Already have an account?  '),
											TextSpan(
												text: 'Sign In',
												style: AppTextStyles.titleSmall,
											),
										],
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
