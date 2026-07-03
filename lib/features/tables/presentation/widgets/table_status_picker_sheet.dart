import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/enums.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../data/service_table_repository.dart';

const Map<TableStatus, Color> tableStatusColors = {
  TableStatus.available: AppColors.statusAvailable,
  TableStatus.reserved: AppColors.statusReserved,
  TableStatus.occupied: AppColors.statusOccupied,
  TableStatus.cleaning: AppColors.statusCleaning,
  TableStatus.disabled: AppColors.statusDisabled,
};

Future<void> showTableStatusPickerSheet(
  BuildContext context, {
  required int tableId,
  required TableStatus current,
}) {
  return showAppBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (context) => Consumer(
      builder: (context, ref, _) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final status in TableStatus.values)
            ListTile(
              leading: Icon(Icons.circle, size: 12, color: tableStatusColors[status]),
              title: Text(status.label),
              trailing: status == current ? const Icon(Icons.check_rounded) : null,
              onTap: () async {
                await ref.read(serviceTableRepositoryProvider).updateStatus(tableId, status);
                if (context.mounted) Navigator.of(context).pop();
              },
            ),
        ],
      ),
    ),
  );
}
