import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/domain/enums.dart';

part 'reservation_repository.g.dart';

class ReservationRepository {
  ReservationRepository(this._db);

  final AppDatabase _db;

  Stream<List<Reservation>> watchReservations(int branchId) {
    final query = _db.select(_db.reservations)
      ..where((t) => t.branchId.equals(branchId))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]);
    return query.watch();
  }

  Future<Reservation> create({
    required int branchId,
    int? tableId,
    required String customerName,
    String? phone,
    required DateTime date,
    required String time,
    int guestCount = 2,
    String? notes,
  }) async {
    final id = await _db.into(_db.reservations).insert(
          ReservationsCompanion.insert(
            branchId: branchId,
            tableId: Value(tableId),
            customerName: customerName,
            phone: Value(phone),
            date: date,
            time: time,
            guestCount: Value(guestCount),
            notes: Value(notes),
          ),
        );
    return (_db.select(_db.reservations)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> update(Reservation reservation) async {
    await _db.update(_db.reservations).replace(reservation);
  }

  Future<void> updateStatus(int id, ReservationStatus status) async {
    await (_db.update(_db.reservations)..where((t) => t.id.equals(id)))
        .write(ReservationsCompanion(status: Value(status.name)));
  }

  Future<void> cancel(int id) => updateStatus(id, ReservationStatus.cancelled);
}

@Riverpod(keepAlive: true)
ReservationRepository reservationRepository(Ref ref) {
  return ReservationRepository(ref.watch(appDatabaseProvider));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final reservationsForBranchProvider =
    StreamProvider.family<List<Reservation>, int>((ref, branchId) {
  return ref.watch(reservationRepositoryProvider).watchReservations(branchId);
});
