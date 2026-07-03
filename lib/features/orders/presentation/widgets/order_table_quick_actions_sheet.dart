import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/router/app_routes.dart';
import '../../../reservations/presentation/widgets/reservation_form_sheet.dart';
import '../../../tables/presentation/widgets/table_status_picker_sheet.dart';
import 'seat_guest_sheet.dart';

/// What a tap on a table means in the Orders tab: seat a guest, jump back
/// into their order, change status, or reserve the table for later. All of
/// these are day-to-day operations any checked-in staff member can do —
/// unlike the hall/table *setup* actions, nothing here is Owner-gated.
Future<void> showOrderTableQuickActionsSheet(
  BuildContext context,
  WidgetRef ref, {
  required ServiceTable table,
  required int branchId,
  required Order? activeOrder,
}) {
  final status = TableStatus.values.byName(table.status);

  return showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(table.name, style: Theme.of(context).textTheme.titleLarge),
          ),
          if (activeOrder != null)
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text('Open Order'),
              subtitle: Text('Total: ${activeOrder.total.toStringAsFixed(2)}'),
              onTap: () {
                Navigator.of(context).pop();
                context.push(AppRoutes.orderDetailPath(activeOrder.id));
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.person_add_alt_1_rounded),
              title: const Text('Seat Guest'),
              subtitle: const Text('Start an order — guest name optional'),
              onTap: () {
                Navigator.of(context).pop();
                showSeatGuestSheet(
                  context,
                  branchId: branchId,
                  hallId: table.hallId,
                  tableId: table.id,
                  tableName: table.name,
                );
              },
            ),
          ListTile(
            leading: const Icon(Icons.sync_alt_rounded),
            title: const Text('Change Status'),
            subtitle: Text('Currently ${status.label}'),
            onTap: () {
              Navigator.of(context).pop();
              showTableStatusPickerSheet(context, tableId: table.id, current: status);
            },
          ),
          ListTile(
            leading: const Icon(Icons.event_available_outlined),
            title: const Text('Reserve This Table'),
            onTap: () {
              Navigator.of(context).pop();
              showReservationFormSheet(
                context,
                branchId: branchId,
                initialHallId: table.hallId,
                initialTableId: table.id,
              );
            },
          ),
        ],
      ),
    ),
  );
}
