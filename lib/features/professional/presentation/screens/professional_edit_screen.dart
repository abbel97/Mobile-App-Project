import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/primary_button.dart';

class ProfessionalEditScreen extends StatefulWidget {
	const ProfessionalEditScreen({super.key});

	@override
	State<ProfessionalEditScreen> createState() => _ProfessionalEditScreenState();
}

class _ProfessionalEditScreenState extends State<ProfessionalEditScreen> {
	final TextEditingController nameController = TextEditingController(text: 'Elphaz Jovani');
	final TextEditingController titleController = TextEditingController(text: 'Carpenter');
	final TextEditingController locationController = TextEditingController(text: 'Addis Ababa, Ethiopia');
	final TextEditingController bioController = TextEditingController(text: 'Skilled carpenter with more than 10 years of experience in furniture and finishing work.');

	@override
	void dispose() {
		nameController.dispose();
		titleController.dispose();
		locationController.dispose();
		bioController.dispose();
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
									Text('Edit Profile', style: AppTextStyles.titleMedium.copyWith(fontSize: 24, color: AppColors.primary)),
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
									children: [
										const CircleAvatar(radius: 40, backgroundColor: AppColors.neutral, child: Icon(Icons.person_outline_rounded, size: 42, color: AppColors.primary)),
										const SizedBox(height: 18),
										CustomTextField(label: 'Full Name', controller: nameController, prefix: const Icon(Icons.person_outline_rounded)),
										const SizedBox(height: 14),
										CustomTextField(label: 'Profession', controller: titleController, prefix: const Icon(Icons.work_outline_rounded)),
										const SizedBox(height: 14),
										CustomTextField(label: 'Location', controller: locationController, prefix: const Icon(Icons.location_on_outlined)),
										const SizedBox(height: 14),
										CustomTextField(label: 'Bio', controller: bioController, prefix: const Icon(Icons.description_outlined), maxLines: 4),
									],
								),
							),
							const SizedBox(height: 24),
							PrimaryButton(label: 'Save Changes', onPressed: () {}, height: 56),
						],
					),
				),
			),
		);
	}
}