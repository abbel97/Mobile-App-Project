import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/primary_button.dart';

class EditRequestScreen extends StatefulWidget {

	const EditRequestScreen({super.key});

	@override
	State<EditRequestScreen> createState() => _EditRequestScreenState();
}

class _EditRequestScreenState extends State<EditRequestScreen> {
	late final TextEditingController projectNameController;
	late final TextEditingController locationController;
	late final TextEditingController descriptionController;
	String profession = 'Civil Engineer';

	@override
	void initState() {
		super.initState();
		projectNameController = TextEditingController(text: 'Modern Villa Expansion - Phase II');
		locationController = TextEditingController(text: '4kilo, Addis Ababa');
		descriptionController = TextEditingController(text: 'Structural assessment and blueprint drafting\nfor the north-wing extension project.');
	}

	@override
	void dispose() {
		projectNameController.dispose();
		locationController.dispose();
		descriptionController.dispose();
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
									Text('Edit Request', style: AppTextStyles.titleMedium.copyWith(fontSize: 24, color: AppColors.primary)),
								],
							),
							const SizedBox(height: 16),
							Container(
								padding: const EdgeInsets.all(20),
								decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(4)),
								child: Column(
									children: [
										CustomTextField(label: 'Project Name', controller: projectNameController),
										const SizedBox(height: 18),
										DropdownButtonFormField<String>(
											initialValue: profession,
											items: const [
												DropdownMenuItem(value: 'Civil Engineer', child: Text('Civil Engineer')),
												DropdownMenuItem(value: 'Electrician', child: Text('Electrician')),
												DropdownMenuItem(value: 'Plumber', child: Text('Plumber')),
											],
											onChanged: (value) => setState(() => profession = value ?? profession),
											decoration: const InputDecoration(labelText: 'Profession Needed'),
										),
										const SizedBox(height: 18),
										CustomTextField(label: 'LOCATION', controller: locationController),
										const SizedBox(height: 18),
										Row(
											mainAxisAlignment: MainAxisAlignment.spaceBetween,
											children: [
												Text('Description of Updates', style: AppTextStyles.labelLarge),
												Text('Required', style: AppTextStyles.bodySmall.copyWith(fontSize: 12, color: AppColors.textMuted)),
											],
										),
										const SizedBox(height: 10),
										TextField(
											controller: descriptionController,
											maxLines: 5,
											decoration: InputDecoration(
												hintText: 'Description of Updates',
												filled: true,
												fillColor: AppColors.surface,
												border: OutlineInputBorder(
													borderRadius: BorderRadius.circular(AppRadii.sm),
													borderSide: const BorderSide(color: AppColors.border),
												),
											),
										),
									],
								),
							),
							const SizedBox(height: 32),
							PrimaryButton(label: 'Update Request', onPressed: () {}, height: 56),
							const SizedBox(height: 14),
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
