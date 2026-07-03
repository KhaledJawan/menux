import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

/// Standard error-state layout: simple explanation + retry.
/// Never expose technical error details here. See DesignGD.md → Error States.
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    this.message = "Something went wrong.",
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.md),
              OutlinedButton(
                onPressed: onRetry,
                child: const Text("Retry"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
