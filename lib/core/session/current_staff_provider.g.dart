// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_staff_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activeStaffId)
final activeStaffIdProvider = ActiveStaffIdProvider._();

final class ActiveStaffIdProvider
    extends $FunctionalProvider<AsyncValue<int?>, int?, Stream<int?>>
    with $FutureModifier<int?>, $StreamProvider<int?> {
  ActiveStaffIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeStaffIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeStaffIdHash();

  @$internal
  @override
  $StreamProviderElement<int?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int?> create(Ref ref) {
    return activeStaffId(ref);
  }
}

String _$activeStaffIdHash() => r'ded9384b3a72352b4b4b320866db40dc74d62d3d';

/// Backfills the Owner link for restaurants that existed before staff
/// switching did, so those accounts don't lose edit access. Only acts when
/// nobody has explicitly checked in yet — never overrides a real switch
/// (e.g. to Waiter). Watched once from [AppShell] so it runs on every
/// login without any manual migration step.

@ProviderFor(ownerLinkGuard)
final ownerLinkGuardProvider = OwnerLinkGuardProvider._();

/// Backfills the Owner link for restaurants that existed before staff
/// switching did, so those accounts don't lose edit access. Only acts when
/// nobody has explicitly checked in yet — never overrides a real switch
/// (e.g. to Waiter). Watched once from [AppShell] so it runs on every
/// login without any manual migration step.

final class OwnerLinkGuardProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// Backfills the Owner link for restaurants that existed before staff
  /// switching did, so those accounts don't lose edit access. Only acts when
  /// nobody has explicitly checked in yet — never overrides a real switch
  /// (e.g. to Waiter). Watched once from [AppShell] so it runs on every
  /// login without any manual migration step.
  OwnerLinkGuardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ownerLinkGuardProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ownerLinkGuardHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return ownerLinkGuard(ref);
  }
}

String _$ownerLinkGuardHash() => r'7f38a144e47ed18427d2fe27c75b7d3375690170';
