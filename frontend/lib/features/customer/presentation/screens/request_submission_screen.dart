import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/primary_button.dart';
import '../providers/service_request_notifier.dart';

class RequestSubmissionScreen extends ConsumerStatefulWidget {
  const RequestSubmissionScreen({super.key});

  @override
  ConsumerState<RequestSubmissionScreen> createState() =>
      _RequestSubmissionScreenState();
}

class _RequestSubmissionScreenState extends ConsumerState<RequestSubmissionScreen> {
  final _issueTitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  String _profession = 'General Handyman';
  String _urgency = 'REGULAR';

  final List<String> _professions = [
    'General Handyman',
    'Electrician',
    'Plumber',
    'Carpenter',
    'Mechanic',
    'Painter',
    'Home Inspector',
    'Home Organizer',
    'HVAC Technician',
    'Roofer',
    'Flooring Specialist',
    'Pool Technician',
    'Pest Control Expert',
    'Grass Cutter',
    'Landscaper',
    'General Contractor',
    'Interior Designer',
    'Architect',
    'Structural Engineer', 
    'Other Home Pro',
  ];

  @override
  void dispose() {
    _issueTitleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final srState = ref.watch(serviceRequestProvider);

    ref.listen<ServiceRequestState>(serviceRequestProvider, (_, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error!), backgroundColor: AppColors.danger));
        ref.read(serviceRequestProvider.notifier).clearError();
      }
      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Request submitted successfully'),
          backgroundColor: AppColors.success,
        ));
        ref.read(serviceRequestProvider.notifier).clearSuccess();
        context.pop();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          'Back',
                          style: AppTextStyles.titleSmall.copyWith(
                            fontSize: 18,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Describe the issue',
                      style: AppTextStyles.titleLarge.copyWith(
                        fontSize: 28,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Provide as much detail as possible to help our technicians prepare the right tools for your repair.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textBody,
                      ),
                    ),
                    const SizedBox(height: 28),

                    CustomTextField(
                      label: 'ISSUE TITLE',
                      hintText: 'e.g., Power Outage in the kitchen',
                      controller: _issueTitleController,
                    ),
                    const SizedBox(height: 18),

                    Text(
                      'DETAILED DESCRIPTION',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 5,
                      style: AppTextStyles.bodyRegular.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Describe the issue in a detailed manner...',
                        hintStyle: AppTextStyles.bodyRegular.copyWith(
                          color: AppColors.textMuted,
                        ),
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
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadii.sm),
                          borderSide: const BorderSide(color: AppColors.primary),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(height: 18),

                    Text(
                      'PROFESSION NEEDED',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      initialValue: _profession,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.inputFill,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadii.sm),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                      ),
                      items: _professions.map((String profession) {
                        return DropdownMenuItem(
                          value: profession,
                          child: Text(profession),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _profession = val ?? _profession),
                    ),
                    const SizedBox(height: 18),

                    CustomTextField(
                      label: 'LOCATION',
                      hintText: '4kilo, Addis Ababa',
                      controller: _locationController,
                      prefix: const Icon(Icons.location_on_outlined),
                    ),
                    const SizedBox(height: 24),

                    Text(
                      'URGENCY PROTOCOL',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _UrgencyButton(
                            label: 'REGULAR',
                            selected: _urgency == 'REGULAR',
                            onTap: () => setState(() => _urgency = 'REGULAR'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _UrgencyButton(
                            label: 'URGENT',
                            selected: _urgency == 'URGENT',
                            onTap: () => setState(() => _urgency = 'URGENT'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _UrgencyButton(
                      label: 'EMERGENCY',
                      selected: _urgency == 'EMERGENCY',
                      onTap: () => setState(() => _urgency = 'EMERGENCY'),
                      fullWidth: true,
                    ),
                    const SizedBox(height: 24),

                    Text(
                      'PHOTO DOCUMENTATION (OPTIONAL)',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        // TODO: implement file picker
                      },
                      child: Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                          color: AppColors.inputFill,
                          borderRadius: BorderRadius.circular(AppRadii.md),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius:
                                    BorderRadius.circular(AppRadii.sm),
                              ),
                              child: const Icon(
                                Icons.add_a_photo_outlined,
                                color: AppColors.primary,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Tap to upload photos',
                              style: AppTextStyles.titleSmall.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Include clear shots of the damage or unit serial numbers',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textMuted,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 38),
                    PrimaryButton(
                      label: 'SUBMIT REQUEST',
                      trailing: const Icon(
                        Icons.send_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                      height: 52,
                     onPressed: srState.isLoading ? null : () {
                      final title = _issueTitleController.text.trim();
                      final desc  = _descriptionController.text.trim();
                      final loc   = _locationController.text.trim();
                      if (title.isEmpty || desc.isEmpty || loc.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill in all required fields'), backgroundColor: Colors.red)); 
                        return;
                      }
                      ref.read(serviceRequestProvider.notifier).createRequest(
                        title:       title,
                        description: desc,
                        profession:  _profession,
                        location:    loc,
                        urgency:     _urgency.toLowerCase(),
                      );
                    },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UrgencyButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool fullWidth;

  const _UrgencyButton({
    required this.label,
    required this.selected,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadii.sm),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.labelLarge.copyWith(
            color: selected ? AppColors.surface : AppColors.textBody,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}