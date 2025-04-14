import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rwa_app/constant/app_color.dart';

final TextTheme appTextTheme = TextTheme(
  displayLarge: GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  ),
  bodyLarge: GoogleFonts.inter(fontSize: 16, color: AppColors.textPrimary),
  bodyMedium: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary),
);
