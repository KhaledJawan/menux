import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/domain/table_size_presets.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../tables/data/service_table_repository.dart';

Future<void> showResizeTableSheet(BuildContext context, {required ServiceTable table}) {
  return showAppBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (context) => _ResizeTableSheet(table: table),
  );
}

class _ResizeTableSheet extends ConsumerStatefulWidget {
  const _ResizeTableSheet({required this.table});

  final ServiceTable table;

  @override
  ConsumerState<_ResizeTableSheet> createState() => _ResizeTableSheetState();
}

class _ResizeTableSheetState extends ConsumerState<_ResizeTableSheet> {
  late double _width = widget.table.width;
  late double _height = widget.table.height;
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shape = TableShape.values.byName(widget.table.shape);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Resize ${widget.table.name}', style: theme.textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),
        Center(
          child: SizedBox(
            width: 140,
            height: 140,
            child: Center(
              child: Container(
                width: _width.clamp(TableSizePresets.minSize, 120),
                height: _height.clamp(TableSizePresets.minSize, 120),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  border: Border.all(color: theme.colorScheme.primary, width: 1.5),
                  borderRadius: shape == TableShape.circle || shape == TableShape.oval
                      ? BorderRadius.circular(1000)
                      : BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text('Width: ${_width.round()}', style: theme.textTheme.bodyMedium),
        Slider(
          value: _width.clamp(TableSizePresets.minSize, TableSizePresets.maxSize),
          min: TableSizePresets.minSize,
          max: TableSizePresets.maxSize,
          onChanged: (value) => setState(() => _width = value),
        ),
        Text('Height: ${_height.round()}', style: theme.textTheme.bodyMedium),
        Slider(
          value: _height.clamp(TableSizePresets.minSize, TableSizePresets.maxSize),
          min: TableSizePresets.minSize,
          max: TableSizePresets.maxSize,
          onChanged: (value) => setState(() => _height = value),
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'Save Size',
          isLoading: _isSaving,
          onPressed: () async {
            setState(() => _isSaving = true);
            await ref
                .read(serviceTableRepositoryProvider)
                .updateLayout(widget.table.id, width: _width, height: _height);
            if (context.mounted) Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
