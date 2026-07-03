import 'package:drift/drift.dart';

/// The local device account used to sign in. Menux is offline-first and
/// single-tenant per device, so this is a simple local credential store —
/// not a synced multi-device identity system.
class LocalProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get email => text().unique()();
  TextColumn get passwordHash => text()();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

/// Team members of a restaurant. Staff still aren't separate login
/// accounts (Menux is one device login per PRD's local-first model) — but
/// on a shared restaurant device, whoever is physically using it "checks
/// in" as one of these records (optionally behind a PIN) so the app knows
/// their role for permission checks. [linkedProfileId] connects the owner's
/// staff record back to the [LocalProfiles] row that registered the
/// restaurant, so the owner never gets locked out of their own device.
@DataClassName('StaffMember')
class Staff extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get restaurantId => integer()();
  IntColumn get linkedProfileId => integer().nullable()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get role => text()();
  TextColumn get pin => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

/// Generic key-value store for app/session state (current restaurant id,
/// logged-in profile id, seed-data flag, etc).
class AppSettingsEntries extends Table {
  TextColumn get key => text()();
  TextColumn get value => text().nullable()();

  @override
  Set<Column> get primaryKey => {key};
}
