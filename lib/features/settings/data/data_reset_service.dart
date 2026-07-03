import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

part 'data_reset_service.g.dart';

/// Wipes every local table. Used by the "Reset Data" action in App
/// Settings — destructive, always gated behind a confirmation dialog.
class DataResetService {
  DataResetService(this._db);

  final AppDatabase _db;

  Future<void> resetAll() async {
    await _db.transaction(() async {
      for (final table in _db.allTables) {
        await _db.delete(table).go();
      }
    });
  }
}

@Riverpod(keepAlive: true)
DataResetService dataResetService(Ref ref) {
  return DataResetService(ref.watch(appDatabaseProvider));
}
