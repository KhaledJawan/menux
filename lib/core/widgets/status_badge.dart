import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

/// Small status pill: a color dot plus a text label, so status is never
/// conveyed by color alone. See DesignGD.md → Status Colors, Accessibility.
///
/// Feature modules supply their own status → color mapping (e.g. table
/// status in Phase 7, order status in Phase 10) using the semantic colors
/// defined in [AppColors].
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
