import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/enums.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../auth/data/auth_repository.dart';
import '../../data/message_repository.dart';

Future<void> showMessageFormSheet(BuildContext context) {
  return showAppBottomSheet(context: context, builder: (context) => const _MessageFormSheet());
}

class _MessageFormSheet extends ConsumerStatefulWidget {
  const _MessageFormSheet();

  @override
  ConsumerState<_MessageFormSheet> createState() => _MessageFormSheetState();
}

class _MessageFormSheetState extends ConsumerState<_MessageFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  StaffRole? _recipientRole;
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final senderName = ref.read(currentProfileProvider).value?.name ?? 'Team';
    await ref.read(messageRepositoryProvider).create(
          senderName: senderName,
          recipientRole: _recipientRole?.name,
          title: _titleController.text.trim(),
          body: _bodyController.text.trim(),
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('New Message', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _titleController,
            label: 'Title',
            autofocus: true,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter a title' : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _bodyController,
            label: 'Message',
            maxLines: 4,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter a message' : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          DropdownButtonFormField<StaffRole?>(
            initialValue: _recipientRole,
            decoration: const InputDecoration(labelText: 'Recipients'),
            items: [
              const DropdownMenuItem(value: null, child: Text('All staff')),
              for (final role in StaffRole.values) DropdownMenuItem(value: role, child: Text(role.label)),
            ],
            onChanged: (value) => setState(() => _recipientRole = value),
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(label: 'Send', isLoading: _isSaving, onPressed: _submit),
        ],
      ),
    );
  }
}
