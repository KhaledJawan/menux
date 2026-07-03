import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_state.dart';
import '../../../orders/data/order_repository.dart';
import '../../data/receipt_repository.dart';

class ReceiptDetailScreen extends ConsumerWidget {
  const ReceiptDetailScreen({super.key, required this.receiptId});

  final int receiptId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receiptAsync = ref.watch(receiptByIdProvider(receiptId));

    return Scaffold(
      appBar: AppBar(title: const Text('Receipt')),
      body: receiptAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(receiptByIdProvider(receiptId))),
        data: (receipt) {
          if (receipt == null) {
            return const ErrorState(message: 'Receipt not found.');
          }
          final theme = Theme.of(context);
          final itemsAsync = ref.watch(orderItemsProvider(receipt.orderId));

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.sm),
            children: [
              Center(
                child: Column(
                  children: [
                    Text(receipt.restaurantName, style: theme.textTheme.titleLarge),
                    Text(receipt.branchName, style: theme.textTheme.bodyMedium),
                    if (receipt.hallName != null || receipt.serviceTableName != null)
                      Text(
                        [receipt.hallName, receipt.serviceTableName].whereType<String>().join(' · '),
                        style: theme.textTheme.bodyMedium,
                      ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(DateFormat.yMMMd().add_jm().format(receipt.createdAt), style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppCard(
                child: itemsAsync.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: LinearProgressIndicator(),
                  ),
                  error: (error, stack) => const SizedBox.shrink(),
                  data: (items) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final item in items)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Text('${item.quantity}x', style: theme.textTheme.bodyMedium),
                              const SizedBox(width: AppSpacing.xs),
                              Expanded(
                                child: Text(
                                  item.variantName != null ? '${item.itemName} · ${item.variantName}' : item.itemName,
                                ),
                              ),
                              Text((item.unitPrice * item.quantity).toStringAsFixed(2)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _row(theme, 'Subtotal', receipt.subtotal),
                    if (receipt.discount > 0) _row(theme, 'Discount', -receipt.discount),
                    _row(theme, 'Tax', receipt.tax),
                    if (receipt.tip > 0) _row(theme, 'Tip', receipt.tip),
                    const Divider(height: AppSpacing.md),
                    _row(theme, 'Total', receipt.total, emphasize: true),
                    const SizedBox(height: AppSpacing.xs),
                    _row(theme, 'Payment method', null, valueText: receipt.paymentMethod),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _row(ThemeData theme, String label, double? value, {bool emphasize = false, String? valueText}) {
    final style = emphasize ? theme.textTheme.titleMedium : theme.textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(valueText ?? value!.toStringAsFixed(2), style: style),
        ],
      ),
    );
  }
}
