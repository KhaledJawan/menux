import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/bar/presentation/screens/bar_screen.dart';
import '../../features/branches/presentation/screens/branches_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/halls/presentation/screens/halls_screen.dart';
import '../../features/kitchen/presentation/screens/kitchen_screen.dart';
import '../../features/menu/presentation/screens/discounts_screen.dart';
import '../../features/menu/presentation/screens/menu_screen.dart';
import '../../features/menu/presentation/screens/menus_screen.dart';
import '../../features/messages/presentation/screens/messages_screen.dart';
import '../../features/more/presentation/screens/more_screen.dart';
import '../../features/orders/presentation/screens/order_detail_screen.dart';
import '../../features/orders/presentation/screens/orders_screen.dart';
import '../../features/receipts/presentation/screens/receipt_detail_screen.dart';
import '../../features/receipts/presentation/screens/receipts_screen.dart';
import '../../features/reservations/presentation/screens/reservations_screen.dart';
import '../../features/restaurant/data/restaurant_repository.dart';
import '../../features/restaurant/presentation/screens/restaurant_settings_screen.dart';
import '../../features/restaurant/presentation/screens/restaurant_setup_screen.dart';
import '../../features/settings/presentation/screens/app_settings_screen.dart';
import '../../features/staff/presentation/screens/staff_screen.dart';
import '../../features/tables/presentation/screens/tables_screen.dart';
import 'app_routes.dart';
import 'app_shell.dart';
import 'go_router_refresh_stream.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // `redirect` below reads currentProfileProvider/currentRestaurantProvider
  // directly, so the refresh trigger must be driven by those *same*
  // providers via ref.listen — not by independently re-subscribing to the
  // repositories' streams. Two separate subscriptions to logically the same
  // data can emit at slightly different times, so redirect() could run on a
  // stale cached value (e.g. right after registering, still reading
  // profile == null) and silently fail to navigate.
  final refresh = RouterRefreshNotifier();
  ref.listen(currentProfileProvider, (previous, next) => refresh.ping());
  ref.listen(currentRestaurantProvider, (previous, next) => refresh.ping());
  ref.onDispose(refresh.dispose);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.dashboard,
    refreshListenable: refresh,
    redirect: (context, state) {
      final profile = ref.read(currentProfileProvider).value;
      final restaurant = ref.read(currentRestaurantProvider).value;
      final loc = state.matchedLocation;

      final isAuthRoute = loc == AppRoutes.login || loc == AppRoutes.register || loc == AppRoutes.forgotPassword;
      final isSetupRoute = loc == AppRoutes.restaurantSetup;

      if (profile == null) {
        return isAuthRoute ? null : AppRoutes.login;
      }
      if (restaurant == null) {
        return isSetupRoute ? null : AppRoutes.restaurantSetup;
      }
      if (isAuthRoute || isSetupRoute) {
        return AppRoutes.dashboard;
      }
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: AppRoutes.register, builder: (context, state) => const RegisterScreen()),
      GoRoute(path: AppRoutes.forgotPassword, builder: (context, state) => const ForgotPasswordScreen()),
      GoRoute(path: AppRoutes.restaurantSetup, builder: (context, state) => const RestaurantSetupScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.dashboard, builder: (context, state) => const DashboardScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.orders, builder: (context, state) => const OrdersScreen())],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: AppRoutes.reservations, builder: (context, state) => const ReservationsScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: AppRoutes.messages, builder: (context, state) => const MessagesScreen())],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.more,
                builder: (context, state) => const MoreScreen(),
                routes: [
                  GoRoute(
                    path: 'branches',
                    builder: (context, state) => const BranchesScreen(),
                    routes: [
                      GoRoute(
                        path: 'halls/:branchId',
                        builder: (context, state) =>
                            HallsScreen(branchId: int.parse(state.pathParameters['branchId']!)),
                      ),
                      GoRoute(
                        path: 'halls/tables/:hallId',
                        builder: (context, state) =>
                            TablesScreen(hallId: int.parse(state.pathParameters['hallId']!)),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'menu',
                    builder: (context, state) => const MenusScreen(),
                    routes: [
                      GoRoute(
                        path: 'menu/:menuId',
                        builder: (context, state) =>
                            MenuScreen(menuId: int.parse(state.pathParameters['menuId']!)),
                      ),
                    ],
                  ),
                  GoRoute(path: 'discounts', builder: (context, state) => const DiscountsScreen()),
                  GoRoute(path: 'staff', builder: (context, state) => const StaffScreen()),
                  GoRoute(path: 'kitchen', builder: (context, state) => const KitchenScreen()),
                  GoRoute(path: 'bar', builder: (context, state) => const BarScreen()),
                  GoRoute(
                    path: 'receipts',
                    builder: (context, state) => const ReceiptsScreen(),
                    routes: [
                      GoRoute(
                        path: ':receiptId',
                        builder: (context, state) =>
                            ReceiptDetailScreen(receiptId: int.parse(state.pathParameters['receiptId']!)),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'restaurant-settings',
                    builder: (context, state) => const RestaurantSettingsScreen(),
                  ),
                  GoRoute(path: 'app-settings', builder: (context, state) => const AppSettingsScreen()),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '${AppRoutes.orderDetail}/:orderId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => OrderDetailScreen(orderId: int.parse(state.pathParameters['orderId']!)),
      ),
    ],
  );
}
