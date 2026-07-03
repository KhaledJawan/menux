import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';

part 'app_settings_repository.g.dart';

/// Well-known keys stored in [AppSettingsEntries].
abstract final class SettingsKeys {
  static const sessionProfileId = 'session_profile_id';
  static const currentRestaurantId = 'current_restaurant_id';
  static const currentBranchId = 'current_branch_id';
  static const seedDataApplied = 'seed_data_applied';
}

class AppSettingsRepository {
  AppSettingsRepository(this._db);

  final AppDatabase _db;

  Future<String?> get(String key) async {
    final row = await (_db.select(_db.appSettingsEntries)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Stream<String?> watch(String key) {
    final query = _db.select(_db.appSettingsEntries)
      ..where((t) => t.key.equals(key));
    return query.watchSingleOrNull().map((row) => row?.value);
  }

  Future<void> set(String key, String? value) async {
    await _db.into(_db.appSettingsEntries).insertOnConflictUpdate(
          AppSettingsEntriesCompanion.insert(
            key: key,
            value: Value(value),
          ),
        );
  }

  Future<void> remove(String key) async {
    await (_db.delete(_db.appSettingsEntries)
          ..where((t) => t.key.equals(key)))
        .go();
  }
}

@Riverpod(keepAlive: true)
AppSettingsRepository appSettingsRepository(Ref ref) {
  return AppSettingsRepository(ref.watch(appDatabaseProvider));
}
