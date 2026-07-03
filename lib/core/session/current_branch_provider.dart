import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';
import 'app_settings_repository.dart';

part 'current_branch_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<int?> currentBranchId(Ref ref) {
  return ref
      .watch(appSettingsRepositoryProvider)
      .watch(SettingsKeys.currentBranchId)
      .map((value) => int.tryParse(value ?? ''));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
final currentBranchProvider = StreamProvider<Branch?>((ref) {
  final branchId = ref.watch(currentBranchIdProvider).value;
  if (branchId == null) return Stream.value(null);
  final db = ref.watch(appDatabaseProvider);
  final query = db.select(db.branches)..where((t) => t.id.equals(branchId));
  return query.watchSingleOrNull();
});
