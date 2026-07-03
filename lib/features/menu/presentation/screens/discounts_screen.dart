import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/enums.dart';
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
import '../../data/discount_repository.dart';
import '../widgets/discount_form_sheet.dart';

class DiscountsScreen extends ConsumerWidget {
  const DiscountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantAsync = ref.watch(currentRestaurantProvider);
    final isOwner = ref.watch(isOwnerProvider);

    return AppScaffold(
      title: 'Discounts',
      floatingActionButton: (!isOwner || restaurantAsync.value == null)
          ? null
          : FloatingActionButton(
              onPressed: () => showDiscountFormSheet(context, restaurantId: restaurantAsync.value!.id),
              child: const Icon(Icons.add_rounded),
            ),
      body: restaurantAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(currentRestaurantProvider)),
        data: (restaurant) {
          if (restaurant == null) {
            return const EmptyState(icon: Icons.storefront_outlined, title: 'No restaurant found');
          }
          final discountsAsync = ref.watch(discountsForRestaurantProvider(restaurant.id));
          return discountsAsync.when(
            loading: () => const LoadingState(),
            error: (error, stack) =>
                ErrorState(onRetry: () => ref.invalidate(discountsForRestaurantProvider(restaurant.id))),
            data: (discounts) {
              if (discounts.isEmpty) {
                return EmptyState(
                  icon: Icons.percent_rounded,
                  title: 'No discounts yet',
                  message: isOwner
                      ? 'Add a discount so staff can apply it at checkout instead of typing a number each time.'
                      : 'Ask the restaurant owner to set up discounts.',
                  actionLabel: isOwner ? 'Add Discount' : null,
                  onAction: isOwner ? () => showDiscountFormSheet(context, restaurantId: restaurant.id) : null,
                );
              }
              return ListView(
                padding: const EdgeInsets.all(AppSpacing.sm),
                children: [
                  if (!isOwner) const OwnerOnlyBanner(),
                  for (final discount in discounts)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: AppCard(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(discount.name, style: Theme.of(context).textTheme.titleMedium),
                                  Text(
                                    DiscountType.values.byName(discount.type) == DiscountType.percent
                                        ? '${discount.value.toStringAsFixed(0)}% off'
                                        : '${discount.value.toStringAsFixed(2)} off',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: discount.isActive,
                              onChanged: (value) =>
                                  ref.read(discountRepositoryProvider).setActive(discount.id, value),
                            ),
                            if (isOwner)
                              IconButton(
                                icon: const Icon(Icons.more_vert_rounded),
                                onPressed: () => showEntityActionsSheet(
                                  context: context,
                                  onEdit: () =>
                                      showDiscountFormSheet(context, restaurantId: restaurant.id, initial: discount),
                                  onDelete: () async {
                                    final confirmed =
                                        await confirmDelete(context, title: 'Delete ${discount.name}?');
                                    if (confirmed) {
                                      await ref.read(discountRepositoryProvider).delete(discount.id);
                                    }
                                  },
                                ),
                              ),
                          ],
                        ),
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
