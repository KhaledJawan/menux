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
import '../../data/branch_repository.dart';
import '../widgets/branch_form_sheet.dart';

class BranchesScreen extends ConsumerWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantAsync = ref.watch(currentRestaurantProvider);
    final isOwner = ref.watch(isOwnerProvider);

    return AppScaffold(
      title: 'Branches',
      floatingActionButton: (!isOwner || restaurantAsync.value == null)
          ? null
          : FloatingActionButton(
              onPressed: () => showBranchFormSheet(context, restaurantId: restaurantAsync.value!.id),
              child: const Icon(Icons.add_rounded),
            ),
      body: restaurantAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(currentRestaurantProvider)),
        data: (restaurant) {
          if (restaurant == null) {
            return const EmptyState(icon: Icons.storefront_outlined, title: 'No restaurant found');
          }
          final branchesAsync = ref.watch(branchesForRestaurantProvider(restaurant.id));
          return branchesAsync.when(
            loading: () => const LoadingState(),
            error: (error, stack) =>
                ErrorState(onRetry: () => ref.invalidate(branchesForRestaurantProvider(restaurant.id))),
            data: (branches) {
              if (branches.isEmpty) {
                return EmptyState(
                  icon: Icons.store_outlined,
                  title: 'No branches yet',
                  message: isOwner
                      ? 'Add a branch to start organizing halls and tables.'
                      : 'Ask the restaurant owner to set up a branch.',
                  actionLabel: isOwner ? 'Add Branch' : null,
                  onAction: isOwner ? () => showBranchFormSheet(context, restaurantId: restaurant.id) : null,
                );
              }
              return ListView(
                padding: const EdgeInsets.all(AppSpacing.sm),
                children: [
                  if (!isOwner) const OwnerOnlyBanner(),
                  for (final branch in branches)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: AppCard(
                        onTap: () => context.push(AppRoutes.hallsPath(branch.id)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(branch.name, style: Theme.of(context).textTheme.titleMedium),
                                  if (branch.address != null) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      branch.address!,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                          ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            if (isOwner)
                              IconButton(
                                icon: const Icon(Icons.more_vert_rounded),
                                onPressed: () => showEntityActionsSheet(
                                  context: context,
                                  onEdit: () =>
                                      showBranchFormSheet(context, restaurantId: restaurant.id, initial: branch),
                                  onDelete: () async {
                                    final confirmed = await confirmDelete(
                                      context,
                                      title: 'Archive ${branch.name}?',
                                      message:
                                          'Halls and tables under this branch will remain but the branch will be hidden.',
                                    );
                                    if (confirmed) {
                                      await ref.read(branchRepositoryProvider).archive(branch.id);
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
          );
        },
      ),
    );
  }
}
