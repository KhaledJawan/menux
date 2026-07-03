import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/enums.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../tables/presentation/widgets/table_status_picker_sheet.dart';

/// A single table on the floor plan canvas.
///
/// Interaction model (see DesignGD.md and the floor-plan spec) has two
/// modes:
/// - Editable (hall setup, Owner only): tap = quick actions, double-tap =
///   open the order, long-press then drag = move the table.
/// - View-only (Orders tab — picking a table to order for, no layout
///   editing allowed): tap = open the order directly, long-press = change
///   status. Nothing is draggable, and there's no double-tap delay since
///   only one tap gesture is registered.
class FloorPlanTableWidget extends StatefulWidget {
  const FloorPlanTableWidget({
    super.key,
    required this.table,
    required this.activeOrderTotal,
    required this.snapToGrid,
    required this.gridSize,
    required this.onTap,
    this.onDoubleTap,
    this.onLongPressAction,
    this.movable = true,
    this.onMoveEnd,
    this.onDragStateChanged,
  }) : assert(
          movable ? onMoveEnd != null && onDragStateChanged != null : onLongPressAction != null,
          'movable tables need onMoveEnd/onDragStateChanged; non-movable '
          'tables need onLongPressAction for their long-press gesture.',
        );

  final ServiceTable table;
  final double? activeOrderTotal;
  final bool snapToGrid;
  final double gridSize;

  /// Single tap — quick actions in editable mode, opens the order directly
  /// in view-only mode.
  final VoidCallback onTap;

  /// Only wired in editable mode; leaving this null (view-only) avoids
  /// Flutter's double-tap detection delay on the primary tap.
  final VoidCallback? onDoubleTap;

  /// Long-press action for view-only tables (e.g. change status), used
  /// instead of drag-to-move.
  final VoidCallback? onLongPressAction;

  /// Whether long-press-then-drag repositions the table. False on the
  /// Orders tab's view-only floor plan.
  final bool movable;
  final void Function(double x, double y)? onMoveEnd;
  final void Function(bool dragging)? onDragStateChanged;

  @override
  State<FloorPlanTableWidget> createState() => _FloorPlanTableWidgetState();
}

class _FloorPlanTableWidgetState extends State<FloorPlanTableWidget> {
  // Local override while actively dragging. GestureDetector reports
  // long-press positions in the *local* coordinate space, which Flutter
  // already adjusts for ancestor transforms (including the canvas's
  // InteractiveViewer zoom) — so this offset needs no manual scale
  // conversion.
  Offset? _dragOffset;

  double get _x => (widget.table.positionX + (_dragOffset?.dx ?? 0));
  double get _y => (widget.table.positionY + (_dragOffset?.dy ?? 0));

  double _snap(double value) {
    if (!widget.snapToGrid) return value;
    return (value / widget.gridSize).round() * widget.gridSize;
  }

  @override
  Widget build(BuildContext context) {
    final status = TableStatus.values.byName(widget.table.status);
    final color = tableStatusColors[status]!;
    final shape = TableShape.values.byName(widget.table.shape);
    final isDragging = _dragOffset != null;

    return Positioned(
      left: _x,
      top: _y,
      width: widget.table.width,
      height: widget.table.height,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        onDoubleTap: widget.onDoubleTap,
        onLongPress: widget.movable ? null : widget.onLongPressAction,
        onLongPressStart: widget.movable
            ? (_) {
                HapticFeedback.mediumImpact();
                setState(() => _dragOffset = Offset.zero);
                widget.onDragStateChanged!(true);
              }
            : null,
        onLongPressMoveUpdate: widget.movable
            ? (details) => setState(() => _dragOffset = details.localOffsetFromOrigin)
            : null,
        onLongPressEnd: widget.movable
            ? (_) {
                final finalX = _snap(_x);
                final finalY = _snap(_y);
                setState(() => _dragOffset = null);
                widget.onDragStateChanged!(false);
                widget.onMoveEnd!(finalX, finalY);
              }
            : null,
        child: Transform.rotate(
          angle: widget.table.rotation * math.pi / 180,
          child: AnimatedScale(
            scale: isDragging ? 1.06 : 1.0,
            duration: const Duration(milliseconds: 150),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                border: Border.all(color: color, width: isDragging ? 2.5 : 1.5),
                borderRadius: _shapeRadius(shape, widget.table.width, widget.table.height),
                boxShadow: isDragging
                    ? [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 12, offset: const Offset(0, 4))]
                    : null,
              ),
              child: _TableContent(table: widget.table, color: color, activeOrderTotal: widget.activeOrderTotal),
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius _shapeRadius(TableShape shape, double width, double height) {
    switch (shape) {
      case TableShape.circle:
      case TableShape.oval:
        return BorderRadius.circular(1000); // fully rounded -> ellipse/circle
      case TableShape.square:
        return BorderRadius.circular(12);
      case TableShape.rectangle:
        return BorderRadius.circular(10);
    }
  }
}

class _TableContent extends StatelessWidget {
  const _TableContent({required this.table, required this.color, required this.activeOrderTotal});

  final ServiceTable table;
  final Color color;
  final double? activeOrderTotal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compact = table.width < 90 || table.height < 70;

    return Padding(
      padding: const EdgeInsets.all(6),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  table.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: (compact ? theme.textTheme.bodyMedium : theme.textTheme.titleMedium)
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                if (!compact) ...[
                  Text(
                    '${table.capacity} seats',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                ],
              ],
            ),
          ),
          if (activeOrderTotal != null)
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.statusOccupied,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  activeOrderTotal!.toStringAsFixed(0),
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
