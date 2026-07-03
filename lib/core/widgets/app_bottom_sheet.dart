import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

/// Shows the app's standard bottom sheet: drag handle, rounded top corners,
/// drag-to-dismiss. Preferred over pushing a new page for Add/Edit/Quick
/// Settings/Comments/Discounts/Variants. See DesignGD.md → Bottom Sheets.
Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    showDragHandle: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.sm,
            0,
            AppSpacing.sm,
            AppSpacing.sm,
          ),
          // Forms with several fields (or a shrunk viewport once the
          // keyboard opens) can exceed the sheet's available height —
          // without this, content overflows instead of scrolling.
          child: SingleChildScrollView(child: builder(context)),
        ),
      ),
    ),
  );
}
