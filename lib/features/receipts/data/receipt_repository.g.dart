// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(receiptRepository)
final receiptRepositoryProvider = ReceiptRepositoryProvider._();

final class ReceiptRepositoryProvider
    extends
        $FunctionalProvider<
          ReceiptRepository,
          ReceiptRepository,
          ReceiptRepository
        >
    with $Provider<ReceiptRepository> {
  ReceiptRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'receiptRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$receiptRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReceiptRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReceiptRepository create(Ref ref) {
    return receiptRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReceiptRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReceiptRepository>(value),
    );
  }
}

String _$receiptRepositoryHash() => r'6f33c7491ddce68f0dae9f9e521180f07c479248';
