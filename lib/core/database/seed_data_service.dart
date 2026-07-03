import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/enums.dart';
import '../domain/table_size_presets.dart';
import '../session/app_settings_repository.dart';
import '../session/current_staff_provider.dart';
import 'app_database.dart';
import 'database_provider.dart';

part 'seed_data_service.g.dart';

/// Populates a full demo dataset (restaurant, branch, halls, tables, menu,
/// staff) so every module can be exercised without manual data entry.
/// Development convenience only — never runs automatically; it's an
/// explicit action offered from the Restaurant Setup screen. Idempotent:
/// guarded by [SettingsKeys.seedDataApplied] so re-running it is a no-op.
class SeedDataService {
  SeedDataService(this._db, this._settings);

  final AppDatabase _db;
  final AppSettingsRepository _settings;

  Future<bool> seedIfNeeded({required int profileId, required String profileName}) async {
    final applied = await _settings.get(SettingsKeys.seedDataApplied);
    if (applied == 'true') return false;

    await _db.transaction(() async {
      final restaurantId = await _db.into(_db.restaurants).insert(
            RestaurantsCompanion.insert(
              name: 'Menux Demo Restaurant',
              address: const Value('123 Market Street'),
              currency: const Value('USD'),
              language: const Value('en'),
              taxPercent: const Value(8.5),
              workingHoursOpen: const Value('09:00'),
              workingHoursClose: const Value('23:00'),
            ),
          );

      final branchId = await _db.into(_db.branches).insert(
            BranchesCompanion.insert(
              restaurantId: restaurantId,
              name: 'Main Branch',
              address: const Value('123 Market Street'),
              workingHoursOpen: const Value('09:00'),
              workingHoursClose: const Value('23:00'),
            ),
          );

      final mainHallId = await _db.into(_db.halls).insert(
            HallsCompanion.insert(branchId: branchId, name: 'Main Hall'),
          );
      final terraceId = await _db.into(_db.halls).insert(
            HallsCompanion.insert(branchId: branchId, name: 'Terrace'),
          );

      // Explicit shape/position/size (rather than relying on the schema's
      // flat defaults) so the floor plan's Graphical View doesn't render
      // every seeded table stacked on top of each other at (40, 40).
      for (final entry in [
        (mainHallId, 'T1', 2, TableShape.circle, 40.0, 40.0),
        (mainHallId, 'T2', 4, TableShape.rectangle, 180.0, 40.0),
        (mainHallId, 'T3', 4, TableShape.square, 40.0, 160.0),
        (mainHallId, 'T4', 6, TableShape.oval, 200.0, 170.0),
        (terraceId, 'T5', 2, TableShape.circle, 40.0, 40.0),
        (terraceId, 'T6', 4, TableShape.rectangle, 180.0, 40.0),
      ]) {
        final size = TableSizePresets.defaultSize(entry.$4, entry.$3);
        await _db.into(_db.serviceTables).insert(
              ServiceTablesCompanion.insert(
                hallId: entry.$1,
                name: entry.$2,
                capacity: Value(entry.$3),
                shape: Value(entry.$4.name),
                positionX: Value(entry.$5),
                positionY: Value(entry.$6),
                width: Value(size.$1),
                height: Value(size.$2),
              ),
            );
      }

      final foodCategoryId = await _db.into(_db.menuCategories).insert(
            MenuCategoriesCompanion.insert(restaurantId: restaurantId, name: 'Food'),
          );
      final drinksCategoryId = await _db.into(_db.menuCategories).insert(
            MenuCategoriesCompanion.insert(restaurantId: restaurantId, name: 'Drinks', sortOrder: const Value(1)),
          );

      final burgerId = await _db.into(_db.menuItems).insert(
            MenuItemsCompanion.insert(
              categoryId: foodCategoryId,
              name: 'Classic Burger',
              description: const Value('Beef patty, cheddar, lettuce, tomato'),
              price: 12.5,
              taxPercent: const Value(8.5),
            ),
          );
      await _db.into(_db.menuVariants).insert(
            MenuVariantsCompanion.insert(itemId: burgerId, name: 'Double Patty', priceDelta: const Value(3)),
          );

      await _db.into(_db.menuItems).insert(
            MenuItemsCompanion.insert(
              categoryId: foodCategoryId,
              name: 'Margherita Pizza',
              description: const Value('Tomato, mozzarella, basil'),
              price: 14,
              taxPercent: const Value(8.5),
            ),
          );

      final colaId = await _db.into(_db.menuItems).insert(
            MenuItemsCompanion.insert(
              categoryId: drinksCategoryId,
              name: 'Cola',
              price: 3.5,
              taxPercent: const Value(8.5),
              isDrink: const Value(true),
            ),
          );
      await _db.into(_db.menuVariants).insert(
            MenuVariantsCompanion.insert(itemId: colaId, name: 'Large', priceDelta: const Value(1)),
          );

      await _db.into(_db.menuItems).insert(
            MenuItemsCompanion.insert(
              categoryId: drinksCategoryId,
              name: 'House Red Wine',
              price: 7,
              taxPercent: const Value(8.5),
              isDrink: const Value(true),
            ),
          );

      final ownerId = await _db.into(_db.staff).insert(
            StaffCompanion.insert(
              restaurantId: restaurantId,
              name: profileName,
              role: StaffRole.owner.name,
              linkedProfileId: Value(profileId),
            ),
          );

      for (final entry in [
        ('Alex Manager', StaffRole.manager),
        ('Jamie Waiter', StaffRole.waiter),
        ('Casey Kitchen', StaffRole.kitchen),
        ('Riley Bar', StaffRole.bar),
      ]) {
        await _db.into(_db.staff).insert(
              StaffCompanion.insert(restaurantId: restaurantId, name: entry.$1, role: entry.$2.name),
            );
      }

      await _settings.set(SettingsKeys.currentRestaurantId, restaurantId.toString());
      await _settings.set(SettingsKeys.currentBranchId, branchId.toString());
      await _settings.set(SettingsKeysStaff.activeStaffId, ownerId.toString());
    });

    await _settings.set(SettingsKeys.seedDataApplied, 'true');
    return true;
  }
}

@Riverpod(keepAlive: true)
SeedDataService seedDataService(Ref ref) {
  return SeedDataService(ref.watch(appDatabaseProvider), ref.watch(appSettingsRepositoryProvider));
}
