import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../data/menu_item_repository.dart';
import '../../data/menu_variant_repository.dart';
import 'image_picker_field.dart';
import 'menu_variant_form_sheet.dart';

Future<void> showMenuItemFormSheet(
  BuildContext context, {
  required int categoryId,
  MenuItem? initial,
}) {
  return showAppBottomSheet(
    context: context,
    builder: (context) => _MenuItemFormSheet(categoryId: categoryId, initial: initial),
  );
}

class _MenuItemFormSheet extends ConsumerStatefulWidget {
  const _MenuItemFormSheet({required this.categoryId, this.initial});

  final int categoryId;
  final MenuItem? initial;

  @override
  ConsumerState<_MenuItemFormSheet> createState() => _MenuItemFormSheetState();
}

class _MenuItemFormSheetState extends ConsumerState<_MenuItemFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.initial?.name);
  late final _descriptionController = TextEditingController(text: widget.initial?.description);
  late final _priceController = TextEditingController(text: (widget.initial?.price ?? 0).toString());
  late final _taxController = TextEditingController(text: (widget.initial?.taxPercent ?? 0).toString());
  late String? _imagePath = widget.initial?.imagePath;
  late bool _isDrink = widget.initial?.isDrink ?? false;
  late bool _isAvailable = widget.initial?.isAvailable ?? true;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _taxController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final repo = ref.read(menuItemRepositoryProvider);
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim();
    final price = double.tryParse(_priceController.text.trim()) ?? 0;
    final taxPercent = double.tryParse(_taxController.text.trim()) ?? 0;
    final imagePath = _imagePath;

    if (widget.initial == null) {
      await repo.create(
        categoryId: widget.categoryId,
        name: name,
        description: description,
        price: price,
        taxPercent: taxPercent,
        isDrink: _isDrink,
        imagePath: imagePath,
      );
      if (mounted) Navigator.of(context).pop();
    } else {
      await repo.update(widget.initial!.copyWith(
        name: name,
        description: Value(description),
        price: price,
        taxPercent: taxPercent,
        isDrink: _isDrink,
        isAvailable: _isAvailable,
        imagePath: Value(imagePath),
      ));
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initial != null;
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(isEdit ? 'Edit Item' : 'Add Item', style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _nameController,
            label: 'Item name',
            autofocus: !isEdit,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter an item name' : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(controller: _descriptionController, label: 'Description', maxLines: 2),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: _priceController,
                  label: 'Price',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) =>
                      (double.tryParse(value ?? '') == null) ? 'Enter a price' : null,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppTextField(
                  controller: _taxController,
                  label: 'Tax %',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ImagePickerField(imagePath: _imagePath, onChanged: (value) => setState(() => _imagePath = value)),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: false, label: Text('Food')),
                    ButtonSegment(value: true, label: Text('Drink')),
                  ],
                  selected: {_isDrink},
                  onSelectionChanged: (value) => setState(() => _isDrink = value.first),
                ),
              ),
            ],
          ),
          if (isEdit) ...[
            const SizedBox(height: AppSpacing.sm),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Available'),
              value: _isAvailable,
              onChanged: (value) => setState(() => _isAvailable = value),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          AppButton(label: isEdit ? 'Save Changes' : 'Add Item', isLoading: _isSaving, onPressed: _submit),
          if (isEdit) ...[
            const SizedBox(height: AppSpacing.md),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Variants', style: theme.textTheme.titleMedium),
            ),
            const SizedBox(height: AppSpacing.xs),
            _VariantsList(itemId: widget.initial!.id),
            const SizedBox(height: AppSpacing.xs),
            AppButton(
              label: 'Add Variant',
              variant: AppButtonVariant.secondary,
              onPressed: () => showMenuVariantFormSheet(context, itemId: widget.initial!.id),
            ),
          ],
        ],
      ),
    );
  }
}

class _VariantsList extends ConsumerWidget {
  const _VariantsList({required this.itemId});

  final int itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final variantsAsync = ref.watch(menuVariantsForItemProvider(itemId));
    return variantsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
      data: (variants) {
        if (variants.isEmpty) {
          return Text(
            'No variants yet',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
          );
        }
        return Column(
          children: [
            for (final variant in variants)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(variant.name),
                subtitle: Text(
                  variant.priceDelta >= 0
                      ? '+${variant.priceDelta.toStringAsFixed(2)}'
                      : variant.priceDelta.toStringAsFixed(2),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      onPressed: () => showMenuVariantFormSheet(context, itemId: itemId, initial: variant),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.danger),
                      onPressed: () async {
                        final confirmed = await confirmDelete(context, title: 'Delete ${variant.name}?');
                        if (confirmed) {
                          await ref.read(menuVariantRepositoryProvider).delete(variant.id);
                        }
                      },
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
