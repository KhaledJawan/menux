import 'package:drift/drift.dart';

class Reservations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get branchId => integer()();
  IntColumn get tableId => integer().nullable()();
  TextColumn get customerName => text()();
  TextColumn get phone => text().nullable()();
  DateTimeColumn get date => dateTime()();
  TextColumn get time => text()();
  IntColumn get guestCount => integer().withDefault(const Constant(2))();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get branchId => integer()();
  IntColumn get hallId => integer().nullable()();
  IntColumn get tableId => integer().nullable()();
  TextColumn get customerName => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('draft'))();
  TextColumn get comment => text().nullable()();
  RealColumn get subtotal => real().withDefault(const Constant(0))();
  RealColumn get discount => real().withDefault(const Constant(0))();
  RealColumn get tax => real().withDefault(const Constant(0))();
  RealColumn get tip => real().withDefault(const Constant(0))();
  RealColumn get total => real().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
}

class OrderItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId => integer()();
  IntColumn get menuItemId => integer()();
  IntColumn get variantId => integer().nullable()();
  TextColumn get itemName => text()();
  TextColumn get variantName => text().nullable()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  RealColumn get unitPrice => real()();
  TextColumn get comment => text().nullable()();
  BoolColumn get isDrink => boolean().withDefault(const Constant(false))();
  TextColumn get status => text().withDefault(const Constant('newItem'))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

class Payments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId => integer()();
  TextColumn get method => text()();
  RealColumn get amountCash => real().withDefault(const Constant(0))();
  RealColumn get amountCard => real().withDefault(const Constant(0))();
  RealColumn get discount => real().withDefault(const Constant(0))();
  RealColumn get tip => real().withDefault(const Constant(0))();
  RealColumn get total => real()();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

class Receipts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get orderId => integer()();
  IntColumn get paymentId => integer()();
  TextColumn get restaurantName => text()();
  TextColumn get branchName => text()();
  TextColumn get hallName => text().nullable()();
  TextColumn get serviceTableName => text().nullable()();
  TextColumn get customerName => text().nullable()();
  RealColumn get subtotal => real()();
  RealColumn get discount => real()();
  RealColumn get tax => real()();
  RealColumn get tip => real()();
  RealColumn get total => real()();
  TextColumn get paymentMethod => text()();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}
