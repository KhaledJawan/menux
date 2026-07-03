// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appSettingsRepository)
final appSettingsRepositoryProvider = AppSettingsRepositoryProvider._();

final class AppSettingsRepositoryProvider
    extends
        $FunctionalProvider<
          AppSettingsRepository,
          AppSettingsRepository,
          AppSettingsRepository
        >
    with $Provider<AppSettingsRepository> {
  AppSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appSettingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appSettingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AppSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppSettingsRepository create(Ref ref) {
    return appSettingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppSettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppSettingsRepository>(value),
    );
  }
}

String _$appSettingsRepositoryHash() =>
    r'f6ae250a3df712c3a86dbd24ba827b19c70c3c15';
