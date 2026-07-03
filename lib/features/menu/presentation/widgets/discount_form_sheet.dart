import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/discount_repository.dart';

Future<void> showDiscountFormSheet(
  BuildContext context, {
  required int restaurantId,
  Discount? initial,
}) {
  return showAppBottomSheet(
    context: context,
    builder: (context) => _DiscountFormSheet(restaurantId: restaurantId, initial: initial),
  );
}

class _DiscountFormSheet extends ConsumerStatefulWidget {
  const _DiscountFormSheet({required this.restaurantId, this.initial});

  final int restaurantId;
  final Discount? initial;

  @override
  ConsumerState<_DiscountFormSheet> createState() => _DiscountFormSheetState();
}

class _DiscountFormSheetState extends ConsumerState<_DiscountFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.initial?.name);
  late final _valueController = TextEditingController(text: widget.initial?.value.toString() ?? '10');
  late DiscountType _type =
      widget.initial != null ? DiscountType.values.byName(widget.initial!.type) : DiscountType.percent;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final repo = ref.read(discountRepositoryProvider);
    final name = _nameController.text.trim();
    final value = double.tryParse(_valueController.text.trim()) ?? 0;

    if (widget.initial == null) {
      await repo.create(restaurantId: widget.restaurantId, name: name, type: _type, value: value);
    } else {
      await repo.update(widget.initial!.copyWith(name: name, type: _type.name, value: value));
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initial != null;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(isEdit ? 'Edit Discount' : 'Add Discount', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _nameController,
            label: 'Name',
            hint: 'Happy Hour, Staff Meal, VIP…',
            autofocus: !isEdit,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter a name' : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          SegmentedButton<DiscountType>(
            segments: const [
              ButtonSegment(value: DiscountType.percent, label: Text('Percent')),
              ButtonSegment(value: DiscountType.fixed, label: Text('Fixed Amount')),
            ],
            selected: {_type},
            onSelectionChanged: (value) => setState(() => _type = value.first),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _valueController,
            label: _type == DiscountType.percent ? 'Percent off' : 'Amount off',
            hint: _type == DiscountType.percent ? '10' : '5.00',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) => (double.tryParse(value ?? '') == null) ? 'Enter a value' : null,
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(label: isEdit ? 'Save Changes' : 'Add Discount', isLoading: _isSaving, onPressed: _submit),
        ],
      ),
    );
  }
}
