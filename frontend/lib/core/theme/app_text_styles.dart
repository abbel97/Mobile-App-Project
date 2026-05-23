import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle get headline1 => GoogleFonts.manrope(
    fontSize: 42,
    height: 1.08,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.2,
  );

  static TextStyle get headline2 => GoogleFonts.manrope(
    fontSize: 34,
    height: 1.1,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.0,
  );

  static TextStyle get titleLarge => GoogleFonts.manrope(
    fontSize: 24,
    height: 1.2,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get titleMedium => GoogleFonts.manrope(
    fontSize: 22,
    height: 1.25,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get titleSmall => GoogleFonts.manrope(
    fontSize: 16,
    height: 1.3,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 18,
    height: 1.5,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    height: 1.5,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get bodyRegular => GoogleFonts.inter(
    fontSize: 16,
    height: 1.45,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 12,
    height: 1.15,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
  );

  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: 11,
    height: 1.15,
    fontWeight: FontWeight.w700,
    letterSpacing: 2.4,
  );

  static TextStyle get button => GoogleFonts.inter(
    fontSize: 15,
    height: 1.15,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.2,
  );

  static TextStyle get buttonSmall => GoogleFonts.inter(
    fontSize: 14,
    height: 1,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 0.3,
  );
}