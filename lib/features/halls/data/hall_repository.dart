import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

part 'hall_repository.g.dart';

class HallRepository {
  HallRepository(this._db);

  final AppDatabase _db;

  Stream<List<Hall>> watchHalls(int branchId) {
    final query = _db.select(_db.halls)
      ..where((t) => t.branchId.equals(branchId) & t.isArchived.equals(false))
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    return query.watch();
  }

  Stream<Hall?> watchById(int id) {
    final query = _db.select(_db.halls)..where((t) => t.id.equals(id));
    return query.watchSingleOrNull();
  }

  Future<Hall> create({required int branchId, required String name}) async {
    final id = await _db.into(_db.halls).insert(
          HallsCompanion.insert(branchId: branchId, name: name),
        );
    return (_db.select(_db.halls)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> update(Hall hall) async {
    await _db.update(_db.halls).replace(hall);
  }

  Future<void> archive(int id) async {
    await (_db.update(_db.halls)..where((t) => t.id.equals(id)))
        .write(const HallsCompanion(isArchived: Value(true)));
  }
}

@Riverpod(keepAlive: true)
HallRepository hallRepository(Ref ref) {
  return HallRepository(ref.watch(appDatabaseProvider));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final hallsForBranchProvider =
    StreamProvider.family<List<Hall>, int>((ref, branchId) {
  return ref.watch(hallRepositoryProvider).watchHalls(branchId);
});

final hallByIdProvider = StreamProvider.family<Hall?, int>((ref, id) {
  return ref.watch(hallRepositoryProvider).watchById(id);
});
