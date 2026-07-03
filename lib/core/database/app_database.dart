import 'package:drift/drift.dart';

import 'connection/connection.dart';
import 'tables/identity_tables.dart';
import 'tables/menu_tables.dart';
import 'tables/messaging_tables.dart';
import 'tables/operations_tables.dart';
import 'tables/restaurant_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    LocalProfiles,
    Staff,
    AppSettingsEntries,
    Restaurants,
    Branches,
    Halls,
    ServiceTables,
    Menus,
    MenuCategories,
    MenuItems,
    MenuVariants,
    Discounts,
    Reservations,
    Orders,
    OrderItems,
    Payments,
    Receipts,
    Messages,
    SyncQueueEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(staff, staff.linkedProfileId);
            await m.addColumn(staff, staff.pin);
          }
          if (from < 3) {
            await m.addColumn(serviceTables, serviceTables.notes);
            await m.addColumn(serviceTables, serviceTables.sortOrder);
            await m.addColumn(serviceTables, serviceTables.shape);
            await m.addColumn(serviceTables, serviceTables.positionX);
            await m.addColumn(serviceTables, serviceTables.positionY);
            await m.addColumn(serviceTables, serviceTables.width);
            await m.addColumn(serviceTables, serviceTables.height);
            await m.addColumn(serviceTables, serviceTables.rotation);
          }
          if (from < 4) {
            await m.createTable(menus);
            await m.createTable(discounts);
            await m.addColumn(menuCategories, menuCategories.menuId);

            // Backfill: every restaurant that already has categories gets a
            // "Main Menu" so its existing items don't vanish from ordering
            // now that items only surface through an active menu.
            final restaurantIds = await (selectOnly(menuCategories, distinct: true)
                  ..addColumns([menuCategories.restaurantId]))
                .map((row) => row.read(menuCategories.restaurantId)!)
                .get();
            for (final restaurantId in restaurantIds) {
              final menuId = await into(menus).insert(
                MenusCompanion.insert(restaurantId: restaurantId, name: 'Main Menu'),
              );
              await (update(menuCategories)..where((t) => t.restaurantId.equals(restaurantId)))
                  .write(MenuCategoriesCompanion(menuId: Value(menuId)));
            }
          }
        },
      );
}
