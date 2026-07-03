import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/domain/enums.dart';

part 'discount_repository.g.dart';

class DiscountRepository {
  DiscountRepository(this._db);

  final AppDatabase _db;

  Stream<List<Discount>> watchDiscounts(int restaurantId) {
    final query = _db.select(_db.discounts)
      ..where((t) => t.restaurantId.equals(restaurantId))
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    return query.watch();
  }

  Stream<List<Discount>> watchActiveDiscounts(int restaurantId) {
    final query = _db.select(_db.discounts)
      ..where((t) => t.restaurantId.equals(restaurantId) & t.isActive.equals(true))
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    return query.watch();
  }

  Future<Discount> create({
    required int restaurantId,
    required String name,
    required DiscountType type,
    required double value,
  }) async {
    final id = await _db.into(_db.discounts).insert(
          DiscountsCompanion.insert(restaurantId: restaurantId, name: name, type: type.name, value: value),
        );
    return (_db.select(_db.discounts)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> update(Discount discount) async {
    await _db.update(_db.discounts).replace(discount);
  }

  Future<void> setActive(int id, bool isActive) async {
    await (_db.update(_db.discounts)..where((t) => t.id.equals(id)))
        .write(DiscountsCompanion(isActive: Value(isActive)));
  }

  Future<void> delete(int id) async {
    await (_db.delete(_db.discounts)..where((t) => t.id.equals(id))).go();
  }
}

@Riverpod(keepAlive: true)
DiscountRepository discountRepository(Ref ref) {
  return DiscountRepository(ref.watch(appDatabaseProvider));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final discountsForRestaurantProvider =
    StreamProvider.family<List<Discount>, int>((ref, restaurantId) {
  return ref.watch(discountRepositoryProvider).watchDiscounts(restaurantId);
});

final activeDiscountsForRestaurantProvider =
    StreamProvider.family<List<Discount>, int>((ref, restaurantId) {
  return ref.watch(discountRepositoryProvider).watchActiveDiscounts(restaurantId);
});
