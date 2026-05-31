import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/app_colors.dart';
import '../theme/app_radii.dart';

class ProfileImagePicker extends StatelessWidget {
  final String?      base64Image;
  final double       size;
  final bool         isRound;
  final VoidCallback onPickImage;

  const ProfileImagePicker({
    super.key,
    this.base64Image,
    this.size       = 100,
    this.isRound    = false,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = base64Image != null && base64Image!.isNotEmpty;

    return GestureDetector(
      onTap: onPickImage,
      child: Stack(
        children: [
          Container(
            width: size, height: size,
            decoration: BoxDecoration(
              color:        AppColors.neutral,
              shape:        isRound ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: isRound
                  ? null
                  : BorderRadius.circular(AppRadii.md),
              image: hasImage
                  ? DecorationImage(
                      image: MemoryImage(base64Decode(base64Image!)),
                      fit:   BoxFit.cover,
                    )
                  : null,
            ),
            child: hasImage
                ? null
                : Icon(Icons.person_outline_rounded,
                    size:  size * 0.5,
                    color: AppColors.textMuted),
          ),
          Positioned(
            right:  4, bottom: 4,
            child: Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                color:        AppColors.primary,
                shape:        BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(Icons.camera_alt_rounded,
                  size: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}


Future<String?> pickImageAsBase64() async {
  try {
    final XFile? file = await ImagePicker().pickImage(
      source:       ImageSource.gallery,
      imageQuality: 60,
      maxWidth:     800,
    );
    if (file == null) return null;
    final Uint8List bytes = await file.readAsBytes();
    return base64Encode(bytes);
  } catch (_) {
    return null;
  }
}

Widget profileImageWidget({
  String? base64Image,
  double  size  = 52,
  bool    round = false,
}) {
  final hasImage = base64Image != null && base64Image.isNotEmpty;
  return Container(
    width: size, height: size,
    decoration: BoxDecoration(
      color:        AppColors.neutral,
      shape:        round ? BoxShape.circle : BoxShape.rectangle,
      borderRadius: round ? null : BorderRadius.circular(AppRadii.sm),
      image: hasImage
          ? DecorationImage(
              image: MemoryImage(base64Decode(base64Image)),
              fit:   BoxFit.cover,
            )
          : null,
    ),
    child: hasImage
        ? null
        : Icon(Icons.person_outline_rounded,
            size: size * 0.5, color: AppColors.textMuted),
  );
}