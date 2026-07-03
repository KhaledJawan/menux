import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/staff_repository.dart';

Future<void> showStaffFormSheet(
  BuildContext context, {
  required int restaurantId,
  StaffMember? initial,
}) {
  return showAppBottomSheet(
    context: context,
    builder: (context) => _StaffFormSheet(restaurantId: restaurantId, initial: initial),
  );
}

class _StaffFormSheet extends ConsumerStatefulWidget {
  const _StaffFormSheet({required this.restaurantId, this.initial});

  final int restaurantId;
  final StaffMember? initial;

  @override
  ConsumerState<_StaffFormSheet> createState() => _StaffFormSheetState();
}

class _StaffFormSheetState extends ConsumerState<_StaffFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.initial?.name);
  late final _phoneController = TextEditingController(text: widget.initial?.phone);
  late final _pinController = TextEditingController(text: widget.initial?.pin);
  late StaffRole _role =
      widget.initial != null ? StaffRole.values.byName(widget.initial!.role) : StaffRole.waiter;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final repo = ref.read(staffRepositoryProvider);
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim();
    final pin = _pinController.text.trim().isEmpty ? null : _pinController.text.trim();

    if (widget.initial == null) {
      await repo.create(restaurantId: widget.restaurantId, name: name, phone: phone, role: _role, pin: pin);
    } else {
      await repo.update(widget.initial!.copyWith(
        name: name,
        phone: Value(phone),
        role: _role.name,
        pin: Value(pin),
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
          Text(isEdit ? 'Edit Staff Member' : 'Add Staff Member', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _nameController,
            label: 'Name',
            autofocus: !isEdit,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter a name' : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(controller: _phoneController, label: 'Phone', keyboardType: TextInputType.phone),
          const SizedBox(height: AppSpacing.sm),
          DropdownButtonFormField<StaffRole>(
            initialValue: _role,
            decoration: const InputDecoration(labelText: 'Role'),
            items: [for (final role in StaffRole.values) DropdownMenuItem(value: role, child: Text(role.label))],
            onChanged: (value) => setState(() => _role = value ?? _role),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _pinController,
            label: 'PIN (optional)',
            hint: '4-digit code to check in as this person',
            obscureText: true,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) return null;
              return RegExp(r'^\d{4}$').hasMatch(value) ? null : 'PIN must be 4 digits';
            },
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(label: isEdit ? 'Save Changes' : 'Add Staff Member', isLoading: _isSaving, onPressed: _submit),
        ],
      ),
    );
  }
}
