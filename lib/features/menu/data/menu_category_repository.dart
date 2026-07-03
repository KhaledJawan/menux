import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

part 'menu_category_repository.g.dart';

class MenuCategoryRepository {
  MenuCategoryRepository(this._db);

  final AppDatabase _db;

  Stream<List<MenuCategory>> watchCategoriesForMenu(int menuId) {
    final query = _db.select(_db.menuCategories)
      ..where((t) => t.menuId.equals(menuId))
      ..orderBy([(t) => OrderingTerm.asc(t.sortOrder), (t) => OrderingTerm.asc(t.name)]);
    return query.watch();
  }

  /// Categories belonging to any currently-active menu — the chips shown
  /// at the top of the order builder's item picker.
  Stream<List<MenuCategory>> watchCategoriesForActiveMenus(int restaurantId) {
    final query = _db.select(_db.menuCategories).join([
      innerJoin(_db.menus, _db.menus.id.equalsExp(_db.menuCategories.menuId)),
    ])
      ..where(_db.menus.restaurantId.equals(restaurantId) & _db.menus.isActive.equals(true))
      ..orderBy([OrderingTerm.asc(_db.menuCategories.sortOrder), OrderingTerm.asc(_db.menuCategories.name)]);
    return query.watch().map((rows) => rows.map((r) => r.readTable(_db.menuCategories)).toList());
  }

  Future<MenuCategory> create({required int restaurantId, required int menuId, required String name}) async {
    final id = await _db.into(_db.menuCategories).insert(
          MenuCategoriesCompanion.insert(restaurantId: restaurantId, menuId: Value(menuId), name: name),
        );
    return (_db.select(_db.menuCategories)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> update(MenuCategory category) async {
    await _db.update(_db.menuCategories).replace(category);
  }

  Future<void> delete(int id) async {
    await (_db.delete(_db.menuCategories)..where((t) => t.id.equals(id))).go();
  }
}

@Riverpod(keepAlive: true)
MenuCategoryRepository menuCategoryRepository(Ref ref) {
  return MenuCategoryRepository(ref.watch(appDatabaseProvider));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final menuCategoriesForMenuProvider =
    StreamProvider.family<List<MenuCategory>, int>((ref, menuId) {
  return ref.watch(menuCategoryRepositoryProvider).watchCategoriesForMenu(menuId);
});

final activeMenuCategoriesForRestaurantProvider =
    StreamProvider.family<List<MenuCategory>, int>((ref, restaurantId) {
  return ref.watch(menuCategoryRepositoryProvider).watchCategoriesForActiveMenus(restaurantId);
});
