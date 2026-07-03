import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/domain/table_size_presets.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/service_table_repository.dart';

Future<void> showTableFormSheet(
  BuildContext context, {
  required int hallId,
  ServiceTable? initial,
}) {
  return showAppBottomSheet(
    context: context,
    builder: (context) => _TableFormSheet(hallId: hallId, initial: initial),
  );
}

class _TableFormSheet extends ConsumerStatefulWidget {
  const _TableFormSheet({required this.hallId, this.initial});

  final int hallId;
  final ServiceTable? initial;

  @override
  ConsumerState<_TableFormSheet> createState() => _TableFormSheetState();
}

class _TableFormSheetState extends ConsumerState<_TableFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.initial?.name);
  late final _customCapacityController =
      TextEditingController(text: widget.initial?.capacity.toString());
  late final _notesController = TextEditingController(text: widget.initial?.notes);
  late final _widthController = TextEditingController(text: widget.initial?.width.toString());
  late final _heightController = TextEditingController(text: widget.initial?.height.toString());

  late TableShape _shape =
      widget.initial != null ? TableShape.values.byName(widget.initial!.shape) : TableShape.rectangle;
  late TableStatus _status =
      widget.initial != null ? TableStatus.values.byName(widget.initial!.status) : TableStatus.available;
  late int _capacity = widget.initial?.capacity ?? 2;
  late bool _isCustomCapacity =
      widget.initial != null && !TableSizePresets.capacityChoices.contains(widget.initial!.capacity);

  /// Once the user (or an edit's existing data) has touched width/height
  /// directly, stop silently overwriting their choice when shape/capacity
  /// changes — auto-sizing is a starting point, not a leash.
  late bool _sizeManuallyEdited = widget.initial != null;

  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _customCapacityController.dispose();
    _notesController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _applyAutoSize() {
    if (_sizeManuallyEdited) return;
    final size = TableSizePresets.defaultSize(_shape, _capacity);
    _widthController.text = size.$1.toStringAsFixed(0);
    _heightController.text = size.$2.toStringAsFixed(0);
  }

  @override
  void initState() {
    super.initState();
    if (!_sizeManuallyEdited) _applyAutoSize();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final repo = ref.read(serviceTableRepositoryProvider);
    final name = _nameController.text.trim();
    final notes = _notesController.text.trim().isEmpty ? null : _notesController.text.trim();
    final width = double.tryParse(_widthController.text.trim());
    final height = double.tryParse(_heightController.text.trim());

    if (widget.initial == null) {
      await repo.create(
        hallId: widget.hallId,
        name: name,
        capacity: _capacity,
        shape: _shape,
        status: _status,
        width: width,
        height: height,
        notes: notes,
      );
    } else {
      await repo.update(widget.initial!.copyWith(
        name: name,
        capacity: _capacity,
        shape: _shape.name,
        status: _status.name,
        width: width ?? widget.initial!.width,
        height: height ?? widget.initial!.height,
        notes: Value(notes),
      ));
    }
    if (mounted) Navigator.of(context).pop();
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
          Text(isEdit ? 'Edit Table' : 'Add Table', style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _nameController,
            label: 'Table name',
            hint: 'T1',
            autofocus: !isEdit,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter a table name' : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('Shape', style: theme.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            children: [
              for (final shape in TableShape.values)
                ChoiceChip(
                  label: Text(shape.label),
                  selected: _shape == shape,
                  onSelected: (_) => setState(() {
                    _shape = shape;
                    _applyAutoSize();
                  }),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('Capacity', style: theme.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            children: [
              for (final choice in TableSizePresets.capacityChoices)
                ChoiceChip(
                  label: Text('$choice'),
                  selected: !_isCustomCapacity && _capacity == choice,
                  onSelected: (_) => setState(() {
                    _isCustomCapacity = false;
                    _capacity = choice;
                    _applyAutoSize();
                  }),
                ),
              ChoiceChip(
                label: const Text('Custom'),
                selected: _isCustomCapacity,
                onSelected: (_) => setState(() => _isCustomCapacity = true),
              ),
            ],
          ),
          if (_isCustomCapacity) ...[
            const SizedBox(height: AppSpacing.sm),
            AppTextField(
              controller: _customCapacityController,
              label: 'Guest count',
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {
                _capacity = int.tryParse(value) ?? _capacity;
                _applyAutoSize();
              }),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: _widthController,
                  label: 'Width',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (_) => _sizeManuallyEdited = true,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppTextField(
                  controller: _heightController,
                  label: 'Height',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (_) => _sizeManuallyEdited = true,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          DropdownButtonFormField<TableStatus>(
            initialValue: _status,
            decoration: const InputDecoration(labelText: 'Status'),
            items: [
              for (final status in TableStatus.values)
                DropdownMenuItem(value: status, child: Text(status.label)),
            ],
            onChanged: (value) => setState(() => _status = value ?? _status),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(controller: _notesController, label: 'Notes', maxLines: 2),
          const SizedBox(height: AppSpacing.md),
          AppButton(label: isEdit ? 'Save Changes' : 'Add Table', isLoading: _isSaving, onPressed: _submit),
        ],
      ),
    );
  }
}
