import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

part 'payment_repository.g.dart';

class PaymentRepository {
  PaymentRepository(this._db);

  final AppDatabase _db;

  Stream<List<Payment>> watchPaymentsForOrder(int orderId) {
    final query = _db.select(_db.payments)..where((t) => t.orderId.equals(orderId));
    return query.watch();
  }

  Future<Payment> create(PaymentsCompanion companion) async {
    final id = await _db.into(_db.payments).insert(companion);
    return (_db.select(_db.payments)..where((t) => t.id.equals(id))).getSingle();
  }
}

@Riverpod(keepAlive: true)
PaymentRepository paymentRepository(Ref ref) {
  return PaymentRepository(ref.watch(appDatabaseProvider));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final paymentsForOrderProvider =
    StreamProvider.family<List<Payment>, int>((ref, orderId) {
  return ref.watch(paymentRepositoryProvider).watchPaymentsForOrder(orderId);
});
