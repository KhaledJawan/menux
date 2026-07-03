import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/session/current_branch_provider.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_state.dart';
import '../../data/receipt_repository.dart';

class ReceiptsScreen extends ConsumerWidget {
  const ReceiptsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branchAsync = ref.watch(currentBranchProvider);

    return AppScaffold(
      title: 'Receipts',
      body: branchAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(currentBranchProvider)),
        data: (branch) {
          if (branch == null) {
            return const EmptyState(icon: Icons.store_outlined, title: 'No active branch');
          }
          final receiptsAsync = ref.watch(receiptsForBranchProvider(branch.id));
          return receiptsAsync.when(
            loading: () => const LoadingState(),
            error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(receiptsForBranchProvider(branch.id))),
            data: (receipts) {
              if (receipts.isEmpty) {
                return const EmptyState(
                  icon: Icons.receipt_outlined,
                  title: 'No receipts yet',
                  message: 'Paid orders will show up here.',
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.sm),
                itemCount: receipts.length,
                separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.xs),
                itemBuilder: (context, index) {
                  final receipt = receipts[index];
                  return AppCard(
                    onTap: () => context.push(AppRoutes.receiptDetailPath(receipt.id)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                receipt.customerName?.isNotEmpty == true
                                    ? receipt.customerName!
                                    : 'Receipt #${receipt.id}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                DateFormat.yMMMd().add_jm().format(receipt.createdAt),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Text(receipt.total.toStringAsFixed(2), style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
