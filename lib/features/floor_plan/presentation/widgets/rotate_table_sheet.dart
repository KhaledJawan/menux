import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../tables/data/service_table_repository.dart';

Future<void> showRotateTableSheet(BuildContext context, {required ServiceTable table}) {
  return showAppBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (context) => _RotateTableSheet(table: table),
  );
}

class _RotateTableSheet extends ConsumerStatefulWidget {
  const _RotateTableSheet({required this.table});

  final ServiceTable table;

  @override
  ConsumerState<_RotateTableSheet> createState() => _RotateTableSheetState();
}

class _RotateTableSheetState extends ConsumerState<_RotateTableSheet> {
  late double _rotation = widget.table.rotation;
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shape = TableShape.values.byName(widget.table.shape);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Rotate ${widget.table.name}', style: theme.textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),
        Center(
          child: SizedBox(
            width: 140,
            height: 140,
            child: Center(
              child: Transform.rotate(
                angle: _rotation * math.pi / 180,
                child: Container(
                  width: widget.table.width.clamp(0, 120),
                  height: widget.table.height.clamp(0, 100),
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
        ),
        const SizedBox(height: AppSpacing.md),
        Text('Rotation: ${_rotation.round()}°', style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
        Slider(
          value: _rotation,
          min: 0,
          max: 359,
          onChanged: (value) => setState(() => _rotation = value),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: AppSpacing.xs,
          children: [
            for (final angle in [0.0, 45.0, 90.0, 135.0, 180.0])
              OutlinedButton(
                onPressed: () => setState(() => _rotation = angle),
                child: Text('${angle.round()}°'),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'Save Rotation',
          isLoading: _isSaving,
          onPressed: () async {
            setState(() => _isSaving = true);
            await ref.read(serviceTableRepositoryProvider).updateLayout(widget.table.id, rotation: _rotation);
            if (context.mounted) Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
