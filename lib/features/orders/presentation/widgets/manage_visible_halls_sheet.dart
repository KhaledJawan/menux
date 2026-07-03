import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../data/hall_visibility_repository.dart';

/// Lets a waiter hide halls they're not covering so the Orders tab only
/// shows the tables they're actually responsible for.
Future<void> showManageVisibleHallsSheet(
  BuildContext context, {
  required int branchId,
  required List<Hall> halls,
}) {
  return showAppBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (context) => _ManageVisibleHallsSheet(branchId: branchId, halls: halls),
  );
}

class _ManageVisibleHallsSheet extends ConsumerWidget {
  const _ManageVisibleHallsSheet({required this.branchId, required this.halls});

  final int branchId;
  final List<Hall> halls;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hiddenAsync = ref.watch(hiddenHallsProvider(branchId));
    final hidden = hiddenAsync.value ?? const <int>{};

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Visible Halls', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.xs),
        Text(
          "Hide halls you're not covering — they'll stay set up, just out of your way here.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final hall in halls)
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(hall.name),
            value: !hidden.contains(hall.id),
            onChanged: (visible) =>
                ref.read(hallVisibilityRepositoryProvider).setHidden(branchId, hall.id, !visible),
          ),
      ],
    );
  }
}
