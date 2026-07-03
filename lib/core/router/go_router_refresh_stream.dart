import 'package:flutter/foundation.dart';

/// Notifies GoRouter to re-run `redirect` whenever session/restaurant state
/// changes. Driven by `ref.listen` on the exact same providers `redirect`
/// reads from (see app_router.dart) — not an independent subscription to
/// the underlying repository streams, which could emit at a slightly
/// different time and cause `redirect` to see a stale value.
class RouterRefreshNotifier extends ChangeNotifier {
  void ping() => notifyListeners();
}
