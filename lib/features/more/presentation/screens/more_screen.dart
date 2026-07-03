import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/domain/enums.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/session/current_branch_provider.dart';
import '../../../../core/session/current_staff_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../auth/data/auth_repository.dart';
import '../../../restaurant/data/restaurant_repository.dart';
import '../../../staff/presentation/widgets/switch_user_sheet.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(currentProfileProvider).value;
    final restaurant = ref.watch(currentRestaurantProvider).value;
    final branch = ref.watch(currentBranchProvider).value;
    final activeStaff = ref.watch(activeStaffMemberProvider).value;
    final theme = Theme.of(context);

    return AppScaffold(
      title: 'More',
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.sm),
        children: [
          AppCard(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                  child: Text(
                    (activeStaff?.name ?? profile?.name ?? '?').isNotEmpty
                        ? (activeStaff?.name ?? profile?.name ?? '?')[0].toUpperCase()
                        : '?',
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(activeStaff?.name ?? profile?.name ?? 'Not checked in', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 2),
                      if (activeStaff != null)
                        StatusBadge(
                          label: StaffRole.values.byName(activeStaff.role).label,
                          color: theme.colorScheme.onSurface,
                        )
                      else
                        Text(
                          'Select who is using Menux',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: restaurant == null
                      ? null
                      : () => showSwitchUserSheet(context, restaurantId: restaurant.id),
                  child: const Text('Switch'),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text('Setup', style: theme.textTheme.labelSmall?.copyWith(letterSpacing: 0.5)),
          const SizedBox(height: AppSpacing.xs),
          _MoreEntry(
            icon: Icons.storefront_outlined,
            label: 'Restaurant Settings',
            onTap: () => context.push(AppRoutes.restaurantSettings),
          ),
          _MoreEntry(
            icon: Icons.table_bar_outlined,
            label: 'Halls & Tables',
            subtitle: 'Salons/areas and the tables in them',
            onTap: branch == null ? null : () => context.push(AppRoutes.hallsPath(branch.id)),
          ),
          _MoreEntry(
            icon: Icons.store_outlined,
            label: 'Branches',
            onTap: () => context.push(AppRoutes.branches),
          ),
          _MoreEntry(
            icon: Icons.restaurant_menu_outlined,
            label: 'Menu',
            onTap: () => context.push(AppRoutes.menu),
          ),
          _MoreEntry(
            icon: Icons.groups_outlined,
            label: 'Staff',
            onTap: () => context.push(AppRoutes.staff),
          ),
          const SizedBox(height: AppSpacing.md),
          Text('Operations', style: theme.textTheme.labelSmall?.copyWith(letterSpacing: 0.5)),
          const SizedBox(height: AppSpacing.xs),
          _MoreEntry(
            icon: Icons.soup_kitchen_outlined,
            label: 'Kitchen Display',
            onTap: () => context.push(AppRoutes.kitchen),
          ),
          _MoreEntry(
            icon: Icons.local_bar_outlined,
            label: 'Bar Display',
            onTap: () => context.push(AppRoutes.bar),
          ),
          _MoreEntry(
            icon: Icons.receipt_outlined,
            label: 'Receipts',
            onTap: () => context.push(AppRoutes.receipts),
          ),
          _MoreEntry(
            icon: Icons.settings_outlined,
            label: 'App Settings',
            onTap: () => context.push(AppRoutes.appSettings),
          ),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: TextButton(
              onPressed: () => ref.read(authRepositoryProvider).logout(),
              child: const Text('Log Out of This Device', style: TextStyle(color: AppColors.danger)),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoreEntry extends StatelessWidget {
  const _MoreEntry({required this.icon, required this.label, required this.onTap, this.subtitle});

  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: AppCard(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: theme.textTheme.bodyLarge),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}
