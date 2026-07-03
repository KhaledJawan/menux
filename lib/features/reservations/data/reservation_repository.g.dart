// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reservationRepository)
final reservationRepositoryProvider = ReservationRepositoryProvider._();

final class ReservationRepositoryProvider
    extends
        $FunctionalProvider<
          ReservationRepository,
          ReservationRepository,
          ReservationRepository
        >
    with $Provider<ReservationRepository> {
  ReservationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reservationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reservationRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReservationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReservationRepository create(Ref ref) {
    return reservationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReservationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReservationRepository>(value),
    );
  }
}

String _$reservationRepositoryHash() =>
    r'1ea92f679a135c090f71b8a0b6b518e461f82642';
