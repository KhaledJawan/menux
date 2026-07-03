import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

part 'menu_item_repository.g.dart';

class MenuItemRepository {
  MenuItemRepository(this._db);

  final AppDatabase _db;

  Stream<List<MenuItem>> watchItemsForCategory(int categoryId) {
    final query = _db.select(_db.menuItems)
      ..where((t) => t.categoryId.equals(categoryId))
      ..orderBy([(t) => OrderingTerm.asc(t.sortOrder), (t) => OrderingTerm.asc(t.name)]);
    return query.watch();
  }

  /// All items in one menu (across its categories) — used by the Menu
  /// Management search field, which is scoped to whichever menu is
  /// currently open for editing.
  Stream<List<MenuItem>> watchItemsForMenu(int menuId) {
    final query = _db.select(_db.menuItems).join([
      innerJoin(_db.menuCategories, _db.menuCategories.id.equalsExp(_db.menuItems.categoryId)),
    ])
      ..where(_db.menuCategories.menuId.equals(menuId))
      ..orderBy([OrderingTerm.asc(_db.menuItems.name)]);
    return query.watch().map((rows) => rows.map((r) => r.readTable(_db.menuItems)).toList());
  }

  /// Items available for ordering: every item under a *currently active*
  /// menu. An inactive menu's items simply don't show up here — the data
  /// stays intact, so switching it back on brings everything back exactly
  /// as it was.
  Stream<List<MenuItem>> watchActiveMenuItemsForRestaurant(int restaurantId) {
    final query = _db.select(_db.menuItems).join([
      innerJoin(_db.menuCategories, _db.menuCategories.id.equalsExp(_db.menuItems.categoryId)),
      innerJoin(_db.menus, _db.menus.id.equalsExp(_db.menuCategories.menuId)),
    ])
      ..where(_db.menus.restaurantId.equals(restaurantId) & _db.menus.isActive.equals(true))
      ..orderBy([OrderingTerm.asc(_db.menuItems.sortOrder), OrderingTerm.asc(_db.menuItems.name)]);
    return query.watch().map((rows) => rows.map((r) => r.readTable(_db.menuItems)).toList());
  }

  Future<MenuItem> create({
    required int categoryId,
    required String name,
    String? description,
    required double price,
    double taxPercent = 0,
    bool isDrink = false,
    String? imagePath,
  }) async {
    final id = await _db.into(_db.menuItems).insert(
          MenuItemsCompanion.insert(
            categoryId: categoryId,
            name: name,
            description: Value(description),
            price: price,
            taxPercent: Value(taxPercent),
            isDrink: Value(isDrink),
            imagePath: Value(imagePath),
          ),
        );
    return (_db.select(_db.menuItems)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> update(MenuItem item) async {
    await _db.update(_db.menuItems).replace(item);
  }

  Future<void> setAvailability(int id, bool isAvailable) async {
    await (_db.update(_db.menuItems)..where((t) => t.id.equals(id)))
        .write(MenuItemsCompanion(isAvailable: Value(isAvailable)));
  }

  Future<void> delete(int id) async {
    await (_db.delete(_db.menuItems)..where((t) => t.id.equals(id))).go();
  }
}

@Riverpod(keepAlive: true)
MenuItemRepository menuItemRepository(Ref ref) {
  return MenuItemRepository(ref.watch(appDatabaseProvider));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final menuItemsForCategoryProvider =
    StreamProvider.family<List<MenuItem>, int>((ref, categoryId) {
  return ref.watch(menuItemRepositoryProvider).watchItemsForCategory(categoryId);
});

final menuItemsForMenuProvider =
    StreamProvider.family<List<MenuItem>, int>((ref, menuId) {
  return ref.watch(menuItemRepositoryProvider).watchItemsForMenu(menuId);
});

final activeMenuItemsForRestaurantProvider =
    StreamProvider.family<List<MenuItem>, int>((ref, restaurantId) {
  return ref.watch(menuItemRepositoryProvider).watchActiveMenuItemsForRestaurant(restaurantId);
});
