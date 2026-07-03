import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/domain/enums.dart';

part 'checkout_service.g.dart';

/// Orchestrates paying an order: writes the [Payment], updates the order's
/// discount/tip/total and status, snapshots a [Receipt], and frees the
/// table. Spans three tables, so it lives above the single-table
/// repositories rather than inside any one of them.
class CheckoutService {
  CheckoutService(this._db);

  final AppDatabase _db;

  Future<Receipt> pay({
    required int orderId,
    required PaymentMethod method,
    required double amountCash,
    required double amountCard,
    required double discount,
    required double tip,
  }) async {
    return _db.transaction(() async {
      final order = await (_db.select(_db.orders)..where((t) => t.id.equals(orderId))).getSingle();
      final branch = await (_db.select(_db.branches)..where((t) => t.id.equals(order.branchId))).getSingle();
      final restaurant =
          await (_db.select(_db.restaurants)..where((t) => t.id.equals(branch.restaurantId))).getSingle();

      final tax = order.subtotal * restaurant.taxPercent / 100;
      final total = order.subtotal - discount + tax + tip;

      final paymentId = await _db.into(_db.payments).insert(
            PaymentsCompanion.insert(
              orderId: orderId,
              method: method.name,
              amountCash: Value(amountCash),
              amountCard: Value(amountCard),
              discount: Value(discount),
              tip: Value(tip),
              total: total,
            ),
          );

      await (_db.update(_db.orders)..where((t) => t.id.equals(orderId))).write(
        OrdersCompanion(
          status: Value(OrderStatus.paid.name),
          discount: Value(discount),
          tax: Value(tax),
          tip: Value(tip),
          total: Value(total),
          updatedAt: Value(DateTime.now()),
        ),
      );

      String? hallName;
      String? tableName;
      if (order.hallId != null) {
        final hall = await (_db.select(_db.halls)..where((t) => t.id.equals(order.hallId!))).getSingleOrNull();
        hallName = hall?.name;
      }
      if (order.tableId != null) {
        final table =
            await (_db.select(_db.serviceTables)..where((t) => t.id.equals(order.tableId!))).getSingleOrNull();
        tableName = table?.name;
        if (table != null) {
          await (_db.update(_db.serviceTables)..where((t) => t.id.equals(table.id)))
              .write(ServiceTablesCompanion(status: Value(TableStatus.cleaning.name)));
        }
      }

      final receiptId = await _db.into(_db.receipts).insert(
            ReceiptsCompanion.insert(
              orderId: orderId,
              paymentId: paymentId,
              restaurantName: restaurant.name,
              branchName: branch.name,
              hallName: Value(hallName),
              serviceTableName: Value(tableName),
              customerName: Value(order.customerName),
              subtotal: order.subtotal,
              discount: discount,
              tax: tax,
              tip: tip,
              total: total,
              paymentMethod: method.name,
            ),
          );
      return (_db.select(_db.receipts)..where((t) => t.id.equals(receiptId))).getSingle();
    });
  }
}

@Riverpod(keepAlive: true)
CheckoutService checkoutService(Ref ref) {
  return CheckoutService(ref.watch(appDatabaseProvider));
}
