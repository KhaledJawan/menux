/// Centralized route paths. No screen should hardcode a path string.
abstract final class AppRoutes {
  // Auth (outside the shell)
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const restaurantSetup = '/restaurant-setup';

  // Bottom-nav shell tabs
  static const dashboard = '/dashboard';
  static const orders = '/orders';
  static const reservations = '/reservations';
  static const messages = '/messages';
  static const more = '/more';

  // Pushed on the root navigator (full-screen flows reached from a tab)
  static const orderDetail = '/order'; // /order/:orderId
  static String orderDetailPath(int orderId) => '/order/$orderId';

  static const branches = '/more/branches';
  static const halls = '/more/branches/halls'; // /more/branches/halls/:branchId
  static String hallsPath(int branchId) => '/more/branches/halls/$branchId';
  static const tables = '/more/branches/halls/tables'; // /.../tables/:hallId
  static String tablesPath(int hallId) => '/more/branches/halls/tables/$hallId';

  static const menu = '/more/menu';
  static const menuDetail = '/more/menu/menu'; // /more/menu/menu/:menuId
  static String menuDetailPath(int menuId) => '/more/menu/menu/$menuId';
  static const discounts = '/more/discounts';
  static const staff = '/more/staff';
  static const kitchen = '/more/kitchen';
  static const bar = '/more/bar';
  static const receipts = '/more/receipts';
  static String receiptDetailPath(int receiptId) => '/more/receipts/$receiptId';
  static const restaurantSettings = '/more/restaurant-settings';
  static const appSettings = '/more/app-settings';
}
