import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/domain/enums.dart';

part 'order_repository.g.dart';

/// Order statuses still considered "open" — i.e. shown on the Orders tab
/// and floor plan as an active ticket.
const _openStatuses = ['draft', 'sent', 'preparing', 'ready', 'delivered'];

class OrderRepository {
  OrderRepository(this._db);

  final AppDatabase _db;

  Stream<List<Order>> watchOpenOrders(int branchId) {
    final query = _db.select(_db.orders)
      ..where((t) => t.branchId.equals(branchId) & t.status.isIn(_openStatuses))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    return query.watch();
  }

  Stream<Order?> watchOrder(int orderId) {
    final query = _db.select(_db.orders)..where((t) => t.id.equals(orderId));
    return query.watchSingleOrNull();
  }

  Stream<List<OrderItem>> watchOrderItems(int orderId) {
    final query = _db.select(_db.orderItems)
      ..where((t) => t.orderId.equals(orderId))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    return query.watch();
  }

  /// Most recent orders in a branch regardless of status, for the Dashboard
  /// activity feed.
  Stream<List<Order>> watchRecentOrders(int branchId, {int limit = 5}) {
    final query = _db.select(_db.orders)
      ..where((t) => t.branchId.equals(branchId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(limit);
    return query.watch();
  }

  /// Every order item ever placed in a branch, for best-seller aggregation
  /// on the Dashboard.
  Stream<List<OrderItem>> watchAllOrderItemsForBranch(int branchId) {
    final query = _db.select(_db.orderItems).join([
      innerJoin(_db.orders, _db.orders.id.equalsExp(_db.orderItems.orderId)),
    ])
      ..where(_db.orders.branchId.equals(branchId));
    return query.watch().map((rows) => rows.map((r) => r.readTable(_db.orderItems)).toList());
  }

  /// Food items still in progress across a branch, for the Kitchen Display.
  Stream<List<OrderItem>> watchKitchenItems(int branchId) => _watchStationItems(branchId, isDrink: false);

  /// Drink items still in progress across a branch, for the Bar Display.
  Stream<List<OrderItem>> watchBarItems(int branchId) => _watchStationItems(branchId, isDrink: true);

  Stream<List<OrderItem>> _watchStationItems(int branchId, {required bool isDrink}) {
    final query = _db.select(_db.orderItems).join([
      innerJoin(_db.orders, _db.orders.id.equalsExp(_db.orderItems.orderId)),
    ])
      ..where(
        _db.orders.branchId.equals(branchId) &
            _db.orders.status.isIn(['sent', 'preparing', 'ready']) &
            _db.orderItems.isDrink.equals(isDrink) &
            _db.orderItems.status.equals(OrderItemStatus.completed.name).not(),
      )
      ..orderBy([OrderingTerm.asc(_db.orderItems.createdAt)]);
    return query.watch().map((rows) => rows.map((r) => r.readTable(_db.orderItems)).toList());
  }

  /// Returns the existing open order for a table, or starts a new draft.
  Future<Order> openOrCreateForTable({
    required int branchId,
    required int hallId,
    required int tableId,
    String? customerName,
  }) async {
    final existing = await (_db.select(_db.orders)
          ..where((t) =>
              t.tableId.equals(tableId) & t.status.isIn(_openStatuses))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    if (existing != null) return existing;

    final id = await _db.into(_db.orders).insert(
          OrdersCompanion.insert(
            branchId: branchId,
            hallId: Value(hallId),
            tableId: Value(tableId),
            customerName: Value(customerName),
          ),
        );
    await (_db.update(_db.serviceTables)..where((t) => t.id.equals(tableId)))
        .write(ServiceTablesCompanion(status: Value(TableStatus.occupied.name)));
    return (_db.select(_db.orders)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> addItem({
    required int orderId,
    required MenuItem menuItem,
    MenuVariant? variant,
    int quantity = 1,
    String? comment,
  }) async {
    await _db.into(_db.orderItems).insert(
          OrderItemsCompanion.insert(
            orderId: orderId,
            menuItemId: menuItem.id,
            variantId: Value(variant?.id),
            itemName: menuItem.name,
            variantName: Value(variant?.name),
            quantity: Value(quantity),
            unitPrice: menuItem.price + (variant?.priceDelta ?? 0),
            comment: Value(comment),
            isDrink: Value(menuItem.isDrink),
          ),
        );
    await _recalculate(orderId);
  }

  Future<void> updateItemQuantity(int orderItemId, int quantity) async {
    final item = await (_db.select(_db.orderItems)..where((t) => t.id.equals(orderItemId))).getSingle();
    if (quantity <= 0) {
      await removeItem(orderItemId);
      return;
    }
    await (_db.update(_db.orderItems)..where((t) => t.id.equals(orderItemId)))
        .write(OrderItemsCompanion(quantity: Value(quantity)));
    await _recalculate(item.orderId);
  }

  Future<void> updateItemComment(int orderItemId, String? comment) async {
    await (_db.update(_db.orderItems)..where((t) => t.id.equals(orderItemId)))
        .write(OrderItemsCompanion(comment: Value(comment)));
  }

  Future<void> updateItemStatus(int orderItemId, OrderItemStatus status) async {
    await (_db.update(_db.orderItems)..where((t) => t.id.equals(orderItemId)))
        .write(OrderItemsCompanion(status: Value(status.name)));
  }

  Future<void> removeItem(int orderItemId) async {
    final item = await (_db.select(_db.orderItems)..where((t) => t.id.equals(orderItemId))).getSingle();
    await (_db.delete(_db.orderItems)..where((t) => t.id.equals(orderItemId))).go();
    await _recalculate(item.orderId);
  }

  Future<void> updateComment(int orderId, String? comment) async {
    await (_db.update(_db.orders)..where((t) => t.id.equals(orderId)))
        .write(OrdersCompanion(comment: Value(comment), updatedAt: Value(DateTime.now())));
  }

  Future<void> submit(int orderId) async {
    await (_db.update(_db.orders)..where((t) => t.id.equals(orderId))).write(
      OrdersCompanion(status: Value(OrderStatus.sent.name), updatedAt: Value(DateTime.now())),
    );
  }

  Future<void> updateStatus(int orderId, OrderStatus status) async {
    await (_db.update(_db.orders)..where((t) => t.id.equals(orderId))).write(
      OrdersCompanion(status: Value(status.name), updatedAt: Value(DateTime.now())),
    );
    if (status == OrderStatus.paid || status == OrderStatus.cancelled) {
      final order = await (_db.select(_db.orders)..where((t) => t.id.equals(orderId))).getSingle();
      final tableId = order.tableId;
      if (tableId != null) {
        await (_db.update(_db.serviceTables)..where((t) => t.id.equals(tableId)))
            .write(ServiceTablesCompanion(status: Value(TableStatus.cleaning.name)));
      }
    }
  }

  Future<void> _recalculate(int orderId) async {
    final items = await (_db.select(_db.orderItems)..where((t) => t.orderId.equals(orderId))).get();
    final subtotal = items.fold<double>(0, (sum, item) => sum + item.unitPrice * item.quantity);

    final order = await (_db.select(_db.orders)..where((t) => t.id.equals(orderId))).getSingle();
    final branch = await (_db.select(_db.branches)..where((t) => t.id.equals(order.branchId))).getSingle();
    final restaurant =
        await (_db.select(_db.restaurants)..where((t) => t.id.equals(branch.restaurantId))).getSingle();

    final tax = subtotal * restaurant.taxPercent / 100;
    final total = subtotal - order.discount + tax + order.tip;

    await (_db.update(_db.orders)..where((t) => t.id.equals(orderId))).write(
      OrdersCompanion(
        subtotal: Value(subtotal),
        tax: Value(tax),
        total: Value(total),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

@Riverpod(keepAlive: true)
OrderRepository orderRepository(Ref ref) {
  return OrderRepository(ref.watch(appDatabaseProvider));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final openOrdersForBranchProvider =
    StreamProvider.family<List<Order>, int>((ref, branchId) {
  return ref.watch(orderRepositoryProvider).watchOpenOrders(branchId);
});

final orderByIdProvider = StreamProvider.family<Order?, int>((ref, orderId) {
  return ref.watch(orderRepositoryProvider).watchOrder(orderId);
});

final orderItemsProvider = StreamProvider.family<List<OrderItem>, int>((ref, orderId) {
  return ref.watch(orderRepositoryProvider).watchOrderItems(orderId);
});

final recentOrdersForBranchProvider =
    StreamProvider.family<List<Order>, int>((ref, branchId) {
  return ref.watch(orderRepositoryProvider).watchRecentOrders(branchId);
});

final allOrderItemsForBranchProvider =
    StreamProvider.family<List<OrderItem>, int>((ref, branchId) {
  return ref.watch(orderRepositoryProvider).watchAllOrderItemsForBranch(branchId);
});

final kitchenItemsForBranchProvider =
    StreamProvider.family<List<OrderItem>, int>((ref, branchId) {
  return ref.watch(orderRepositoryProvider).watchKitchenItems(branchId);
});

final barItemsForBranchProvider =
    StreamProvider.family<List<OrderItem>, int>((ref, branchId) {
  return ref.watch(orderRepositoryProvider).watchBarItems(branchId);
});
