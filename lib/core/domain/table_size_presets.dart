import 'enums.dart';

/// Default visual footprint for a table on the floor plan canvas, derived
/// from capacity and shape. Square/circle use an equal-sided box; rectangle
/// and oval use an elongated one. Users can resize manually afterward —
/// these are just sensible starting points so a newly added table doesn't
/// look wrong before anyone touches it.
abstract final class TableSizePresets {
  static const List<int> capacityChoices = [1, 2, 4, 6, 8, 10];

  static (double width, double height) defaultSize(TableShape shape, int capacity) {
    return shape.isElongated ? _elongated(capacity) : _square(capacity);
  }

  static (double, double) _square(int capacity) {
    if (capacity <= 1) return (64, 64);
    if (capacity == 2) return (80, 80);
    if (capacity <= 4) return (110, 110);
    if (capacity <= 6) return (140, 140);
    if (capacity <= 8) return (170, 170);
    return (200, 200);
  }

  static (double, double) _elongated(int capacity) {
    if (capacity <= 1) return (64, 64);
    if (capacity == 2) return (80, 80);
    if (capacity <= 4) return (120, 80);
    if (capacity <= 6) return (150, 90);
    if (capacity <= 8) return (180, 100);
    return (220, 110);
  }

  static const double minSize = 48;
  static const double maxSize = 320;
}
