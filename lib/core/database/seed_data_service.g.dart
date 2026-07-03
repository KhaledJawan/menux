// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seed_data_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(seedDataService)
final seedDataServiceProvider = SeedDataServiceProvider._();

final class SeedDataServiceProvider
    extends
        $FunctionalProvider<SeedDataService, SeedDataService, SeedDataService>
    with $Provider<SeedDataService> {
  SeedDataServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'seedDataServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$seedDataServiceHash();

  @$internal
  @override
  $ProviderElement<SeedDataService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SeedDataService create(Ref ref) {
    return seedDataService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SeedDataService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SeedDataService>(value),
    );
  }
}

String _$seedDataServiceHash() => r'b32dd4928e4f7a4facf2a1e388785377687d5fe1';
