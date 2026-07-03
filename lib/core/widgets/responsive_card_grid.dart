import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

/// Lays out cards in fixed-width columns whose row height matches the
/// tallest card in that row — instead of `GridView`'s `childAspectRatio`,
/// which forces every cell into the same fixed box regardless of what's
/// actually inside it. A card with a status badge, a price, or a longer
/// name (or just a larger accessibility font scale) can easily need a
/// fraction of a pixel more height than that fixed box allows, which
/// overflows instead of laying out — this doesn't have that failure mode
/// because nothing is a fixed height to begin with.
///
/// Not a scrollable itself — embed it inside a ListView/SingleChildScrollView.
class ResponsiveCardGrid extends StatelessWidget {
  const ResponsiveCardGrid({
    super.key,
    required this.children,
    this.crossAxisCount = 2,
    this.spacing = AppSpacing.sm,
  });

  final List<Widget> children;
  final int crossAxisCount;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i += crossAxisCount) {
      if (rows.isNotEmpty) rows.add(SizedBox(height: spacing));
      final rowChildren = <Widget>[];
      for (var column = 0; column < crossAxisCount; column++) {
        final index = i + column;
        if (column > 0) rowChildren.add(SizedBox(width: spacing));
        rowChildren.add(
          Expanded(child: index < children.length ? children[index] : const SizedBox.shrink()),
        );
      }
      rows.add(IntrinsicHeight(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: rowChildren)));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }
}
