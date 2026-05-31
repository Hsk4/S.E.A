import 'package:flutter/material.dart';
import 'package:mobile/core/constants/app_colors.dart';
import 'package:mobile/core/constants/app_radius.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/constants/app_spacing.dart';

class AppStatTile extends StatelessWidget {
  const AppStatTile({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.helper,
    this.accentColor,
  });

  final String label;
  final String value;
  final IconData? icon;
  final String? helper;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppColors.primaryCol;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color: AppColors.overlay,
        borderRadius: AppRadius.borderMd,
        border: Border.all(color: AppColors.border, width: AppSizes.borderThin),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.14),
                    borderRadius: AppRadius.borderSm,
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                const SizedBox(width: AppSpacing.s3),
              ],
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s3),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                ),
          ),
          if (helper != null) ...[
            const SizedBox(height: AppSpacing.s1),
            Text(
              helper!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }
}
