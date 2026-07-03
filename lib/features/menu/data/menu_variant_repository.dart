import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

part 'menu_variant_repository.g.dart';

class MenuVariantRepository {
  MenuVariantRepository(this._db);

  final AppDatabase _db;

  Stream<List<MenuVariant>> watchVariants(int itemId) {
    final query = _db.select(_db.menuVariants)
      ..where((t) => t.itemId.equals(itemId))
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    return query.watch();
  }

  Future<MenuVariant> create({
    required int itemId,
    required String name,
    double priceDelta = 0,
  }) async {
    final id = await _db.into(_db.menuVariants).insert(
          MenuVariantsCompanion.insert(itemId: itemId, name: name, priceDelta: Value(priceDelta)),
        );
    return (_db.select(_db.menuVariants)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> update(MenuVariant variant) async {
    await _db.update(_db.menuVariants).replace(variant);
  }

  Future<void> delete(int id) async {
    await (_db.delete(_db.menuVariants)..where((t) => t.id.equals(id))).go();
  }
}

@Riverpod(keepAlive: true)
MenuVariantRepository menuVariantRepository(Ref ref) {
  return MenuVariantRepository(ref.watch(appDatabaseProvider));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final menuVariantsForItemProvider =
    StreamProvider.family<List<MenuVariant>, int>((ref, itemId) {
  return ref.watch(menuVariantRepositoryProvider).watchVariants(itemId);
});
