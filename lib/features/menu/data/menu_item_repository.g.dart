// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(menuItemRepository)
final menuItemRepositoryProvider = MenuItemRepositoryProvider._();

final class MenuItemRepositoryProvider
    extends
        $FunctionalProvider<
          MenuItemRepository,
          MenuItemRepository,
          MenuItemRepository
        >
    with $Provider<MenuItemRepository> {
  MenuItemRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'menuItemRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$menuItemRepositoryHash();

  @$internal
  @override
  $ProviderElement<MenuItemRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MenuItemRepository create(Ref ref) {
    return menuItemRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MenuItemRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MenuItemRepository>(value),
    );
  }
}

String _$menuItemRepositoryHash() =>
    r'84901876112845ccbb920e6e43c35c9d7f3d29fe';
