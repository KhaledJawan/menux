import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/session/app_settings_repository.dart';

part 'restaurant_repository.g.dart';

class RestaurantRepository {
  RestaurantRepository(this._db, this._settings);

  final AppDatabase _db;
  final AppSettingsRepository _settings;

  Stream<Restaurant?> watchCurrentRestaurant() {
    return _settings.watch(SettingsKeys.currentRestaurantId).asyncExpand((idString) {
      final id = int.tryParse(idString ?? '');
      if (id == null) return Stream.value(null);
      final query = _db.select(_db.restaurants)..where((t) => t.id.equals(id));
      return query.watchSingleOrNull();
    });
  }

  Future<Restaurant?> getCurrentRestaurant() async {
    final idString = await _settings.get(SettingsKeys.currentRestaurantId);
    final id = int.tryParse(idString ?? '');
    if (id == null) return null;
    return (_db.select(_db.restaurants)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<Restaurant> create({
    required String name,
    String? address,
    required String currency,
    required String language,
    required double taxPercent,
    String? workingHoursOpen,
    String? workingHoursClose,
  }) async {
    final id = await _db.into(_db.restaurants).insert(
          RestaurantsCompanion.insert(
            name: name,
            address: Value(address),
            currency: Value(currency),
            language: Value(language),
            taxPercent: Value(taxPercent),
            workingHoursOpen: Value(workingHoursOpen),
            workingHoursClose: Value(workingHoursClose),
          ),
        );
    await _settings.set(SettingsKeys.currentRestaurantId, id.toString());
    return (_db.select(_db.restaurants)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> update(Restaurant restaurant) async {
    await _db.update(_db.restaurants).replace(restaurant);
  }
}

@Riverpod(keepAlive: true)
RestaurantRepository restaurantRepository(Ref ref) {
  return RestaurantRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(appSettingsRepositoryProvider),
  );
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final currentRestaurantProvider = StreamProvider<Restaurant?>((ref) {
  return ref.watch(restaurantRepositoryProvider).watchCurrentRestaurant();
});
