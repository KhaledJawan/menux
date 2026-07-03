import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

/// Reusable card shell: consistent radius, border, padding and tap ripple.
/// Feature cards (table, order, menu item...) compose their own content
/// inside this shell rather than re-implementing the container.
/// See DesignGD.md → Cards.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.padding = const EdgeInsets.all(AppSpacing.sm),
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shape = theme.cardTheme.shape as RoundedRectangleBorder?;
    final radius = shape?.borderRadius ?? BorderRadius.circular(AppRadius.card);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        customBorder: RoundedRectangleBorder(borderRadius: radius),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
