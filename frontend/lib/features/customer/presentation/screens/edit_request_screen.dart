import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/primary_button.dart';
import '../providers/service_request_notifier.dart';

class EditRequestScreen extends ConsumerStatefulWidget {
  final String requestId;
  const EditRequestScreen({super.key, required this.requestId});

  @override
  ConsumerState<EditRequestScreen> createState() => _EditRequestScreenState();
}

class _EditRequestScreenState extends ConsumerState<EditRequestScreen> {
  final _titleController       = TextEditingController();
  final _locationController    = TextEditingController();
  final _descriptionController = TextEditingController();
  String _profession = 'Civil Engineer';

  @override
  void initState() {
    super.initState();
    // Pre-fill with real data after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final requests = ref.read(serviceRequestProvider).requests;
      try {
        final r = requests.firstWhere((r) => r.id == widget.requestId);
        _titleController.text       = r.title;
        _locationController.text    = r.location;
        _descriptionController.text = r.description;
        setState(() => _profession  = r.profession);
      } catch (_) {
        ref.read(serviceRequestProvider.notifier).refreshRequests();
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final srState = ref.watch(serviceRequestProvider); 

    ref.listen<ServiceRequestState>(serviceRequestProvider, (_, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(next.error!), backgroundColor: AppColors.danger
            ));
        ref.read(serviceRequestProvider.notifier).clearError();
      }
      if (next.isSuccess) {
        ref.read(serviceRequestProvider.notifier).clearSuccess();
        context.pop();
      }
    });

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
                    icon: const Icon(Icons.arrow_back_rounded,
                        color: AppColors.primary),
                  ),
                  Text('Edit Request',
                      style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary)),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                        label: 'Project Name', controller: _titleController),
                    const SizedBox(height: 18),
                    Text('PROFESSION NEEDED',
                        style: AppTextStyles.labelLarge
                            .copyWith(color: AppColors.textPrimary)),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _profession,
                      decoration: InputDecoration(
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
                            horizontal: 16, vertical: 16),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'Civil Engineer',
                            child: Text('Civil Engineer')),
                        DropdownMenuItem(
                            value: 'Electrician', child: Text('Electrician')),
                        DropdownMenuItem(
                            value: 'Plumber', child: Text('Plumber')),
                        DropdownMenuItem(
                            value: 'Carpenter', child: Text('Carpenter')),
                      ],
                      onChanged: (v) =>
                          setState(() => _profession = v ?? _profession),
                    ),
                    const SizedBox(height: 18),
                    CustomTextField(
                        label: 'LOCATION', controller: _locationController),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Description of Updates',
                            style: AppTextStyles.labelLarge
                                .copyWith(color: AppColors.primary)),
                        Text('Required',
                            style: AppTextStyles.bodySmall.copyWith(
                                fontSize: 12, color: AppColors.textMuted)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 5,
                      style: AppTextStyles.bodyRegular
                          .copyWith(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Description of updates...',
                        filled: true,
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadii.sm),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadii.sm),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Update Request',
                height: 52,
                trailing: srState.isLoading
                    ? const SizedBox(
                        width: 18, height: 18,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : null,
                onPressed: srState.isLoading
                    ? null
                    : () {
                        ref.read(serviceRequestProvider.notifier).updateRequest(
                              id:          widget.requestId,
                              title:       _titleController.text.trim(),
                              description: _descriptionController.text.trim(),
                              location:    _locationController.text.trim(),
                              profession:  _profession,
                            );
                      },
              ),
              const SizedBox(height: 14),
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
                        borderRadius: BorderRadius.circular(AppRadii.sm)),
                  ),
                  child: Text(
                    'Cancel', style: AppTextStyles.button.copyWith(color: AppColors.primary)
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