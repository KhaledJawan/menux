import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

/// Instant-filter search bar — no search button, results update as the
/// user types. See DesignGD.md → Search.
class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    this.controller,
    this.hint = 'Search',
    this.onChanged,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String hint;
  final void Function(String)? onChanged;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      onChanged: onChanged,
      autofocus: autofocus,
      textInputAction: TextInputAction.search,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: (controller != null)
            ? ListenableBuilder(
                listenable: controller!,
                builder: (context, _) => controller!.text.isEmpty
                    ? const SizedBox.shrink()
                    : IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          controller!.clear();
                          onChanged?.call('');
                        },
                      ),
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
      ),
    );
  }
}
