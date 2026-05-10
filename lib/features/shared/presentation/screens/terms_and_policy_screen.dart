import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TermsAndPolicyScreen extends StatelessWidget {
  const TermsAndPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
         child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [IconButton(onPressed: () => Navigator.of(context).maybePop(), icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary)), Text('Terms and Conditions', style: AppTextStyles.titleSmall.copyWith(fontSize: 16, color: AppColors.primary))]), const SizedBox(height: 18), Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: const Color(0xFF6EE7B7), borderRadius: BorderRadius.circular(2)), child: Text('LEGAL FRAMEWORK', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary, fontSize: 10))), const SizedBox(height: 18), Text('Terms of Service &\nPrivacy Policy.', style: AppTextStyles.headline2.copyWith(fontSize: 29, height: 1.1)), const SizedBox(height: 14), Row(children: [const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.tertiary), const SizedBox(width: 6), Text('Last Updated: October 24, 2023', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textBody))]), const SizedBox(height: 6), Row(children: [const Icon(Icons.shield_outlined, size: 16, color: AppColors.tertiary), const SizedBox(width: 6), Text('Version 2.4.0', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textBody))]), const SizedBox(height: 28), const _PolicySection(number: '01', title: 'User Agreement', description: 'By accessing HOME-TWEAK, you acknowledge that you are entering into a legally binding contract between yourself and HOME-TWEAK, Home service Services.', items: [_PolicyItem(title: '1.1 Service Provision', body: 'HOME-TWEAK acts as a digital interface connecting specialized contractors with homeowners. Our role is strictly limited to facilitating communication, architectural and planning tools. We do not provide the physical labor ourselves.'), _PolicyItem(title: '1.2 Account Integrity', body: 'Users must maintain the security of their credentials. Any professional “tweaks” or service requests made via your account are your responsibility. We reserve the right to suspend accounts that exhibit fraudulent or abusive behavior toward service providers.')]), const _PolicySection(number: '02', title: 'Data Privacy', description: 'Your data is the blueprint of your home. We treat it with the same precision and security as a high-security vault.', items: [_PolicyItem(title: 'Information We Collect', body: 'Identity data, home schematics, transaction records, and technical logs are stored to provide the service experience.')]), const _PolicySection(number: '03', title: 'Cookie Policy', description: 'Cookies are small text files that help us recognize you, keep you logged in, and preserve your preferences across sessions.', items: [_PolicyItem(title: 'Essential', body: 'Necessary for the basic functionality of the management dashboard.'), _PolicyItem(title: 'Performance', body: 'Helps us understand how users interact with our project estimation tools.')]), const _PolicySection(number: '04', title: 'Limitation of Liability', description: 'In no event shall HOME-TWEAK, its directors, or employees be liable for indirect, incidental, special, consequential, or punitive damages.', items:[], notice: true), const SizedBox(height: 30), Container(width: double.infinity, padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Have questions\nabout our terms?', style: AppTextStyles.titleLarge.copyWith(color: AppColors.surface, fontSize: 26)), const SizedBox(height: 14), Text('Our legal team is available for clarification regarding any clause.architectural integrity is at the heart of our platform.', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.neutral.withValues(alpha: 0.72), fontSize: 14)), const SizedBox(height: 22), SizedBox(width: 220, height: 48, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(foregroundColor: AppColors.surface, side: BorderSide(color: AppColors.surface.withValues(alpha: 0.2)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: const Text('Contact Legal Support')))])), const SizedBox(height: 28), Center(child: Text('© 2026 HOME-TWEAK Systems Inc.\nAll rights reserved.', textAlign: TextAlign.center, style: AppTextStyles.bodySmall.copyWith(color: AppColors.neutral.withValues(alpha: 0.55), fontSize: 11)))])),
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  const _PolicySection({required this.number, required this.title, required this.description, required this.items, this.notice = false});

  final String number;
  final String title;
  final String description;
  final List<_PolicyItem> items;
  final bool notice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28), 
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children:
       [SizedBox(width: 36, child: 
       Text(number, style: AppTextStyles.titleLarge.copyWith(fontSize: 22, color: AppColors.border))), 
       Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, 
       children: [Text(title, style: AppTextStyles.titleLarge.copyWith(fontSize: 24)),
        const SizedBox(height: 8), 
        Text(description, style: AppTextStyles.bodyMedium.copyWith(fontSize: 15)), 
        const SizedBox(height: 12), 
        if (items.isNotEmpty) ...items.map((item) => Padding(padding: const EdgeInsets.only(bottom: 10),
         child: _PolicyCard(item: item, notice: notice))),
          if (notice) Container(padding: const EdgeInsets.all(18), 
          decoration: BoxDecoration(color: const Color(0xFFFFF7F5),
           borderRadius: BorderRadius.circular(4), 
           border: const Border(left: BorderSide(color: Color(0xFFDC2626), width: 4))),
            child: Text('"In no event shall HOME-TWEAK, its directors, or employees be liable for indirect, incidental, special, consequential, or punitive damages resulting from the execution of physical home services by independent contractors. Our liability is limited to the fees paid for the use of the platform software during the specific billing period of the dispute."', style: AppTextStyles.bodySmall.copyWith(fontStyle: FontStyle.italic, color: AppColors.textBody, height: 1.45)
            )
            )
             ]
             )
             )
             ]
             )
             );
  }
}

class _PolicyItem {
  const _PolicyItem({required this.title, required this.body});

  final String title;
  final String body;
}

class _PolicyCard extends StatelessWidget {
  const _PolicyCard({required this.item, this.notice = false});

  final _PolicyItem item;
  final bool notice;

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.symmetric(vertical: 8), 
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, 
    children: [Icon(Icons.circle, size: 8, color: notice ? AppColors.danger : AppColors.secondary), 
    const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, 
    children: [Text(item.title, style: AppTextStyles.titleSmall.copyWith(fontSize: 15, color: AppColors.textPrimary)), 
    const SizedBox(height: 4), Text(item.body, style: AppTextStyles.bodySmall.copyWith(fontSize: 14))
    ]
    )
    )
    ]
    )
    );
  }
}