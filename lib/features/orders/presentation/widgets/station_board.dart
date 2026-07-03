import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_state.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../data/order_repository.dart';

const Map<OrderItemStatus, Color> orderItemStatusColors = {
  OrderItemStatus.newItem: AppColors.info,
  OrderItemStatus.preparing: AppColors.warning,
  OrderItemStatus.ready: AppColors.success,
  OrderItemStatus.completed: AppColors.statusDisabled,
};

const _statusFlow = [
  OrderItemStatus.newItem,
  OrderItemStatus.preparing,
  OrderItemStatus.ready,
  OrderItemStatus.completed,
];

/// Shared board for the Kitchen and Bar displays — same station workflow
/// (New → Preparing → Ready → Completed), filtered to food or drink items.
class StationBoard extends ConsumerWidget {
  const StationBoard({
    super.key,
    required this.title,
    required this.emptyIcon,
    required this.branchId,
    required this.isDrink,
  });

  final String title;
  final IconData emptyIcon;
  final int branchId;
  final bool isDrink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsProvider = isDrink ? barItemsForBranchProvider(branchId) : kitchenItemsForBranchProvider(branchId);
    final itemsAsync = ref.watch(itemsProvider);

    return AppScaffold(
      title: title,
      body: itemsAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(itemsProvider)),
        data: (items) {
          if (items.isEmpty) {
            return EmptyState(icon: emptyIcon, title: 'No active $title orders', message: 'New orders will appear here.');
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.sm),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.xs),
            itemBuilder: (context, index) => _StationItemCard(item: items[index]),
          );
        },
      ),
    );
  }
}

class _StationItemCard extends ConsumerWidget {
  const _StationItemCard({required this.item});

  final OrderItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final status = OrderItemStatus.values.byName(item.status);
    final nextIndex = _statusFlow.indexOf(status) + 1;
    final next = nextIndex < _statusFlow.length ? _statusFlow[nextIndex] : null;

    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${item.quantity}x ${item.itemName}${item.variantName != null ? ' · ${item.variantName}' : ''}',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    StatusBadge(label: status.label, color: orderItemStatusColors[status]!),
                  ],
                ),
                if (item.comment != null && item.comment!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(item.comment!, style: theme.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic)),
                ],
              ],
            ),
          ),
          if (next != null) ...[
            const SizedBox(width: AppSpacing.sm),
            AppButton(
              label: next == OrderItemStatus.completed ? 'Complete' : next.label,
              expand: false,
              onPressed: () => ref.read(orderRepositoryProvider).updateItemStatus(item.id, next),
            ),
          ],
        ],
      ),
    );
  }
}
