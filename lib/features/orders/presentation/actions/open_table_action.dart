import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../data/order_repository.dart';

/// Opens (or creates) the order for a table and navigates to it. Shared by
/// the Orders tab's table grid and the floor plan canvas so there's one
/// place that knows how "tap a table to order" behaves.
Future<void> openTableAndNavigate(
  BuildContext context,
  WidgetRef ref, {
  required int branchId,
  required int hallId,
  required int tableId,
  String? customerName,
}) async {
  final order = await ref.read(orderRepositoryProvider).openOrCreateForTable(
        branchId: branchId,
        hallId: hallId,
        tableId: tableId,
        customerName: customerName,
      );
  if (context.mounted) context.push(AppRoutes.orderDetailPath(order.id));
}
