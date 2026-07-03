import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/session/current_branch_provider.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_state.dart';
import '../../../orders/data/order_repository.dart';
import '../../../reservations/data/reservation_repository.dart';
import '../../../tables/data/service_table_repository.dart';
import '../widgets/stat_tile.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branchAsync = ref.watch(currentBranchProvider);

    return AppScaffold(
      title: 'Dashboard',
      body: branchAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(currentBranchProvider)),
        data: (branch) {
          if (branch == null) {
            return const EmptyState(icon: Icons.store_outlined, title: 'No active branch');
          }
          return _DashboardBody(branchId: branch.id);
        },
      ),
    );
  }
}

class _DashboardBody extends ConsumerWidget {
  const _DashboardBody({required this.branchId});

  final int branchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(openOrdersForBranchProvider(branchId));
    final recentOrdersAsync = ref.watch(recentOrdersForBranchProvider(branchId));
    final reservationsAsync = ref.watch(reservationsForBranchProvider(branchId));
    final tablesAsync = ref.watch(tablesForBranchProvider(branchId));
    final orderItemsAsync = ref.watch(allOrderItemsForBranchProvider(branchId));

    final today = DateTime.now();
    bool isToday(DateTime date) => date.year == today.year && date.month == today.month && date.day == today.day;

    final todaySales = ordersAsync.value
            ?.where((o) => o.status == OrderStatus.paid.name && isToday(o.updatedAt))
            .fold<double>(0, (sum, o) => sum + o.total) ??
        0;
    final openOrdersCount = ordersAsync.value?.length ?? 0;
    final reservationsToday = reservationsAsync.value?.where((r) => isToday(r.date)).length ?? 0;
    final activeTables =
        tablesAsync.value?.where((t) => t.status == TableStatus.occupied.name).length ?? 0;

    final bestSellers = <String, int>{};
    for (final item in orderItemsAsync.value ?? const <OrderItem>[]) {
      bestSellers[item.itemName] = (bestSellers[item.itemName] ?? 0) + item.quantity;
    }
    final topSellers = bestSellers.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.sm),
      children: [
        // A fixed-aspect-ratio grid was cutting stat cards off by a fraction
        // of a pixel (worse under larger accessibility font scales, since
        // the ratio doesn't grow with text). Two rows of Expanded tiles let
        // each card size to its own content instead.
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: StatTile(
                  icon: Icons.payments_outlined,
                  label: "Today's Sales",
                  value: todaySales.toStringAsFixed(2),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: StatTile(
                  icon: Icons.receipt_long_outlined,
                  label: 'Open Orders',
                  value: '$openOrdersCount',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: StatTile(
                  icon: Icons.event_available_outlined,
                  label: 'Reservations Today',
                  value: '$reservationsToday',
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: StatTile(
                  icon: Icons.table_bar_outlined,
                  label: 'Active Tables',
                  value: '$activeTables',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text('Best Selling Items', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.xs),
        if (topSellers.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Text(
              'No sales data yet',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
            ),
          )
        else
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final entry in topSellers.take(5))
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key),
                        Text('${entry.value} sold'),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.md),
        Text('Recent Orders', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.xs),
        recentOrdersAsync.when(
          loading: () => const LoadingState(itemCount: 3),
          error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(recentOrdersForBranchProvider(branchId))),
          data: (orders) {
            if (orders.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                child: Text(
                  'No orders yet',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                ),
              );
            }
            return Column(
              children: [
                for (final order in orders)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: AppCard(
                      onTap: () => context.push(AppRoutes.orderDetailPath(order.id)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              order.customerName?.isNotEmpty == true ? order.customerName! : 'Order #${order.id}',
                            ),
                          ),
                          Text(order.total.toStringAsFixed(2)),
                          const SizedBox(width: AppSpacing.xs),
                          Text(OrderStatus.values.byName(order.status).label),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
