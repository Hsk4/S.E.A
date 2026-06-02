import 'package:flutter/material.dart';
import 'package:mobile/core/constants/app_colors.dart';
import 'package:mobile/core/constants/app_spacing.dart';
import 'package:mobile/core/constants/routes.dart';
import 'package:mobile/core/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppScaffold(
      title: 'S.E.A System',
      body: ListView(
        children: [
          const AppSectionHeader(
            title: 'Reusable widgets',
            subtitle: 'Built from shared tokens to match the dark dashboard style in your design.',
          ),
          const SizedBox(height: AppSpacing.s4),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppStatusBadge(
                  label: 'Responder online',
                  color: AppColors.online,
                  icon: Icons.circle,
                  compact: true,
                ),
                const SizedBox(height: AppSpacing.s4),
                Text('Emergency dispatch panel', style: textTheme.headlineMedium),
                const SizedBox(height: AppSpacing.s1),
                Text(
                  'This screen demonstrates the shared widgets that can be reused across user, responder, and helper flows.',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.s4),
                const AppTextField(
                  label: 'Search incident',
                  hintText: 'Enter incident code',
                  prefixIcon: Icon(Icons.search),
                ),
                const SizedBox(height: AppSpacing.s3),
                Row(
                  children: [
                    Expanded(
                      child: AppPrimaryButton(
                        label: 'Dispatch',
                        icon: Icons.local_fire_department,
                        isExpanded: true,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s3),
                    Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Cancel'))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s4),
          const AppSectionHeader(
            title: 'Quick stats',
            subtitle: 'Small cards you can reuse anywhere on the dashboard.',
          ),
          const SizedBox(height: AppSpacing.s3),
          Wrap(
            spacing: AppSpacing.s3,
            runSpacing: AppSpacing.s3,
            children: const [
              SizedBox(
                width: 160,
                child: AppStatTile(
                  label: 'Active incidents',
                  value: '18',
                  helper: 'Live updates',
                  icon: Icons.warning_amber_rounded,
                  accentColor: AppColors.primaryCol,
                ),
              ),
              SizedBox(
                width: 160,
                child: AppStatTile(
                  label: 'Available responders',
                  value: '42',
                  helper: 'Online now',
                  icon: Icons.groups_rounded,
                  accentColor: AppColors.secondaryCol,
                ),
              ),
              SizedBox(
                width: 160,
                child: AppStatTile(
                  label: 'Resolved today',
                  value: '73',
                  helper: 'Closed cases',
                  icon: Icons.check_circle_rounded,
                  accentColor: AppColors.resolved,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s4),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppSectionHeader(
                  title: 'Available module chips',
                  subtitle: 'Useful for role filters, status tags, or quick category indicators.',
                ),
                SizedBox(height: AppSpacing.s3),
                Wrap(
                  spacing: AppSpacing.s2,
                  runSpacing: AppSpacing.s2,
                  children: [
                    AppStatusBadge(label: 'User', color: AppColors.primaryCol),
                    AppStatusBadge(label: 'Responder', color: AppColors.secondaryCol),
                    AppStatusBadge(label: 'Helper', color: AppColors.tertiary),
                    AppStatusBadge(label: 'On scene', color: AppColors.onScene),
                    AppStatusBadge(label: 'Dispatching', color: AppColors.dispatching),
                  ],
                ),
              ],
            ),
          ),

          AppPrimaryButton(
            label: 'Go to Sign In',
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.authSignIn);
            },
          ),
        ],
      ),
    );
  }
}
