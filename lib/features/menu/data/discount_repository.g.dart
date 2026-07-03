// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(discountRepository)
final discountRepositoryProvider = DiscountRepositoryProvider._();

final class DiscountRepositoryProvider
    extends
        $FunctionalProvider<
          DiscountRepository,
          DiscountRepository,
          DiscountRepository
        >
    with $Provider<DiscountRepository> {
  DiscountRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discountRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discountRepositoryHash();

  @$internal
  @override
  $ProviderElement<DiscountRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DiscountRepository create(Ref ref) {
    return discountRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiscountRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiscountRepository>(value),
    );
  }
}

String _$discountRepositoryHash() =>
    r'5af5dc4cd54ef5f42fe4435c3bc2dcae6809351e';
