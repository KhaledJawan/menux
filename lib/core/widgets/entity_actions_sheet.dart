import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'app_bottom_sheet.dart';

/// Standard "Edit / Delete" action sheet for a list-item's overflow menu.
/// Reused by every management screen (branches, halls, tables, staff,
/// menu categories/items) instead of each re-implementing it.
Future<void> showEntityActionsSheet({
  required BuildContext context,
  required VoidCallback onEdit,
  required VoidCallback onDelete,
  String editLabel = 'Edit',
  String deleteLabel = 'Delete',
}) {
  return showAppBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.edit_outlined),
          title: Text(editLabel),
          onTap: () {
            Navigator.of(context).pop();
            onEdit();
          },
        ),
        ListTile(
          leading: const Icon(Icons.delete_outline_rounded, color: AppColors.danger),
          title: Text(deleteLabel, style: const TextStyle(color: AppColors.danger)),
          onTap: () {
            Navigator.of(context).pop();
            onDelete();
          },
        ),
      ],
    ),
  );
}
