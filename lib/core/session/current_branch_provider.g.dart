// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_branch_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(currentBranchId)
final currentBranchIdProvider = CurrentBranchIdProvider._();

final class CurrentBranchIdProvider
    extends $FunctionalProvider<AsyncValue<int?>, int?, Stream<int?>>
    with $FutureModifier<int?>, $StreamProvider<int?> {
  CurrentBranchIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentBranchIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentBranchIdHash();

  @$internal
  @override
  $StreamProviderElement<int?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int?> create(Ref ref) {
    return currentBranchId(ref);
  }
}

String _$currentBranchIdHash() => r'da8a0241dc13b52d0cd4db56e507882c43b66cad';
