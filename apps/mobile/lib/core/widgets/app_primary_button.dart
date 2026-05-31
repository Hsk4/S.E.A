import 'package:flutter/material.dart';
import 'package:mobile/core/constants/app_colors.dart';
import 'package:mobile/core/constants/app_radius.dart';
import 'package:mobile/core/constants/app_spacing.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isExpanded = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryCol,
        foregroundColor: AppColors.base,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.borderMd),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s5,
          vertical: AppSpacing.s3,
        ),
      ),
      child: icon == null
          ? Text(label)
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18),
                const SizedBox(width: AppSpacing.s2),
                Text(label),
              ],
            ),
    );

    if (!isExpanded) {
      return button;
    }

    return SizedBox(width: double.infinity, child: button);
  }
}
