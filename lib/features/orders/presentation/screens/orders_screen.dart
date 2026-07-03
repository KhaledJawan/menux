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
import '../../../../core/widgets/responsive_card_grid.dart';
import '../../../../core/widgets/search_field.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../floor_plan/presentation/widgets/floor_plan_canvas.dart';
import '../../../floor_plan/presentation/widgets/view_mode_toggle.dart';
import '../../../halls/data/hall_repository.dart';
import '../../../tables/data/service_table_repository.dart';
import '../../../tables/presentation/widgets/table_status_picker_sheet.dart';
import '../../data/hall_visibility_repository.dart';
import '../../data/order_repository.dart';
import '../widgets/manage_visible_halls_sheet.dart';
import '../widgets/order_table_quick_actions_sheet.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  TableViewMode _viewMode = TableViewMode.list;
  int? _selectedHallId;
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final branchAsync = ref.watch(currentBranchProvider);
    final branch = branchAsync.value;
    final hallsAsync = branch == null ? null : ref.watch(hallsForBranchProvider(branch.id));
    final allHalls = hallsAsync?.value ?? const <Hall>[];
    final hidden = branch == null ? const <int>{} : (ref.watch(hiddenHallsProvider(branch.id)).value ?? const {});
    final visibleHalls = allHalls.where((h) => !hidden.contains(h.id)).toList();

    // Floor plans are per-hall, so graphical mode needs one hall selected —
    // default to the first *visible* one once halls load, without
    // stomping a user pick.
    if ((_selectedHallId == null || hidden.contains(_selectedHallId)) && visibleHalls.isNotEmpty) {
      _selectedHallId = visibleHalls.first.id;
    }

    return AppScaffold(
      title: 'Orders',
      actions: [
        if (allHalls.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.visibility_outlined),
            tooltip: 'Visible halls',
            onPressed: branch == null
                ? null
                : () => showManageVisibleHallsSheet(context, branchId: branch.id, halls: allHalls),
          ),
        IconButton(
          icon: const Icon(Icons.receipt_long_outlined),
          tooltip: 'Open orders',
          onPressed: branch == null ? null : () => _showOpenOrdersSheet(context, ref, branch.id),
        ),
      ],
      search: visibleHalls.isEmpty
          ? null
          : SearchField(
              controller: _searchController,
              hint: 'Search tables',
              onChanged: (value) => setState(() => _query = value.trim().toLowerCase()),
            ),
      filters: _query.isNotEmpty || visibleHalls.isEmpty
          ? null
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ViewModeToggle(mode: _viewMode, onChanged: (mode) => setState(() => _viewMode = mode)),
                if (_viewMode == TableViewMode.graphical && visibleHalls.length > 1) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.xs,
                    children: [
                      for (final hall in visibleHalls)
                        ChoiceChip(
                          label: Text(hall.name),
                          selected: _selectedHallId == hall.id,
                          onSelected: (_) => setState(() => _selectedHallId = hall.id),
                        ),
                    ],
                  ),
                ],
              ],
            ),
      body: branchAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(currentBranchProvider)),
        data: (branch) {
          if (branch == null) {
            return const EmptyState(icon: Icons.store_outlined, title: 'No active branch');
          }
          return (hallsAsync ?? const AsyncValue.loading()).when(
            loading: () => const LoadingState(),
            error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(hallsForBranchProvider(branch.id))),
            data: (halls) {
              if (halls.isEmpty) {
                return const EmptyState(
                  icon: Icons.meeting_room_outlined,
                  title: 'No halls set up yet',
                  message: 'Add a hall and some tables from More → Halls & Tables to start taking orders.',
                );
              }
              if (visibleHalls.isEmpty) {
                return EmptyState(
                  icon: Icons.visibility_off_outlined,
                  title: 'All halls are hidden',
                  message: 'Tap the eye icon above to show a hall again.',
                  actionLabel: 'Manage Visible Halls',
                  onAction: () => showManageVisibleHallsSheet(context, branchId: branch.id, halls: halls),
                );
              }

              if (_query.isNotEmpty) {
                return _TableSearchResults(branchId: branch.id, visibleHalls: visibleHalls, query: _query);
              }

              if (_viewMode == TableViewMode.graphical) {
                final hallId = _selectedHallId ?? visibleHalls.first.id;
                return FloorPlanCanvas(
                  hallId: hallId,
                  branchId: branch.id,
                  editable: false,
                  onViewOnlyTap: (table, activeOrder) => showOrderTableQuickActionsSheet(
                    context,
                    ref,
                    table: table,
                    branchId: branch.id,
                    activeOrder: activeOrder,
                  ),
                );
              }

              return ListView(
                padding: const EdgeInsets.all(AppSpacing.sm),
                children: [
                  for (final hall in visibleHalls) _HallTableSection(branchId: branch.id, hall: hall),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _showOpenOrdersSheet(BuildContext context, WidgetRef ref, int branchId) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Consumer(
            builder: (context, ref, _) {
              final ordersAsync = ref.watch(openOrdersForBranchProvider(branchId));
              return ordersAsync.when(
                loading: () => const LoadingState(),
                error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(openOrdersForBranchProvider(branchId))),
                data: (orders) {
                  if (orders.isEmpty) {
                    return const EmptyState(icon: Icons.receipt_long_outlined, title: 'No open orders');
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    itemCount: orders.length,
                    separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.xs),
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      final status = OrderStatus.values.byName(order.status);
                      return AppCard(
                        onTap: () {
                          Navigator.of(context).pop();
                          context.push(AppRoutes.orderDetailPath(order.id));
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                order.customerName?.isNotEmpty == true ? order.customerName! : 'Order #${order.id}',
                              ),
                            ),
                            Text(order.total.toStringAsFixed(2)),
                            const SizedBox(width: AppSpacing.xs),
                            Text(status.label),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HallTableSection extends ConsumerWidget {
  const _HallTableSection({required this.branchId, required this.hall});

  final int branchId;
  final Hall hall;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tablesAsync = ref.watch(tablesForHallProvider(hall.id));
    final openOrdersAsync = ref.watch(openOrdersForBranchProvider(branchId));

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hall.name, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.xs),
          tablesAsync.when(
            loading: () => const LoadingState(itemCount: 2),
            error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(tablesForHallProvider(hall.id))),
            data: (tables) {
              if (tables.isEmpty) {
                return Text(
                  'No tables in this hall',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                );
              }
              final ordersByTable = <int, Order>{
                for (final order in openOrdersAsync.value ?? const <Order>[])
                  if (order.tableId != null) order.tableId!: order,
              };
              return ResponsiveCardGrid(
                children: [
                  for (final table in tables)
                    Builder(
                      builder: (context) {
                        final status = TableStatus.values.byName(table.status);
                        final order = ordersByTable[table.id];
                        return AppCard(
                          onTap: status == TableStatus.disabled
                              ? null
                              : () => showOrderTableQuickActionsSheet(
                                    context,
                                    ref,
                                    table: table,
                                    branchId: branchId,
                                    activeOrder: order,
                                  ),
                          onLongPress: () => showTableStatusPickerSheet(context, tableId: table.id, current: status),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(table.name, style: Theme.of(context).textTheme.titleMedium),
                              Text(
                                '${table.capacity} guests',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                    ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              if (order != null) ...[
                                Text(order.total.toStringAsFixed(2), style: Theme.of(context).textTheme.titleMedium),
                                const SizedBox(height: 2),
                              ],
                              StatusBadge(label: status.label, color: tableStatusColors[status]!),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TableSearchResults extends ConsumerWidget {
  const _TableSearchResults({required this.branchId, required this.visibleHalls, required this.query});

  final int branchId;
  final List<Hall> visibleHalls;
  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tablesAsync = ref.watch(tablesForBranchProvider(branchId));
    final openOrdersAsync = ref.watch(openOrdersForBranchProvider(branchId));

    return tablesAsync.when(
      loading: () => const LoadingState(),
      error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(tablesForBranchProvider(branchId))),
      data: (tables) {
        final visibleHallIds = visibleHalls.map((h) => h.id).toSet();
        final hallNames = {for (final hall in visibleHalls) hall.id: hall.name};
        final matches = tables
            .where((t) => visibleHallIds.contains(t.hallId) && t.name.toLowerCase().contains(query))
            .toList();

        if (matches.isEmpty) {
          return const EmptyState(icon: Icons.search_off_rounded, title: 'No matching tables');
        }

        final ordersByTable = <int, Order>{
          for (final order in openOrdersAsync.value ?? const <Order>[])
            if (order.tableId != null) order.tableId!: order,
        };

        return ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.sm),
          itemCount: matches.length,
          separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.xs),
          itemBuilder: (context, index) {
            final table = matches[index];
            final status = TableStatus.values.byName(table.status);
            final order = ordersByTable[table.id];
            return AppCard(
              onTap: status == TableStatus.disabled
                  ? null
                  : () => showOrderTableQuickActionsSheet(
                        context,
                        ref,
                        table: table,
                        branchId: branchId,
                        activeOrder: order,
                      ),
              onLongPress: () => showTableStatusPickerSheet(context, tableId: table.id, current: status),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(table.name, style: Theme.of(context).textTheme.titleMedium),
                        Text(
                          '${hallNames[table.hallId] ?? ''} · ${table.capacity} guests',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                        ),
                      ],
                    ),
                  ),
                  if (order != null) ...[
                    Text(order.total.toStringAsFixed(2), style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(width: AppSpacing.xs),
                  ],
                  StatusBadge(label: status.label, color: tableStatusColors[status]!),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
