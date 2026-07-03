import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/domain/enums.dart';

part 'staff_repository.g.dart';

class StaffRepository {
  StaffRepository(this._db);

  final AppDatabase _db;

  Stream<List<StaffMember>> watchStaff(int restaurantId) {
    final query = _db.select(_db.staff)
      ..where((t) => t.restaurantId.equals(restaurantId))
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    return query.watch();
  }

  Stream<StaffMember?> watchById(int id) {
    final query = _db.select(_db.staff)..where((t) => t.id.equals(id));
    return query.watchSingleOrNull();
  }

  Future<StaffMember> create({
    required int restaurantId,
    required String name,
    String? phone,
    required StaffRole role,
    String? pin,
    int? linkedProfileId,
  }) async {
    final id = await _db.into(_db.staff).insert(
          StaffCompanion.insert(
            restaurantId: restaurantId,
            name: name,
            phone: Value(phone),
            role: role.name,
            pin: Value(pin),
            linkedProfileId: Value(linkedProfileId),
          ),
        );
    return (_db.select(_db.staff)..where((t) => t.id.equals(id))).getSingle();
  }

  /// Creates the Owner staff record for a newly registered restaurant,
  /// linked back to the account that created it, and returns it. Ensures
  /// the owner is never locked out of their own device by the role gate.
  Future<StaffMember> createOwner({
    required int restaurantId,
    required int profileId,
    required String name,
  }) {
    return create(
      restaurantId: restaurantId,
      name: name,
      role: StaffRole.owner,
      linkedProfileId: profileId,
    );
  }

  Future<StaffMember?> findByLinkedProfile(int restaurantId, int profileId) {
    final query = _db.select(_db.staff)
      ..where((t) => t.restaurantId.equals(restaurantId) & t.linkedProfileId.equals(profileId));
    return query.getSingleOrNull();
  }

  /// Backfill for restaurants created before staff switching/owner-linking
  /// existed: finds (or creates) the Owner record for this profile so
  /// existing accounts aren't locked out of editing their own restaurant
  /// by the role gate. Idempotent — safe to call on every login.
  Future<StaffMember> ensureOwnerLinked({
    required int restaurantId,
    required int profileId,
    required String profileName,
  }) async {
    final linked = await findByLinkedProfile(restaurantId, profileId);
    if (linked != null) return linked;

    // An Owner record might already exist without a link — e.g. seed data
    // or a restaurant created before this backfill existed. Claim it
    // instead of creating a duplicate owner.
    final unlinkedOwner = await (_db.select(_db.staff)
          ..where((t) =>
              t.restaurantId.equals(restaurantId) &
              t.role.equals(StaffRole.owner.name) &
              t.linkedProfileId.isNull()))
        .getSingleOrNull();
    if (unlinkedOwner != null) {
      final updated = unlinkedOwner.copyWith(linkedProfileId: Value(profileId));
      await update(updated);
      return updated;
    }

    return createOwner(restaurantId: restaurantId, profileId: profileId, name: profileName);
  }

  Future<void> update(StaffMember member) async {
    await _db.update(_db.staff).replace(member);
  }

  Future<void> delete(int id) async {
    await (_db.delete(_db.staff)..where((t) => t.id.equals(id))).go();
  }
}

@Riverpod(keepAlive: true)
StaffRepository staffRepository(Ref ref) {
  return StaffRepository(ref.watch(appDatabaseProvider));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final staffForRestaurantProvider =
    StreamProvider.family<List<StaffMember>, int>((ref, restaurantId) {
  return ref.watch(staffRepositoryProvider).watchStaff(restaurantId);
});

final staffByIdProvider = StreamProvider.family<StaffMember?, int>((ref, id) {
  return ref.watch(staffRepositoryProvider).watchById(id);
});
