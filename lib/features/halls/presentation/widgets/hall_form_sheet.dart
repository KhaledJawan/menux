import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/hall_repository.dart';

Future<void> showHallFormSheet(
  BuildContext context, {
  required int branchId,
  Hall? initial,
}) {
  return showAppBottomSheet(
    context: context,
    builder: (context) => _HallFormSheet(branchId: branchId, initial: initial),
  );
}

class _HallFormSheet extends ConsumerStatefulWidget {
  const _HallFormSheet({required this.branchId, this.initial});

  final int branchId;
  final Hall? initial;

  @override
  ConsumerState<_HallFormSheet> createState() => _HallFormSheetState();
}

class _HallFormSheetState extends ConsumerState<_HallFormSheet> {
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
    final repo = ref.read(hallRepositoryProvider);
    final name = _nameController.text.trim();

    if (widget.initial == null) {
      await repo.create(branchId: widget.branchId, name: name);
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
          Text(isEdit ? 'Edit Hall' : 'Add Hall', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _nameController,
            label: 'Hall name',
            hint: 'Main Hall, Garden, VIP Room…',
            autofocus: !isEdit,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter a hall name' : null,
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(label: isEdit ? 'Save Changes' : 'Add Hall', isLoading: _isSaving, onPressed: _submit),
        ],
      ),
    );
  }
}
