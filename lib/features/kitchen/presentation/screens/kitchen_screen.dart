import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/current_branch_provider.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_state.dart';
import '../../../orders/presentation/widgets/station_board.dart';

class KitchenScreen extends ConsumerWidget {
  const KitchenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branchAsync = ref.watch(currentBranchProvider);

    return branchAsync.when(
      loading: () => const Scaffold(body: LoadingState()),
      error: (error, stack) => Scaffold(body: ErrorState(onRetry: () => ref.invalidate(currentBranchProvider))),
      data: (branch) {
        if (branch == null) {
          return const Scaffold(body: EmptyState(icon: Icons.store_outlined, title: 'No active branch'));
        }
        return StationBoard(
          title: 'Kitchen',
          emptyIcon: Icons.soup_kitchen_outlined,
          branchId: branch.id,
          isDrink: false,
        );
      },
    );
  }
}
