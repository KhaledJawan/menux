import 'package:flutter/material.dart';

enum TableViewMode { list, graphical }

/// Switches a hall's table view between the plain list and the graphical
/// floor plan. See DesignGD.md — segmented control, not a separate tab, so
/// it reads as one screen with two ways to look at the same data.
class ViewModeToggle extends StatelessWidget {
  const ViewModeToggle({super.key, required this.mode, required this.onChanged});

  final TableViewMode mode;
  final ValueChanged<TableViewMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<TableViewMode>(
      segments: const [
        ButtonSegment(value: TableViewMode.list, icon: Icon(Icons.view_list_rounded), label: Text('List')),
        ButtonSegment(
          value: TableViewMode.graphical,
          icon: Icon(Icons.dashboard_customize_outlined),
          label: Text('Graphical'),
        ),
      ],
      selected: {mode},
      onSelectionChanged: (value) => onChanged(value.first),
    );
  }
}
