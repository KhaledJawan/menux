import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_state.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../payments/presentation/widgets/payment_form_sheet.dart';
import '../../../restaurant/data/restaurant_repository.dart';
import '../../data/order_repository.dart';
import '../widgets/menu_item_picker_sheet.dart';

const Map<OrderStatus, Color> orderStatusColors = {
  OrderStatus.draft: AppColors.gray400,
  OrderStatus.sent: AppColors.info,
  OrderStatus.preparing: AppColors.warning,
  OrderStatus.ready: AppColors.success,
  OrderStatus.delivered: AppColors.statusCleaning,
  OrderStatus.cancelled: AppColors.danger,
  OrderStatus.paid: AppColors.gray600,
};

class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({super.key, required this.orderId});

  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(orderByIdProvider(orderId));

    return Scaffold(
      appBar: AppBar(title: const Text('Order')),
      body: orderAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(orderByIdProvider(orderId))),
        data: (order) {
          if (order == null) {
            return const ErrorState(message: 'This order no longer exists.');
          }
          return _OrderDetailBody(order: order);
        },
      ),
    );
  }
}

class _OrderDetailBody extends ConsumerWidget {
  const _OrderDetailBody({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final itemsAsync = ref.watch(orderItemsProvider(order.id));
    final status = OrderStatus.values.byName(order.status);

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.sm),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      order.customerName?.isNotEmpty == true ? order.customerName! : 'Walk-in guest',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  StatusBadge(label: status.label, color: orderStatusColors[status]!),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              itemsAsync.when(
                loading: () => const LoadingState(),
                error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(orderItemsProvider(order.id))),
                data: (items) {
                  if (items.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                      child: Text(
                        'No items yet. Tap "Add Item" to start building the order.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: [for (final item in items) _OrderItemRow(item: item, editable: status == OrderStatus.draft)],
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xs),
              if (status == OrderStatus.draft)
                AppButton(
                  label: 'Add Item',
                  variant: AppButtonVariant.secondary,
                  onPressed: () => showMenuItemPickerSheet(
                    context,
                    restaurantId: ref.read(currentRestaurantProvider).value?.id ?? 0,
                    onPicked: (item, variant) => ref.read(orderRepositoryProvider).addItem(
                          orderId: order.id,
                          menuItem: item,
                          variant: variant,
                        ),
                  ),
                ),
              const SizedBox(height: AppSpacing.md),
              AppCard(
                onTap: status == OrderStatus.draft ? () => _editComment(context, ref, order) : null,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        order.comment?.isNotEmpty == true ? order.comment! : 'No order comment',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    if (status == OrderStatus.draft) const Icon(Icons.edit_outlined, size: 18),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _TotalsSummary(order: order),
            ],
          ),
        ),
        _ActionBar(order: order, status: status),
      ],
    );
  }

  void _editComment(BuildContext context, WidgetRef ref, Order order) {
    final controller = TextEditingController(text: order.comment);
    showAppBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Order Comment', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(controller: controller, label: 'Comment', maxLines: 3, autofocus: true),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Save',
            onPressed: () async {
              await ref.read(orderRepositoryProvider).updateComment(
                    order.id,
                    controller.text.trim().isEmpty ? null : controller.text.trim(),
                  );
              if (context.mounted) Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class _TotalsSummary extends StatelessWidget {
  const _TotalsSummary({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _totalsRow(theme, 'Subtotal', order.subtotal),
          if (order.discount > 0) _totalsRow(theme, 'Discount', -order.discount),
          _totalsRow(theme, 'Tax', order.tax),
          if (order.tip > 0) _totalsRow(theme, 'Tip', order.tip),
          const Divider(height: AppSpacing.md),
          _totalsRow(theme, 'Total', order.total, emphasize: true),
        ],
      ),
    );
  }

  Widget _totalsRow(ThemeData theme, String label, double value, {bool emphasize = false}) {
    final style = emphasize ? theme.textTheme.titleMedium : theme.textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value.toStringAsFixed(2), style: style),
        ],
      ),
    );
  }
}

class _ActionBar extends ConsumerWidget {
  const _ActionBar({required this.order, required this.status});

  final Order order;
  final OrderStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: switch (status) {
          OrderStatus.draft => AppButton(
              label: 'Send Order',
              onPressed: () => ref.read(orderRepositoryProvider).submit(order.id),
            ),
          OrderStatus.sent || OrderStatus.preparing || OrderStatus.ready || OrderStatus.delivered =>
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Cancel Order',
                    variant: AppButtonVariant.danger,
                    onPressed: () async {
                      final confirmed = await confirmDelete(
                        context,
                        title: 'Cancel this order?',
                        message: 'This cannot be undone.',
                      );
                      if (confirmed) {
                        await ref.read(orderRepositoryProvider).updateStatus(order.id, OrderStatus.cancelled);
                      }
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: AppButton(label: 'Pay', onPressed: () => showPaymentFormSheet(context, order: order)),
                ),
              ],
            ),
          OrderStatus.paid => const Center(child: Text('This order has been paid.')),
          OrderStatus.cancelled => const Center(child: Text('This order was cancelled.')),
        },
      ),
    );
  }
}

class _OrderItemRow extends ConsumerWidget {
  const _OrderItemRow({required this.item, required this.editable});

  final OrderItem item;
  final bool editable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: AppCard(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.variantName != null ? '${item.itemName} · ${item.variantName}' : item.itemName,
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    '${item.unitPrice.toStringAsFixed(2)} each',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  if (item.comment != null && item.comment!.isNotEmpty)
                    Text(
                      item.comment!,
                      style: theme.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                    ),
                ],
              ),
            ),
            if (editable) ...[
              IconButton(
                icon: const Icon(Icons.remove_circle_outline_rounded),
                onPressed: () => ref.read(orderRepositoryProvider).updateItemQuantity(item.id, item.quantity - 1),
              ),
              Text('${item.quantity}', style: theme.textTheme.bodyLarge),
              IconButton(
                icon: const Icon(Icons.add_circle_outline_rounded),
                onPressed: () => ref.read(orderRepositoryProvider).updateItemQuantity(item.id, item.quantity + 1),
              ),
            ] else
              Text('x${item.quantity}', style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
