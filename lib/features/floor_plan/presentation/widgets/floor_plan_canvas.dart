import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_state.dart';
import '../../../orders/data/order_repository.dart';
import '../../../orders/presentation/actions/open_table_action.dart';
import '../../../tables/data/service_table_repository.dart';
import '../../../tables/presentation/widgets/table_form_sheet.dart';
import '../../../tables/presentation/widgets/table_status_picker_sheet.dart';
import 'canvas_controls.dart';
import 'floor_plan_grid_painter.dart';
import 'floor_plan_table_widget.dart';
import 'table_quick_actions_sheet.dart';

const double _minCanvasSize = 1000;
const double _canvasPadding = 240;
const double _defaultGridSize = 20;

class FloorPlanCanvas extends ConsumerStatefulWidget {
  const FloorPlanCanvas({
    super.key,
    required this.hallId,
    required this.branchId,
    this.editable = true,
    this.onViewOnlyTap,
  });

  final int hallId;
  final int branchId;

  /// False on the Orders tab: view + zoom/pan the layout and tap a table to
  /// order for it, but no moving, resizing, adding, or deleting tables.
  final bool editable;

  /// Only used when [editable] is false. Defaults to opening/creating the
  /// table's order directly; the Orders tab overrides this to show its
  /// fuller quick-actions sheet (seat guest, change status, reserve).
  final void Function(ServiceTable table, Order? activeOrder)? onViewOnlyTap;

  @override
  ConsumerState<FloorPlanCanvas> createState() => _FloorPlanCanvasState();
}

class _FloorPlanCanvasState extends ConsumerState<FloorPlanCanvas> {
  final _transformationController = TransformationController();
  bool _showGrid = true;
  bool _snapToGrid = false;
  bool _isDraggingTable = false;

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _zoomBy(double factor) {
    final matrix = _transformationController.value.clone();
    final currentScale = matrix.getMaxScaleOnAxis();
    final targetScale = (currentScale * factor).clamp(0.4, 3.0);
    final ratio = targetScale / currentScale;
    _transformationController.value = matrix..scaleByDouble(ratio, ratio, ratio, 1.0);
  }

  void _resetZoom() {
    final matrix = _transformationController.value.clone();
    final currentScale = matrix.getMaxScaleOnAxis();
    final ratio = 1 / currentScale;
    _transformationController.value = matrix..scaleByDouble(ratio, ratio, ratio, 1.0);
  }

  void _centerView(List<ServiceTable> tables, Size viewportSize) {
    if (tables.isEmpty) {
      _transformationController.value = Matrix4.identity();
      return;
    }
    final minX = tables.map((t) => t.positionX).reduce((a, b) => a < b ? a : b);
    final maxX = tables.map((t) => t.positionX + t.width).reduce((a, b) => a > b ? a : b);
    final minY = tables.map((t) => t.positionY).reduce((a, b) => a < b ? a : b);
    final maxY = tables.map((t) => t.positionY + t.height).reduce((a, b) => a > b ? a : b);
    final contentCenter = Offset((minX + maxX) / 2, (minY + maxY) / 2);

    final scale = _transformationController.value.getMaxScaleOnAxis();
    final target = Matrix4.identity()
      ..translateByDouble(
        viewportSize.width / 2 - contentCenter.dx * scale,
        viewportSize.height / 2 - contentCenter.dy * scale,
        0.0,
        1.0,
      )
      ..scaleByDouble(scale, scale, scale, 1.0);
    _transformationController.value = target;
  }

  @override
  Widget build(BuildContext context) {
    final tablesAsync = ref.watch(tablesForHallProvider(widget.hallId));
    final openOrdersAsync = ref.watch(openOrdersForBranchProvider(widget.branchId));

    return tablesAsync.when(
      loading: () => const LoadingState(),
      error: (error, stack) => ErrorState(onRetry: () => ref.invalidate(tablesForHallProvider(widget.hallId))),
      data: (tables) {
        if (tables.isEmpty) {
          return EmptyState(
            icon: Icons.table_bar_outlined,
            title: 'No tables yet',
            message: widget.editable
                ? 'Add a table to start designing this hall\'s floor plan.'
                : 'This hall has no tables to order for yet.',
            actionLabel: widget.editable ? 'Add Table' : null,
            onAction: widget.editable ? () => showTableFormSheet(context, hallId: widget.hallId) : null,
          );
        }

        final ordersByTable = <int, Order>{
          for (final order in openOrdersAsync.value ?? const <Order>[])
            if (order.tableId != null) order.tableId!: order,
        };

        final maxX = tables.map((t) => t.positionX + t.width).reduce((a, b) => a > b ? a : b);
        final maxY = tables.map((t) => t.positionY + t.height).reduce((a, b) => a > b ? a : b);
        final canvasSize = Size(
          (maxX + _canvasPadding).clamp(_minCanvasSize, double.infinity),
          (maxY + _canvasPadding).clamp(_minCanvasSize, double.infinity),
        );

        return LayoutBuilder(
          builder: (context, constraints) {
            final viewportSize = Size(constraints.maxWidth, constraints.maxHeight);
            return Stack(
              children: [
                InteractiveViewer(
                  transformationController: _transformationController,
                  panEnabled: !_isDraggingTable,
                  minScale: 0.4,
                  maxScale: 3,
                  constrained: false,
                  boundaryMargin: const EdgeInsets.all(400),
                  child: SizedBox(
                    width: canvasSize.width,
                    height: canvasSize.height,
                    child: Stack(
                      children: [
                        if (_showGrid)
                          Positioned.fill(
                            child: CustomPaint(
                              painter: FloorPlanGridPainter(
                                gridSize: _defaultGridSize,
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.12),
                              ),
                            ),
                          ),
                        for (final table in tables)
                          if (widget.editable)
                            FloorPlanTableWidget(
                              key: ValueKey(table.id),
                              table: table,
                              activeOrderTotal: ordersByTable[table.id]?.total,
                              snapToGrid: _snapToGrid,
                              gridSize: _defaultGridSize,
                              movable: true,
                              onDragStateChanged: (dragging) => setState(() => _isDraggingTable = dragging),
                              onMoveEnd: (x, y) => ref
                                  .read(serviceTableRepositoryProvider)
                                  .updateLayout(table.id, positionX: x, positionY: y),
                              onTap: () => showTableQuickActionsSheet(
                                context,
                                ref,
                                table: table,
                                branchId: widget.branchId,
                              ),
                              onDoubleTap: () => openTableAndNavigate(
                                context,
                                ref,
                                branchId: widget.branchId,
                                hallId: widget.hallId,
                                tableId: table.id,
                              ),
                            )
                          else
                            FloorPlanTableWidget(
                              key: ValueKey(table.id),
                              table: table,
                              activeOrderTotal: ordersByTable[table.id]?.total,
                              snapToGrid: false,
                              gridSize: _defaultGridSize,
                              movable: false,
                              onTap: widget.onViewOnlyTap != null
                                  ? () => widget.onViewOnlyTap!(table, ordersByTable[table.id])
                                  : () => openTableAndNavigate(
                                        context,
                                        ref,
                                        branchId: widget.branchId,
                                        hallId: widget.hallId,
                                        tableId: table.id,
                                      ),
                              onLongPressAction: () => showTableStatusPickerSheet(
                                context,
                                tableId: table.id,
                                current: TableStatus.values.byName(table.status),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: CanvasControls(
                    onZoomIn: () => _zoomBy(1.2),
                    onZoomOut: () => _zoomBy(1 / 1.2),
                    onResetZoom: _resetZoom,
                    onCenterView: () => _centerView(tables, viewportSize),
                    showGrid: _showGrid,
                    onToggleGrid: () => setState(() => _showGrid = !_showGrid),
                    // Snap-to-grid only matters while dragging, which is
                    // disabled in view-only mode — showing the toggle there
                    // would be a dead control.
                    snapToGrid: widget.editable ? _snapToGrid : null,
                    onToggleSnap: () => setState(() => _snapToGrid = !_snapToGrid),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
