import 'package:drift/drift.dart';

class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get senderName => text()();
  TextColumn get recipientRole => text().nullable()(); // null = all staff
  TextColumn get title => text()();
  TextColumn get body => text()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

/// Placeholder for future Supabase sync (Phase 19). Not actively consumed
/// yet, but the shape is here so writes can start queuing without a schema
/// migration later.
class SyncQueueEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityTable => text()();
  IntColumn get entityId => integer()();
  TextColumn get operation => text()();
  TextColumn get payload => text().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}
