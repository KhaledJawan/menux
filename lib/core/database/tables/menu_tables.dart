import 'package:drift/drift.dart';

/// A named, independently-toggleable menu (e.g. "Breakfast Menu", "Drinks
/// Menu", "Holiday Specials"). A restaurant can have several; each has its
/// own categories/items, and only items on an *active* menu show up when
/// building an order — inactive menus stay fully intact, just hidden from
/// ordering, so switching a seasonal menu off and back on doesn't lose
/// anything.
///
/// Named `RestaurantMenu` (not the naive singular `Menu`) because that
/// collides with Flutter Material's own `Menu` widget class — the same
/// reason Branches/Staff needed an explicit @DataClassName too.
@DataClassName('RestaurantMenu')
class Menus extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get restaurantId => integer()();
  TextColumn get name => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

class MenuCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get restaurantId => integer()();

  /// Nullable only so existing rows survive the migration that introduced
  /// this column — every category created through the app from here on
  /// always has one. See AppDatabase's v4 migration for the backfill.
  IntColumn get menuId => integer().nullable()();
  TextColumn get name => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

class MenuItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  RealColumn get price => real()();
  RealColumn get taxPercent => real().withDefault(const Constant(0))();
  BoolColumn get isAvailable => boolean().withDefault(const Constant(true))();
  BoolColumn get isDrink => boolean().withDefault(const Constant(false))();

  /// A pasted image URL (http/https) or a local file path copied in via
  /// device upload — see AppImage for how this is rendered.
  TextColumn get imagePath => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

class MenuVariants extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itemId => integer()();
  TextColumn get name => text()();
  RealColumn get priceDelta => real().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}

/// A reusable discount rule (e.g. "Happy Hour 20%", "Staff Meal -5.00") a
/// waiter picks at checkout instead of typing a raw number each time.
class Discounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get restaurantId => integer()();
  TextColumn get name => text()();

  /// 'percent' or 'fixed' — see DiscountType in core/domain/enums.dart.
  TextColumn get type => text()();
  RealColumn get value => real()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}
