import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/primary_button.dart';

class RequestSubmissionScreen extends StatefulWidget {
	const RequestSubmissionScreen({super.key});

	@override
	State<RequestSubmissionScreen> createState() => _RequestSubmissionScreenState();
}

class _RequestSubmissionScreenState extends State<RequestSubmissionScreen> {
	final TextEditingController projectTitleController = TextEditingController();
	final TextEditingController locationController = TextEditingController();
	final TextEditingController detailsController = TextEditingController();
	String profession = 'Electrician';

	@override
	void dispose() {
		projectTitleController.dispose();
		locationController.dispose();
		detailsController.dispose();
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
									Text(
										'Submit Request',
										style: AppTextStyles.titleMedium.copyWith(fontSize: 24, color: AppColors.primary),
									),
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
										Text(
											'Tell us what you need',
											style: AppTextStyles.titleLarge.copyWith(fontSize: 26, color: AppColors.textPrimary),
										),

										const SizedBox(height: 8),
										Text(
											'Describe your project and we will match the right professional.',
											style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textBody),
										),

										const SizedBox(height: 20),
										CustomTextField(
											label: 'Project Title',
											hintText: 'Kitchen wiring upgrade',
											controller: projectTitleController,
											prefix: const Icon(Icons.title_rounded),
										),

										const SizedBox(height: 14),
										DropdownButtonFormField<String>(
											initialValue: profession,
											items: const [
												DropdownMenuItem(value: 'Electrician', child: Text('Electrician')),
												DropdownMenuItem(value: 'Plumber', child: Text('Plumber')),
												DropdownMenuItem(value: 'Carpenter', child: Text('Carpenter')),
											],

											onChanged: (value) => setState(() => profession = value ?? profession),
											decoration: InputDecoration(
												labelText: 'Profession Needed',
												filled: true,
												fillColor: AppColors.inputFill,
												border: OutlineInputBorder(
													borderRadius: BorderRadius.circular(AppRadii.sm),
												),
											),
										),

										const SizedBox(height: 14),
										CustomTextField(
											label: 'Location',
											hintText: 'Addis Ababa, Ethiopia',
											controller: locationController,
											prefix: const Icon(Icons.location_on_outlined),
										),

										const SizedBox(height: 14),
										CustomTextField(
											label: 'Project Details',
											hintText: 'Describe the issue, timeline, and special requirements.',
											controller: detailsController,
											prefix: const Icon(Icons.description_outlined),
											maxLines: 5,
										),
									],
								),
							),

							const SizedBox(height: 24),
							PrimaryButton(label: 'Submit Request', onPressed: () {}, height: 56),
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
