import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import 'app_card.dart';
import 'skeleton_box.dart';

/// Skeleton loader for a screen still fetching data. Avoid fullscreen
/// spinners. See DesignGD.md → Loading States.
class LoadingState extends StatelessWidget {
  const LoadingState({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.sm),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) => const AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonBox(width: 140, height: 18),
            SizedBox(height: AppSpacing.xs),
            SkeletonBox(width: 90, height: 14),
          ],
        ),
      ),
    );
  }
}
