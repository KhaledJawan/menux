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
import '../../../../core/widgets/status_badge.dart';
import '../../../restaurant/data/restaurant_repository.dart';
import '../../data/staff_repository.dart';
import '../widgets/staff_form_sheet.dart';

class StaffScreen extends ConsumerWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantAsync = ref.watch(currentRestaurantProvider);
    final isOwner = ref.watch(isOwnerProvider);

    return AppScaffold(
      title: 'Staff',
      floatingActionButton: (!isOwner || restaurantAsync.value == null)
          ? null
          : FloatingActionButton(
              onPressed: () => showStaffFormSheet(context, restaurantId: restaurantAsync.value!.id),
              child: const Icon(Icons.person_add_alt_1_rounded),
            ),
      body: restaurantAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(currentRestaurantProvider)),
        data: (restaurant) {
          if (restaurant == null) {
            return const EmptyState(icon: Icons.storefront_outlined, title: 'No restaurant found');
          }
          final staffAsync = ref.watch(staffForRestaurantProvider(restaurant.id));
          return staffAsync.when(
            loading: () => const LoadingState(),
            error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(staffForRestaurantProvider(restaurant.id))),
            data: (staff) {
              if (staff.isEmpty) {
                return EmptyState(
                  icon: Icons.groups_outlined,
                  title: 'No staff yet',
                  message: isOwner
                      ? 'Add your team so everyone can be assigned a role.'
                      : 'Ask the restaurant owner to add your team.',
                  actionLabel: isOwner ? 'Add Staff Member' : null,
                  onAction: isOwner ? () => showStaffFormSheet(context, restaurantId: restaurant.id) : null,
                );
              }
              return ListView(
                padding: const EdgeInsets.all(AppSpacing.sm),
                children: [
                  if (!isOwner) const OwnerOnlyBanner(),
                  for (final member in staff)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: AppCard(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(member.name, style: Theme.of(context).textTheme.titleMedium),
                                  if (member.phone != null)
                                    Text(
                                      member.phone!,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                          ),
                                    ),
                                ],
                              ),
                            ),
                            StatusBadge(
                              label: StaffRole.values.byName(member.role).label,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            if (isOwner)
                              IconButton(
                                icon: const Icon(Icons.more_vert_rounded),
                                onPressed: () => showEntityActionsSheet(
                                  context: context,
                                  onEdit: () =>
                                      showStaffFormSheet(context, restaurantId: restaurant.id, initial: member),
                                  onDelete: () async {
                                    final confirmed =
                                        await confirmDelete(context, title: 'Remove ${member.name}?');
                                    if (confirmed) {
                                      await ref.read(staffRepositoryProvider).delete(member.id);
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
