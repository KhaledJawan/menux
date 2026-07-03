import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/data/auth_repository.dart';
import '../../features/restaurant/data/restaurant_repository.dart';
import '../../features/staff/data/staff_repository.dart';
import '../database/app_database.dart';
import '../domain/enums.dart';
import 'app_settings_repository.dart';

part 'current_staff_provider.g.dart';

extension SettingsKeysStaff on SettingsKeys {
  static const activeStaffId = 'active_staff_id';
}

@Riverpod(keepAlive: true)
Stream<int?> activeStaffId(Ref ref) {
  return ref
      .watch(appSettingsRepositoryProvider)
      .watch(SettingsKeysStaff.activeStaffId)
      .map((value) => int.tryParse(value ?? ''));
}

// Hand-written: see the note in auth_repository.dart — riverpod_generator
// can't emit code for providers returning a Drift row class.
//
// Falls back to the Owner staff record linked to the logged-in profile when
// nobody has explicitly "checked in" yet — covers the first login right
// after restaurant creation, and any staff row from before switching
// existed.
final activeStaffMemberProvider = StreamProvider<StaffMember?>((ref) {
  final explicitId = ref.watch(activeStaffIdProvider).value;
  final staffRepo = ref.watch(staffRepositoryProvider);

  if (explicitId != null) {
    return staffRepo.watchById(explicitId);
  }

  final profile = ref.watch(currentProfileProvider).value;
  final restaurant = ref.watch(currentRestaurantProvider).value;
  if (profile == null || restaurant == null) {
    return Stream.value(null);
  }
  return Stream.fromFuture(staffRepo.findByLinkedProfile(restaurant.id, profile.id));
});

/// Whether the person currently checked in on this device is the
/// restaurant Owner — the only role allowed to edit structural setup
/// (restaurant profile, branches, halls, tables, staff roster).
final isOwnerProvider = Provider<bool>((ref) {
  final member = ref.watch(activeStaffMemberProvider).value;
  return member != null && member.role == StaffRole.owner.name;
});

/// Backfills the Owner link for restaurants that existed before staff
/// switching did, so those accounts don't lose edit access. Only acts when
/// nobody has explicitly checked in yet — never overrides a real switch
/// (e.g. to Waiter). Watched once from [AppShell] so it runs on every
/// login without any manual migration step.
@Riverpod(keepAlive: true)
Future<void> ownerLinkGuard(Ref ref) async {
  final profile = ref.watch(currentProfileProvider).value;
  final restaurant = ref.watch(currentRestaurantProvider).value;
  final explicitActiveId = ref.watch(activeStaffIdProvider).value;
  if (profile == null || restaurant == null || explicitActiveId != null) return;

  final owner = await ref.read(staffRepositoryProvider).ensureOwnerLinked(
        restaurantId: restaurant.id,
        profileId: profile.id,
        profileName: profile.name,
      );
  await ref.read(appSettingsRepositoryProvider).set(SettingsKeysStaff.activeStaffId, owner.id.toString());
}
