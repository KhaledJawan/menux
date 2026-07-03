import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/session/app_settings_repository.dart';

part 'hall_visibility_repository.g.dart';

/// Which halls this device is hiding from the Orders tab — e.g. a waiter
/// who only covers the Terrace hiding the Main Hall so it's not clutter.
/// A device-level preference (not per-staff): whoever is checked in tends
/// to be the person actually working the floor right now.
class HallVisibilityRepository {
  HallVisibilityRepository(this._settings);

  final AppSettingsRepository _settings;

  String _key(int branchId) => 'hidden_halls_$branchId';

  Set<int> _parse(String? raw) {
    if (raw == null || raw.isEmpty) return {};
    return raw.split(',').map(int.parse).toSet();
  }

  Stream<Set<int>> watchHidden(int branchId) {
    return _settings.watch(_key(branchId)).map(_parse);
  }

  Future<void> setHidden(int branchId, int hallId, bool hidden) async {
    final current = _parse(await _settings.get(_key(branchId)));
    if (hidden) {
      current.add(hallId);
    } else {
      current.remove(hallId);
    }
    await _settings.set(_key(branchId), current.join(','));
  }
}

@Riverpod(keepAlive: true)
HallVisibilityRepository hallVisibilityRepository(Ref ref) {
  return HallVisibilityRepository(ref.watch(appSettingsRepositoryProvider));
}

final hiddenHallsProvider = StreamProvider.family<Set<int>, int>((ref, branchId) {
  return ref.watch(hallVisibilityRepositoryProvider).watchHidden(branchId);
});
