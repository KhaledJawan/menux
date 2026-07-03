import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/session/current_branch_provider.dart';
import '../../../../core/session/current_staff_provider.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_state.dart';
import '../../../../core/widgets/owner_only_banner.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../data/restaurant_repository.dart';
import '../widgets/restaurant_form.dart';

class RestaurantSettingsScreen extends ConsumerStatefulWidget {
  const RestaurantSettingsScreen({super.key});

  @override
  ConsumerState<RestaurantSettingsScreen> createState() => _RestaurantSettingsScreenState();
}

class _RestaurantSettingsScreenState extends ConsumerState<RestaurantSettingsScreen> {
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final restaurantAsync = ref.watch(currentRestaurantProvider);
    final branchAsync = ref.watch(currentBranchProvider);
    final isOwner = ref.watch(isOwnerProvider);

    return AppScaffold(
      title: 'Restaurant Settings',
      body: restaurantAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(currentRestaurantProvider)),
        data: (restaurant) {
          if (restaurant == null) {
            return const EmptyState(icon: Icons.storefront_outlined, title: 'No restaurant found');
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!isOwner) const OwnerOnlyBanner(),
                // Halls & tables live under a table's own management flow,
                // but this is the discoverable entry point owners look for
                // first — the floor plan is core to how Menux works.
                if (branchAsync.value != null)
                  AppCard(
                    onTap: () => context.push(AppRoutes.hallsPath(branchAsync.value!.id)),
                    child: Row(
                      children: [
                        Icon(Icons.table_bar_outlined, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Halls & Tables', style: Theme.of(context).textTheme.bodyLarge),
                              Text(
                                'Set up salons/areas and the tables in them',
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
                const SizedBox(height: AppSpacing.md),
                RestaurantForm(
                  initial: restaurant,
                  isLoading: _isSaving,
                  submitLabel: 'Save Changes',
                  enabled: isOwner,
                  onSubmit: (result) async {
                    setState(() => _isSaving = true);
                    try {
                      await ref.read(restaurantRepositoryProvider).update(
                            restaurant.copyWith(
                              name: result.name,
                              address: Value(result.address),
                              currency: result.currency,
                              language: result.language,
                              taxPercent: result.taxPercent,
                              workingHoursOpen: Value(result.workingHoursOpen),
                              workingHoursClose: Value(result.workingHoursClose),
                            ),
                          );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('Restaurant updated')));
                      }
                    } finally {
                      if (mounted) setState(() => _isSaving = false);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
