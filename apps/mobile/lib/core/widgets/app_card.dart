import 'package:flutter/material.dart';
import 'package:mobile/core/constants/app_colors.dart';
import 'package:mobile/core/constants/app_radius.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/constants/app_spacing.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.s5),
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.elevation = 0,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppRadius.borderLg;
    final color = backgroundColor ?? AppColors.elevated;
    final outline = borderColor ?? AppColors.border;

    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: radius,
        border: Border.all(
          color: outline,
          width: AppSizes.borderThin,
        ),
        boxShadow: elevation <= 0
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: elevation,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: child,
    );

    if (onTap == null) {
      return Padding(
        padding: margin ?? EdgeInsets.zero,
        child: content,
      );
    }

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: content,
        ),
      ),
    );
  }
}
