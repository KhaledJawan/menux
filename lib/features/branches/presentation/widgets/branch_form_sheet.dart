import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/branch_repository.dart';

Future<void> showBranchFormSheet(
  BuildContext context, {
  required int restaurantId,
  Branch? initial,
}) {
  return showAppBottomSheet(
    context: context,
    builder: (context) => _BranchFormSheet(restaurantId: restaurantId, initial: initial),
  );
}

class _BranchFormSheet extends ConsumerStatefulWidget {
  const _BranchFormSheet({required this.restaurantId, this.initial});

  final int restaurantId;
  final Branch? initial;

  @override
  ConsumerState<_BranchFormSheet> createState() => _BranchFormSheetState();
}

class _BranchFormSheetState extends ConsumerState<_BranchFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.initial?.name);
  late final _addressController = TextEditingController(text: widget.initial?.address);
  late final _openController = TextEditingController(text: widget.initial?.workingHoursOpen);
  late final _closeController = TextEditingController(text: widget.initial?.workingHoursClose);
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _openController.dispose();
    _closeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final repo = ref.read(branchRepositoryProvider);
    final name = _nameController.text.trim();
    final address = _addressController.text.trim().isEmpty ? null : _addressController.text.trim();
    final open = _openController.text.trim().isEmpty ? null : _openController.text.trim();
    final close = _closeController.text.trim().isEmpty ? null : _closeController.text.trim();

    if (widget.initial == null) {
      await repo.create(
        restaurantId: widget.restaurantId,
        name: name,
        address: address,
        workingHoursOpen: open,
        workingHoursClose: close,
      );
    } else {
      await repo.update(widget.initial!.copyWith(
        name: name,
        address: Value(address),
        workingHoursOpen: Value(open),
        workingHoursClose: Value(close),
      ));
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
          Text(isEdit ? 'Edit Branch' : 'Add Branch', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _nameController,
            label: 'Branch name',
            autofocus: !isEdit,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter a branch name' : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(controller: _addressController, label: 'Address'),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(child: AppTextField(controller: _openController, label: 'Opens', hint: '09:00')),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: AppTextField(controller: _closeController, label: 'Closes', hint: '23:00')),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(label: isEdit ? 'Save Changes' : 'Add Branch', isLoading: _isSaving, onPressed: _submit),
        ],
      ),
    );
  }
}
