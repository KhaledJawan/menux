import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/menu_variant_repository.dart';

Future<void> showMenuVariantFormSheet(
  BuildContext context, {
  required int itemId,
  MenuVariant? initial,
}) {
  return showAppBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (context) => _MenuVariantFormSheet(itemId: itemId, initial: initial),
  );
}

class _MenuVariantFormSheet extends ConsumerStatefulWidget {
  const _MenuVariantFormSheet({required this.itemId, this.initial});

  final int itemId;
  final MenuVariant? initial;

  @override
  ConsumerState<_MenuVariantFormSheet> createState() => _MenuVariantFormSheetState();
}

class _MenuVariantFormSheetState extends ConsumerState<_MenuVariantFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.initial?.name);
  late final _priceDeltaController =
      TextEditingController(text: (widget.initial?.priceDelta ?? 0).toString());
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceDeltaController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final repo = ref.read(menuVariantRepositoryProvider);
    final name = _nameController.text.trim();
    final priceDelta = double.tryParse(_priceDeltaController.text.trim()) ?? 0;

    if (widget.initial == null) {
      await repo.create(itemId: widget.itemId, name: name, priceDelta: priceDelta);
    } else {
      await repo.update(widget.initial!.copyWith(name: name, priceDelta: priceDelta));
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
          Text(isEdit ? 'Edit Variant' : 'Add Variant', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _nameController,
            label: 'Variant name',
            hint: 'Large, Double Patty…',
            autofocus: !isEdit,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter a variant name' : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _priceDeltaController,
            label: 'Price adjustment',
            hint: '0.00',
            keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(label: isEdit ? 'Save Changes' : 'Add Variant', isLoading: _isSaving, onPressed: _submit),
        ],
      ),
    );
  }
}
