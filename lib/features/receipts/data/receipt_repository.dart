import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

part 'receipt_repository.g.dart';

class ReceiptRepository {
  ReceiptRepository(this._db);

  final AppDatabase _db;

  Stream<List<Receipt>> watchReceiptsForBranch(int branchId) {
    // Receipts don't carry branchId directly (they're a denormalized
    // snapshot); join through the order they were generated from.
    final query = _db.select(_db.receipts).join([
      innerJoin(_db.orders, _db.orders.id.equalsExp(_db.receipts.orderId)),
    ])
      ..where(_db.orders.branchId.equals(branchId))
      ..orderBy([OrderingTerm.desc(_db.receipts.createdAt)]);
    return query.watch().map((rows) => rows.map((r) => r.readTable(_db.receipts)).toList());
  }

  Stream<Receipt?> watchReceipt(int id) {
    final query = _db.select(_db.receipts)..where((t) => t.id.equals(id));
    return query.watchSingleOrNull();
  }

  Future<Receipt> create(ReceiptsCompanion companion) async {
    final id = await _db.into(_db.receipts).insert(companion);
    return (_db.select(_db.receipts)..where((t) => t.id.equals(id))).getSingle();
  }
}

@Riverpod(keepAlive: true)
ReceiptRepository receiptRepository(Ref ref) {
  return ReceiptRepository(ref.watch(appDatabaseProvider));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final receiptsForBranchProvider =
    StreamProvider.family<List<Receipt>, int>((ref, branchId) {
  return ref.watch(receiptRepositoryProvider).watchReceiptsForBranch(branchId);
});

final receiptByIdProvider = StreamProvider.family<Receipt?, int>((ref, id) {
  return ref.watch(receiptRepositoryProvider).watchReceipt(id);
});
