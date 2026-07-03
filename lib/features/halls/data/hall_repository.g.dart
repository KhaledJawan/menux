// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hall_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hallRepository)
final hallRepositoryProvider = HallRepositoryProvider._();

final class HallRepositoryProvider
    extends $FunctionalProvider<HallRepository, HallRepository, HallRepository>
    with $Provider<HallRepository> {
  HallRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hallRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hallRepositoryHash();

  @$internal
  @override
  $ProviderElement<HallRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HallRepository create(Ref ref) {
    return hallRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HallRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HallRepository>(value),
    );
  }
}

String _$hallRepositoryHash() => r'c5645520b09dff7f127cee6eea7caec1097307ad';
