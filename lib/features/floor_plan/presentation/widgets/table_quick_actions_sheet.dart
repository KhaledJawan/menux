import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/session/current_staff_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../orders/presentation/actions/open_table_action.dart';
import '../../../tables/data/service_table_repository.dart';
import '../../../tables/presentation/widgets/table_form_sheet.dart';
import '../../../tables/presentation/widgets/table_status_picker_sheet.dart';
import 'resize_table_sheet.dart';
import 'rotate_table_sheet.dart';

/// Single-tap quick actions for a table on the floor plan canvas. Open/
/// change-status stay available to any checked-in staff; edit/resize/
/// rotate/duplicate/delete are structural changes, so they're gated to the
/// Owner — same rule as the rest of the hall/table setup screens.
Future<void> showTableQuickActionsSheet(
  BuildContext context,
  WidgetRef ref, {
  required ServiceTable table,
  required int branchId,
}) {
  final isOwner = ref.read(isOwnerProvider);
  final status = TableStatus.values.byName(table.status);

  return showAppBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(table.name, style: Theme.of(context).textTheme.titleLarge),
        ),
        ListTile(
          leading: const Icon(Icons.receipt_long_outlined),
          title: const Text('Open Table'),
          onTap: () {
            Navigator.of(context).pop();
            openTableAndNavigate(context, ref, branchId: branchId, hallId: table.hallId, tableId: table.id);
          },
        ),
        ListTile(
          leading: const Icon(Icons.sync_alt_rounded),
          title: const Text('Change Status'),
          onTap: () {
            Navigator.of(context).pop();
            showTableStatusPickerSheet(context, tableId: table.id, current: status);
          },
        ),
        if (isOwner) ...[
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Edit Table'),
            onTap: () {
              Navigator.of(context).pop();
              showTableFormSheet(context, hallId: table.hallId, initial: table);
            },
          ),
          ListTile(
            leading: const Icon(Icons.aspect_ratio_rounded),
            title: const Text('Resize'),
            onTap: () {
              Navigator.of(context).pop();
              showResizeTableSheet(context, table: table);
            },
          ),
          ListTile(
            leading: const Icon(Icons.rotate_right_rounded),
            title: const Text('Rotate'),
            onTap: () {
              Navigator.of(context).pop();
              showRotateTableSheet(context, table: table);
            },
          ),
          ListTile(
            leading: const Icon(Icons.copy_all_outlined),
            title: const Text('Duplicate'),
            onTap: () async {
              Navigator.of(context).pop();
              await ref.read(serviceTableRepositoryProvider).duplicate(table);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline_rounded, color: AppColors.danger),
            title: const Text('Delete', style: TextStyle(color: AppColors.danger)),
            onTap: () async {
              Navigator.of(context).pop();
              final confirmed = await confirmDelete(context, title: 'Delete ${table.name}?');
              if (confirmed) {
                await ref.read(serviceTableRepositoryProvider).delete(table.id);
              }
            },
          ),
        ],
      ],
    ),
  );
}
