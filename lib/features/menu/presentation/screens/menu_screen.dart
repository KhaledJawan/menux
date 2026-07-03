import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/session/current_staff_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/confirm_delete_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/entity_actions_sheet.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_state.dart';
import '../../../../core/widgets/owner_only_banner.dart';
import '../../../../core/widgets/search_field.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../data/menu_category_repository.dart';
import '../../data/menu_item_repository.dart';
import '../../data/menu_repository.dart';
import '../widgets/menu_category_form_sheet.dart';
import '../widgets/menu_item_form_sheet.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key, required this.menuId});

  final int menuId;

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menuAsync = ref.watch(menuByIdProvider(widget.menuId));
    final isOwner = ref.watch(isOwnerProvider);

    return AppScaffold(
      title: menuAsync.value?.name ?? 'Menu',
      search: SearchField(
        controller: _searchController,
        hint: 'Search items in this menu',
        onChanged: (value) => setState(() => _query = value.trim().toLowerCase()),
      ),
      floatingActionButton: (!isOwner || menuAsync.value == null)
          ? null
          : FloatingActionButton(
              onPressed: () => showMenuCategoryFormSheet(
                context,
                restaurantId: menuAsync.value!.restaurantId,
                menuId: widget.menuId,
              ),
              child: const Icon(Icons.add_rounded),
            ),
      body: menuAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(menuByIdProvider(widget.menuId))),
        data: (menu) {
          if (menu == null) {
            return const ErrorState(message: 'This menu no longer exists.');
          }
          if (_query.isNotEmpty) {
            return _SearchResults(menuId: menu.id, query: _query);
          }
          return _CategoryList(restaurantId: menu.restaurantId, menuId: menu.id, isOwner: isOwner);
        },
      ),
    );
  }
}

class _CategoryList extends ConsumerWidget {
  const _CategoryList({required this.restaurantId, required this.menuId, required this.isOwner});

  final int restaurantId;
  final int menuId;
  final bool isOwner;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(menuCategoriesForMenuProvider(menuId));

    return categoriesAsync.when(
      loading: () => const LoadingState(),
      error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(menuCategoriesForMenuProvider(menuId))),
      data: (categories) {
        if (categories.isEmpty) {
          return EmptyState(
            icon: Icons.restaurant_menu_outlined,
            title: 'No menu categories yet',
            message: isOwner
                ? 'Add a category to start building this menu.'
                : 'Ask the restaurant owner to add categories to this menu.',
            actionLabel: isOwner ? 'Add Category' : null,
            onAction: isOwner
                ? () => showMenuCategoryFormSheet(context, restaurantId: restaurantId, menuId: menuId)
                : null,
          );
        }
        return ListView(
          padding: const EdgeInsets.all(AppSpacing.sm),
          children: [
            if (!isOwner) const OwnerOnlyBanner(),
            for (final category in categories) _CategorySection(category: category, isOwner: isOwner),
          ],
        );
      },
    );
  }
}

class _CategorySection extends ConsumerWidget {
  const _CategorySection({required this.category, required this.isOwner});

  final MenuCategory category;
  final bool isOwner;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(menuItemsForCategoryProvider(category.id));

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          tilePadding: EdgeInsets.zero,
          title: Text(category.name, style: Theme.of(context).textTheme.titleMedium),
          trailing: isOwner
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_rounded),
                      tooltip: 'Add item',
                      onPressed: () => showMenuItemFormSheet(context, categoryId: category.id),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert_rounded),
                      onPressed: () => showEntityActionsSheet(
                        context: context,
                        onEdit: () => showMenuCategoryFormSheet(
                          context,
                          restaurantId: category.restaurantId,
                          menuId: category.menuId!,
                          initial: category,
                        ),
                        onDelete: () async {
                          final confirmed = await confirmDelete(
                            context,
                            title: 'Delete ${category.name}?',
                            message: 'Items in this category will also be removed.',
                          );
                          if (confirmed) {
                            await ref.read(menuCategoryRepositoryProvider).delete(category.id);
                          }
                        },
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
          children: [
            itemsAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: LinearProgressIndicator(),
              ),
              error: (error, stack) => const SizedBox.shrink(),
              data: (items) {
                if (items.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                    child: Text(
                      'No items yet',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                    ),
                  );
                }
                return Column(
                  children: [for (final item in items) _MenuItemRow(item: item, isOwner: isOwner)],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItemRow extends StatelessWidget {
  const _MenuItemRow({required this.item, required this.isOwner});

  final MenuItem item;
  final bool isOwner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: AppCard(
        onTap: isOwner ? () => showMenuItemFormSheet(context, categoryId: item.categoryId, initial: item) : null,
        child: Row(
          children: [
            AppImage(path: item.imagePath, width: 44, height: 44),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: theme.textTheme.bodyLarge),
                  Text(
                    item.price.toStringAsFixed(2),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            if (!item.isAvailable) const StatusBadge(label: 'Unavailable', color: AppColors.statusDisabled),
          ],
        ),
      ),
    );
  }
}

class _SearchResults extends ConsumerWidget {
  const _SearchResults({required this.menuId, required this.query});

  final int menuId;
  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(menuItemsForMenuProvider(menuId));
    final isOwner = ref.watch(isOwnerProvider);

    return itemsAsync.when(
      loading: () => const LoadingState(),
      error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(menuItemsForMenuProvider(menuId))),
      data: (items) {
        final filtered = items.where((item) => item.name.toLowerCase().contains(query)).toList();
        if (filtered.isEmpty) {
          return const EmptyState(icon: Icons.search_off_rounded, title: 'No matching items');
        }
        return ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.sm),
          itemCount: filtered.length,
          itemBuilder: (context, index) => _MenuItemRow(item: filtered[index], isOwner: isOwner),
        );
      },
    );
  }
}
