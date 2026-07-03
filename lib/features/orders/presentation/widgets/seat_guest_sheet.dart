import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../actions/open_table_action.dart';

/// One-step walk-in flow: name is optional, so a guest with no reservation
/// can be seated with a single tap (leave it blank) or with their name
/// captured immediately (type it) — either way this is the only step,
/// instead of opening the order and hunting for somewhere to note who's
/// sitting there.
Future<void> showSeatGuestSheet(
  BuildContext context, {
  required int branchId,
  required int hallId,
  required int tableId,
  required String tableName,
}) {
  return showAppBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (context) => _SeatGuestSheet(branchId: branchId, hallId: hallId, tableId: tableId, tableName: tableName),
  );
}

class _SeatGuestSheet extends ConsumerStatefulWidget {
  const _SeatGuestSheet({
    required this.branchId,
    required this.hallId,
    required this.tableId,
    required this.tableName,
  });

  final int branchId;
  final int hallId;
  final int tableId;
  final String tableName;

  @override
  ConsumerState<_SeatGuestSheet> createState() => _SeatGuestSheetState();
}

class _SeatGuestSheetState extends ConsumerState<_SeatGuestSheet> {
  final _nameController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _isSaving = true);
    final name = _nameController.text.trim();
    Navigator.of(context).pop();
    await openTableAndNavigate(
      context,
      ref,
      branchId: widget.branchId,
      hallId: widget.hallId,
      tableId: widget.tableId,
      customerName: name.isEmpty ? null : name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Seat Guest — ${widget.tableName}', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.xs),
        Text(
          "Guest name is optional — leave it blank to seat them right away.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        AppTextField(controller: _nameController, label: 'Guest name (optional)', autofocus: true),
        const SizedBox(height: AppSpacing.md),
        AppButton(label: 'Start Order', isLoading: _isSaving, onPressed: _submit),
      ],
    );
  }
}
