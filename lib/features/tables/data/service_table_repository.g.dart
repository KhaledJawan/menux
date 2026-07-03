// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_table_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(serviceTableRepository)
final serviceTableRepositoryProvider = ServiceTableRepositoryProvider._();

final class ServiceTableRepositoryProvider
    extends
        $FunctionalProvider<
          ServiceTableRepository,
          ServiceTableRepository,
          ServiceTableRepository
        >
    with $Provider<ServiceTableRepository> {
  ServiceTableRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceTableRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceTableRepositoryHash();

  @$internal
  @override
  $ProviderElement<ServiceTableRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ServiceTableRepository create(Ref ref) {
    return serviceTableRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServiceTableRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServiceTableRepository>(value),
    );
  }
}

String _$serviceTableRepositoryHash() =>
    r'1ccd5bd36d3844dc9c22fc8a3a136572b9d0b8d6';
