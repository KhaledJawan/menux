import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../restaurant/data/restaurant_repository.dart';
import '../../data/data_reset_service.dart';

class AppSettingsScreen extends ConsumerWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurant = ref.watch(currentRestaurantProvider).value;
    final theme = Theme.of(context);

    return AppScaffold(
      title: 'App Settings',
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.sm),
        children: [
          if (restaurant != null)
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Currency', style: theme.textTheme.bodyMedium),
                  Text(restaurant.currency, style: theme.textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.xs),
                  Text('Language', style: theme.textTheme.bodyMedium),
                  Text(restaurant.language, style: theme.textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.xs),
                  Text('Tax', style: theme.textTheme.bodyMedium),
                  Text('${restaurant.taxPercent}%', style: theme.textTheme.titleMedium),
                ],
              ),
            ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Danger Zone',
            style: theme.textTheme.titleMedium?.copyWith(color: AppColors.danger),
          ),
          const SizedBox(height: AppSpacing.xs),
          AppButton(
            label: 'Reset All Data',
            variant: AppButtonVariant.danger,
            onPressed: () async {
              final confirmed = await confirmDelete(
                context,
                title: 'Reset all data?',
                message: 'This permanently deletes your restaurant, orders, menu, and account. '
                    'This cannot be undone.',
              );
              if (confirmed) {
                await ref.read(dataResetServiceProvider).resetAll();
              }
            },
          ),
        ],
      ),
    );
  }
}
