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
import '../../../../core/widgets/responsive_card_grid.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../floor_plan/presentation/widgets/floor_plan_canvas.dart';
import '../../../floor_plan/presentation/widgets/view_mode_toggle.dart';
import '../../../halls/data/hall_repository.dart';
import '../../data/service_table_repository.dart';
import '../widgets/table_form_sheet.dart';
import '../widgets/table_status_picker_sheet.dart';

class TablesScreen extends ConsumerStatefulWidget {
  const TablesScreen({super.key, required this.hallId});

  final int hallId;

  @override
  ConsumerState<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends ConsumerState<TablesScreen> {
  TableViewMode _viewMode = TableViewMode.list;

  @override
  Widget build(BuildContext context) {
    final tablesAsync = ref.watch(tablesForHallProvider(widget.hallId));
    final hallAsync = ref.watch(hallByIdProvider(widget.hallId));
    final isOwner = ref.watch(isOwnerProvider);

    return AppScaffold(
      title: 'Tables',
      filters: ViewModeToggle(mode: _viewMode, onChanged: (mode) => setState(() => _viewMode = mode)),
      floatingActionButton: !isOwner
          ? null
          : FloatingActionButton(
              onPressed: () => showTableFormSheet(context, hallId: widget.hallId),
              child: const Icon(Icons.add_rounded),
            ),
      body: tablesAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(tablesForHallProvider(widget.hallId))),
        data: (tables) {
          if (tables.isEmpty) {
            return EmptyState(
              icon: Icons.table_bar_outlined,
              title: 'No tables yet',
              message: isOwner
                  ? 'Add a table so staff can seat guests, take orders, and reserve it.'
                  : 'Ask the restaurant owner to add tables to this hall.',
              actionLabel: isOwner ? 'Create Table' : null,
              onAction: isOwner ? () => showTableFormSheet(context, hallId: widget.hallId) : null,
            );
          }

          if (_viewMode == TableViewMode.graphical) {
            return hallAsync.when(
              loading: () => const LoadingState(),
              error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(hallByIdProvider(widget.hallId))),
              data: (hall) {
                if (hall == null) {
                  return const ErrorState(message: 'This hall no longer exists.');
                }
                return FloorPlanCanvas(hallId: widget.hallId, branchId: hall.branchId);
              },
            );
          }

          return Column(
            children: [
              if (!isOwner) Padding(padding: const EdgeInsets.all(AppSpacing.sm), child: const OwnerOnlyBanner()),
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.fromLTRB(AppSpacing.sm, isOwner ? AppSpacing.sm : 0, AppSpacing.sm, AppSpacing.sm),
                  child: ResponsiveCardGrid(
                    children: [
                      for (final table in tables)
                        Builder(
                          builder: (context) {
                            final status = TableStatus.values.byName(table.status);
                            return AppCard(
                              onTap: () => showTableStatusPickerSheet(context, tableId: table.id, current: status),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(table.name, style: Theme.of(context).textTheme.titleMedium),
                                      ),
                                      if (isOwner)
                                        InkWell(
                                          borderRadius: BorderRadius.circular(20),
                                          onTap: () => showEntityActionsSheet(
                                            context: context,
                                            onEdit: () =>
                                                showTableFormSheet(context, hallId: widget.hallId, initial: table),
                                            onDelete: () async {
                                              final confirmed = await confirmDelete(
                                                context,
                                                title: 'Delete ${table.name}?',
                                              );
                                              if (confirmed) {
                                                await ref.read(serviceTableRepositoryProvider).delete(table.id);
                                              }
                                            },
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(4),
                                            child: Icon(Icons.more_vert_rounded, size: 18),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Text(
                                    '${table.capacity} guests',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                        ),
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  StatusBadge(label: status.label, color: tableStatusColors[status]!),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
