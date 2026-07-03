import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/menu_repository.dart';

Future<void> showMenuFormSheet(
  BuildContext context, {
  required int restaurantId,
  RestaurantMenu? initial,
}) {
  return showAppBottomSheet(
    context: context,
    builder: (context) => _MenuFormSheet(restaurantId: restaurantId, initial: initial),
  );
}

class _MenuFormSheet extends ConsumerStatefulWidget {
  const _MenuFormSheet({required this.restaurantId, this.initial});

  final int restaurantId;
  final RestaurantMenu? initial;

  @override
  ConsumerState<_MenuFormSheet> createState() => _MenuFormSheetState();
}

class _MenuFormSheetState extends ConsumerState<_MenuFormSheet> {
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
    final repo = ref.read(menuRepositoryProvider);
    final name = _nameController.text.trim();

    if (widget.initial == null) {
      await repo.create(restaurantId: widget.restaurantId, name: name);
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
          Text(isEdit ? 'Rename Menu' : 'Add Menu', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _nameController,
            label: 'Menu name',
            hint: 'Breakfast Menu, Drinks Menu, Holiday Specials…',
            autofocus: true,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter a menu name' : null,
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(label: isEdit ? 'Save Changes' : 'Add Menu', isLoading: _isSaving, onPressed: _submit),
        ],
      ),
    );
  }
}
