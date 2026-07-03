import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/domain/enums.dart';
import '../../../core/domain/table_size_presets.dart';

part 'service_table_repository.g.dart';

class ServiceTableRepository {
  ServiceTableRepository(this._db);

  final AppDatabase _db;

  Stream<List<ServiceTable>> watchTablesForHall(int hallId) {
    final query = _db.select(_db.serviceTables)
      ..where((t) => t.hallId.equals(hallId))
      ..orderBy([(t) => OrderingTerm.asc(t.sortOrder), (t) => OrderingTerm.asc(t.name)]);
    return query.watch();
  }

  /// All tables across every (non-archived) hall in a branch — used by
  /// order/reservation table pickers.
  Stream<List<ServiceTable>> watchTablesForBranch(int branchId) {
    final query = _db.select(_db.serviceTables).join([
      innerJoin(_db.halls, _db.halls.id.equalsExp(_db.serviceTables.hallId)),
    ])
      ..where(_db.halls.branchId.equals(branchId) & _db.halls.isArchived.equals(false))
      ..orderBy([OrderingTerm.asc(_db.serviceTables.name)]);
    return query.watch().map((rows) => rows.map((r) => r.readTable(_db.serviceTables)).toList());
  }

  Future<ServiceTable> create({
    required int hallId,
    required String name,
    required int capacity,
    TableShape shape = TableShape.rectangle,
    TableStatus status = TableStatus.available,
    double? width,
    double? height,
    double? positionX,
    double? positionY,
    double rotation = 0,
    String? notes,
  }) async {
    final existing = await (_db.select(_db.serviceTables)..where((t) => t.hallId.equals(hallId))).get();
    final size = (width != null && height != null) ? (width, height) : TableSizePresets.defaultSize(shape, capacity);
    // Cascade new tables so they don't all land in the same spot when added
    // repeatedly — wraps into a new row every 5 tables.
    final index = existing.length;
    final defaultX = 40.0 + (index % 5) * 40;
    final defaultY = 40.0 + (index ~/ 5) * 40;

    final id = await _db.into(_db.serviceTables).insert(
          ServiceTablesCompanion.insert(
            hallId: hallId,
            name: name,
            capacity: Value(capacity),
            status: Value(status.name),
            shape: Value(shape.name),
            width: Value(size.$1),
            height: Value(size.$2),
            positionX: Value(positionX ?? defaultX),
            positionY: Value(positionY ?? defaultY),
            rotation: Value(rotation),
            notes: Value(notes),
            sortOrder: Value(existing.length),
          ),
        );
    return (_db.select(_db.serviceTables)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> update(ServiceTable table) async {
    await _db.update(_db.serviceTables).replace(table);
  }

  Future<void> updateStatus(int id, TableStatus status) async {
    await (_db.update(_db.serviceTables)..where((t) => t.id.equals(id)))
        .write(ServiceTablesCompanion(status: Value(status.name)));
  }

  /// Position/size/rotation only — called frequently during drag, resize,
  /// and rotate gestures, so it stays a lean partial write rather than a
  /// full row replace.
  Future<void> updateLayout(
    int id, {
    double? positionX,
    double? positionY,
    double? width,
    double? height,
    double? rotation,
  }) async {
    await (_db.update(_db.serviceTables)..where((t) => t.id.equals(id))).write(
      ServiceTablesCompanion(
        positionX: positionX != null ? Value(positionX) : const Value.absent(),
        positionY: positionY != null ? Value(positionY) : const Value.absent(),
        width: width != null ? Value(width) : const Value.absent(),
        height: height != null ? Value(height) : const Value.absent(),
        rotation: rotation != null ? Value(rotation) : const Value.absent(),
      ),
    );
  }

  Future<ServiceTable> duplicate(ServiceTable table) async {
    final id = await _db.into(_db.serviceTables).insert(
          ServiceTablesCompanion.insert(
            hallId: table.hallId,
            name: '${table.name} Copy',
            capacity: Value(table.capacity),
            status: const Value('available'),
            shape: Value(table.shape),
            width: Value(table.width),
            height: Value(table.height),
            positionX: Value(table.positionX + 24),
            positionY: Value(table.positionY + 24),
            rotation: Value(table.rotation),
            notes: Value(table.notes),
            sortOrder: Value(table.sortOrder + 1),
          ),
        );
    return (_db.select(_db.serviceTables)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> delete(int id) async {
    await (_db.delete(_db.serviceTables)..where((t) => t.id.equals(id))).go();
  }
}

@Riverpod(keepAlive: true)
ServiceTableRepository serviceTableRepository(Ref ref) {
  return ServiceTableRepository(ref.watch(appDatabaseProvider));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final tablesForHallProvider =
    StreamProvider.family<List<ServiceTable>, int>((ref, hallId) {
  return ref.watch(serviceTableRepositoryProvider).watchTablesForHall(hallId);
});

final tablesForBranchProvider =
    StreamProvider.family<List<ServiceTable>, int>((ref, branchId) {
  return ref.watch(serviceTableRepositoryProvider).watchTablesForBranch(branchId);
});
