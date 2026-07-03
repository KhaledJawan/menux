// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_variant_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(menuVariantRepository)
final menuVariantRepositoryProvider = MenuVariantRepositoryProvider._();

final class MenuVariantRepositoryProvider
    extends
        $FunctionalProvider<
          MenuVariantRepository,
          MenuVariantRepository,
          MenuVariantRepository
        >
    with $Provider<MenuVariantRepository> {
  MenuVariantRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'menuVariantRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$menuVariantRepositoryHash();

  @$internal
  @override
  $ProviderElement<MenuVariantRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MenuVariantRepository create(Ref ref) {
    return menuVariantRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MenuVariantRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MenuVariantRepository>(value),
    );
  }
}

String _$menuVariantRepositoryHash() =>
    r'8503d8deb59e3edbc0870494730f3087ea71ad00';
