import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

part 'menu_repository.g.dart';

class MenuRepository {
  MenuRepository(this._db);

  final AppDatabase _db;

  Stream<List<RestaurantMenu>> watchMenus(int restaurantId) {
    final query = _db.select(_db.menus)
      ..where((t) => t.restaurantId.equals(restaurantId))
      ..orderBy([(t) => OrderingTerm.asc(t.sortOrder), (t) => OrderingTerm.asc(t.name)]);
    return query.watch();
  }

  Stream<RestaurantMenu?> watchById(int id) {
    final query = _db.select(_db.menus)..where((t) => t.id.equals(id));
    return query.watchSingleOrNull();
  }

  Future<RestaurantMenu> create({required int restaurantId, required String name}) async {
    final id = await _db.into(_db.menus).insert(
          MenusCompanion.insert(restaurantId: restaurantId, name: name),
        );
    return (_db.select(_db.menus)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> update(RestaurantMenu menu) async {
    await _db.update(_db.menus).replace(menu);
  }

  Future<void> setActive(int id, bool isActive) async {
    await (_db.update(_db.menus)..where((t) => t.id.equals(id)))
        .write(MenusCompanion(isActive: Value(isActive)));
  }

  Future<void> delete(int id) async {
    await (_db.delete(_db.menus)..where((t) => t.id.equals(id))).go();
  }
}

@Riverpod(keepAlive: true)
MenuRepository menuRepository(Ref ref) {
  return MenuRepository(ref.watch(appDatabaseProvider));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final menusForRestaurantProvider =
    StreamProvider.family<List<RestaurantMenu>, int>((ref, restaurantId) {
  return ref.watch(menuRepositoryProvider).watchMenus(restaurantId);
});

final menuByIdProvider = StreamProvider.family<RestaurantMenu?, int>((ref, id) {
  return ref.watch(menuRepositoryProvider).watchById(id);
});
