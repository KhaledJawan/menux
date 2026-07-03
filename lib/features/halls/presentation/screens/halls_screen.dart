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
import '../../data/hall_repository.dart';
import '../widgets/hall_form_sheet.dart';

class HallsScreen extends ConsumerWidget {
  const HallsScreen({super.key, required this.branchId});

  final int branchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hallsAsync = ref.watch(hallsForBranchProvider(branchId));
    final isOwner = ref.watch(isOwnerProvider);

    return AppScaffold(
      title: 'Halls & Areas',
      floatingActionButton: !isOwner
          ? null
          : FloatingActionButton(
              onPressed: () => showHallFormSheet(context, branchId: branchId),
              child: const Icon(Icons.add_rounded),
            ),
      body: hallsAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(hallsForBranchProvider(branchId))),
        data: (halls) {
          if (halls.isEmpty) {
            return EmptyState(
              icon: Icons.meeting_room_outlined,
              title: 'No halls yet',
              message: isOwner
                  ? 'A hall (also called a salon or area) groups tables together — '
                      'like Main Hall, Garden, VIP Room, or Terrace. Add one to start '
                      'placing tables you can seat, reserve, and order for.'
                  : 'Ask the restaurant owner to set up halls and tables.',
              actionLabel: isOwner ? 'Add Hall' : null,
              onAction: isOwner ? () => showHallFormSheet(context, branchId: branchId) : null,
            );
          }
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.sm),
            children: [
              if (!isOwner) const OwnerOnlyBanner(),
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Text(
                  'Tap a hall to manage its tables.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                ),
              ),
              for (final hall in halls)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: AppCard(
                    onTap: () => context.push(AppRoutes.tablesPath(hall.id)),
                    child: Row(
                      children: [
                        Expanded(child: Text(hall.name, style: Theme.of(context).textTheme.titleMedium)),
                        if (isOwner)
                          IconButton(
                            icon: const Icon(Icons.more_vert_rounded),
                            onPressed: () => showEntityActionsSheet(
                              context: context,
                              onEdit: () => showHallFormSheet(context, branchId: branchId, initial: hall),
                              onDelete: () async {
                                final confirmed = await confirmDelete(
                                  context,
                                  title: 'Archive ${hall.name}?',
                                  message: 'Tables under this hall will remain but the hall will be hidden.',
                                );
                                if (confirmed) {
                                  await ref.read(hallRepositoryProvider).archive(hall.id);
                                }
                              },
                            ),
                          )
                        else
                          const Icon(Icons.chevron_right_rounded),
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
