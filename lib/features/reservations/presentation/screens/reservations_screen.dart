import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/session/current_branch_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_state.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../data/reservation_repository.dart';
import '../widgets/reservation_form_sheet.dart';

const Map<ReservationStatus, Color> _reservationStatusColors = {
  ReservationStatus.pending: AppColors.warning,
  ReservationStatus.confirmed: AppColors.info,
  ReservationStatus.seated: AppColors.success,
  ReservationStatus.completed: AppColors.statusDisabled,
  ReservationStatus.cancelled: AppColors.danger,
};

class ReservationsScreen extends ConsumerWidget {
  const ReservationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branchAsync = ref.watch(currentBranchProvider);

    return AppScaffold(
      title: 'Reservations',
      floatingActionButton: branchAsync.value == null
          ? null
          : FloatingActionButton(
              onPressed: () => showReservationFormSheet(context, branchId: branchAsync.value!.id),
              child: const Icon(Icons.add_rounded),
            ),
      body: branchAsync.when(
        loading: () => const LoadingState(),
        error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(currentBranchProvider)),
        data: (branch) {
          if (branch == null) {
            return const EmptyState(icon: Icons.store_outlined, title: 'No active branch');
          }
          final reservationsAsync = ref.watch(reservationsForBranchProvider(branch.id));
          return reservationsAsync.when(
            loading: () => const LoadingState(),
            error: (error, stack) =>
                ErrorState(onRetry: () => ref.invalidate(reservationsForBranchProvider(branch.id))),
            data: (reservations) {
              if (reservations.isEmpty) {
                return EmptyState(
                  icon: Icons.event_available_outlined,
                  title: 'No reservations yet',
                  message: 'Add a reservation to hold a table for a guest.',
                  actionLabel: 'Add Reservation',
                  onAction: () => showReservationFormSheet(context, branchId: branch.id),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.sm),
                itemCount: reservations.length,
                separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.xs),
                itemBuilder: (context, index) {
                  final reservation = reservations[index];
                  final status = ReservationStatus.values.byName(reservation.status);
                  return AppCard(
                    onTap: () => _showDetailSheet(context, ref, reservation, status),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(reservation.customerName, style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 2),
                              Text(
                                '${DateFormat.MMMd().format(reservation.date)} · ${reservation.time} · '
                                '${reservation.guestCount} guests',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        StatusBadge(label: status.label, color: _reservationStatusColors[status]!),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _showDetailSheet(
    BuildContext context,
    WidgetRef ref,
    Reservation reservation,
    ReservationStatus status,
  ) {
    showAppBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(reservation.customerName, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          if (reservation.phone != null) Text(reservation.phone!),
          Text('${DateFormat.yMMMd().format(reservation.date)} at ${reservation.time}'),
          Text('${reservation.guestCount} guests'),
          if (reservation.notes != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(reservation.notes!),
          ],
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              for (final next in ReservationStatus.values)
                if (next != status)
                  OutlinedButton(
                    onPressed: () async {
                      await ref.read(reservationRepositoryProvider).updateStatus(reservation.id, next);
                      if (context.mounted) Navigator.of(context).pop();
                    },
                    child: Text(next.label),
                  ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Edit Reservation',
            variant: AppButtonVariant.secondary,
            onPressed: () {
              Navigator.of(context).pop();
              showReservationFormSheet(context, branchId: reservation.branchId, initial: reservation);
            },
          ),
        ],
      ),
    );
  }
}
