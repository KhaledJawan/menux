import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/session/current_staff_provider.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/entity_actions_sheet.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_state.dart';
import '../../../../core/widgets/owner_only_banner.dart';
import '../../../restaurant/data/restaurant_repository.dart';
import '../../data/menu_repository.dart';
import '../widgets/menu_form_sheet.dart';

/// Hub for everything menu-related: the list of menus (each independently
/// toggleable and editable), plus entry points to discounts. A restaurant
/// can run several menus side by side — e.g. a always-on Drinks Menu plus
/// a Breakfast Menu only active in the morning — switching one off just
/// hides it from ordering without losing anything.
class MenusScreen extends ConsumerWidget {
  const MenusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantAsync = ref.watch(currentRestaurantProvider);
    final isOwner = ref.watch(isOwnerProvider);

    return AppScaffold(
      title: 'Menus',
      floatingActionButton: (!isOwner || restaurantAsync.value == null)
          ? null
          : FloatingActionButton(
              onPressed: () => showMenuFormSheet(context, restaurantId: restaurantAsync.value!.id),
              child: const Icon(Icons.add_rounded),
            ),
      body: restaurantAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(currentRestaurantProvider)),
        data: (restaurant) {
          if (restaurant == null) {
            return const EmptyState(icon: Icons.storefront_outlined, title: 'No restaurant found');
          }
          final menusAsync = ref.watch(menusForRestaurantProvider(restaurant.id));
          return menusAsync.when(
            loading: () => const LoadingState(),
            error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(menusForRestaurantProvider(restaurant.id))),
            data: (menus) {
              if (menus.isEmpty) {
                return EmptyState(
                  icon: Icons.restaurant_menu_outlined,
                  title: 'No menus yet',
                  message: isOwner
                      ? 'Create a menu to start adding categories and items — you can add more later (e.g. a separate Drinks Menu or a seasonal one).'
                      : 'Ask the restaurant owner to set up a menu.',
                  actionLabel: isOwner ? 'Add Menu' : null,
                  onAction: isOwner ? () => showMenuFormSheet(context, restaurantId: restaurant.id) : null,
                );
              }
              return ListView(
                padding: const EdgeInsets.all(AppSpacing.sm),
                children: [
                  if (!isOwner) const OwnerOnlyBanner(),
                  for (final menu in menus)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: AppCard(
                        onTap: () => context.push(AppRoutes.menuDetailPath(menu.id)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(menu.name, style: Theme.of(context).textTheme.titleMedium),
                                  Text(
                                    menu.isActive ? 'Active — visible when ordering' : 'Inactive — hidden from ordering',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: menu.isActive,
                              onChanged: (value) => ref.read(menuRepositoryProvider).setActive(menu.id, value),
                            ),
                            if (isOwner)
                              IconButton(
                                icon: const Icon(Icons.more_vert_rounded),
                                onPressed: () => showEntityActionsSheet(
                                  context: context,
                                  onEdit: () => showMenuFormSheet(context, restaurantId: restaurant.id, initial: menu),
                                  onDelete: () async {
                                    final confirmed = await confirmDelete(
                                      context,
                                      title: 'Delete ${menu.name}?',
                                      message: 'Its categories and items will be deleted too.',
                                    );
                                    if (confirmed) {
                                      await ref.read(menuRepositoryProvider).delete(menu.id);
                                    }
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: AppSpacing.md),
                  AppCard(
                    onTap: () => context.push(AppRoutes.discounts),
                    child: Row(
                      children: [
                        Icon(Icons.percent_rounded, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Discounts', style: Theme.of(context).textTheme.bodyLarge),
                              Text(
                                'Manage reusable discounts for checkout',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
