import 'package:flutter/material.dart';

import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_text_styles.dart';

class GreenButton extends StatelessWidget {
  const GreenButton({
    super.key,
    required this.label,
    this.onPressed,
    this.height = 46,
  });

  final String label;
  final VoidCallback? onPressed;
  final double height;

  static const Color _green = Color(0xFF0A7A55);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _green,
          foregroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
        ),
        child: Text(label, style: AppTextStyles.button),
      ),
    );
  }
}