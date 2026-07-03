import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

part 'branch_repository.g.dart';

class BranchRepository {
  BranchRepository(this._db);

  final AppDatabase _db;

  Stream<List<Branch>> watchBranches(int restaurantId) {
    final query = _db.select(_db.branches)
      ..where((t) => t.restaurantId.equals(restaurantId) & t.isArchived.equals(false))
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    return query.watch();
  }

  Stream<Branch?> watchById(int id) {
    final query = _db.select(_db.branches)..where((t) => t.id.equals(id));
    return query.watchSingleOrNull();
  }

  Future<Branch> create({
    required int restaurantId,
    required String name,
    String? address,
    String? workingHoursOpen,
    String? workingHoursClose,
  }) async {
    final id = await _db.into(_db.branches).insert(
          BranchesCompanion.insert(
            restaurantId: restaurantId,
            name: name,
            address: Value(address),
            workingHoursOpen: Value(workingHoursOpen),
            workingHoursClose: Value(workingHoursClose),
          ),
        );
    return (_db.select(_db.branches)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> update(Branch branch) async {
    await _db.update(_db.branches).replace(branch);
  }

  Future<void> archive(int id) async {
    await (_db.update(_db.branches)..where((t) => t.id.equals(id)))
        .write(const BranchesCompanion(isArchived: Value(true)));
  }
}

@Riverpod(keepAlive: true)
BranchRepository branchRepository(Ref ref) {
  return BranchRepository(ref.watch(appDatabaseProvider));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final branchesForRestaurantProvider =
    StreamProvider.family<List<Branch>, int>((ref, restaurantId) {
  return ref.watch(branchRepositoryProvider).watchBranches(restaurantId);
});

final branchByIdProvider = StreamProvider.family<Branch?, int>((ref, id) {
  return ref.watch(branchRepositoryProvider).watchById(id);
});
