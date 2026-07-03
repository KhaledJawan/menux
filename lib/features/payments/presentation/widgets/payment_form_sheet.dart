import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../branches/data/branch_repository.dart';
import '../../../menu/data/discount_repository.dart';
import '../../data/checkout_service.dart';

Future<void> showPaymentFormSheet(BuildContext context, {required Order order}) {
  return showAppBottomSheet(
    context: context,
    builder: (context) => _PaymentFormSheet(order: order),
  );
}

class _PaymentFormSheet extends ConsumerStatefulWidget {
  const _PaymentFormSheet({required this.order});

  final Order order;

  @override
  ConsumerState<_PaymentFormSheet> createState() => _PaymentFormSheetState();
}

class _PaymentFormSheetState extends ConsumerState<_PaymentFormSheet> {
  PaymentMethod _method = PaymentMethod.cash;
  late final _discountController = TextEditingController(text: '0');
  late final _tipController = TextEditingController(text: '0');
  late final _cashController = TextEditingController();
  late final _cardController = TextEditingController();
  int? _selectedDiscountId;
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void dispose() {
    _discountController.dispose();
    _tipController.dispose();
    _cashController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  double get _discount => double.tryParse(_discountController.text.trim()) ?? 0;
  double get _tip => double.tryParse(_tipController.text.trim()) ?? 0;
  double get _estimatedTotal => widget.order.subtotal - _discount + _tip;

  void _applyDiscount(Discount? discount) {
    setState(() {
      _selectedDiscountId = discount?.id;
      _discountController.text = discount == null
          ? '0'
          : DiscountType.values
              .byName(discount.type)
              .amountFor(widget.order.subtotal, discount.value)
              .toStringAsFixed(2);
    });
  }

  Future<void> _submit() async {
    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    double cash = 0;
    double card = 0;
    switch (_method) {
      case PaymentMethod.cash:
        cash = _estimatedTotal;
      case PaymentMethod.card:
        card = _estimatedTotal;
      case PaymentMethod.mixed:
        cash = double.tryParse(_cashController.text.trim()) ?? 0;
        card = double.tryParse(_cardController.text.trim()) ?? 0;
    }

    try {
      final receipt = await ref.read(checkoutServiceProvider).pay(
            orderId: widget.order.id,
            method: _method,
            amountCash: cash,
            amountCard: card,
            discount: _discount,
            tip: _tip,
          );
      if (mounted) {
        Navigator.of(context).pop();
        context.push(AppRoutes.receiptDetailPath(receipt.id));
      }
    } catch (e) {
      setState(() => _errorMessage = 'Could not process payment. Please try again.');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final branchAsync = ref.watch(branchByIdProvider(widget.order.branchId));
    final restaurantId = branchAsync.value?.restaurantId;
    final discountsAsync =
        restaurantId == null ? null : ref.watch(activeDiscountsForRestaurantProvider(restaurantId));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Pay Order', style: theme.textTheme.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        Text('Subtotal: ${widget.order.subtotal.toStringAsFixed(2)}'),
        if (_errorMessage != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(_errorMessage!, style: TextStyle(color: theme.colorScheme.error)),
        ],
        const SizedBox(height: AppSpacing.sm),
        SegmentedButton<PaymentMethod>(
          segments: const [
            ButtonSegment(value: PaymentMethod.cash, label: Text('Cash')),
            ButtonSegment(value: PaymentMethod.card, label: Text('Card')),
            ButtonSegment(value: PaymentMethod.mixed, label: Text('Mixed')),
          ],
          selected: {_method},
          onSelectionChanged: (value) => setState(() => _method = value.first),
        ),
        if (discountsAsync != null && (discountsAsync.value?.isNotEmpty ?? false)) ...[
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            children: [
              ChoiceChip(
                label: const Text('No discount'),
                selected: _selectedDiscountId == null,
                onSelected: (_) => _applyDiscount(null),
              ),
              for (final discount in discountsAsync.value!)
                ChoiceChip(
                  label: Text(discount.name),
                  selected: _selectedDiscountId == discount.id,
                  onSelected: (_) => _applyDiscount(discount),
                ),
            ],
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: _discountController,
                label: 'Discount',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => setState(() => _selectedDiscountId = null),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppTextField(
                controller: _tipController,
                label: 'Tip',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ],
        ),
        if (_method == PaymentMethod.mixed) ...[
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: _cashController,
                  label: 'Cash amount',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppTextField(
                  controller: _cardController,
                  label: 'Card amount',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Estimated total (before tax): ${_estimatedTotal.toStringAsFixed(2)}',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(label: 'Confirm Payment', isLoading: _isSaving, onPressed: _submit),
      ],
    );
  }
}
