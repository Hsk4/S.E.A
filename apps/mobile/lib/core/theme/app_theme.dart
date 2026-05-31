import 'package:flutter/material.dart';
import 'package:mobile/core/constants/app_colors.dart';
import 'package:mobile/core/constants/app_radius.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/constants/app_spacing.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData dark() {
    final borderSide = BorderSide(
      color: AppColors.border,
      width: AppSizes.borderStandard,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.base,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryCol,
        secondary: AppColors.secondaryCol,
        surface: AppColors.elevated,
        error: AppColors.medical,
        onPrimary: AppColors.base,
        onSecondary: AppColors.base,
        onSurface: AppColors.primary,
        onError: AppColors.base,
        outline: AppColors.border,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.base,
        foregroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: false,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.primary,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: TextStyle(
          color: AppColors.primary,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          color: AppColors.primary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: AppColors.primary,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColors.secondary,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: AppColors.muted,
          fontSize: 12,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.overlay,
        hintStyle: const TextStyle(color: AppColors.muted),
        labelStyle: const TextStyle(color: AppColors.secondary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: AppSpacing.s3,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.borderMd,
          borderSide: borderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderMd,
          borderSide: borderSide,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderMd,
          borderSide: borderSide.copyWith(color: AppColors.primaryCol),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryCol,
          foregroundColor: AppColors.base,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s5,
            vertical: AppSpacing.s3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderMd,
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s5,
            vertical: AppSpacing.s3,
          ),
          side: borderSide,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderMd,
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.overlay,
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s5,
            vertical: AppSpacing.s3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderMd,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.overlay,
        selectedColor: AppColors.primaryCol,
        labelStyle: const TextStyle(color: AppColors.primary),
        secondaryLabelStyle: const TextStyle(color: AppColors.base),
        side: borderSide,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderFull,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
      ),
    );
  }
}
