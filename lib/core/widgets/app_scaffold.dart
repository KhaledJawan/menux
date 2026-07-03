import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

/// Enforces the standard screen structure from DesignGD.md → Screen
/// Structure: Page Title → optional search → optional filters → content →
/// optional FAB. Every screen should be built on this instead of a raw
/// [Scaffold] so the app never produces an inconsistent layout.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.search,
    this.filters,
    this.floatingActionButton,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;

  /// Optional search field, placed directly under the app bar.
  final Widget? search;

  /// Optional filter chips row, placed under search (or under the app bar
  /// if there's no search).
  final Widget? filters;

  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      floatingActionButton: floatingActionButton,
      body: Column(
        children: [
          if (search != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                AppSpacing.xs,
                AppSpacing.sm,
                0,
              ),
              child: search,
            ),
          if (filters != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                AppSpacing.xs,
                AppSpacing.sm,
                0,
              ),
              child: filters,
            ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
