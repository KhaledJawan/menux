// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_category_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(menuCategoryRepository)
final menuCategoryRepositoryProvider = MenuCategoryRepositoryProvider._();

final class MenuCategoryRepositoryProvider
    extends
        $FunctionalProvider<
          MenuCategoryRepository,
          MenuCategoryRepository,
          MenuCategoryRepository
        >
    with $Provider<MenuCategoryRepository> {
  MenuCategoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'menuCategoryRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$menuCategoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<MenuCategoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MenuCategoryRepository create(Ref ref) {
    return menuCategoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MenuCategoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MenuCategoryRepository>(value),
    );
  }
}

String _$menuCategoryRepositoryHash() =>
    r'98ced182c3ec89ae9d1969b7d674190ec1e2f45f';
