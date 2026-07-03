// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hall_visibility_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hallVisibilityRepository)
final hallVisibilityRepositoryProvider = HallVisibilityRepositoryProvider._();

final class HallVisibilityRepositoryProvider
    extends
        $FunctionalProvider<
          HallVisibilityRepository,
          HallVisibilityRepository,
          HallVisibilityRepository
        >
    with $Provider<HallVisibilityRepository> {
  HallVisibilityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hallVisibilityRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hallVisibilityRepositoryHash();

  @$internal
  @override
  $ProviderElement<HallVisibilityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HallVisibilityRepository create(Ref ref) {
    return hallVisibilityRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HallVisibilityRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HallVisibilityRepository>(value),
    );
  }
}

String _$hallVisibilityRepositoryHash() =>
    r'b9a2efbc0df67c740f21723c7e26415920e145fd';
