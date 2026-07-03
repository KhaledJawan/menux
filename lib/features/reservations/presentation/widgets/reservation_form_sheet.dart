import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../halls/data/hall_repository.dart';
import '../../../tables/data/service_table_repository.dart';
import '../../data/reservation_repository.dart';

Future<void> showReservationFormSheet(
  BuildContext context, {
  required int branchId,
  Reservation? initial,
  int? initialHallId,
  int? initialTableId,
}) {
  return showAppBottomSheet(
    context: context,
    builder: (context) => _ReservationFormSheet(
      branchId: branchId,
      initial: initial,
      initialHallId: initialHallId,
      initialTableId: initialTableId,
    ),
  );
}

class _ReservationFormSheet extends ConsumerStatefulWidget {
  const _ReservationFormSheet({
    required this.branchId,
    this.initial,
    this.initialHallId,
    this.initialTableId,
  });

  final int branchId;
  final Reservation? initial;

  /// Pre-selects the hall/table pickers when creating a reservation from
  /// the "Reserve This Table" quick action, instead of starting blank.
  final int? initialHallId;
  final int? initialTableId;

  @override
  ConsumerState<_ReservationFormSheet> createState() => _ReservationFormSheetState();
}

class _ReservationFormSheetState extends ConsumerState<_ReservationFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.initial?.customerName);
  late final _phoneController = TextEditingController(text: widget.initial?.phone);
  late final _guestCountController =
      TextEditingController(text: (widget.initial?.guestCount ?? 2).toString());
  late final _notesController = TextEditingController(text: widget.initial?.notes);
  late DateTime _date = widget.initial?.date ?? DateTime.now();
  late TimeOfDay _time = _parseTime(widget.initial?.time) ?? const TimeOfDay(hour: 19, minute: 0);
  late int? _tableId = widget.initial?.tableId ?? widget.initialTableId;
  late int? _hallId = widget.initialHallId;
  late bool _hallResolvedFromInitialTable = widget.initialHallId != null;
  bool _isSaving = false;

  static TimeOfDay? _parseTime(String? value) {
    if (value == null) return null;
    final parts = value.split(':');
    if (parts.length != 2) return null;
    return TimeOfDay(hour: int.tryParse(parts[0]) ?? 19, minute: int.tryParse(parts[1]) ?? 0);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _guestCountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final repo = ref.read(reservationRepositoryProvider);
    final timeString =
        '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}';
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim();
    final notes = _notesController.text.trim().isEmpty ? null : _notesController.text.trim();
    final guestCount = int.tryParse(_guestCountController.text.trim()) ?? 2;

    if (widget.initial == null) {
      await repo.create(
        branchId: widget.branchId,
        tableId: _tableId,
        customerName: name,
        phone: phone,
        date: _date,
        time: timeString,
        guestCount: guestCount,
        notes: notes,
      );
    } else {
      await repo.update(widget.initial!.copyWith(
        tableId: Value(_tableId),
        customerName: name,
        phone: Value(phone),
        date: _date,
        time: timeString,
        guestCount: guestCount,
        notes: Value(notes),
      ));
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initial != null;
    final hallsAsync = ref.watch(hallsForBranchProvider(widget.branchId));
    final tablesAsync = ref.watch(tablesForBranchProvider(widget.branchId));

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(isEdit ? 'Edit Reservation' : 'Add Reservation', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _nameController,
            label: 'Customer name',
            autofocus: !isEdit,
            validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter a customer name' : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(controller: _phoneController, label: 'Phone', keyboardType: TextInputType.phone),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _pickDate,
                  child: Text(DateFormat.yMMMd().format(_date)),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: OutlinedButton(
                  onPressed: _pickTime,
                  child: Text(_time.format(context)),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _guestCountController,
            label: 'Guest count',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildTablePicker(context, hallsAsync, tablesAsync),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(controller: _notesController, label: 'Notes', maxLines: 2),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            label: isEdit ? 'Save Changes' : 'Add Reservation',
            isLoading: _isSaving,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }

  /// Hall-first table picker: choosing a hall narrows the table dropdown to
  /// just that hall's tables, and each hall shows how many of its tables
  /// are currently free — picking a table out of every table in the branch
  /// at once didn't scale past a couple of halls.
  Widget _buildTablePicker(
    BuildContext context,
    AsyncValue<List<Hall>> hallsAsync,
    AsyncValue<List<ServiceTable>> tablesAsync,
  ) {
    final halls = hallsAsync.value;
    final tables = tablesAsync.value;
    if (halls == null || tables == null) return const SizedBox.shrink();

    if (!_hallResolvedFromInitialTable) {
      _hallResolvedFromInitialTable = true;
      if (widget.initial?.tableId != null) {
        final match = tables.where((t) => t.id == widget.initial!.tableId);
        if (match.isNotEmpty) _hallId = match.first.hallId;
      }
    }

    final tablesInHall = tables.where((t) => t.hallId == _hallId).toList();
    final selectedTableStillInHall = tablesInHall.any((t) => t.id == _tableId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<int?>(
          initialValue: _hallId,
          decoration: const InputDecoration(labelText: 'Hall / Area'),
          items: [
            const DropdownMenuItem(value: null, child: Text('Select a hall')),
            for (final hall in halls)
              DropdownMenuItem(
                value: hall.id,
                child: Text(
                  '${hall.name} (${tables.where((t) => t.hallId == hall.id && t.status == TableStatus.available.name).length} free)',
                ),
              ),
          ],
          onChanged: (value) => setState(() {
            _hallId = value;
            _tableId = null;
          }),
        ),
        const SizedBox(height: AppSpacing.sm),
        DropdownButtonFormField<int?>(
          // DropdownButtonFormField only honors `initialValue` on its first
          // build — it won't pick up _tableId being reset from the *hall*
          // dropdown's onChanged above. Keying on the selected hall forces
          // a fresh field (and a fresh initialValue read) whenever it
          // changes.
          key: ValueKey(_hallId),
          initialValue: selectedTableStillInHall ? _tableId : null,
          decoration: const InputDecoration(labelText: 'Table (optional)'),
          items: [
            const DropdownMenuItem(value: null, child: Text('No table assigned')),
            for (final table in tablesInHall)
              DropdownMenuItem(
                value: table.id,
                child: Text(
                  table.status == TableStatus.available.name
                      ? table.name
                      : '${table.name} (${TableStatus.values.byName(table.status).label})',
                ),
              ),
          ],
          onChanged: _hallId == null ? null : (value) => setState(() => _tableId = value),
        ),
      ],
    );
  }
}
