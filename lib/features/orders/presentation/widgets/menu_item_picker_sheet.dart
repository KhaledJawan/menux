import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_state.dart';
import '../../../../core/widgets/responsive_card_grid.dart';
import '../../../../core/widgets/search_field.dart';
import '../../../menu/data/menu_category_repository.dart';
import '../../../menu/data/menu_item_repository.dart';
import '../../../menu/data/menu_variant_repository.dart';

typedef MenuItemPicked = void Function(MenuItem item, MenuVariant? variant);

Future<void> showMenuItemPickerSheet(
  BuildContext context, {
  required int restaurantId,
  required MenuItemPicked onPicked,
}) {
  return showAppBottomSheet(
    context: context,
    builder: (context) => _MenuItemPickerSheet(restaurantId: restaurantId, onPicked: onPicked),
  );
}

class _MenuItemPickerSheet extends ConsumerStatefulWidget {
  const _MenuItemPickerSheet({required this.restaurantId, required this.onPicked});

  final int restaurantId;
  final MenuItemPicked onPicked;

  @override
  ConsumerState<_MenuItemPickerSheet> createState() => _MenuItemPickerSheetState();
}

class _MenuItemPickerSheetState extends ConsumerState<_MenuItemPickerSheet> {
  final _searchController = TextEditingController();
  String _query = '';
  int? _selectedCategoryId;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _select(MenuItem item) async {
    final variants = await ref.read(menuVariantsForItemProvider(item.id).future);
    if (variants.isEmpty) {
      widget.onPicked(item, null);
      if (mounted) Navigator.of(context).pop();
      return;
    }
    if (!mounted) return;
    final variant = await showModalBottomSheet<MenuVariant>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.sm, 0, AppSpacing.sm, AppSpacing.xs),
              child: Text('Choose a variant', style: Theme.of(context).textTheme.titleMedium),
            ),
            for (final variant in variants)
              ListTile(
                title: Text(variant.name),
                trailing: Text(
                  variant.priceDelta >= 0
                      ? '+${variant.priceDelta.toStringAsFixed(2)}'
                      : variant.priceDelta.toStringAsFixed(2),
                ),
                onTap: () => Navigator.of(context).pop(variant),
              ),
          ],
        ),
      ),
    );
    if (variant != null) {
      widget.onPicked(item, variant);
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(activeMenuItemsForRestaurantProvider(widget.restaurantId));
    final categoriesAsync = ref.watch(activeMenuCategoriesForRestaurantProvider(widget.restaurantId));

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Add Item', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          SearchField(
            controller: _searchController,
            hint: 'Search menu items',
            onChanged: (value) => setState(() => _query = value.trim().toLowerCase()),
          ),
          const SizedBox(height: AppSpacing.sm),
          categoriesAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (error, stack) => const SizedBox.shrink(),
            data: (categories) {
              if (categories.isEmpty) return const SizedBox.shrink();
              return SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _CategoryChip(
                      label: 'All',
                      selected: _selectedCategoryId == null,
                      onTap: () => setState(() => _selectedCategoryId = null),
                    ),
                    for (final category in categories)
                      _CategoryChip(
                        label: category.name,
                        selected: _selectedCategoryId == category.id,
                        onTap: () => setState(() => _selectedCategoryId = category.id),
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: itemsAsync.when(
              loading: () => const LoadingState(),
              error: (error, stack) =>
                  ErrorState(onRetry: () => ref.invalidate(activeMenuItemsForRestaurantProvider(widget.restaurantId))),
              data: (items) {
                final available = items.where((item) => item.isAvailable);
                final byCategory = _selectedCategoryId == null
                    ? available
                    : available.where((item) => item.categoryId == _selectedCategoryId);
                final filtered = _query.isEmpty
                    ? byCategory.toList()
                    : byCategory.where((item) => item.name.toLowerCase().contains(_query)).toList();
                if (filtered.isEmpty) {
                  return Center(
                    child: Text('No items found', style: Theme.of(context).textTheme.bodyMedium),
                  );
                }
                return SingleChildScrollView(
                  child: ResponsiveCardGrid(
                    children: [for (final item in filtered) _ItemCard(item: item, onTap: () => _select(item))],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.xs),
      child: ChoiceChip(label: Text(label), selected: selected, onSelected: (_) => onTap()),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item, required this.onTap});

  final MenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outline),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppImage(
                path: item.imagePath,
                height: 96,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.price.toStringAsFixed(2),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                        const Icon(Icons.add_circle_outline_rounded, size: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
