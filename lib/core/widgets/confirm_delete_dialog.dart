import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Delete-confirmation dialog. Per DesignGD.md → Dialogs, dialogs are used
/// only for destructive/critical confirmations — everything else is a
/// bottom sheet.
Future<bool> confirmDelete(
  BuildContext context, {
  required String title,
  String? message,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: message != null ? Text(message) : null,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Delete', style: TextStyle(color: AppColors.danger)),
        ),
      ],
    ),
  );
  return result ?? false;
}
