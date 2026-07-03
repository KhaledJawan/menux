/// Shared domain enums. Stored as `.name` strings in Drift text columns and
/// parsed back at the repository boundary.
library;

enum TableStatus { available, reserved, occupied, cleaning, disabled }

enum ReservationStatus { pending, confirmed, seated, cancelled, completed }

enum OrderStatus { draft, sent, preparing, ready, delivered, cancelled, paid }

enum OrderItemStatus { newItem, preparing, ready, completed }

enum PaymentMethod { cash, card, mixed }

enum StaffRole { owner, manager, waiter, kitchen, bar }

enum TableShape { square, rectangle, circle, oval }

enum DiscountType { percent, fixed }

extension TableStatusX on TableStatus {
  String get label => switch (this) {
        TableStatus.available => 'Available',
        TableStatus.reserved => 'Reserved',
        TableStatus.occupied => 'Occupied',
        TableStatus.cleaning => 'Cleaning',
        TableStatus.disabled => 'Disabled',
      };
}

extension ReservationStatusX on ReservationStatus {
  String get label => switch (this) {
        ReservationStatus.pending => 'Pending',
        ReservationStatus.confirmed => 'Confirmed',
        ReservationStatus.seated => 'Seated',
        ReservationStatus.cancelled => 'Cancelled',
        ReservationStatus.completed => 'Completed',
      };
}

extension OrderStatusX on OrderStatus {
  String get label => switch (this) {
        OrderStatus.draft => 'Draft',
        OrderStatus.sent => 'Sent',
        OrderStatus.preparing => 'Preparing',
        OrderStatus.ready => 'Ready',
        OrderStatus.delivered => 'Delivered',
        OrderStatus.cancelled => 'Cancelled',
        OrderStatus.paid => 'Paid',
      };
}

extension OrderItemStatusX on OrderItemStatus {
  String get label => switch (this) {
        OrderItemStatus.newItem => 'New',
        OrderItemStatus.preparing => 'Preparing',
        OrderItemStatus.ready => 'Ready',
        OrderItemStatus.completed => 'Completed',
      };
}

extension PaymentMethodX on PaymentMethod {
  String get label => switch (this) {
        PaymentMethod.cash => 'Cash',
        PaymentMethod.card => 'Card',
        PaymentMethod.mixed => 'Mixed',
      };
}

extension StaffRoleX on StaffRole {
  String get label => switch (this) {
        StaffRole.owner => 'Owner',
        StaffRole.manager => 'Manager',
        StaffRole.waiter => 'Waiter',
        StaffRole.kitchen => 'Kitchen',
        StaffRole.bar => 'Bar',
      };
}

extension TableShapeX on TableShape {
  String get label => switch (this) {
        TableShape.square => 'Square',
        TableShape.rectangle => 'Rectangle',
        TableShape.circle => 'Circle',
        TableShape.oval => 'Oval',
      };

  /// Square and circle both need an equal-sided bounding box; rectangle and
  /// oval both need an elongated one. Only the box shape (equal vs.
  /// elongated) differs between the two pairs — how it's *drawn* (corners
  /// vs. ellipse) is handled separately in FloorPlanTableWidget.
  bool get isElongated => this == TableShape.rectangle || this == TableShape.oval;
}

extension DiscountTypeX on DiscountType {
  String get label => switch (this) {
        DiscountType.percent => 'Percent',
        DiscountType.fixed => 'Fixed Amount',
      };

  double amountFor(double subtotal, double value) =>
      this == DiscountType.percent ? subtotal * value / 100 : value;
}
