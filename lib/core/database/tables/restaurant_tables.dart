import 'package:drift/drift.dart';

class Restaurants extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get address => text().nullable()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
  TextColumn get language => text().withDefault(const Constant('en'))();
  RealColumn get taxPercent => real().withDefault(const Constant(0))();
  TextColumn get workingHoursOpen => text().nullable()();
  TextColumn get workingHoursClose => text().nullable()();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

@DataClassName('Branch')
class Branches extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get restaurantId => integer()();
  TextColumn get name => text()();
  TextColumn get address => text().nullable()();
  TextColumn get workingHoursOpen => text().nullable()();
  TextColumn get workingHoursClose => text().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

class Halls extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get branchId => integer()();
  TextColumn get name => text()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

class ServiceTables extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get hallId => integer()();
  TextColumn get name => text()();
  IntColumn get capacity => integer().withDefault(const Constant(2))();
  TextColumn get status => text().withDefault(const Constant('available'))();
  TextColumn get notes => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  // Floor plan layout — populated with sensible defaults so tables created
  // before the graphical floor plan existed still place cleanly on canvas.
  TextColumn get shape => text().withDefault(const Constant('rectangle'))();
  RealColumn get positionX => real().withDefault(const Constant(40))();
  RealColumn get positionY => real().withDefault(const Constant(40))();
  RealColumn get width => real().withDefault(const Constant(120))();
  RealColumn get height => real().withDefault(const Constant(80))();
  RealColumn get rotation => real().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}
