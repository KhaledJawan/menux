import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/menu_category_repository.dart';

Future<void> showMenuCategoryFormSheet(
  BuildContext context, {
  required int restaurantId,
  required int menuId,
  MenuCategory? initial,
}) {
  return showAppBottomSheet(
    context: context,
    builder: (context) => _MenuCategoryFormSheet(restaurantId: restaurantId, menuId: menuId, initial: initial),
  );
}

class _MenuCategoryFormSheet extends ConsumerStatefulWidget {
  const _MenuCategoryFormSheet({required this.restaurantId, required this.menuId, this.initial});

  final int restaurantId;
  final int menuId;
  final MenuCategory? initial;

  @override
  ConsumerState<_MenuCategoryFormSheet> createState() => _MenuCategoryFormSheetState();
}

class _MenuCategoryFormSheetState extends ConsumerState<_MenuCategoryFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.initial?.name);
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final repo = ref.read(menuCategoryRepositoryProvider);
    final name = _nameController.text.trim();

    if (widget.initial == null) {
      await repo.create(restaurantId: widget.restaurantId, menuId: widget.menuId, name: name);
    } else {
      await repo.update(widget.initial!.copyWith(name: name));
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
          Text(isEdit ? 'Edit Category' : 'Add Category', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _nameController,
            label: 'Category name',
            hint: 'Starters, Mains, Drinks…',
            autofocus: !isEdit,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter a category name' : null,
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(label: isEdit ? 'Save Changes' : 'Add Category', isLoading: _isSaving, onPressed: _submit),
        ],
      ),
    );
  }
}
