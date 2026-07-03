import 'package:drift/drift.dart';

/// Menux is mobile/desktop-first and offline-first (see PRD.md); local
/// persistence on the web target is out of MVP scope. Screens that read
/// from the database surface this as a normal error state on web instead
/// of crashing — every data provider is a Stream/FutureProvider, so this
/// throw is caught by Riverpod and rendered through the existing
/// loading/empty/error UI states.
///
/// The throw must stay inside the [LazyDatabase] callback (deferred until
/// the first query) rather than thrown directly from this function — a
/// direct throw happens synchronously while [AppDatabase] is constructed,
/// which propagates out of every provider that merely *depends* on the
/// database (e.g. the router), crashing the whole app instead of being
/// scoped to the one query that touches it.
QueryExecutor openConnection() {
  return LazyDatabase(() async {
    throw UnsupportedError(
      'Local persistence is not available in the web build of Menux.',
    );
  });
}
