import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';

/// Compact zoom/grid control cluster for the floor plan canvas. Kept to one
/// small vertical strip (rather than scattering separate floating buttons)
/// to avoid visual clutter on an already busy canvas.
class CanvasControls extends StatelessWidget {
  const CanvasControls({
    super.key,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onResetZoom,
    required this.onCenterView,
    required this.showGrid,
    required this.onToggleGrid,
    this.snapToGrid,
    required this.onToggleSnap,
  });

  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onResetZoom;
  final VoidCallback onCenterView;
  final bool showGrid;
  final VoidCallback onToggleGrid;

  /// Null hides the snap-to-grid button entirely — used in view-only mode,
  /// where dragging (and therefore snapping) is disabled.
  final bool? snapToGrid;
  final VoidCallback onToggleSnap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8)],
      ),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ControlButton(icon: Icons.add_rounded, tooltip: 'Zoom in', onPressed: onZoomIn),
          _ControlButton(icon: Icons.remove_rounded, tooltip: 'Zoom out', onPressed: onZoomOut),
          const Divider(height: 1, indent: AppSpacing.xs, endIndent: AppSpacing.xs),
          _ControlButton(icon: Icons.crop_free_rounded, tooltip: 'Reset zoom', onPressed: onResetZoom),
          _ControlButton(icon: Icons.center_focus_strong_rounded, tooltip: 'Center view', onPressed: onCenterView),
          const Divider(height: 1, indent: AppSpacing.xs, endIndent: AppSpacing.xs),
          _ControlButton(
            icon: Icons.grid_on_rounded,
            tooltip: 'Toggle grid',
            onPressed: onToggleGrid,
            active: showGrid,
          ),
          if (snapToGrid != null)
            _ControlButton(
              icon: Icons.grid_goldenratio_rounded,
              tooltip: 'Snap to grid',
              onPressed: onToggleSnap,
              active: snapToGrid!,
            ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({required this.icon, required this.tooltip, required this.onPressed, this.active = false});

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon, size: 20),
        color: active ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.7),
        onPressed: onPressed,
      ),
    );
  }
}
